#' ---
#' title: "ch005(Tree-Based Method)"
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

#' ### Build a random forest model for bike rentals
#' 
#' You will use the ranger package to fit the random forest model. For this exercise, the key arguments to the ranger() call are:

#' --formula
#' 
#' --data
#' 
#' - num.trees: the number of trees in the forest.
#' 
#' - respect.unordered.factors : Specifies how to treat unordered factor variables. We recommend setting this to "order" for regression.
#' 
#' - seed: because this is a random algorithm, you will set the seed to get reproducible results

load('./data/Bikes.RData')
str(bikesJuly)

#'Random seed to reproduce results
seed <- 2019

#'The outcome column
(outcome <- "cnt")

#'The input variables
(vars <- c("hr", "holiday", "workingday", "weathersit", "temp", "atemp", "hum", "windspeed"))

#'Create the formula string for bikes rented as a function of the inputs
(fmla <- paste(outcome, "~", paste(vars, collapse = " + ")))


#'Fit and print the random forest model
(bike_model_rf <- ranger(fmla, #'formula 
                            bikesJuly, #'data
                            num.trees = 500, 
                            respect.unordered.factors = 'order', 
                            seed = seed))

#' Check bikesAugust data
str(bikesAugust)

#'bike_model_rf is in the workspace
bike_model_rf

predict(bike_model_rf, bikesAugust) %>% str()

#'Make predictions on the August data
bikesAugust$pred <- predict(bike_model_rf, bikesAugust)$predictions

#'Calculate the RMSE of the predictions
bikesAugust %>% 
  mutate(residual = pred - cnt)  %>% #'calculate the residual
  summarize(rmse  = sqrt(mean(residual^2)))      #'calculate rmse

#'Plot actual outcome vs predictions (predictions on x-axis)
ggplot(bikesAugust, aes(x = pred, y = cnt)) + 
  geom_point() + 
  geom_abline()

#' ### Visualize random forest bike model predictions

first_two_weeks <- bikesAugust %>% 
  # Set start to 0, convert unit to days
  mutate(instant = (instant - min(instant)) / 24) %>% 
  # Gather cnt and pred into a column named value with key valuetype
  gather(key = valuetype, value = value, cnt, pred) %>%
  # Filter for rows in the first two
  filter(instant < 14) 

#' Plot predictions and cnt by date/time 
#+ fig.width = 10, fig.hight = 8
ggplot(first_two_weeks, aes(x = instant, y = value, color = valuetype, linetype = valuetype)) + 
  geom_point() + 
  geom_line() + 
  scale_x_continuous("Day", breaks = 0:14, labels = 0:14) + 
  scale_color_brewer(palette = "Dark2") + 
  ggtitle("Predicted August bike rentals, Random Forest plot")


