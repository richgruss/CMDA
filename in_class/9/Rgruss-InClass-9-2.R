setwd('/Users/rgruss/git/CMDA/in_class/9')

load("fdata.RData")

# 90% training size
train_size <- floor(0.90 * nrow(final))
set.seed(123)
train_ind <- sample(seq_len(nrow(final)), size = train_size)
train <- final[train_ind, ]
test <- final[-train_ind, ]

full_model <- lm(ssc ~ age + gender + location 
                 + ethnicity + coder, data=train) 
summary(full_model) 

library(MASS)
step <- stepAIC(full_model, direction = "both")
summary(step)
step$anova

#coder and gender were dropped

reduced_model <- lm(ssc ~ age + location + ethnicity, data=train) 
summary(reduced_model) 

test$sscpred <- predict(reduced_model, newdata = test)

library(ggplot2)
ggplot(data = test, aes(x = sscpred, y = ssc)) +
  geom_point(color = "red")+
  geom_line(aes(x = ssc, y = ssc), 
            color = "blue")

#this model does not predict well at all.  
#the dots are nowhere near the line




