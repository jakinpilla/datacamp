library(openintro)
library(tidyverse)
library(broom)

mod <- lm(totalPr ~ wheels + cond, data = mario_kart)

# R^2 and adjusted R^2
summary(mod)

# add random noise
mario_kart_noisy <- mario_kart %>%
  mutate(noise = rnorm(n = nrow(.)))

# mario_kart_noisy %>% View()
# compute new model
mod2 <- lm(totalPr ~ wheels + cond + noise, data = mario_kart_noisy)

# new R^2 and adjusted R^2
summary(mod2)

# return a vector
predict(mod)

# return a data frame
augment(mod)

# Interaction...

# The rate at which apples rot will vary based on the temperature.

# include interaction
lm(totalPr ~ duration + cond + duration:cond,
   data = mario_kart)

# interaction plot
# interaction plot
ggplot(mario_kart, aes(duration, totalPr, color = cond)) + 
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE)


SAT <- read_csv('./data/SAT.csv')

SAT %>% 
  mutate(sat_bin = cut(sat_pct, 3)) -> SAT_wbin

mod <- lm(formula = total ~ salary + sat_bin, data = SAT_wbin)

mod

ggplot(data = SAT_wbin, 
       aes(x = salary, y = total, color = sat_bin)) +
  geom_point() + 
  geom_line(data = broom::augment(mod), aes(y = .fitted))



slr <- ggplot(mario_kart, aes(y = totalPr, x = duration)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = 0)

# model with one slope
lm(totalPr ~ duration, data = mario_kart)

# plot with two slopes
slr + aes(color = cond)
