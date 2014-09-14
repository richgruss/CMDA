#Lecture 9

getwd()
setwd('/Users/rgruss/git/CMDA')

#The health insurance customer data
load('exampleData.rData')
#Examine data
names(custdata)
dim(custdata)


library(ggplot2)

#Bivariate Charts

#Scatterplots: examine the relationship between age and income

#extract a subset of the dataset with reasonable values for the two 
#variables
custdata2 <- subset(custdata,
                    (custdata$age > 0 & custdata$age < 100
                     & custdata$income > 0))

#get a numerical summary of the relationship between the two
cor(custdata2$age, custdata2$income) #weak negative relationship

#get further insight into the relationship with a
#scatterplot visualization

ggplot(custdata2, aes(x=age,y=income)) +
  geom_point() +
  ylim(0,200000) +
  theme_bw() +
  ggtitle("Scatterplot of Income vs Age")

?geom_point

#can throw another variable in the mix

names(custdata2)
ggplot(custdata2, aes(x=age,y=income)) +
  geom_point(aes(colour = marital.stat )) +
  ylim(0,200000) +
  theme_bw() +
  ggtitle("Scatterplot of Income vs Age")

#can fit a line to the scatterplot, to approximate the relationship

ggplot(custdata2, aes(x=age,y=income)) +
  geom_point() + 
  stat_smooth(method = "lm")+
  ylim(0,200000) +
  theme_bw() +
  ggtitle("Scatterplot of Income vs Age") #not a very good fit
  
#can fit a smooth curve to the scatterplot, to better approximate
#the relationship
ggplot(custdata2, aes(x=age,y=income)) +
    ylim(0,200000) +
  geom_point() +
  geom_smooth()+
  ggtitle("Scatterplot of Income vs Age") +
  theme_bw() 

#there are other types of plots to: deal with high volume data, include a
#third variable etc.


#Stacked bar chart for relationship between two categorical variables
ggplot(custdata) +
  geom_bar(aes(x=marital.stat, fill=health.ins))+
  theme_bw()+
  ggtitle("How many people are insured per marital status")

#Side - by -side chart
ggplot(custdata) + geom_bar(aes(x=marital.stat,
                                fill=health.ins),
                            position="dodge") +
  theme_bw()+
  ggtitle("How many people are insured per marital status")

#Show relative frequencies with a filled bar chart

ggplot(custdata) + geom_bar(aes(x=marital.stat,
                                fill=health.ins),
                            position="fill") +
  theme_bw()+
  ggtitle("Compare percentages of people uninsured per marital category")

#Filled bar chart with a rug

ggplot(custdata, aes(x=marital.stat)) +
  geom_bar(aes(fill=health.ins), position="fill") +
  geom_point(aes(y=-0.05), size=0.75, alpha=0.3,
             position=position_jitter(h=0.01)) +
  theme_bw()+
  ggtitle("Compare percentages of people uninsured per marital category
          and how popular each marital category is")


#this adds a "rug" under the bar which shows the amount (density)

#If both variables have many categories: Faceted bar chart 

#first try side-by-side
ggplot(custdata2) +
  geom_bar(aes(x=housing.type, fill=marital.stat ),
           position="dodge") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme_bw()
  
#Faceted

ggplot(custdata2) +
  geom_bar(aes(x=marital.stat), position="dodge",
           fill="darkgray") +
  facet_wrap(~housing.type, scales="free_y") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


