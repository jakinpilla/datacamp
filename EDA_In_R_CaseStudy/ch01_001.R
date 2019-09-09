library(tidyverse)

votes <- readRDS('./data/votes.rds')
votes

# Filter for votes that are "yes", "abstain", or "no"
votes %>%
  filter(vote <= 3)


# Add another %>% step to add a year column
votes %>%
  filter(vote <= 3) %>%
  mutate(year = session + 1945)


# install.packages("countrycode")
# Load the countrycode package
library(countrycode)

# Convert country code 100
countrycode(100, "cown", "country.name")

# Add a country column within the mutate: votes_processed
votes_processed <- votes %>%
  filter(vote <= 3) %>%
  mutate(year = session + 1945) %>%
  mutate(country = countrycode(ccode, "cown", "country.name"))


# Print votes_processed
votes_processed

# Find total and fraction of "yes" votes
votes_processed %>%
  summarise(total = n(), percent_yes = mean(vote == 1))

