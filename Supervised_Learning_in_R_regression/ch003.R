#' ---
#' title: "Advanced_R(chap_2)"
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

#' ### Logistic Regression

#' #### Fit a model of sparrow survival probability
#' 
#' sparrow survival probability against severe winter storm
#' 
#' - total_length: length of the bird from tip of beak to tip of tail (mm)
#' - weight: in grams
#' - humerus : length of humerus ("upper arm bone" that connects the wing to the body) (inches)

#' psedo r-square : deviance explained...
#' 

sparrow <- readRDS('./data/sparrow.rds')
summary(sparrow)

#' EDA
sparrow$survived <- ifelse(sparrow$status == 'Survived', 'Survived', 'Dead')
sparrow %>% str()
# sparrow %>% str()

#+ fig.height= 7
sparrow %>% 
  ggplot(aes(survived, total_length, col = survived)) + 
  geom_boxplot(alpha = .5) +
  geom_jitter() + 
  theme(legend.position = "none") +
  scale_color_brewer(palette = 'Set1') -> p1

sparrow %>% 
  ggplot(aes(survived, weight, col = survived)) + 
  geom_boxplot(alpha = .5) +
  geom_jitter() + 
  theme(legend.position = "none") +
  scale_color_brewer(palette = 'Set1') -> p2

sparrow %>% 
  ggplot(aes(humerus, fill = survived)) + 
  geom_density(alpha = .5) +
  # theme(legend.position = "none") +
  scale_fill_brewer(palette = 'Set1') -> p3

sparrow$survived %>% table() %>% 
  as.data.frame() %>%
  rename(status = '.') -> data

data %>%
  ggplot(aes(status, Freq, fill = status)) + geom_bar(stat = 'identity') +
  theme(legend.position = "none") +
  scale_fill_brewer(palette = 'Set1') -> p4

grid.arrange(p1, p2, p3, p4, ncol = 2)

#' show pairs graph...
sparrow %>%
  select(survived, total_length, weight, humerus) -> sparrow_1

pairs.panels(sparrow_1)

#' Create the survived column
sparrow$survived <- ifelse(sparrow$status == 'Survived', T, F)

#' Create the formula
(fmla <- survived ~ total_length + weight + humerus)

#' Fit the logistic regression model
sparrow_model <- glm(fmla, data = sparrow, family = binomial)

#' Call summary
summary(sparrow_model)

#' Call glance
(perf <- glance(sparrow_model))

#' Calculate pseudo-R-squared
(pseudoR2 <- 1 - perf$deviance / perf$null.deviance)


#' Make predictions
sparrow$pred <- predict(sparrow_model, type = 'response')

#' Look at gain curve
#+ fig.width = 10, fig.height = 10
GainCurvePlot(sparrow, 'pred', 'survived', "sparrow survival model")


### Poisson or quasipoisson

#' the average count per unit time is the same as the variance of the count
#' 
#' When the variance is much larger than the mean, the Poisson assumption doesn't apply, and one solution is to use quasipoisson regression, which does not assume that variance=mean.
#' 


#' - cnt: the number of bikes rented in that hour (the outcome)
#' - hr: the hour of the day (0-23, as a factor)
#' - holiday: TRUE/FALSE
#' - workingday: TRUE if neither a holiday nor a weekend, else FALSE
#' - weathersit: categorical, "Clear to partly cloudy"/"Light Precipitation"/"Misty"
#' - temp: normalized temperature in Celsius
#' - atemp: normalized "feeling" temperature in Celsius
#' - hum: normalized humidity
#' - windspeed: normalized windspeed
#' - instant: the time index -- number of hours since beginning of data set (not a variable)
#' - mnth and yr: month and year indices (not variables)

load('./data/Bikes.RData')

# bikesJuly is in the workspace
str(bikesJuly)

# The outcome column
outcome <- c('cnt')

# The inputs to use
vars <- c("hr", "holiday", "workingday", "weathersit",  "temp", "atemp", "hum", "windspeed")
# bikesJuly %>% colnames()

# Create the formula string for bikes rented as a function of the inputs
(fmla <- paste(outcome, "~", paste(vars, collapse = " + ")))

# Calculate the mean and variance of the outcome
(mean_bikes <- mean(bikesJuly$cnt))
(var_bikes <- var(bikesJuly$cnt))

# Fit the model
bike_model <- glm(fmla, data = bikesJuly, family = quasipoisson)

# Call glance
(perf <- glance(bike_model))

# Calculate pseudo-R-squared
(pseudoR2 <- 1 - perf$deviance / perf$null.deviance)

#' Predict bike rentals on new data
#' In this exercise you will use the model you built in the previous exercise to make predictions for the month of August. The data set bikesAugust has the same columns as bikesJuly.
#' 
#' Recall that you must specify type = "response" with predict() when predicting counts from a glm poisson or quasipoisson model.

# Make predictions on August data
bikesAugust$pred  <- predict(bike_model, newdata = bikesAugust, type = 'response')

# Calculate the RMSE
bikesAugust %>% 
  mutate(residual = pred - cnt) %>%
  summarize(rmse  = sqrt(mean(residual^2)))

# Plot predictions vs cnt (pred on x-axis)
ggplot(bikesAugust, aes(x = pred, y = cnt)) +
  geom_point() + 
  geom_abline(color = "darkblue")


# Plot predictions and cnt by date/time
bikesAugust %>% 
  # set start to 0, convert unit to days
  mutate(instant = (instant - min(instant))/24) %>%  
  # gather cnt and pred into a value column
  gather(key = valuetype, value = value, cnt, pred) %>%
  filter(instant < 14) %>% # restric to first 14 days
  # plot value by instant
  ggplot(aes(x = instant, y = value, color = valuetype, linetype = valuetype)) + 
  geom_point() + 
  geom_line() + 
  scale_x_continuous("Day", breaks = 0:14, labels = 0:14) + 
  scale_color_brewer(palette = "Dark2") + 
  ggtitle("Predicted August bike rentals, Quasipoisson model")


### GAM to learn non-linear trandform

#' Generalized Additive Models
#' 
#' Model soybean growth with GAM
#' 
#' In this exercise you will model the average leaf weight on a soybean plant as a function of time (after planting). As you will see, the soybean plant doesn't grow at a steady rate, but rather has a "growth spurt" that eventually tapers off. Hence, leaf weight is not well described by a linear model.
#' 

load('./data/Soybean.RData')
model.lin <- lm(weight ~ Time, data = soybean_train)

#' soybean_train is in the workspace
summary(soybean_train)

#' Plot weight vs Time (Time on x axis)
ggplot(soybean_train, aes(x = Time, y = weight)) + 
  geom_point() 

#' Create the formula 
(fmla.gam <- weight ~ s(Time) )

#' Fit the GAM Model
model.gam <- gam(fmla.gam, data = soybean_train, family= gaussian)


#' Call summary() on model.lin and look for R-squared
summary(model.lin)

#' Call summary() on model.gam and look for R-squared
summary(model.gam)

#' Call plot() on model.gam
plot(model.gam)

#' see soybean_test 
summary(soybean_test)

#' Get predictions from linear model
soybean_test$pred.lin <- predict(model.lin, newdata = soybean_test)

#' Get predictions from gam model
soybean_test$pred.gam <- as.numeric(predict(model.gam, newdata = soybean_test))

#' Gather the predictions into a "long" dataset
soybean_long <- soybean_test %>%
  gather(key = modeltype, value = pred, pred.lin, pred.gam)

#' Calculate the rmse
soybean_long %>%
  mutate(residual = weight - pred) %>%     # residuals
  group_by(modeltype) %>%                  # group by modeltype
  summarize(rmse = sqrt(mean(residual^2))) # calculate the RMSE

#' Compare the predictions against actual weights on the test data
soybean_long %>%
  ggplot(aes(x = Time)) +                          # the column for the x axis
  geom_point(aes(y = weight)) +                    # the y-column for the scatterplot
  geom_point(aes(y = pred, color = modeltype)) +   # the y-column for the point-and-line plot
  geom_line(aes(y = pred, color = modeltype, linetype = modeltype)) + # the y-column for the point-and-line plot
  scale_color_brewer(palette = "Dark2")

#' The GAM learns the non-linear growth function of the soybean plants, including the fact that weight is never negative.