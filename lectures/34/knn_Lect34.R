#KNN
setwd('/Users/rgruss/git/CMDA/lectures/33')
load('KDD2009.Rdata')

#Use dTrain data for KDD Cup
names(dTrain)
#use Churn as the outcome
head(dTrain$churn) # 1 and -1 type variable; 1 is pos outcome

#use pre-selected 27 variables as features
#previous data wrangling and variable selection 
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
install.packages('class')
library(class)

#use system.time function to time the training of the model

system.time(knnDecision <- knn(knnTrain,knnTrain,response,k=200,prob=T))
?knn #to learn more about the knn implementation

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
library(ROCR)
eval <- prediction(knnPred, response) #from ROCR package
auc_calc <- performance(eval,'auc')
auc_calc@y.values #special object; this is how we extract the exact AUC part

#################Logistic algo

#compare to logistic regression AUC and system time
f <- paste('response ~ ',paste(selVars,collapse=' + '),sep='') #create formula
system.time(gmodel <- glm(as.formula(f),
                          data=knnTrain,
                          family=binomial(link='logit'))) #get system time and train the model
log_predict <- predict(gmodel, 
                       newdata=knnTrain, 
                       type = "response") #get p predictions

#get AUC for logistic model

eval <- prediction(log_predict, response) #from ROCR package
auc_calc <- performance(eval,'auc')
auc_calc@y.values #special object; this is how we extract the exact AUC part

###########CART algo
#train CART decision tree, get AUC and system time
library(rpart)
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




