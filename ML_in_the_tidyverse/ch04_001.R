library(tidyverse)

library(rsample)

# gapminder %>% head()
attrition <- readRDS('./data/attrition.rds') %>% as_tibble()
attrition %>% colnames()

set.seed(42)

# Prepare the initial split object
data_split <- initial_split(attrition, prop = .75)

# Extract the training dataframe
training_data <- training(data_split)

training_data %>% head()
training_data %>% dim()

# Extract the testing dataframe
testing_data <- testing(data_split)
testing_data %>% head()
testing_data %>% dim()
