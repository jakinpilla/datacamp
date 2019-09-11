library(tidyverse)

library(openintro)
data('ncbirths')

ncbirths %>% head()
ncbirths %>% colnames()

ggplot(ncbirths, aes(weeks, weight)) + geom_point()
