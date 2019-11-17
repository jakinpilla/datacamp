# Binary predictions with regression...

donors <- read_csv('./data/donors.csv')
donors %>% head %>% as.data.frame()

# Examine the dataset to identify potential independent variables
str(donors)

# Explore the dependent variable
table(donors$donated)

# Build the donation model
donation_model <- glm(donated ~ bad_address + interest_religion + interest_veterans, 
                         data = donors, family = "binomial")

# Summarize the model results
summary(donation_model)


# Estimate the donation probability
donors$donation_prob <- predict(donation_model, type = "response")

# Find the donation probability of the average prospect
mean(donors$donated)

# Predict a donation if probability of donation is greater than average (0.0504)
donors$donation_pred <- ifelse(donors$donation_prob > 0.0504, 1, 0)

# Calculate the model's accuracy
mean(donors$donation_pred == donors$donated)

# Model performance tradeoffs...
# ROC curves...

donors %>% head %>% as.data.frame()

# Load the pROC package
library(pROC)

# Create a ROC curve
ROC <- roc(donors$donated, donors$donation_prob)

# Plot the ROC curve
plot(ROC, col = 'blue')

# Calculate the area under the curve (AUC)
auc(ROC)


# Dummy variables, missing data and interactions...
donors$wealth_rating

# Convert the wealth rating to a factor
donors$wealth_rating <- factor(donors$wealth_rating, levels = c(0, 1, 2, 3), labels = c('Unknown', 'Low', 'Medium', 'High'))

# donors %>% head %>% as.data.frame()
donors$wealth_rating

# Use relevel() to change reference category
donors$wealth_rating <- relevel(donors$wealth_rating, ref = "Medium")

# Levels: Medium Unknown Low High...

# See how our factor coding impacts the model
summary(glm(donated ~ wealth_rating, data = donors, family = "binomial"))

# What would the model output have looked like if this variable had been left as a numeric column?


# Find the average age among non-missing values
summary(donors$age)

# round(mean(donors$age, na.rm = T), 2)

# Impute missing age values with the mean age
donors$imputed_age <- ifelse(is.na(donors$age), round(mean(donors$age, na.rm = T), 2), donors$age)

# Create missing value indicator for age
donors$missing_age <- ifelse(is.na(donors$age), 1, 0)

View(donors)

colnames(donors)

# Donors that haven't given both recently and frequently may be especially likely to give again
rfm_model <- glm(donated ~ money + recency*frequency, data = donors, family = 'binomial')

# Summarize the RFM model to see how the parameters were coded
summary(rfm_model)

# Compute predicted probabilities for the RFM model
rfm_prob <- predict(rfm_model, donors, type = 'response')

# Plot the ROC curve and find AUC for the new model
library(pROC)
ROC <- roc(donors$donated, rfm_prob)
plot(ROC, col = "red")
auc(ROC)


# Automatic feature selection...

# Stepwise regression...

# Though stepwise regression is frowned upon, it may still be useful for building predictive models in the absence of another starting place...

# Specify a null model with no predictors
null_model <- glm(donated ~ 1, data = donors, family = "binomial")

# Specify the full model using all of the potential predictors
full_model <- glm(donated ~ ., data = donors, family = "binomial")

# Use a forward stepwise algorithm to build a parsimonious model
step_model <- step(null_model, scope = list(lower = null_model, upper = full_model), direction = "forward")

# Estimate the stepwise donation probability
step_prob <- predict(step_model, newdata = donors, type = 'response')

# Plot the ROC of the stepwise model
library(pROC)
ROC <- roc(donors$donated, step_prob)
plot(ROC, col = "red")
auc(ROC)
