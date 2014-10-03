getwd()
setwd('/Users/rgruss/git/CMDA')

load('exampleData.rData')

summary(custdata)

#marital.status: clean
#health.ins: clean
#housing.type: 56 missing values
#recenet.move: missing 56 values
#num.vehicles: 56 missing values 
#age:  maximum (146) cannot be right
#age.normalized: clean
#median income: clean
#income.norm:  clean
#gp: clean
#income:  328 missing values

uciCar <- read.table(
  'http://www.win-vector.com/dfiles/car.data.csv',
  sep=',',
  header=T
)

summary(uciCar)

#this is all factor data with varying levels, even though the number of doors
#may deceive us into thinking it's numeric.  In general, we don't seem to 
#be missing any variables.

load('credit.RData')

summary(d)

#we'll need to map these character codes onto meaningful strings
mapping <- list('A11'='... < 0 DM',
                'A12'='0 <= ... < 200 DM',
                'A13'='... >= 200 DM / salary assignments for at least 1 year',
                'A14'='no checking account',
                'A30'='no credits taken/all credits paid back duly',
                'A31'='all credits at this bank paid back duly',
                'A32'='existing credits paid back duly till now',
                'A33'='delay in paying off in the past',
                'A34'='critical account/other credits existing (not at this bank)',
                'A40'='car (new)',
                'A41'='car (used)',
                'A42'='furniture/equipment',
                'A43'='radio/television',
                'A44'='domestic appliances',
                'A45'='repairs',
                'A46'='education',
                'A47'='(vacation - does not exist?)',
                'A48'='retraining',
                'A49'='business',
                'A410'='others',
                'A61'='... < 100 DM',
                'A62'='100 <= ... < 500 DM',
                'A63'='500 <= ... < 1000 DM',
                'A64'='.. >= 1000 DM',
                'A65'='unknown/ no savings account',
                'A71'='unemployed',
                'A72'='... < 1 year',
                'A73'='1 <= ... < 4 years',
                'A74'='4 <= ... < 7 years',
                'A75'='.. >= 7 years',
                'A91'='male : divorced/separated',
                'A92'='female : divorced/separated/married',
                'A93'='male : single',
                'A94'='male : married/widowed',
                'A95'='female : single',
                'A101'='none',
                'A102'='co-applicant',
                'A103'='guarantor',
                'A121'='real estate',
                'A122'='if not A121 : building society savings agreement/life insurance',
                'A123'='if not A121/A122 : car or other, not in attribute 6',
                'A124'='unknown / no property',
                'A141'='bank',
                'A142'='stores',
                'A143'='none',
                'A151'='rent',
                'A152'='own',
                'A153'='for free',
                'A171'='unemployed/ unskilled - non-resident',
                'A172'='unskilled - resident',
                'A173'='skilled employee / official',
                'A174'='management/ self-employed/highly qualified employee/ officer',
                'A191'='none',
                'A192'='yes, registered under the customers name',
                'A201'='yes',
                'A202'='no')

num_variables <- dim(d)[2]
for(i in 1:num_variables) {
  if(class(d[,i])=='character') { #if variable i is character type
    d[,i] <- as.factor(as.character(mapping[d[,i]])) #look at all the values
    #of variable i and map the correct code to the correct string
    #use the associated string in the mapping list as being a character type
    #and assign it as the new value of variable i, changing the type
    #into factor
  }
}
summary(d$Personal.status.and.sex)

#we have much more specific knowledge of men's married status:
#92 married/widowed, 548 single, and 50 divorced or separated
#all 310 females are lumped into the same general category, div/sep/married

summary(d$`Other.debtors/guarantors`) #need to escape because of the /

#This tells me that credit must be easy in Germany
#907 loan applications had not co-applicant or guarantor,
#only 41 had co-applicants an 52 had guarantors




