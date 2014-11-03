setwd('/Users/rgruss/git/CMDA/in_class/9')

#synthetic variables; no header; no names

data29 <- read.csv('train.csv', header = F, sep = ',')
head(data29)

data29Labels <- read.csv('trainLabels.csv', header = F, sep = ',')
head(data29Labels)

#I will have to get a testing and training set 

#change the name of the variable in Labels
names(data29Labels) <- "target"
names(data29Labels)

#put data and labels together
all <- cbind(data29, data29Labels)
head(all)
rm(data29)
rm(data29Labels)

#create a random variable and use it to extract a 50% training
#and 50% test set
all$gp <- runif(dim(all)[1])
train <- subset(all, all$gp > 0.5)
test <- subset(all, all$gp <= 0.5)

#Make sure we know what we got
names(train)
head(train)

#fit logistic regression to train set

#make response a factor variable with values 0/1
#corresponding to the two classes we want to use
y <- factor(train$target)
head(y)

#Use only the first 20 variables in the train set; 40 slow down 
#and might create computational issues with this method

#Use a shortcut to create the logistic regression formula

x <- paste("V", 1:20, sep="")
x
x1 <- paste(x, collapse = "+")
x1
fmla <- paste("y",x1,sep = '~')
print(fmla)

#Train the logistic regression model
log_reg <- glm(fmla, data = train, family = "binomial")
summary(log_reg)

#Use the training set to see prediction ability of the same data
train$pred <- predict(log_reg, newdata = train, type = "response")
head(train$pred)
head(y)

#check sum(pred)= number of positive outcomes in y
#this is a property of the logistic regression

table(y)
sum(train$pred)

#visualize predicted vs actual using the training set

library(ggplot2)
#distribution of prediction scores by the original
#value of y, 0 or 1 (false or true)
ggplot(train, aes(x=pred, color=factor(target), linetype=factor(target))) +  geom_density()

#looks like a good threshold could be p_thresh = 0.5
#we use training data to pick threshold

#now validation on test set

test$pred <- predict(log_reg, newdata = test, type = "response")
head(test)

#Use threshold for test set prediction and get confusion matrix

confusion.test <- table(pred=test$pred>0.5, target = test$target)
confusion.test
#rows contain predicted negative and positives
#columns contain actual negatives and positives

#Then calculate, accuracy, precision and recall
accuracy <- (confusion.test[2,2] + confusion.test[1,1])/sum(confusion.test[,])
accuracy 
precision <- confusion.test[2,2] / sum(confusion.test[2,])
precision
recall <- confusion.test[2,2] / sum(confusion.test[,2])
recall

