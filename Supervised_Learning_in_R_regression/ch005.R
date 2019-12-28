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

#' ###'Build a random forest model for bike rentals
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

#' ###'Visualize random forest bike model predictions

first_two_weeks <- bikesAugust %>% 
  #'Set start to 0, convert unit to days
  mutate(instant = (instant - min(instant)) / 24) %>% 
  #'Gather cnt and pred into a column named value with key valuetype
  gather(key = valuetype, value = value, cnt, pred) %>%
  #'Filter for rows in the first two
  filter(instant < 14) 

#' Plot predictions and cnt by date/time 
#+ fig.width = 10, fig.hight = 8
ggplot(first_two_weeks, aes(x = instant, y = value, color = valuetype, linetype = valuetype)) + 
  geom_point() + 
  geom_line() + 
  scale_x_continuous("Day", breaks = 0:14, labels = 0:14) + 
  scale_color_brewer(palette = "Dark2") + 
  ggtitle("Predicted August bike rentals, Random Forest plot")

#' The random forest model captured the day-to-day variations in peak demand better than the quasipoisson model, but it still underestmates peak demand, and also overestimates minimum demand. So there is still room for improvement.
#' 


#'dframe ...

popularity <- rnorm(10, 1, .4)
color <- c('b', 'r', 'r', 'r', 'r', 'b', 'r', 'g', 'b', 'b')
size <- c(13, 11, 15, 14, 13, 11, 9, 12, 7, 12)

dframe <- data.frame(
  color = color, 
  size= size,
  popularity = popularity
)

dframe

#'Create and print a vector of variable names
(vars <- c('color', 'size'))

#'Load the package vtreat
library(vtreat)
library(magrittr)

#'Create the treatment plan
treatplan <- designTreatmentsZ(dframe, vars)

treatplan %>% str()

treatplan %>%
  magrittr::use_series(scoreFrame) # use_series() is an alias for $ that you can pipe...

#'Examine the scoreFrame
(scoreFrame <- treatplan %>%
    magrittr::use_series(scoreFrame) %>%
    select(varName, origName, code))

#'We only want the rows with codes "clean" or "lev"
(newvars <- scoreFrame %>%
    filter(code %in% c('clean', 'lev')) %>%
    use_series(varName))

#'Create the treated training data
(dframe.treat <- prepare(treatplan, dframe, varRestriction = newvars))



#' practice data preprocessing with 

library(RMySQL)
library(DBI)

rm(con)

con <- dbConnect(
  RMySQL::MySQL(),
  user = "root", 
  password = "chr0n3!7!",
  dbname = 'adult'
)


# https://stackoverflow.com/questions/50745431/trying-to-use-r-with-mysql-the-used-command-is-not-allowed-with-this-mysql-vers?rq=1

# The following steps should fix the dbWritetable() error in R:
#   
#   Login MySQL terminal by typing "MySQL -u user -p*" (followed by user password if you set one).
# 
# Type "SET GLOBAL local_infile = true;" in the MySQL terminal command.
# 
# Lastly, type "SHOW GLOBAL VARIABLES LIKE 'local_infile';" into the terminal and check the command line output for the ON status.
# 
# I'm not sure why the database function fails from MySQL 5.6 to 8.0, however, "local_infile" enables user access to data loads from local sources--- this solution should work for all database interference stacks (R, Python, etc)!

# dbWriteTable(con, "adult", adult, overwrite = TRUE)



adult <- dbSendQuery(con, "SELECT * FROM adult")

dbClearResult(dbListResults(con)[[1]])

tbl(con, "adult") %>%
  select(age, education, race, capital_gain) %>%
  group_by(race) %>%
  summarise(sum_capital_gain = sum(capital_gain)) -> ql

show_query(ql)

tbl(con, "adult") %>%
  select(-row_names) -> adult

adult %>% as_tibble() -> adult_data

adult_data %>% head
adult_data %>% str()



#' treatplan is in the workspace
summary(treatplan)

#' newvars is in the workspace
newvars


popularity <- rnorm(10, 1, .4)
color <- c('g', 'g', 'y', 'g', 'g', 'y', 'b', 'g', 'g', 'r')
size <- c(7, 8, 10, 12, 6, 8, 12, 12, 12, 8)

data.frame(
  color = color, 
  size = size, 
  popularity = popularity
) -> testframe

#' Print dframe and testframe
print(dframe)
print(testframe)

#' Use prepare() to one-hot-encode testframe
(testframe.treat <- prepare(treatplan, testframe, varRestriction = newvars))


#' The outcome column
(outcome <- "cnt")

#' The input columns
(vars <- c("hr", "holiday", "workingday", "weathersit", "temp", "atemp", "hum", "windspeed"))

#' Load the package vtreat
library(vtreat)

#' Create the treatment plan from bikesJuly (the training data)
treatplan <- designTreatmentsZ(bikesJuly, vars, verbose = FALSE)

#' Get the "clean" and "lev" variables from the scoreFrame
(newvars <- treatplan %>%
    use_series(scoreFrame) %>%        
    filter(code %in% c('clean', 'lev')) %>%  #' get the rows you care about
    use_series(varName))           #' get the varName column

#' Prepare the training data
bikesJuly.treat <- prepare(treatplan, bikesJuly,  varRestriction = newvars)

#' Prepare the test data
bikesAugust.treat <- prepare(treatplan, bikesAugust,  varRestriction = newvars)

#' Call str() on the treated data
str(bikesJuly.treat)
str(bikesAugust.treat)


#' GBM
#' 

#' The July data is in the workspace
ls()

#' Load the package xgboost
library(xgboost)

#' Run xgb.cv
cv <- xgb.cv(data = as.matrix(bikesJuly.treat), 
             label = bikesJuly$cnt,
             nrounds = 100,
             nfold = 5,
             objective = "reg:linear",
             eta = .3,
             max_depth = 6,
             early_stopping_rounds = 10,
             verbose = 0    #' silent
)


#' Get the evaluation log 
elog <- cv$evaluation_log

#' Determine and print how many trees minimize training and test error
elog %>% 
  summarize(ntrees.train = which.min(train_rmse_mean),   #' find the index of min(train_rmse_mean)
            ntrees.test  = which.min(test_rmse_mean))   #' find the index of min(test_rmse_mean)


#' Examine the workspace
ls()

#' The number of trees to use, as determined by xgb.cv
ntrees <- 84

head(bikesJuly.treat)

#' Run xgboost
bike_model_xgb <- xgboost(data = as.matrix(bikesJuly.treat), #' training data as matrix
                          label = bikesJuly$cnt,  #' column of outcomes
                   nrounds = ntrees,       #' number of trees to build
                   objective = 'reg:linear', #' objective
                   eta = .3,
                   depth = 6,
                   verbose = 0  #' silent
)

#' Make predictions
bikesAugust$pred <- predict(bike_model_xgb, as.matrix(bikesAugust.treat))

#' Plot predictions (on x axis) vs actual bike rental count
ggplot(bikesAugust, aes(x = pred, y = cnt)) + 
  geom_point() + 
  geom_abline()


#' bikesAugust is in the workspace
str(bikesAugust)

#' Calculate RMSE
bikesAugust %>%
  mutate(residuals = cnt - pred) %>%
  summarize(rmse = sqrt(mean(residuals^2)))


#' Plot predictions and actual bike rentals as a function of time (days)
bikesAugust %>% 
  mutate(instant = (instant - min(instant))/24) %>%  #' set start to 0, convert unit to days
  gather(key = valuetype, value = value, cnt, pred) %>%
  filter(instant < 14) %>% #' first two weeks
  ggplot(aes(x = instant, y = value, color = valuetype, linetype = valuetype)) + 
  geom_point() + 
  geom_line() + 
  scale_x_continuous("Day", breaks = 0:14, labels = 0:14) + 
  scale_color_brewer(palette = "Dark2") + 
  ggtitle("Predicted August bike rentals, Gradient Boosting model")
