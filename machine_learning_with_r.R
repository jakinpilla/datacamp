Packages <- c('plyr', 'dplyr', 'tidyverse', 'data.table', 'reshape2', 'caret', 'rpart', 'GGally', 'ROCR', 'party', 
              'randomForest', 'dummies', 'curl', 'gridExtra')

lapply(Packages, library, character.only=T)

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

airquality %>% head()

h <- new_handle(copypostfields = "moo=moomooo")
handle_setheaders(h,
                  "Content-Type" = "text/moo",
                  "Cache-Control" = "no-cache",
                  "User-Agent" = "A cow"
)

tmp <- tempfile()

curl_download('https://archive.ics.uci.edu/ml/machine-learning-databases/00291/airfoil_self_noise.dat', tmp, handle=h)
data <-read.table(tmp, header=F)
head(data)
feature_names <- c('freq', 'angle', 'ch_length',
                   'velocity', 'thickness', 'dec')

colnames(data) <- feature_names
head(data)
summary(data)
data %>% View()

str(data)
air <- data
fit <- lm(dec ~ freq + angle + ch_length, data =air)
air %>%
  select(freq, angle, ch_length) -> new.data

pred <- predict(fit, new.data)
rsme <- sqrt((1/nrow(air)) * sum( (air$dec - pred) ^ 2))

# Previous model
fit <- lm(dec ~ freq + angle + ch_length, data = air)
pred <- predict(fit)
rmse <- sqrt(sum( (air$dec - pred) ^ 2) / nrow(air))
rmse

# Your colleague's more complex model
fit2 <- lm(dec ~ freq + angle + ch_length + velocity + thickness, data = air)

# Use the model to predict for all values: pred2
pred2 <- predict(fit2)

# Calculate rmse2
rmse2 <- sqrt(sum( (air$dec - pred2) ^ 2) / nrow(air))

# Print out rmse2
rmse2

# taking data from web
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
data <- data[, -ncol(data)]

feature_names <- c('area', 'perimeter', 'compactness',
                   'length', 'width', 'asymmetry',
                   'groove_length')

colnames(data) <- feature_names
head(data)
summary(data)
data %>% View()

seeds <- data

set.seed(1)
str(seeds)

km_seeds <- kmeans(seeds, 3)
plot(length ~ compactness, data = seeds, col = km_seeds$cluster)
km_seed$tot.withinss / km_seeds$betweenss 

# split the sets
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

# using cross validation
set.seed(1)

# initialize the accs vector
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


# print out the mean of accs
print(mean(accs))

# Bias and Variance






































