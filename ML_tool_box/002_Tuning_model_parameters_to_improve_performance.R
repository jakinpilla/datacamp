wine <- readRDS("./ML_tool_box/data/wine_100.RDS")
wine %>% as_tibble() -> wine; wine

# Fit random forest : model...
model <- train(
  quality ~., 
  tuneLength = 1,
  data = wine,
  method = "ranger",
  trControl = trainControl(
    method = "cv",
    number = 5,
    verboseIter = T
  )
)

model

model <- train(
  quality ~.,
  tuneLength = 3,
  data = wine,
  method = "ranger",
  trControl = trainControl(
    method = "cv",
    number = 5,
    verboseIter = T
  )
)

model

plot(model)

# Define the tuning grid : tuneGrid...
tuneGrid <- data.frame(
  .mtry =c(2, 3, 7),
  .splitrule = "variance",
  .min.node.size = 5
)

# Create custom trainControl : myControl...
myControl <- trainControl(
  method = "cv",
  number = 10,
  summaryFunction = twoClassSummary,
  classProbs = T,
  verboseIter = T
)

overfit <- read_csv('./ML_tool_box/data/overfit.csv')

model <- train(
  y ~.,
  overfit,
  method = "glmnet",
  trControl = myControl
)

# Print maximum ROC statistic...
max(model[["results"]][["ROC"]])

# Train glmnet with custom trainControl and tunning : model..
model <- train(
  y ~., 
  overfit,
  tuneGrid = expand.grid(
    alpha = 0:1,
    lambda = seq(0.0001, 1, length = 20)
  ),
  method = "glmnet",
  trControl = myControl
)

model

max(model[["results"]][["ROC"]])
















