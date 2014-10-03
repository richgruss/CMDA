
getwd()
setwd('/Users/rgruss/git/CMDA')


#The health insurance customer data
load('exampleData.rData')

summary(custdata$Income) #all obs, including 328 NAs

summary(custdata[!is.na(custdata$Income), "housing.type"])

meanincome <- mean(custdata$Income, na.rm=T)

Income.fix <- ifelse(is.na(custdata$Income), meanincome, custdata$Income)

summary(Income.fix)

breaks <- c(0, 10000, 50000, 100000, 250000, 1000000)

Income.groups <- cut(custdata$income, breaks=breaks, include.lowest=T)
