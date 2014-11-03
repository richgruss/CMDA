#Stepwise Regression Demonstration for Linear Regression
#Validation of the Linear Regression Model

setwd('/Users/rgruss/git/CMDA/in_class/9')

bike <- read.csv("day.csv", header = T) #data on Scholar
#data source
#https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset

head(bike)

#cnt is the y variable (target score)
#all the other variables are features X

#First create a train and test set

bike$gp <- runif(dim(bike)[1])
testSet <- subset(bike, bike$gp <= 0.1)
trainSet <- subset(bike, bike$gp > 0.1)

rm(bike)

#package MASS has an implementation of the Stepwise regression
install.packages("MASS")
library(MASS)

attach(trainSet)
#first fit the linear regression with all features
fit <- lm(casual ~  season + yr + mnth + holiday + weekday +
            workingday + weathersit + temp + atemp + hum + windspeed)
summary(fit)

#then apply the stepwise procedure
step <- stepAIC(fit, direction = "both")

step
step$anova
rm(step)
rm(fit)


#And build the model with just the retained variables


fit1 <- lm(casual ~  season + yr + mnth + holiday + weekday +
             workingday + weathersit + temp + hum + windspeed)
summary(fit1)

detach(trainSet)

#Make predictions using the test set
testSet$casualpred <- predict(fit1, newdata = testSet)
head(testSet)

#See how predicted counts of casual users compare to 
#actual counts of casual users
library(ggplot2)
ggplot(data = testSet, aes(x = casualpred, y = casual)) +
  geom_point(color = "red")+
  geom_line(aes(x = casual, y = casual), color = "blue")
