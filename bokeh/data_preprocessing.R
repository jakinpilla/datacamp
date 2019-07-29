library(tidyverse)
setwd('C:/Users/Daniel/datacamp/bokeh/')
getwd()

literacy_birth_rate <- read_csv('./data/literacy_birth_rate.csv')
literacy_birth_rate %>% colnames()

literacy_birth_rate$fertility -> fertility
literacy_birth_rate$`female literacy` -> female_literacy

fertility

literacy_birth_rate %>% View()
literacy_birth_rate_1 <- literacy_birth_rate[1:162, ]

fertility <- literacy_birth_rate_1$fertility
female_literacy <- literacy_birth_rate_1$`female literacy`

fertility_data <- data.frame(fertility = fertility,fertility_data %>% write_csv("./data/fertility_data.csv")

           female_literacy = female_literacy)

literacy_birth_rate_1 %>% 
  rename(female_literacy = `female literacy`) %>%
  write_csv("./data/fertility_data.csv")


