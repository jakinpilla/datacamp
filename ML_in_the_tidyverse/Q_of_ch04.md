Questions of ch04
================

Loding dataset…

``` r
library(tidyverse)
library(rsample)
attrition <- readRDS('./data/attrition.rds') %>% as_tibble()
attrition %>% colnames()
```

    ##  [1] "Age"                      "Attrition"               
    ##  [3] "BusinessTravel"           "DailyRate"               
    ##  [5] "Department"               "DistanceFromHome"        
    ##  [7] "Education"                "EducationField"          
    ##  [9] "EnvironmentSatisfaction"  "Gender"                  
    ## [11] "HourlyRate"               "JobInvolvement"          
    ## [13] "JobLevel"                 "JobRole"                 
    ## [15] "JobSatisfaction"          "MaritalStatus"           
    ## [17] "MonthlyIncome"            "MonthlyRate"             
    ## [19] "NumCompaniesWorked"       "OverTime"                
    ## [21] "PercentSalaryHike"        "PerformanceRating"       
    ## [23] "RelationshipSatisfaction" "StockOptionLevel"        
    ## [25] "TotalWorkingYears"        "TrainingTimesLastYear"   
    ## [27] "WorkLifeBalance"          "YearsAtCompany"          
    ## [29] "YearsInCurrentRole"       "YearsSinceLastPromotion" 
    ## [31] "YearsWithCurrManager"

Prepare the initial split object

``` r
set.seed(42)
data_split <- initial_split(attrition, prop = .75)
```

Extract the training and testing dataframe

``` r
training_data <- training(data_split)
testing_data <- testing(data_split)

# Calculate the dimensions of both training_data and testing_data
dim(training_data)
```

    ## [1] 1103   31

``` r
dim(testing_data)
```

    ## [1] 367  31

Prepare the dataframe containing the cross validation partitions

``` r
set.seed(42)

cv_split <- vfold_cv(training_data, v = 5)

cv_data <- cv_split %>% 
  mutate(
    # Extract the train dataframe for each split
    train = map(splits, ~training(.x)), 
    # Extract the validate dataframe for each split
    validate = map(splits, ~testing(.x))
  )
```

Use head() to preview cv\_data

``` r
head(cv_data)
```

    ## # A tibble: 5 x 4
    ##   splits            id    train               validate           
    ## * <list>            <chr> <list>              <list>             
    ## 1 <split [882/221]> Fold1 <tibble [882 x 31]> <tibble [221 x 31]>
    ## 2 <split [882/221]> Fold2 <tibble [882 x 31]> <tibble [221 x 31]>
    ## 3 <split [882/221]> Fold3 <tibble [882 x 31]> <tibble [221 x 31]>
    ## 4 <split [883/220]> Fold4 <tibble [883 x 31]> <tibble [220 x 31]>
    ## 5 <split [883/220]> Fold5 <tibble [883 x 31]> <tibble [220 x 31]>

``` r
# Extract the first model and validate 
model <- cv_models_lr$___[[___]]
validate <- cv_models_lr$___[[___]]

# Prepare binary vector of actual Attrition values in validate
validate_actual <- ___ == "Yes"

# Predict the probabilities for the observations in validate
validate_prob <- predict(___, ___, type = "response")

# Prepare binary vector of predicted Attrition values for validate
validate_predicted <- ___
```

``` r
library(Metrics)

# Compare the actual & predicted performance visually using a table
table(___, ___)

# Calculate the accuracy
accuracy(___, ___)

# Calculate the precision
precision(___, ___)

# Calculate the recall
recall(___, ___)
```

``` r
cv_prep_lr <- cv_models_lr %>% 
  mutate(
    # Prepare binary vector of actual Attrition values in validate
    validate_actual = map(___, ~.x$___ == "___"),
    # Prepare binary vector of predicted Attrition values for validate
    validate_predicted = map2(.x = ___, .y = ___, ~predict(.x, .y, type = "response") > ___)
  )
```

``` r
# Calculate the validate recall for each cross validation fold
cv_perf_recall <- cv_prep_lr %>% 
  mutate(validate_recall = map2_dbl(___, ___, 
                                       ~recall(actual = .x, predicted = .y)))

# Print the validate_recall column
cv_perf_recall$___

# Calculate the average of the validate_recall column
___
```

``` r
library(ranger)

# Prepare for tuning your cross validation folds by varying mtry
cv_tune <- cv_data %>%
  crossing(mtry = c(___)) 

# Build a cross validation model for each fold & mtry combination
cv_models_rf <- cv_tune %>% 
  mutate(model = map2(___, ___, ~ranger(formula = Attrition~., 
                                           data = .x, mtry = .y,
                                           num.trees = 100, seed = 42)))
```

``` r
cv_prep_rf <- cv_models_rf %>% 
  mutate(
    # Prepare binary vector of actual Attrition values in validate
    validate_actual = map(validate, ~.x$___ == "___"),
    # Prepare binary vector of predicted Attrition values for validate
    validate_predicted = map2(.x = ___, .y = ___, ~predict(.x, .y, type = "response")$predictions == "Yes")
  )

# Calculate the validate recall for each cross validation fold
cv_perf_recall <- cv_prep_rf %>% 
  mutate(recall = map2_dbl(.x = ___, .y = ___, ~recall(actual = .x, predicted = .y)))

# Calculate the mean recall for each mtry used  
cv_perf_recall %>% 
  group_by(___) %>% 
  summarise(mean_recall = mean(___))
```

``` r
# Build the logistic regression model using all training data
best_model <- glm(formula = ___, 
                  data = ___, family = "binomial")


# Prepare binary vector of actual Attrition values for testing_data
test_actual <- testing_data$___ == "___"

# Prepare binary vector of predicted Attrition values for testing_data
test_predicted <- predict(___, ___, type = "response") > ___
```

``` r
# Compare the actual & predicted performance visually using a table
___

# Calculate the test accuracy
___

# Calculate the test precision
___

# Calculate the test recall
___
```
