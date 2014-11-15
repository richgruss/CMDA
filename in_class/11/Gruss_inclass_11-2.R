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

#package to implement kNN algo
install.packages('class')
library(class)
response <- mtcars$am > 0

system.time(knnDecision <- knn(mtcars,mtcars,response,k=200,prob=T))
?knn #to learn more about the knn implementation

head(knnDecision)

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
f <- paste('response ~ ',paste(mtcars[,],collapse=' + '),sep='')
system.time(gmodel <- glm(as.formula(f),
                          data=mtcars,
                          family=binomial(link='logit'))) #get system time and train the model
log_predict <- predict(gmodel, 
                       newdata=mtcars, 
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




