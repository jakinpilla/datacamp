# Bayesian method....

locations <- read_csv('./data/locations.csv')

locations %>%
  filter(hour == 9 & hourtype == 'morning') %>%
  select(daytype, location) -> where9am

where9am

# Compute P(A) 
p_A <- nrow(subset(where9am, location == 'office')) / nrow(where9am)
p_A

# Compute P(B)
p_B <- nrow(subset(where9am, daytype == 'weekday')) / nrow(where9am)
p_B

# Compute the observed P(A and B)
p_AB <- nrow(subset(where9am, location == 'office' & daytype == 'weekday')) / nrow(where9am)

# Compute P(A | B) and print its value
p_A_given_B <- p_AB / p_B
p_A_given_B


# -------------------------------------------------------------------------
# install.packages('naivebayes')
str(where9am)

# Load the naivebayes package
library(naivebayes)

# Build the location prediction model
locmodel <- naive_bayes(location ~ ., data = where9am)

# thursday9am <- data.frame(daytype = c('weekday'))
# thursday9am$daytype <- factor(thursday9am$daytype, levels = c('weekday', 'weekend'))
# str(thursday9am)

# Predict Thursday's 9am location
predict(locmodel, thursday9am)

saturday9am <- data.frame(daytype = c('weekend'))
saturday9am$daytype <- factor(saturday9am$daytype, levels = c('weekday', 'weekend'))
str(saturday9am)


# Predict Saturdays's 9am location
predict(locmodel, saturday9am)

# Examine the location prediction model
locmodel

# Obtain the predicted probabilities for Thursday at 9am
predict(locmodel, thursday9am , type = 'prob')

# Obtain the predicted probabilities for Saturday at 9am
predict(locmodel, saturday9am , type = 'prob')

# A 'naive' simplication....
## The joint probability of independent events can be computed much more simply by multiplying their individual probabilities.
# An 'infrequent' problem...
# The Laplace correction...

df <- read_csv('./data/locations.csv')
locations <- df %>% select(daytype, hourtype, location)

# Build a NB model of location
locmodel <- naive_bayes(location ~ daytype + hourtype, 
                        data = locations)


weekday_afternoon <- locations[13, ]
weekday_evening <- locations[19, ]

# Predict Brett's location on a weekday afternoon
predict(locmodel, weekday_afternoon)

# Predict Brett's location on a weekday evening
predict(locmodel, weekday_evening)


##----
weekend_afternoon <- locations[85, ]

# Observe the predicted probabilities for a weekend afternoon
predict(locmodel, weekend_afternoon, type = 'prob')

# Build a new model using the Laplace correction
locmodel2 <- naive_bayes(location ~ ., data  = locations, laplace = 1)

# Observe the new predicted probabilities for a weekend afternoon
predict(locmodel2, weekend_afternoon, type = 'prob')


# Binning numeric data fot NB...
# text data fot NB
