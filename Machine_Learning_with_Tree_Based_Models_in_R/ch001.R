#' ---
#' title: "ch001(Tree-Based Method)"
#' author: "jakinpilla"
#' date : "`r format(Sys.time(), '%Y-%m-%d')`"
#' output: 
#'    github_document : 
#'        toc : true
#' ---
#' 
#' 

#+ message = FALSE, warning = FALSE
library(tidyverse)
library(broom)
library(gridExtra)
library(psych)
library(WVPlots)
library(mgcv)
library(ranger)
library(rpart)
library(rpart.plot)

read_csv('./data/credit.csv') %>%
  select(months_loan_duration,
         percent_of_income,
         years_at_residence,
         age,
         default) %>%
  sample_n(522) -> creditsub

#' Look at the data
str(creditsub)

#' Create the model
credit_model <- rpart(formula = default ~ ., 
                      data = creditsub, 
                      method = "class")

#' Display the results
rpart.plot(x = credit_model, yesno = 2, type = 0, extra = 0)

read_csv('./data/credit.csv') -> credit

#' Total number of rows in the credit data frame
n <- nrow(credit)

#' Number of rows for the training set (80% of the dataset)
n_train <- round(.8 * n) 

#' Create a vector of indices which is an 80% random sample
set.seed(123)
train_indices <- sample(1:n, n_train)

#' Subset the credit data frame to training indices only
credit_train <- credit[train_indices, ]  

#' Exclude the training indices to create the test set
credit_test <- credit[-train_indices, ]  



#' Train the model (to predict 'default')
credit_model <- rpart(formula = default ~ ., 
                      data = credit_train, 
                      method = "class")

#' Look at the model output                      
print(credit_model)

#' Generate predicted classes using the model object
class_prediction <- predict(object = credit_model,  
                            newdata = credit_test,   
                            type = "class")  

library(caret)
#' Calculate the confusion matrix for the test set
confusionMatrix(data = class_prediction,       
                reference = as.factor(credit_test$default))


#' Train a gini-based model
credit_model1 <- rpart(formula = default ~ ., 
                       data = credit_train, 
                       method = "class",
                       parms = list(split = 'gini'))

#' Train an information-based model
credit_model2 <- rpart(formula = default ~ ., 
                       data = credit_train, 
                       method = "class",
                       parms = list(split = 'information'))


#' Generate predictions on the validation set using the gini model
pred1 <- predict(object = credit_model1, 
                 newdata = credit_test,
                 type = 'class')    

#' Generate predictions on the validation set using the information model
pred2 <- predict(object = credit_model2, 
                 newdata = credit_test,
                 type = 'class')

ce <- function(actual, predicted) {
  return(mean(actual != predicted))
}


#' Compare classification error
ce(actual = credit_test$default, 
   predicted = pred1)

ce(actual = credit_test$default, 
   predicted = pred2)  



