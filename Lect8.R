#Lecture 8

getwd()
setwd('/Users/rgruss/git/CMDA')


#The health insurance customer data
load('exampleData.rData')
#Examine data
names(custdata)
dim(custdata)
class(custdata)

#Summary statistics

summary(custdata) #for the entire data frame

#Visualizations
#We will use a new R package that we need to install
install.packages("ggplot2")
library(ggplot2)
help(package=ggplot2) #all functions in the package

#the + is function chaining; each term is a "layer"

#Histograms
ggplot(custdata) + 
  geom_histogram(aes(x=age),
                 binwidth = 5)+
  theme_bw() #to make background white

#Density plots
ggplot(custdata) +
  geom_density(aes(x=income)) +
  theme_bw() +
  ggtitle("Density plot")

#Bar charts for factor variables

#Visualize the marital status variable

ggplot(custdata) + 
  geom_bar(aes(x=marital.stat), fill = "green") +
  theme_bw() +
  ggtitle("Vertical Bar Chart")
  
#Horizontal bar chart for many categories

ggplot(custdata) +
  geom_bar(aes(x=state.of.res), fill = "blue") +
  coord_flip() +
  theme(axis.text.y = element_text(size = rel(0.7))) +
  theme_bw()+
  ggtitle("Horizontal Bar Chart")

?theme

#Bar chart with categories sorted in order of bar length (frequency)
#Steps:
#first create a table with frequencies for each category; 
#this is a table with numerical summaries
statesums <- table(custdata$state.of.res)
statesums
#make it into a data frame
statef <- as.data.frame(statesums)
statef
#give better names to the variables in the statef data frame
colnames(statef) <- c("state.of.res", "count")

head(statef)

#Sort states in the descending order of counts of observations
statef <- transform(statef, state.of.res=reorder(state.of.res,count))

#Build the horizontal bar chart with the new data
ggplot(statef) +
  geom_bar(aes(x=state.of.res,y=count),
           stat = "identity",
           fill = "blue")+
  coord_flip() +
  theme(axis.text.y = element_text(size=rel(0.6))) +
  theme_bw() +
  ggtitle ("Horizontal bar chart with ordered categories")
  