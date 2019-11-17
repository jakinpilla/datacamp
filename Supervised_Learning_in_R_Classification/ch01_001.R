# kNN

# Classification tasks for driverless cars...

signs_total <- read_csv('./data/knn_traffic_signs.csv')
signs_total %>% dim()

colnames(signs_total)
dim(signs_total)
head(signs_total$sign_type)

signs_total %>% distinct(sign_type)

# library(caret)
# 
# not_test_idx <- createDataPartition(signs_total$sign_type, p=.8, list = F)[, 1] 
# 
# not_test_signs_total <- signs_total[not_test_idx, ]
# test_signs_total <- signs_total[-not_test_idx, ]
# 
# 
# train_idx <- createDataPartition(not_test_signs_total$sign_type, p=.9, list = F)[, 1] 
# 
# train_idx %>% length()
# 
# train_signs_total <- not_test_signs_total[train_idx, ]
# valid_signs_total <- not_test_signs_total[-train_idx, ]
# 
# dim(train_signs_total)[1] + dim(valid_signs_total)[1] + dim(test_signs_total)[1]
# 
# nrow(signs_total)
# 
# test_dataset <- test_signs_total %>%
#   select(-sign_type)

signs_total %>%
  filter(sample == 'train') %>%
  select(-sample, -id) -> signs

signs
signs[-1]

signs_total %>%
  filter(sample == 'test') %>%
  select(-sample, -id, -sign_type) -> next_sign

# Load the 'class' package
library(class)

# Create a vector of labels
sign_types <- signs$sign_type

# Classify the next sign observed
knn(train = signs[-1], test = next_sign, cl = sign_types)


# Examine the structure of the signs dataset
str(signs)

# Count the number of signs of each type
table(signs$sign_type)

# Check r10's average red level by sign type
aggregate(r10 ~ sign_type, data = signs, mean)



# -------------------------------------------------------------------------

signs_total %>%
  filter(sample == 'train') %>%
  select(-sample, -id) -> signs

signs_total %>%
  filter(sample == 'test') %>%
  select(-sample, -id) -> test_signs

# Use kNN to identify the test road signs
sign_types <- signs$sign_type
signs_pred <- knn(train = signs[-1], test = test_signs[-1], cl = sign_types) # to predict test)signs' class(sign_type) with signs[-1] train data...

# Create a confusion matrix of the predicted versus actual values
signs_actual <- test_signs$sign_type
table(signs_pred, signs_actual)

# Compute the accuracy
mean(signs_pred == signs_actual)

# Bigger k is not always better...

signs_test <- test_signs

# Compute the accuracy of the baseline model (default k = 1)
k_1 <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types)
mean(k_1 == signs_test$sign_type)

# Modify the above to set k = 7
k_7 <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types, k=7) # notice the argument  k = 7
mean(k_7 == signs_test$sign_type)

# Set k = 15 and compare to the above
k_15 <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types, k=15)
mean(k_15 == signs_test$sign_type)


# Use the prob parameter to get the proportion of votes for the winning class
sign_pred <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types, k=7, prob = TRUE)

# Get the "prob" attribute from the predicted classes
sign_prob <- attr(sign_pred, "prob")

# Examine the first several predictions
head(sign_pred)

# Examine the proportion of votes for the winning class
head(sign_prob)


# kNN benefits from normalized data...

# Normalizing data...

normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

signs$r1 %>% normalize() %>% summary()
signs$r1 %>% summary()




