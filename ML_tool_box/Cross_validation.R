# 10-fold cross-validation...
library(caret)
diamonds

model <- train(
  price ~., 
  diamonds,
  mothod = "lm",
  trControl = trainControl(
    method = "cv",
    number = 10,
    verboseIter = T
  )
)

# 5-fold cross-validation...
read.table('./data/housing_data.csv') -> boston
names(boston) <- c('crim', 'zn', 'indus', 'chas', 'nox', 'rm', 'age', 'dis', 'rad',  
                   'tax', 'ptratio', 'black', 'lstat', 'medv')
head(boston)

model <- train(
  medv ~.,
  boston,
  method = "lm",
  trControl = trainControl(
    method = "cv",
    number = 5, 
    verboseIter = T
  )
)

model

model <- train(
  medv ~.,
  boston,
  method = "lm",
  trControl = trainControl(
    method = "repeatedcv",
    number = 5, 
    repeats = 5,
    verboseIter = T
  )
)

model

# Predict on full Boston dataset...
predict(model, boston)





