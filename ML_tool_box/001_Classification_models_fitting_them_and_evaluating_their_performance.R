

# install.packages("mlbench")
library(tidyverse)
library(caret)

# Load the Sonar dataset...
library(mlbench)
data(Sonar)

# Look at the data...
head(Sonar)

# Get the number of observation...
n_obs <- nrow(Sonar)

# Shuffle row indices : permuted_rows...
permuted_rows <- sample(n_obs)

# Randomly order data : Sonar...
Sonar_shuffled <- Sonar[permuted_rows, ]

# Identify row to split on : split...
split <- round(n_obs * 0.60)

# Create train...
train <- Sonar_shuffled[1:split, ]

# Create test...
test <- Sonar_shuffled[(split+1): n_obs, ]

# Fit glm model : model...
model <- glm(Class ~. ,
             family = "binomial",
             data = train)

# Prdict on test : p...
p <- predict(model, test, type = "response")

# Calculate a confusion matrix...

# If p exceeds threshold of .5, M else R : m_or_r...
m_or_r <- ifelse(p > .5, "M", "R")

# Convert to factor : p-class...
p_class <- factor(m_or_r, levels = levels(test[["Class"]]))

#  Create confusion matrix...
confusionMatrix(p_class, test$Class)

# If p exceeds threshold of .9, M else R : m_or_r
m_or_r <- ifelse(p > .9, "M", "R")

# Convert to factor : p_class
p_class <- factor(m_or_r, levels = levels(test[["Class"]]))

# Create confusion matrix...
confusionMatrix(p_class, test$Class)

# If p exceeds threshold of .9, M else R : m_or_r
m_or_r <- ifelse(p > .1, "M", "R")

# Convert to factor : p_class
p_class <- factor(m_or_r, levels = levels(test[["Class"]]))

# Create confusion matrix...
confusionMatrix(p_class, test$Class)

library(caTools)
p <- predict(model, test, type = "response")

# Make ROC Curve...
colAUC(p, test$Class, plotROC = T)

# Create trainControl object : myControl...
myControl <- trainControl(
  method = "cv",
  number = 10,
  summaryFunction = twoClassSummary,
  classProbs = T,
  verboseIter = T
)

# Train glm with custom trainControl : model...
model <- train(Class ~., Sonar, method = "glm",
               trControl = myControl)

model


