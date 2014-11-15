#Naive Bayes
setwd('/Users/rgruss/git/CMDA/lectures/35')
load('Lect35.Rdata') #same KDDcup data
library(ROCR)
library(rpart)
library(class)

#Use dTrain data for KDD Cup
#use pre-selected 27 variables as features
#previous data wrangling and variable selection 

names(dTrain)
#use Churn as the outcome
head(dTrain$churn) # 1 and -1 type variable; 1 is pos outcome

#create the 0/1 response/class variable
dTrain$response <- dTrain$churn > 0

#Package for Naive Bayes implementation
install.packages("e1071")
library(e1071)

#train model on selected variables from dTrain data set
#use the shortcut to formula as before

#train the model
system.time(fit <- naiveBayes(as.formula(f), data=dTrain))

#make predictions
system.time(naivB_pred <- predict(fit, dTrain, type = 'raw'))
head(naivB_pred) #need just the "probability of TRUE" as prediction

?naiveBayes

#calculate AUC for Naive Bayes
#notice that second column from predictions denotes "p of pos"
eval <- prediction(naivB_pred[,2], dTrain$response) 
auc_calc <- performance(eval,'auc')
auc_calc@y.values


#KNN#############################################################


knnTrain <- dTrain[,selVars]
names(knnTrain)

#known classes in training set; 
#change levels to 0=False=neg class and 1=TRUE=pos class
response <- dTrain$churn > 0

#examine features and classes to know our data
head(response)
head(knnTrain)
dim(knnTrain)

################kNN algo

#package to implement kNN algo

#use system.time function to time the training of the model

system.time(knnDecision <- knn(knnTrain,knnTrain,response,k=200,prob=T))
?knn #to learn more about the knn implementation
#time = 113

#notice that response should not be part of the training set(knnTrain)
#for knn training

#the values of knnDecision are classifications
head(knnDecision)

#the "prob" argument returns, for each observation, the proportion of
#votes for the winning class (pos or neg)
#we want the predicted probabilities (which is p = probability(pos))
#so we will use the "prob" attribute values
#to get the p predictions


knnPred <- ifelse(knnDecision==TRUE,
                  attributes(knnDecision)$prob,
                  1-(attributes(knnDecision)$prob))
head(knnPred)

#calculate AUC

eval <- prediction(knnPred, response) #from ROCR package
auc_calc <- performance(eval,'auc')
auc_calc@y.values #special object; this is how we extract the exact AUC part
#AUC = 74.4%
#################Logistic algo

#compare to logistic regression AUC and system time
f <- paste('response ~ ',paste(selVars,collapse=' + '),sep='') #create formula
system.time(gmodel <- glm(as.formula(f),
                          data=knnTrain,
                          family=binomial(link='logit'))) #get system time and train the model

#user time = 1.26

log_predict <- predict(gmodel, 
                       newdata=knnTrain, 
                       type = "response") #get p predictions

#get AUC for logistic model

eval <- prediction(log_predict, response) #from ROCR package
auc_calc <- performance(eval,'auc')
auc_calc@y.values #special object; this is how we extract the exact AUC part

#AUC= 73.7%

###########CART algo
#train CART decision tree, get AUC and system time

f <- paste('response ~ ',paste(selVars,collapse=' + '),sep='')
system.time(tmodel <- rpart(f,data=dTrain,
                control=rpart.control(cp=0.001,minsplit=1000,
                                      minbucket=1000,maxdepth=5)))

dTrain$pred <- predict(tmodel, newdata = dTrain)
dTrain$response <- dTrain$churn > 0

#calculate AUC for CART decision tree
eval <- prediction(dTrain$pred, dTrain$response) 
auc_calc <- performance(eval,'auc')
auc_calc@y.values

#0.69



