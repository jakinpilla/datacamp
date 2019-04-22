load("./ML_tool_box/data/Churn.RData")

# Create custom indices : myFolds
myFolds <- createFolds(churn_y, k = 5)

# Create reusable trainControl object: myControl...

myControl <- trainControl(
  summaryFunction = twoClassSummary,
  classProbs = T,
  verboseIter = T,
  savePredictions = T,
  index = myFolds
)

model_glmnet <- train(
  x = churn_x,
  y = churn_y,
  metric = "ROC",
  method = "glmnet",
  trControl = myControl
)

model_rf <- train(
  x = churn_x,
  y = churn_y,
  metric = "ROC",
  method = "ranger",
  trControl = myControl
)

# Create model_list...
model_list <- list(item = model_glmnet,
                   item2 = model_rf)

resamples <- resamples(model_list)

summary(resamples)

bwplot(resamples, metric = "ROC")
xyplot(resamples, metric = "ROC")

















