library(openintro)
library(tidyverse)
marioKart %>% str()

mario_kart <- marioKart 

mario_kart %>% ggplot(aes(1, totalPr, col = cond)) + geom_boxplot()

mario_kart %>%
  filter(totalPr < 100) %>% 
  ggplot(aes(1, totalPr, col = cond)) + geom_boxplot()

boxplot(marioKart$totalPr)$stat

marioKart %>%
  filter(totalPr >= 28.98, totalPr <= 100) -> mario_kart

# Explore the data
glimpse(mario_kart)
str(mario_kart)

mario_kart %>% colnames()

# fit parallel slopes
lm(totalPr ~ wheels + cond, data = mario_kart)


library(broom)
mod <- lm(totalPr ~ wheels + cond, data = mario_kart)

# Augment the model
augmented_mod <- augment(mod)
glimpse(augmented_mod)

# scatterplot, with color
data_space <- ggplot(augmented_mod, aes(x = wheels, y = totalPr, color = cond)) + 
  geom_point()
  
# single call to geom_line()
data_space + 
  geom_line(aes(y = .fitted))

mod

babies %>% as_tibble() %>% head()

# build model
lm(bwt ~ age + parity, data =babies)

lm(bwt ~ gestation + smoke, data = babies)


ggplot(babies, aes(gestation, bwt, col = factor(smoke))) + 
  geom_point()




