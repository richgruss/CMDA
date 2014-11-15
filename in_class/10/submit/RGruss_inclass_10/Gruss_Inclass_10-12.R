#load the iris data
data(iris)

#examine the data
names(iris)
head(iris)
summary(iris)

#the last column is the species.  take cols 1-4 for features
features <- iris[,1:4]

#variabels are raw lengths, normalize
scaled_features <- scale(features)

#FOR 10.3 : we need the data as a frame to use Shiny app
scaled_features_frame <-as.data.frame(scaled_features)
#fifth column is species name
label_points <- iris[,5]
#double check data
names(scaled_features_frame)
summary(scaled_features)
#see the distances between each observed iris
#rows and columns are both iris observations, so this gives
#a symmetrical matrix
distance <- dist(scaled_features, method = "euclidean")
distance

####### 10.1: Hierarchical Clustering #############################
hier_cl <- hclust(distance, method="ward.D")
plot(hier_cl, labels=iris$Species)
rect.hclust(hier_cl, k=3)
hierarchical_clustering_groups <- cutree(hier_cl, k = 3)
#gives a vector that maps each of the 150 observations to a cluster
print(hierarchical_clustering_groups) #print dendrogram

######### 10.2 K-Means Clustering ###################################

kmeans_clusters <- kmeans(distance, 3 , nstart=100, iter.max=100)
kmeans_clusters

#Compare the two clustering algo results 
compare <- cbind(hierarchical_clustering_groups,kmeans_clusters$cluster)
compare <- as.data.frame(compare)
names(compare) <- c("Hierarchical", "kmeans")
compare <- cbind(iris$Species,compare)
compare

#both alogorithms do well in grouping the setosas and the versicolors together.  
#Hierarchial used cluster 1 and kmeans called it 3, but the important point 
#is that both algorithms grouped them accuratey. Both were less successful 
#with the virginicas, though.  Both alogorithsm were all over the place 
#in the groupings of that species.


