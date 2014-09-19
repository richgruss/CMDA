#Lecture 10
#Managing Data

getwd()
setwd('/Users/rgruss/git/CMDA')
#reload the insurance data (new version of the file)

load("exampleData.rData")

summary(custdata)
#Missing values

#Are the 56 NA's in "recent.move", "housing.type", and "num.vehicles" for the same rows?


#extract rows/observations/customers where there are NA's for the housing.type
#variable; create a new data frame with only the variables "recent.move" and "num.vehicles"
d <- custdata[is.na(custdata$housing.type),
              c("recent.move","num.vehicles")]
#explore the new data frame
summary(d)
#can probably drop these rows from original data frame

#Explore variable is.employed

summary(custdata$is.employed)
#328 NA's; differentiate between true missing and "not seeking employment" 
#need additional information: students? retirees? people of leisure? entrepreneurs? 
#stay at home dads?

#helpful to set NA = missing so that models don't drop rows

custdata$is.employed.fix <- ifelse(is.na(custdata$is.employed), "missing", 
                                   ifelse(custdata$is.employed, "employed", "not employed"))

summary(custdata$is.employed.fix) #because not factor, R does not recognize levels/categories
summary(as.factor(custdata$is.employed.fix)) #tell R to treat variable as factor

#or change the type of variable in the data frame
custdata$is.employed.fix <- factor(custdata$is.employed.fix) 
summary(custdata$is.employed.fix) #now the variable is a factor

#Tip: keep track of your variable transformations; document it all.

#Missing Data in Numeric variables
summary(custdata$Income)

#1.missing randomly; replace NA's with the average of the variable

avgIncome <- mean(custdata$Income, na.rm = T) #na.rm is an argument that tells R
#to ignor the NA's, so that it does not return NA for the avgIncome calculation
#many R functions have a default way to deal with NA's
#and an argument that you can change to deal differently with NA's
#na.rm means "remove NA", a logical argument

income.fix <- ifelse(is.na(custdata$Income),
                     avgIncome,
                     custdata$Income)

#recheck
summary(income.fix)

#Values of numeric variable missing systematically; 
#For eg., income data missing  because customers are not employed

#Cut numeric variable into categories
#Make one of the categories "missing" or "not employed" or "no income"

breaks <-c(0, 10000, 50000, 100000, 250000, 1000000)
Income.groups <-
  cut(custdata$Income,
      breaks=breaks, include.lowest=T)

summary(Income.groups) #this is now a factor variable

#Now change NA to "no income"
Income.groups <- ifelse(is.na(Income.groups),
                        "no income", Income.groups)

summary(as.factor(Income.groups))
#what happened?

#We have a quick fix to preserve category names

Income.groups <-
  cut(custdata$Income,
      breaks=breaks, include.lowest=T)

Income.groups <- as.character(Income.groups) # use as character var

Income.groups <- ifelse(is.na(Income.groups),
                        "no income", Income.groups)

summary(as.factor(Income.groups))

#Question: why can't we just replace the initial NA's with 0
#income? 
#Sol: sometimes we can, sometimes we can but we keep track of the change;
#sometimes we cut the numeric into categories; data science really is an art


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

