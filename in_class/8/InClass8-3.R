setwd('/Users/rgruss/git/CMDA/in_class/8')

load("fdata.RData")

attach(final)

model <- lm(ssc ~ som1 + som2 + som3 + som4 + som5 + som6 + 
              som7 + som8 + som9 +som10 + som11 + som12 +som13 + som14 + 
              age) 
summary(model) 

