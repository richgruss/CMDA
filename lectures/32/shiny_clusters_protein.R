#Shiny visualization of kmeans clusters with protein data
#use 2 features at a time to determine a variable number of clusters
setwd('/Users/rgruss/git/CMDA/lectures/32')
protein <- read.table('protein.txt', header=T, sep='\t')

#Always examine data first
names(protein)
head(protein)
summary(protein)


#############################################
library(shiny)
runApp("App_3")

#have data loaded;
#will use the features for clustering
#and a separate variable with country names
#for labeling points in clusters
#ui and server R files should be in the folder "App_3" created
#at this location (working directory)

names(protein)
protein1 <- scale(protein[,-1])
protein1 <- as.data.frame(protein1)
names(protein1)
label_points <- protein[,1]
label_points


