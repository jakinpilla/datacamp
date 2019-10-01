library(tidyverse)

read_csv('./data/wbc.csv') %>% head() %>% View()

df <- read_csv('./data/wbc.csv')
df[, -33] %>% write_csv('./data/wbc.csv')
