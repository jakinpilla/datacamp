possum %>% head()

bdims %>% colnames()
# Scatterplot with regression line
ggplot(data = bdims, aes(x = hgt, y = wgt)) + 
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE)


64.594 - .591*92.4

summary(bdims)

171.1/69.15

bdims %>% colnames()

bdims %>%
  summarise(N = n(),
         r = cor(hgt, wgt),
         mean_hgt = mean(hgt), 
         mean_wgt = mean(wgt), 
         sd_wgt = sd(wgt),
         sd_hgt = sd(hgt)) -> bdims_summary

bdims_summary

bdims_summary %>%
  mutate(
    slope = r*(sd_wgt/sd_hgt),
    intercept = mean_wgt - slope*mean(mean_hgt)
  )

# data('Galton')

# install.packages("HistData")
library(HistData)
Galton %>% head()
GaltonFamilies %>% colnames()

GaltonFamilies %>%
  mutate(gender = ifelse(gender == 'male', 'M', 'F')) %>%
  filter(gender == 'M') %>%
  select(family, father, mother, gender, childHeight, childNum) %>%
  rename(sex = gender,
         height = childHeight,
         nkids = childNum) %>% 
  as_tibble() -> Galton_men
  
Galton_men

GaltonFamilies %>%
  mutate(gender = ifelse(gender == 'male', 'M', 'F')) %>%
  filter(gender == 'F') %>%
  select(family, father, mother, gender, childHeight, childNum) %>%
  rename(sex = gender,
         height = childHeight,
         nkids = childNum) %>% 
  as_tibble() -> Galton_women

Galton_women

# Height of children vs. height of father
ggplot(data = Galton_men, aes(x = father, y = height)) +
  geom_point() + 
  geom_abline(slope = 1, intercept = 0) + 
  geom_smooth(method = 'lm', se = FALSE)

# Height of children vs. height of mother
ggplot(data = Galton_women, aes(x = mother, y = height)) +
  geom_point() + 
  geom_abline(slope = 1, intercept = 0) + 
  geom_smooth(method = 'lm', se = FALSE)




