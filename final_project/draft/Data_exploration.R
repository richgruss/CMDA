setwd('/Users/rgruss/git/CMDA/final_project')

#Bicycle share data (see manual here: https://www.kaggle.com/c/bike-sharing-demand/data)
bicycle_data <- read.csv(
  'bicycle_data.csv',
  sep=',',
  header=T
)

#10,886 observations of 12 variables
bicycle_data['datetime'] #10/19/12 14:00
bicycle_data['season'] #1 = spring, 2 = summer, 3 = fall, 4 = winter 
summary(bicycle_data$holiday)
summary(bicycle_data$temp)
bicycle_data$humidity
plot(bicycle_data$temp, bicycle_data$count)

