# don't overfit

data(mtcars)
model <- lm(mpg ~ hp, mtcars[1:20, ])

predicted <- predict(model, 
                     mtcars[21:32, ],
                     type = "response")

actual <- mtcars[21:32, "mpg"]

sqrt(mean((predicted - actual)^2))

# Randomly order the data frame...
library(ggplot2)
data(diamonds)
set.seed(42)
rows <- sample(nrow(diamonds))
shuffled_diamonds <- diamonds[rows, ]

# Try an 80/20 split...
# Determine row to split on : split...
split <- round(nrow(diamonds) * .80)

# Create train...
train <- diamonds[1:split, ]

# Create test...
test <- diamonds[(split + 1) : nrow(diamonds), ]

# Predict on test set...
# Fit lm model on train model...
model <- lm(price ~., train)

# Predict on test : p...
p <- predict(model, test)

# Calculate test set RMSE by hand...
error <- p - test$price

# Calculate RMSE...
sqrt(mean(error^2))






