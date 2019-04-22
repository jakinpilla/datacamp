load("./ML_tool_box/data/BreastCancer.RData")

# Create custom trainControl : myControl...
myControl <- trainControl(
  method = "cv",
  number = 10,
  summaryFunction = twoClassSummary,
  classProbs = T,
  verboseIter = T
)

# Apply median imputation: median_model...
median_model <- train(
  x = breast_cancer_x,
  y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = "medianImpute"
)

# install.packages("RANN")
library(RANN)

# Apply KNN imputation: median_model...
knn_model <- train(
  x = breast_cancer_x,
  y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = "knnImpute"
)

knn_model

load("./ML_tool_box/data/BloodBrain.RData")

# Identify near zero variance predictors : remove_cols...
remove_cols <- nearZeroVar(bloodbrain_x,
                           names = T,
                           freqCut = 2,
                           uniqueCut = 20)

# Get all column names from bloodbrain_x : all_cols...

all_cols <- names(bloodbrain_x)

# Remove from data : bloodbrain_x_small...
bloodbrain_x_small <- 
  bloodbrain_x[, setdiff(all_cols, remove_cols)]

model <- train(
  x = bloodbrain_x_small,
  y = bloodbrain_y,
  method = "glm"
)

model

# Fit glm model using PCA : model...
model <- train(
  x = bloodbrain_x, 
  y = bloodbrain_y, 
  method ="glm",
  preProcess = "pca"
)

model

