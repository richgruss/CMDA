getwd()
setwd('/Users/rgruss/git/CMDA')

load("exampleData1.rData")

combined <- merge(custdata,medianincome)

combined$norm.income <- combined$Income/combined$Median.Income

summary(combined$norm.income)

#this normalization is useful when you want to know the
#actualy purchasing power of a salary.  You want to see
#how it compares to the median for the state

combined$gp <- runif(dim(combined)[1])

head(combined$gp)

testSet <- subset(combined, combined$gp <= 0.3)
trainingSet <- subset(combined, combined$gp > 0.3)
