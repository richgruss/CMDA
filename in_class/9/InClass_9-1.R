setwd('/Users/rgruss/git/CMDA/in_class/9')

load("fdata.RData")

attach(final)

#convert ssc to factor

model1 <- glm(disorder ~ som1 + som2 + som3 + som4 + som5, family=binomial) 
summary(model1) 

#som2,3,4 and 5 are significant.
# Null deviance: 447.70  on 322  degrees of freedom
#Residual deviance: 123.75  on 317  degrees of freedom
#AIC: 135.75

model2 <- glm(disorder ~ som6 + som7 + som8 + som8 + som9, family=binomial) 
summary(model2) 

#som6,7,8 and 9 are significant
# Null deviance: 447.70  on 322  degrees of freedom
#Residual deviance: 270.32  on 318  degrees of freedom
#AIC: 280.32

model3 <- glm(disorder ~ som10 + som11 + som12 + som13 + som14, family=binomial) 
summary(model3) 

#13 and 10 are significant
# Null deviance: 447.70  on 322  degrees of freedom
#Residual deviance: 110.32  on 317  degrees of freedom
#AIC: 122.32

#model 3 is the best at predicting the likelihood disorder, because it has the lowest 
#residual deviance. 




