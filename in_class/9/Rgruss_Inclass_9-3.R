setwd('/Users/rgruss/git/CMDA/in_class/9')

load("NatalRiskData.rData")

train <- sdata[sdata$ORIGRANDGROUP <= 5,]
test <- sdata[sdata$ORIGRANDGROUP > 5,]

complications <- c("ULD_MECO", "ULD_PRECIP", "ULD_BREECH")
riskfactors <- c("URF_DIAB", "URF_CHYPER", "URF_PHYPER", "URF_ECLAM")

y <- "atRisk"
x <- c("PWGT",
       "UPREVIS",
       "CIG_REC",
       "GESTREC3",
       "DPLURAL",
       complications,
       riskfactors
  )
fmla <- paste(y, paste(x, collapse="+"), sep="~")

model <- glm(fmla, data=train, family=binomial(link="logit"))

test$pred <- predict(model, newdata = test, type = "response")
head(test$pred)
head(test$atRisk)

library(ggplot2)
#distribution of prediction scores by the original
#value of y, 0 or 1 (false or true)
ggplot(test, aes(x=pred, color=factor(atRisk), linetype=factor(atRisk))) +  geom_density()



