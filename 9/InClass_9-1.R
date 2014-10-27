setwd('/Users/rgruss/git/CMDA/in_class/9')

load("fdata.RData")

attach(final)

model <- glm(ssc ~ som1 + som2 + som3 + som4 + som5) 
summary(model) 


