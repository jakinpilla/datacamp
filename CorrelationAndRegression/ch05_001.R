library(tidyverse)
library(openintro)
library(broom)


mod <- lm(wgt ~ hgt, data = bdims)

# View summary of model
summary(mod)

# Compute the mean of the residuals
mean(residuals(mod))

df.residual(mod)

# Compute RMSE
sqrt(sum(residuals(mod)^2) / df.residual(mod))

bdims_tidy <- mod %>% augment()
bdims_tidy %>% colnames()


# View model summary
summary(mod)

# Compute R-squared
bdims_tidy %>%
  summarize(var_y = var(bdims$wgt), var_e = var(residuals(mod))) %>%
  mutate(R_squared = 1 - (var_e / var_y))

data('countryComplete')

# 46.4% of the variability in poverty rate among U.S. counties can be explained by high school graduation rate.

# Compute SSE for null model
mod_null %>%
  summarize(SSE = var(.resid))

# Compute SSE for regression model
mod_hgt %>%
  summarize(SSE = var(.resid))


# The leverage of an observation in a regression model is defined entirely in terms of the distance of that observation from the mean of the explanatory variable. That is, observations close to the mean of the explanatory variable have low leverage, while observations far from the mean of the explanatory variable have high leverage. 

# Rank points of high leverage
mod %>%
  augment() %>%
  arrange(desc(.hat)) %>%
  head()

# Rank influential points
mod %>%
  augment() %>%
  arrange(desc(.cooksd)) %>%
  head()

mlbBat10 %>% colnames()

# Create nontrivial_players
nontrivial_players <- mlbBat10 %>%
  filter(AB >= 10, OBP < .5)


# Fit model to new data
mod_cleaner <- lm(SLG ~ OBP, data = nontrivial_players)

# View model summary
summary(mod_cleaner)

coefs <- coef(mod_cleaner) %>% as.matrix() %>% t() %>% as.data.frame()

# Visualize new model
ggplot(nontrivial_players, aes(OBP, SLG)) +
  geom_point() + 
  geom_abline(data = coefs, aes(intercept = `(Intercept)`, slope = OBP),  color = "dodgerblue")


ggplot(nontrivial_players, aes(OBP, SLG)) +
  geom_point() + 
  geom_smooth(method = 'lm')


mod_cleaner %>%
  augment() %>%
  arrange(desc(.hat), .cooksd) %>%
  head()


