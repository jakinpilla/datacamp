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
#+ fig.width = 10
GainCurvePlot(sparrow, 'pred', 'survived', "sparrow survival model")

