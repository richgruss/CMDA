# Name: Scout (Mugdha) Sujyot
# Class name: Intro Data Analytics & Visualisation (CS 3654)
# Homework number: 1
# Date: 09/01/2014

# Git account: https://github.com/msujyot

getwd()
setwd("C:\\Users\\Scout\\Desktop\\School\\CS 3654\\RFolder")


# === Problem 1 ====

prices<- read.table('prices.csv', sep=',', header=F, skip = 1, col.names = c('PRICE', 'SQFT', 'AGE', 'NE' ))
print(prices)

# row.names gets and sets row names for data frames

hw1data<- read.table('HW1 data.txt', sep=' ', header=T, col.names=c('a','b','c'))  

hw1data

# === Problem 2 ====

# create a 4x4 matrix MAT1 using the cbind()function

c1 = c(-4, -1, -4, -1)
c2 = c(0, 2, 4, -9)
c3 = c(0, 0, 4, -1)
c4 = c(0, 0, 0, 1)
MAT1=cbind(c1,c2,c3, c4)
MAT1

# list the last element of the matrix with a one line command
MAT1[4,4]

# find the transpose of the matrix
t(MAT1)

# find the inverse of the matrix
solve(MAT1)




# === Problem 3 ====

fpe <- read.table("http://data.princeton.edu/wws509/datasets/effort.dat")

print(subset(fpe, effort == 0))      # print out only the observations with 0 effort
    
names(fpe)                  # print the names of the variables using one function
    
rownames(fpe)               # print the names of the rows using one function

head(fpe)                   # head() returns the first few rows of the dataset 

    
# Exports fpe data frame as both a text and a csv file
write.csv(fpe,file="fpe.csv") 
write.table(fpe,file="fpe.txt", sep="\t")
