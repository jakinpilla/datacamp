#' ---
#' title: "Introduction to ML learning with R(DataCamp)"
#' author: "jakinpilla"
#' output: rmarkdown::github_document
#' ---

Packages <- c('plyr', 'dplyr', 'tidyverse', 'data.table', 'reshape2', 'caret', 'rpart', 'GGally', 'ROCR', 'party', 'randomForest', 'dummies', 'curl', 'gridExtra', 'cluster.datasets')

#+ setup, include=FALSE
lapply(Packages, library, character.only=T)

airquality %>% head()

#' Loading datesets from Web
h <- new_handle(copypostfields = "moo=moomooo")
handle_setheaders(h,
                  "Content-Type" = "text/moo",
                  "Cache-Control" = "no-cache",
                  "User-Agent" = "A cow")
tmp <- tempfile()
curl_download('https://archive.ics.uci.edu/ml/machine-learning-databases/00291/airfoil_self_noise.dat', tmp, handle=h)
data <-read.table(tmp, header=F)
head(data)
feature_names <- c('freq', 'angle', 'ch_length',
                   'velocity', 'thickness', 'dec')

colnames(data) <- feature_names
head(data)
summary(data)


air <- data
fit <- lm(dec ~ freq + angle + ch_length, data =air)
air %>%
  select(freq, angle, ch_length) -> new.data

pred <- predict(fit, new.data)
rsme <- sqrt((1/nrow(air)) * sum( (air$dec - pred) ^ 2))

#' Previous model
fit <- lm(dec ~ freq + angle + ch_length, data = air)
pred <- predict(fit)
rmse <- sqrt(sum( (air$dec - pred) ^ 2) / nrow(air))
rmse

#' Your colleague's more complex model
fit2 <- lm(dec ~ freq + angle + ch_length + velocity + thickness, data = air)

#' Use the model to predict for all values: pred2
pred2 <- predict(fit2)

#' Calculate rmse2
rmse2 <- sqrt(sum( (air$dec - pred2) ^ 2) / nrow(air))

#' Print out rmse2
rmse2

#' taking data from web
h <- new_handle(copypostfields = "moo=moomooo")
handle_setheaders(h,
                  "Content-Type" = "text/moo",
                  "Cache-Control" = "no-cache",
                  "User-Agent" = "A cow")

tmp <- tempfile()
curl_download('https://archive.ics.uci.edu/ml/machine-learning-databases/00236/seeds_dataset.txt', tmp, handle=h)
data <-read.table(tmp, header=F)
data <- data[, -ncol(data)]

feature_names <- c('area', 'perimeter', 'compactness',
                   'length', 'width', 'asymmetry',
                   'groove_length')

colnames(data) <- feature_names
head(data)
summary(data)

seeds <- data

set.seed(1)
str(seeds)

km_seeds <- kmeans(seeds, 3)
plot(length ~ compactness, data = seeds, col = km_seeds$cluster)
km_seeds$tot.withinss / km_seeds$betweenss 

#' ### Decision Tree
#' 
#' Loading Data
titanic <- read.csv("./data/titanic3.csv")
head(titanic)

set.seed(1)
str(titanic)

titanic %>%
  select(pclass, survived, sex, age) -> titanic


tree <- rpart(survived ~., data = titanic,
              method = "class")

pred <- predict(tree, titanic, type = "class")

table(titanic$survived, pred) %>%
  as.matrix() -> conf
#' split the sets
set.seed(1)
head(titanic)
n <- nrow(titanic)
shuffled <- titanic[sample(n), ]

train_indice <- 1:round(.7*n)
test_indice <- (round(.7*n) + 1) : n

train <- shuffled[train_indice, ]
test <- shuffled[test_indice, ]

str(train)
str(test)

library(rpart)
tree <- rpart(survived ~., train, method = 'class')
pred <- predict(tree, test, type = "class")

conf <- table(test$survived, pred)

conf

#' using cross validation
set.seed(1)

#' initialize the accs vector
accs <- rep(0, 6)

for (i in 1:6) {
  # these indices indicate the interval of the test
  indices <- (((i- 1)*round((1/6)*nrow(shuffled))) + 1 :
                ((i*round((1/6) * nrow(shuffled)))))
  # print(indices)
  # print(length(indices))
  
  # exclude them from the train set
  train <- shuffled[-indices, ]
  
  # include them in the test set
  test <- shuffled[indices, ]
  
  # A model is learned using each training set
  tree <- rpart(survived ~ ., train, method= "class")
  
  # Make a prediction on the test set using tree
  pred <- predict(tree, test, type = "class")
  
  # assign the confusion matrix to conf
  conf <- table(test$survived, pred)
  
  # assign the accuracy of this model to the ith index in accs
  accs[i] <- sum(diag(conf)) / sum(conf)
  
}


#' print out the mean of accs
print(mean(accs))

#' Bias and Variance
#'
#' Decision Tree
set.seed(1)
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

tree <- rpart(survived ~., train, method = "class")

fancyRpartPlot(tree)

#' ### Clustering
#' Cluster: collection of objets
#' 
#' Similar within cluster
#' 
#' Dissimilar between clusters
#' 
#' WSS : Within Cluster Sums of Squares (Meassure of compactness)
#' 
#' BSS : Between Cluster Sums of Squares (Measure of separation)
#' 
#' Choosing k
#' 
#' - Goal : Find k that minimizes WSS
#' 
#' - Problems : WSS keeps decreasing as k increase
#' 
#' - Solution : WSS starts decreasing slowly
#' $$WSS / TSS < 0.2 (TSS = WSS + BSS)$$
#' 
#' Scree Plot, elbow...
#' 
#' `my_km <- kmeans(data, centers, nstarts)`
#' 
#' - centers : Starting centroid #clusters
#' 
#' - nstart : #times R restarts with different centroids
#' 
#' - `my_km$tot.withinss`` <-- WSS
#' 
#' - `my_km$betweenss` <-- BSS
#' 
#' taking the seed data from web
h <- new_handle(copypostfields = "moo=moomooo")
handle_setheaders(h,
                  "Content-Type" = "text/moo",
                  "Cache-Control" = "no-cache",
                  "User-Agent" = "A cow"
)

tmp <- tempfile()

curl_download('https://archive.ics.uci.edu/ml/machine-learning-databases/00236/seeds_dataset.txt', tmp, handle=h)
data <-read.table(tmp, header=F)
head(data)
ncol(data)

#' defining data feature names and save the data as an csv file
feature_names <- c('area', 'perimeter', 'compactness','length', 'width', 'asymmetry',
                   'groove_length', 'seed_type')
colnames(data) <- feature_names
data %>% write.csv("./data/seed_data.csv", row.names = F)
seeds <- data

#' Set random seed. 
set.seed(100)

#' Do k_means clustering with three clusters, repeat 20 times: seed_km
seeds_km <- kmeans(seeds, centers = 3, nstart = 20)

#' Compare clusters with actual  seed types. Set k-means clusters as rows
table(seeds_km$cluster, seeds$seed_type)

#' Plot the length as function of width. Color by cluster
plot(seeds$width, seeds$length, 
     xlab = "Length", ylab ="Width",
     col = seeds_km$cluster)

#' Apply kmeans to seeds twice : seeds_km_1 and seeds_km_2
set.seed(2019)
seeds_km_1 <- kmeans(seeds, centers = 5, nstart = 1)
seeds_km_2 <- kmeans(seeds, centers = 5, nstart = 1)

#' Return the ratio of the within cluster sum of squares
seeds_km_1$tot.withinss  /seeds_km_2$tot.withinss

#' Compare the resulting clusters
table(seeds_km_1$cluster, seeds_km_2$cluster)

#' cluster 4 from `seeds_km_1` completely contains cluster 5 from  seeds_km_2
#' 

library(cluster.datasets)
data("new.haven.school.scores")
new.haven.school.scores %>% head
school_result <- new.haven.school.scores[, -1]
str(school_result)

set.seed(2019)
str(school_result)

ratio_ss <- rep(0, 7)
for (k in 1:7) {
  
  # Apply k-means to school_result: school_km
  school_km <- kmeans(school_result, k, nstart = 20)
  
  # Save the ratio between of WSS to TSS in kth element of ratio_ss
  ratio_ss[k] <- school_km$tot.withinss / school_km$totss
  
}

#' Make scree plot s with type "b" and xlab "k"
plot(ratio_ss, type = "b", xlab = "k")

#' Cluser Evaluation
#' Not trivial! There is no truth
#' 
#' - No true labels
#' 
#' - No true response
#' 
#' Underlying idea :: Variance within clusters, Seperation between clusters
#' 
#' Alternative:: Diameter, Intercluster Distance
#' 
#' Dunnn's Index
#' 
#' Higher Dunn :: Better seperated / more compact
#' 
#' - High computational cost
#' 
#' Internal Validation : based on intrinsic knowledge
#' 
#' - BIC Index
#' 
#' - Silhouette's Index
#' 
#' External Validation : based on previous knowledge
#' 
#' - Hulbert's Correlation
#' 
#' - Jaccard's Coefficient
#' 
#' 








