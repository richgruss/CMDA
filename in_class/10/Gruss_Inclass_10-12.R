data(iris)
names(iris)
head(iris)
summary(iris)

features <- iris[,1:4]

scaled_features <- scale(features)

scaled_features_frame <-as.data.frame(scaled_features)
label_points <- iris[,5]
names(scaled_features_frame)

summary(scaled_features)

distance <- dist(scaled_features, method = "euclidean")


####### Hierarchical Clustering #############################
hier_cl <- hclust(distance, method="ward.D")
plot(hier_cl, labels=iris$Species)
rect.hclust(hier_cl, k=3)
hierarchical_clustering_groups <- cutree(hier_cl, k = 3)
print(hierarchical_clustering_groups) 

######### K-Means Clustering ###################################

kmeans_clusters <- kmeans(distance, 3 , nstart=100, iter.max=100)
kmeans_clusters

#Compare the two clustering algo results 
#for protein data(hier and kmeans)

compare <- cbind(hierarchical_clustering_groups,kmeans_clusters$cluster)
compare <- as.data.frame(compare)
names(compare) <- c("Hierarchical", "kmeans")
compare <- cbind(iris$Species,compare)
compare