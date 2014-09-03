setwd('/Users/rgruss/git/CMDA/')

#import
carsdata<-read.table('cars1.csv', sep=',', header=T)

#size
dim(carsdata)

#assign 2,3 (but there's no 2,3, so we'll take 2,3)
var1 <-carsdata[2,2]

#vars:  age, weight, var1
head(carsdata, 0)

#print columns 1 and 2 separately
carsdata[,1]
carsdata[,2]

SPEED<-carsdata[,1]

print(SPEED)

carsdata[15,]
