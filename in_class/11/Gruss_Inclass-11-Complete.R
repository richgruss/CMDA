### Richard Gruss : In Class Assignment 11 ######

#data preparation
data(mtcars)
head(mtcars)
names(mtcars)
?mtcars

###
#The data was extracted from the 1974 Motor Trend US magazine, 
#and comprises fuel consumption and 10 aspects of automobile design 
#and performance for 32 automobiles (1973–74 models).

"mpg, Miles per US Gallon"
"cy number of cyliners"  
"disp displacement in cubic inches" 
"hp gross horsepower"   
"drat rear axle ratio" 
"wt weigth"   
"qsec 1/4 mile time" 
"vs, V-engine or straight engine"   
"am automatic or manual transmission"   
"gear num forward gears" 
"carb num carburetors"
###

library(rpart)
?rpart

#we should scale these values.
#first, move am to the end for each of subscripting
response <- mtcars$am
#no need to keep am any more
mtcars <- as.data.frame(mtcars[,!(names(mtcars) %in% "am")])
mtcars_scaled <- as.data.frame(scale(mtcars))
#now add response column back
mtcars_scaled$response <- response
#convert to logical classification
mtcars_scaled$response <- mtcars_scaled$response > 0
features <- mtcars_scaled[1:10]
featuresVars <- names(features)
###### 11-1 : Decision Tree (Classification and Regression Trees) #######


#let's try using all the variables
f <- paste('response ~ ',paste(featuresVars,collapse=' + '),sep='')
f

tmodel <- rpart(f,data=mtcars_scaled[,1:11],
                control=rpart.control(cp=0.001,
                                      minbucket=2))

tmodel

install.packages("rpart.plot")
library(rpart.plot)
prp(tmodel)

#the tree is not very deep.  Only three decision levels:  ROOT, wt, and qsec
install.packages('ROCR') 
library(ROCR)

mtcars_scaled$response_pred_tree <- predict(tmodel, newdata = mtcars_scaled[,1:11])
eval <- prediction(mtcars_scaled$response_pred_tree, mtcars_scaled$response) #from ROCR package
mtcars_scaled[,11:12]

#these predictions represent probability of being in TRUE class

#calculate AUC
auc_calc <- performance(eval,'auc')
auc_calc@y.values #special object; this is how we extract the exact AUC part
#good AUC is close to 1; useless models have AUC of 0.5
#.9979, but of course this is testing on the training data

#plot ROC curve
plot(performance(eval, "tpr", "fpr"))

################# 11-2 : K-Nearest Neighbors #####################
#package to implement kNN algo
install.packages('class')
library(class)

system.time(knnDecision <- knn(features,features,
                               mtcars_scaled$response,k=3,prob=T))
?knn #to learn more about the knn implementation

head(knnDecision)
knnDecision

mtcars_scaled$response_pred_knn <- ifelse(knnDecision==1,
                  attributes(knnDecision)$prob,
                  1-(attributes(knnDecision)$prob))

#calculate AUC

eval <- prediction(mtcars_scaled$response_pred_knn, (mtcars_scaled$response) #from ROCR package
auc_calc <- performance(eval,'auc')
auc_calc@y.values #special object; this is how we extract the exact AUC part

#AUC=.9979

#compare to logistic regression AUC and system time

#let's try using all the variables
f <- paste('response ~ ',paste(featuresVars),collapse=' + '),sep='')
f

system.time(gmodel <- glm(as.formula(f),
                          data=mtcars_scaled[, 1:11],
                          family=binomial(link='logit'))) #get system time and train the model

mtcars_scaled$response_pred_log <- predict(gmodel, 
                       newdata=mtcars_scaled, 
                       type = "response") #get p predictions

#get AUC for logistic model
eval <- prediction(mtcars_scaled$response_pred_log, mtcars_scaled$response)
auc_calc <- performance(eval,'auc')
auc_calc@y.values 

#1 : logistic auc--perfect score

################  11-3 : Naive Bayes Classifier ##################
#train the model

install.packages("e1071")
library(e1071)

system.time(fit <- naiveBayes(as.formula(f), data=mtcars_scaled[,1:11]))

system.time(naivB_pred <- predict(fit, mtcars_scaled[,1:11], type = 'raw'))
head(naivB_pred) #need just the "probability of TRUE" as prediction

#calculate AUC for Naive Bayes
#notice that second column from predictions denotes "p of pos"
eval <- prediction(naivB_pred[,2], mtcars_scaled$response) 
auc_calc <- performance(eval,'auc')
auc_calc@y.values

#.9838 AUC for Naive Bayes.

#final tally for AUC:
#Decision tree: .9979
#Knn: .9979
#Logistic: 1.0
#Naive Bayes: .9838

#Best: logistic, worst: Naive Bayes




