library(tidyverse)

weather <- readRDS('weather.rds')

weather %>% head()

str(weather)

bmi <- read_csv('bmi_clean.csv')
bmi
class(bmi)
dim(bmi)
names(bmi)
str(bmi)
glimpse(bmi)
summary((bmi))

hist(bmi$Y2008)
plot(bmi$Y1980, bmi$Y2008)

