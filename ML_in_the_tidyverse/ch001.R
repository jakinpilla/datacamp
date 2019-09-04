# list column workflow
# 1. make a list column | tidyr::nest()
# 2. work with list columns | purrr::map()
# 3. simplify the list columns | tidyr::unnest(), purrr::map_*()

setwd("~/datacamp/ML_in_the_tidyverse")
rm(list = ls()); gc()
library(tidyverse)
library(purrr)
library(dslabs)
# install.packages("dslabs")

# library(gapminder)
gapminder %>% as_tibble()
# load('./data/gapminder.rds')
# gapminder <- read_delim("data/gapminder.tsv", "\t", escape_double = FALSE, trim_ws = TRUE)

nested <- gapminder %>%
  group_by(country) %>%
  nest()


nested$data[[1]]
nested$data[[4]]


nested %>% unnest()

# Explore gapminder
head(gapminder)

# Prepare the nested dataframe gap_nested
gap_nested <- gapminder %>% 
  group_by(country) %>% 
  nest()

# Explore gap_nested
head(gap_nested)


# Create the unnested dataframe called gap_unnnested
gap_unnested <- gap_nested %>% 
  unnest()

# Confirm that your data was not modified  
identical(gapminder, gap_unnested)

# Extract the data of Algeria
algeria_df <- gap_nested$data[[2]]

# Calculate the minimum of the population vector
min(algeria_df$population, na.rm = T)

# Calculate the maximum of the population vector
max(algeria_df$population, na.rm = T)

# Calculate the mean of the population vector
mean(algeria_df$population, na.rm = T)

map(.x= nested$data, .f = ~mean(.x$population, na.rm = T))

pop_df <- nested %>%
  mutate(pop_mean = map(data, ~mean(.x$population, na.rm = T)))

pop_df %>% unnest(pop_mean)

nested %>%
  mutate(pop_mean = map_dbl(data, ~mean(.x$population, na.rm = T)))

nested %>%
  mutate(pop_mean = map(data, ~lm(formula = population ~ fertility, data = .x)))

# Calculate the mean population for each country
pop_nested <- gap_nested %>%
  mutate(mean_pop = map(data, ~mean(.x$population, na.rm = T)))

# Take a look at pop_nested
head(pop_nested)

# Extract the mean_pop value by using unnest
pop_mean <- pop_nested %>% 
  unnest(mean_pop)

# Take a look at pop_mean
head(pop_mean)
