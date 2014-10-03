# Author:  Rich Gruss
# Date: 9-8-2014
# Homwork 1

setwd('/Users/rgruss/git/CMDA/')

########## PROBLEM 1 ##########

#import
pricedata <-read.table('prices.csv', sep=',', header=T, 
                       col.names=c('PRICE', 'SQFT', 'AGE', 'NE'))                  
pricedata

#The row.names parameter allows you to specify either a vector of row 
#names or a column number that holds the row names

tinydata <- read.table('tinytable.txt', sep=' ', header=T, col.names=c('a','b','c'))


########## PROBLEM 2 ##########
#carefully selected matrix (det=0) to get inverse
c1 = c(1, 1, 1, 1)
c2 = c(1, 2, 1, 2)
c3 = c(1, 1, 1, 0)
c4 = c(1, 4, 2, 2)
MAT1=cbind(c1,c2,c3, c4)

#last element
MAT1[4,4]

#transpose
t(MAT1)

#inverse
solve(MAT1)

########## PROBLEM 3 ##########
fpe <- read.table("http://data.princeton.edu/wws509/datasets/effort.dat") 

#from fpe data frame, get rows where effort=0, all columns
fpe[fpe$effort==0,]

#names of variables
names(fpe)

#row names
row.names(fpe)

#the head function selects the top n parts of a vector or data frame.  
#second param specifies the number you want, default is 6
head(fpe, 20)

#export to text
write.table(fpe,file="fpe.txt", sep="\t")
#export to csv
write.csv(fpe,file="fpe.csv") 
