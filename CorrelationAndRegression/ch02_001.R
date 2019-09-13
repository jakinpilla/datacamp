library(tidyverse)
library(openintro)

# Compute correlation
ncbirths %>% colnames()
ncbirths %>%
  summarize(N = n(), r = cor(weight, mage))

# Compute correlation for all non-missing pairs
ncbirths %>%
  summarize(N = n(), 
            r = cor(weight, mage, use = 'pairwise.complete.obs'))


# anscombe %>%
#   gather() %>%
#   mutate(set = NA) %>%
#   mutate(set = ifelse((is.na(set) & str_detect(key, '1')), 'set1', set)) %>%
#   mutate(set = ifelse((is.na(set) & str_detect(key, '2')), 'set2', set)) %>%
#   mutate(set = ifelse((is.na(set) & str_detect(key, '3')), 'set3', set)) %>%
#   mutate(set = ifelse((is.na(set) &  str_detect(key, '4')), 'set4', set)) %>%
#   mutate(key = ifelse(str_detect(key, 'x'), 'x', 'y')) %>%
#   rowid_to_column() %>%
#   spread(key, value)

anscombe %>%
  select(x1, y1) %>%
  rename(x = x1, y = y1) %>%
  mutate(set = 'set1') -> df.1

anscombe %>%
  select(x2, y2) %>%
  rename(x = x2, y = y2) %>%
  mutate(set = 'set2') -> df.2

anscombe %>%
  select(x3, y3) %>%
  rename(x = x3, y = y3) %>%
  mutate(set = 'set3') -> df.3

anscombe %>%
  select(x4, y4) %>%
  rename(x = x4, y = y4) %>%
  mutate(set = 'set4') -> df.4

bind_rows(df.1, df.2, df.3, df.4) -> Anscombe

ggplot(data = Anscombe, aes(x, y)) + 
  geom_point() + 
  facet_wrap(~set)


# Compute properties of Anscombe
Anscombe %>%
  group_by(set) %>%
  summarize(
    N = n(), 
    mean_of_x = mean(x), 
    std_dev_of_x = sd(x), 
    mean_of_y = mean(y), 
    std_dev_of_y = sd(y), 
    correlation_between_x_and_y = cor(x, y)
  )


# Run this and look at the plot
ggplot(data = mlbBat10, aes(x = OBP, y = SLG)) +
  geom_point()

# Correlation for all baseball players
mlbBat10 %>%
  summarize(N = n(), r = cor(OBP, SLG))


# Run this and look at the plot
mlbBat10 %>% 
  filter(AB > 200) %>%
  ggplot(aes(x = OBP, y = SLG)) + 
  geom_point()

# Correlation for all players with at least 200 ABs
mlbBat10 %>%
  filter(AB >= 200) %>%
  summarize(N = n(), r = cor(OBP, SLG))


# Run this and look at the plot
ggplot(data = bdims, aes(x = hgt, y = wgt, color = factor(sex))) +
  geom_point() 

# Correlation of body dimensions
bdims %>%
  group_by(sex) %>%
  summarize(N = n(), r = cor(hgt, wgt))


# Run this and look at the plot
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() + scale_x_log10() + scale_y_log10()

# Correlation among mammals, with and without log
mammals %>%
  summarize(N = n(), 
            r = cor(BodyWt, BrainWt), 
            r_log = cor(log(BodyWt), log(BrainWt)))


# make noise dataset

x = rnorm(1000, 0, 1)
y = rnorm(1000, 0, 1)
x == y
z = rep(1:20, 500)

noise = data.frame(x = x, y = y, z = z)
noise %>% dim()

# Create faceted scatterplot

ggplot(noise, aes(x, y)) + 
  geom_point() + 
  facet_wrap(~z)


# Compute correlations for each dataset
noise_summary <- noise %>%
  group_by(z) %>%
  summarize(N = n(), spurious_cor = cor(x, y))

# Isolate sets with correlations above 0.2 in absolute strength
noise_summary %>%
  filter(abs(spurious_cor) > .2)

