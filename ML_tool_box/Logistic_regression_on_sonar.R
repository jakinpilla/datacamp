# install.packages("mlbench")

# Load the Sonar dataset...
library(mlbench)
data(Sonar)

# Look at the data...
head(Sonar)

# Randomly order the dataset...
rows <- sample(nrow(Sonar))
Sonar <- Sonar[rows, ]

# Find row to split on...
split <- round(nrow(Sonar) * .60)
train <- Sonar[1:split, ]
test <- Sonar[(split + 1):nrow(Sonar), ]

# Confirm test set size...
nrow(train) / nrow(Sonar)

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



