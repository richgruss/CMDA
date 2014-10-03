#Lecture 6

getwd()
setwd("/Users/rgruss/git/CMDA")

#Load cars data from the URL and create  R data frame

#Data that is structured, with the right headings, 
#and ready to use for modeling
uciCar <- read.table(
  'http://www.win-vector.com/dfiles/car.data.csv',
  sep=',',
  header=T
)

#Examin the loaded data

class(uciCar) 
help(class(uciCar))
summary(uciCar)
dim(uciCar)

#Less-structured data; German credit data

d <- read.table(paste('http://archive.ics.uci.edu/ml/',
                      'machine-learning-databases/statlog/german/german.data',sep=''),
                stringsAsFactors=F,header=F)
#Examine data
head(d)
dim(d)[1] #number of rows or observations
dim(d)[2] #number of columns or variables

#Start reshaping data

#Give more meaningful names to the variables
#We know what those are from some separate documentation
names(d) <- c('Status.of.existing.checking.account',
                 'Duration.in.month', 'Credit.history', 'Purpose',
                 'Credit.amount', 'Savings account/bonds',
                 'Present.employment.since','Installment.rate.in.percentage.of.disposable.income',
                 'Personal.status.and.sex', 'Other.debtors/guarantors',
                 'Present.residence.since', 'Property', 'Age.in.years',
                 'Other.installment.plans', 'Housing',
                 'Number.of.existing.credits.at.this.bank', 'Job',
                 'Number.of.people.being.liable.to.provide.maintenance.for',
                 'Telephone', 'foreign.worker', 'Good.Loan')

#check the resulting variable names in data frame d
names(d)

#Create a map of values using lists

#################Lists####################
person <- list(name = "Jane", age = 24) 
person


#extract component of list with the extract operator $
person$name
person$age
#Another way to extract a list's individual elements
#using vector notation
person[1]
person["name"]

#What is the following doing?
person[[1]]
person[['name']]

############################################################

#Build a map to interpret loan use codes (meaningful values
#for the various codes present in our d data frame)
#using information from data documentation

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

mapping[1]
mapping['A11']
mapping[[1]]

#################Vectorized operation###################
x <- 1:3
x
Y <- x + 1
Y

####################Loops##################################

for(i in 1:10){
  print(i)
}

##################Conditional Assignment with If/Else##################

# if statement:
# Even example           
x <- 1:10 + 1  #vectorized operation
for(i in 1:10){  #loop
  if(x[i]%%2==0){ #if statement
    print(T)
    print (i)
  }
} 

# if/else statement:           
# Even example           
x <- 1:10 + 1
for(i in 1:10){
  if(x[i]%%2==0)
    print(T)
  else
    print(F)
} 
#######################################

#For our credit data, we might check the data manual 
#and decide we want more informative values
#for the variable Good.Loan
#The data documentation tells us that the value 1 right now
# refers to good loans and the value 2 refers to Bad Loans
#We will recode the variable values to illustrate that

d$Good.Loan <- 
  ifelse(d$Good.Loan==1,'GoodLoan','BadLoan') #another way to do if/else

d$Good.Loan[1:3]


#we now recode values in the data set using the mapping created
#we do this for all character variables where the A codes are encountered
# we need to be able to cycle through all the variables of interest
#and all the values for the variables of interest
#we use lists, loops and vectorization

nvariables <- dim(d)[2]


for(i in 1:nvariables) {
  if(class(d[,i])=='character') { #if variable i is character type
    d[,i] <- as.factor(as.character(mapping[d[,i]])) #look at all the values
    #of variable i and map the correct code to the correct string
    #use the associated string in the mapping list as being a character type
    #and assign it as the new value of variable i, changing the type
    #into factor
  }
}
?factor
?character


#Examine the data frame now, after reshaping

head(d)

#Save the reshaped data as an RData file that you can load later
#directly
save(d, file ="credit.RData")
#later can use
load("credit.RData") #this will create our d data frame directly


