counties <- readRDS('./data/counties.rds')
counties


glimpse(counties)

counties %>%
  count(state)

counties %>%
  count(state, wt = population, sort =T)
