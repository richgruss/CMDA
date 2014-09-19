#Lecture 10
#Managing Data


getwd()
setwd('/Users/rgruss/git/CMDA')

#reload the insurance data (new version of the file)

load("exampleData1.rData")


#Data Transformations

#to allow meaning

#Convert Continuous to Discrete

#For insurance customer data, create age categories
brks <- c(0,25,65,Inf)
custdata$age.range <- cut(custdata$age,
                          breaks = brks, include.lowest = T)
summary(custdata$age.range)

#Normalize age 
summary(custdata$age)
meanage <- mean(custdata$age)
custdata$age.normalized <- custdata$age/meanage
summary(custdata$age.normalized)

#Rescaling age
stdage <- sd(custdata$age)
meanage
stdage
custdata$age.normalized <- (custdata$age-meanage)/stdage
summary(custdata$age.normalized)
hist(custdata$age.normalized, breaks = 7)
hist(custdata$age, breaks = 7)

#Log Transformations

hist(custdata$Income)
hist(log10(custdata$Income))

#Sampling data

#Extracting a reproducible training and testing set

#First generate an additional column with random numbers
#between 0 and 1
#be sure to do this only once, and do it AFTER you clean your data
custdata$gp <- runif(dim(custdata)[1])

head(custdata$gp)

#Suppose you want 20% of your dataset to be in the training set
#and 80% in the test set.
#20% of gp values are below 0.20 and 80% of the values are above 0.20.
#So split dataset according to values of gp. (percentages will be approximate)

testSet <- subset(custdata, custdata$gp <= 0.2)
trainingSet <- subset(custdata, custdata$gp > 0.2)


#this works when each customer has its own row in the dataset
