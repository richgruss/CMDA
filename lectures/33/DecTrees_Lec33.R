#Decision trees
setwd('/Users/rgruss/git/CMDA/lectures/33')
load('KDD2009.Rdata')

library(rpart)
?rpart

head(dTrain)
names(dTrain)#training set

#use Churn as the outcome
head(dTrain$churn) # 1 and -1 type variable; 1 is pos outcome

#Decision trees (CART: Classification and Regression Treess)

#problems with Dec trees: too many features; categ features with too many levels;
#too many missing values
#do a preliminary feature selection and feature engineering

#create a new response/classification category variable
#with values 0/1 (False/True)

dTrain$response <- dTrain$churn > 0
head(dTrain$response)

##using the previously selected features (through var selection methods)
#shortcut to create formula

f <- paste('response ~ ',paste(selVars,collapse=' + '),sep='')
f
tmodel <- rpart(f,data=dTrain,
                control=rpart.control(cp=0.001,minsplit=1000,
                                      minbucket=1000,maxdepth=5))
tmodel

?rpart #learn more
?rpart.control #learn.more

#to visualize tree
install.packages("rpart.plot")
library(rpart.plot)
prp(tmodel)

#another measure of performance :ROC curve and AUC

install.packages('ROCR') #only need to do this once
library(ROCR)

#using the same training data data
#should do for at least one test set as well
dTrain$pred <- predict(tmodel, newdata = dTrain)
eval <- prediction(dTrain$pred, dTrain$response) #from ROCR package

#calculate AUC

auc_calc <- performance(eval,'auc')
auc_calc@y.values #special object; this is how we extract the exact AUC part
#good AUC is close to 1; useless models have AUC of 0.5

#plot ROC curve

plot(performance(eval, "tpr", "fpr"))
#when area under the curve AUC is maximum we have a good model

#Example classification with decision trees and more than three categories example
data(iris)
# fit model
fit <- rpart(Species~., data=iris)
fit
# make predictions (using the same training set; should also use at least one test set)
predictions <- predict(fit, iris[,1:4], type="class")
# summarize accuracy
table(predictions, iris$Species)

prp(fit)

