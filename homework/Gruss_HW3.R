setwd('/Users/rgruss/git/CMDA')

#Pew Social Trends data (see manual here: https://github.com/richgruss/CMDA/blob/master/data/Data%20manual.pdf)
pewSocial <- read.csv(
  'data/pew-diet-movies.csv',
  sep=',',
  header=T
)

sink('pewSocialNames.txt')
names(pewSocial)
sink()

"1.  There are over 400 variables, corresponding to both basic biodemographic data and answers to survey questions.
Each question has a code for 'Don't know/refused', so for aggregate operations that involve rows with missing data, it is safe 
to drop those records. We're really only interested in the biodemo questions, fitness, and movies question.  
We've narrowed it down to 108 variables.  This creates a smaller dataframe with only the columns listed in 
the file pewSocialNamesSubset.txt."

columns_of_interest <- readLines('pewSocialNamesSubset.txt')
cols <- unlist(lapply(columns_of_interest, function (x) gsub("^\\s+|\\s+$", "", x)))
pewsubset <- subset(pewSocial, select = cols)

#Any numerical data has been conveniently broken up into buckets to begin with.  
#For example, income looks like this:
summary(pewsubset$INCOME.Last.year..that.is.in.2005..what.was.your.total.family.income.from.all.sources..before.taxes...Just.stop.me.when._labels)

"Don't know/Refused:363                                                                                      
 50 to under $75,000                  :338                                                                                      
 30 to under $40,000                  :247                                                                                      
 75 to under $100,000                 :246                                                                                      
 20 to under $30,000                  :231                                                                                      
 40 to under $50,000                  :222                                                                                      
 (Other)                              :604"

summary(pewsubset$Q.59.About.how.often.in.an.average.week.do.you.eat.a.meal.from.a.fast.food.restaurant.like.McDonald.s.or.Burger.King._labels)

#let's make names easier to work with:
colnames(pewsubset)[colnames(pewsubset)=="Q.59.About.how.often.in.an.average.week.do.you.eat.a.meal.from.a.fast.food.restaurant.like.McDonald.s.or.Burger.King._labels"] <- "fast_food_freq"
summary(pewsubset$fast_food_freq)

colnames(pewsubset)[colnames(pewsubset)=="RACE.Are.you.white.Hispanic..black.Hispanic..or.some.other.race...What.is.your.race...Are.you.white..black..Asian..or.so_labels"] <- "race"
summary(pewsubset$race)

ggplot(pewsubset) + geom_bar(aes(x=race,
                                 fill=fast_food_freq),
                             position="fill") +
  theme_bw()+
  ggtitle("Fast food frequency by race")


ggplot(pewSocial) + geom_bar(aes(x=Q.1.How.would.you.rate.the.overall.quality.of.your.life...READ._labels,
                                 fill=Census.region_labels),
                            position="fill") +
  theme_bw()+
  ggtitle("Quality of life per region")



