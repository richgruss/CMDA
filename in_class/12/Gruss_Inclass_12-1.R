setwd('/Users/rgruss/git/CMDA/in_class/12')
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

#svm for classification into two classes based on features#####################
install.packages('kernlab')
?ksvm
library(kernlab)
#time-consuming function################
system.time(
  mSVMV <- ksvm(as.formula(f),data = dTrain, kernel = 'vanilladot') #bad kernel function
)
##############
# user  system elapsed 
#257.527   0.466 257.985 
##########
f <- paste('response ~ ',paste(selVars,collapse=' + '),sep='')
f

#predict
svm_pred <- predict(mSVMV, newdata = dTrain, type = 'response')
head(svm_pred)
#calculate AUC for SVM
#notice that second column from predictions denotes "p of pos"
eval <- prediction(svm_pred, dTrain$response) 
auc_calc <- performance(eval,'auc')
auc_calc@y.values

#next, good kernel function, commonly used#####################################
system.time(
  mSVMV1 <- ksvm(as.formula(f),data = dTrain, kernel = 'rbfdot') 
)
#predict
svm_pred1 <- predict(mSVMV1, newdata = dTrain, type = 'response')
head(svm_pred1)
#calculate AUC for SVM
#notice that second column from predictions denotes "p of pos"
eval <- prediction(svm_pred1, dTrain$response) 
auc_calc <- performance(eval,'auc')
auc_calc@y.values


