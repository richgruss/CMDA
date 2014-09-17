setwd('/Users/rgruss/git/CMDA')

load('phsample.RData')

"This is PUMS (Public Use Microdata Survey) data from the US Census.  Each row 
represents one anonymized person.  Is dhus, there are 2982 observations of 210 
variables, and in dpus there are 6279 observatiosn of 288 variables.  Variables 
include things like age, sex, employement class, and education level."

psub = subset(dpus, with (dpus,
              (PINCP > 1000) & 
                (ESR == 1) & 
                (PINCP <= 250000) & 
                (PERNP > 1000) &
                (PERNP <= 250000) &
                (WKHP >= 40) &
                (AGEP >= 20) & (AGEP <= 50) &
                (PWGTP1 > 0) & (COW %in% (1:7)) & (SCHL %in% (1:24))
                ))

"psub is a data frame that is a subset of the rows dpus
the function subset takes a variable number of args in this order:
1) the vector, matrix, or frame to subset
2) a logical expression indicating rows to keep
...
Here the dpus is the frame, and several predicates are 
chained together using R's logical AND operator (&), including 
income range (PINCP and PERNP columns), age and COW (I assume 
'category of work'"

psub$SEX = as.factor(ifelse(psub$SEX==1, 'M','F'))
"uses R's ternary function (ifelse) to change the SEX column to read 
M and F instead of 1 and 2.  the factor() function converts a vector 
into a factor.  'as.factor' coerces an argument to a factor"

psub$SEX = relevel(psub$SEX, 'M')
#reorders the level of the factor SEX so that M is first

cowmap <- c("Employee of a private for-profit",
            "Private not-for-profit employee",
            "Local government employee",
            "State government employee",
            "Federal government employee",
            "Self-employed not incorporated",
            "Self-employed incorporated")
#the 7 levels of work category we'll use to map numerics to factors

psub$COW = as.factor(cowmap[psub$COW])
#maps the numeric values in the COW column to their indexes in the cowmap

psub$COW = relevel(psub$COW, cowmap[1])
#reorders factor levels so that Employee of a private for-profit is first

schlmap = c(
  rep("no high school diploma", 15),
  "Regular high school diploma",
  "GED or alternative credential",
  "some college credit, no degree",
  "some college credit, no degree",
  "Associate's degree",
  "Bachelor's degree",
  "Master's degree",
  "Professional degree",
  "Doctorate degree")
  )
psub$SCHL = as.factor(schlmap[psub$SCHL])
psub$SCHL = relevel(psub$SCHL, schlmap[1])
#maps and relevels the school column, similar to cow

dtrain = subset(psub, ORIGRANDGROUP >= 500)
dtest = subset(psub, ORIGRANDGROUP < 500)
#splits psub into two subsets on the ORIGRANDGROUP variables value

summary(dtrain$COW)
#gives the counts of each work category

#Pew Social Trends data (see manual here: https://github.com/richgruss/CMDA/blob/master/data/Data%20manual.pdf)
pewSocial <- read.csv(
  'data/pew-diet-movies.csv',
  sep=',',
  header=T
)

dim(pewSocial)
names(pewSocial)
summary(pewSocial)

summary(pewSocial$AGE.What.is.your.age.)
              
              
              
              