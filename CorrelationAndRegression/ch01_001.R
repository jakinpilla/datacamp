library(tidyverse)
library(openintro)

data('ncbirths')

ncbirths %>% head()
ncbirths %>% colnames()

ggplot(ncbirths, aes(weeks, weight)) + geom_point()


# Boxplot of weight vs. weeks
ggplot(data = ncbirths, 
       aes(x = cut(weeks, breaks = 5), y = weight)) + geom_boxplot()

cut(ncbirths$weeks, breaks = 5) %>% unique()


data('mammals')
mammals %>% head()
mammals %>% colnames()

ggplot(mammals, aes(BodyWt, BrainWt)) + 
  geom_point()

data('mlbBat10')
mlbBat10 %>% colnames()
ggplot(mlbBat10, aes(OBP, SLG)) + geom_point()

?bdims
data('bdims')
bdims %>% colnames()
ggplot(bdims, aes(hgt, wgt, color = factor(sex))) + 
  geom_point()

data('smoking')
smoking %>% colnames()
ggplot(smoking, aes(age, amtWeekdays)) + geom_point()


mammals %>% colnames()
# Scatterplot with coord_trans()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() + 
  coord_trans(x = "log10", y = "log10")

# Scatterplot with scale_x_log10() and scale_y_log10()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() +
  scale_x_log10() + 
  scale_y_log10()


# Filter for AB greater than or equal to 200
ab_gt_200 <- mlbBat10 %>%
  filter(AB >= 200) 

# Scatterplot of SLG vs. OBP
ggplot(ab_gt_200, aes(x = OBP, y = SLG)) +
  geom_point()

# Identify the outlying player
ab_gt_200 %>%
  filter(OBP < .2)
