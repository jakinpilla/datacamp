library(tidyverse)
library(openintro)

textbooks %>% head()
textbooks %>% dim()

bdims %>% colnames()
mammals %>% colnames()

# Linear model for weight as a function of height
lm(wgt ~ hgt, data = bdims)

# Linear model for SLG as a function of OBP
lm(SLG ~ OBP, data = mlbBat10)

# Log-linear model for body weight as a function of brain weight
lm(log(BodyWt) ~ log(BrainWt), data = mammals)

-105.011 + 1.018*170


mod <- lm(wgt ~ hgt, data = bdims)

coef(mod)

summary(mod)

mean(bdims$wgt)
fitted.values(mod) %>% mean()

mean(bdims$wgt) ==  mean(fitted.values(mod))

mean(residuals(mod))


# Load broom
library(broom)

# Create bdims_tidy
bdims_tidy = augment(mod)

# Glimpse the resulting data frame
glimpse(bdims_tidy)

ben = data.frame(wgt = c(74.8), hgt = c(182.8))

predict(mod, newdata = ben)

coef(mod)

coefs <- coef(mod) %>% as.matrix() %>% t() %>% as.data.frame()

# Add the line to the scatterplot
ggplot(data = bdims, aes(x = hgt, y = wgt)) + 
  geom_point() + 
  geom_abline(data = coefs, 
              aes(intercept = `(Intercept)`, slope = hgt),  
              color = "dodgerblue")


