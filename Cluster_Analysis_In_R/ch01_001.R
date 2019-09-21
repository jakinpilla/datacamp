setwd("~/datacamp/Cluster_Analysis_In_R")
library(tidyverse)

readRDS('./data/lineup.rds')


two_players <- data.frame(x = c(5, 15),  y = c(4, 10))

# Plot the positions of the players
ggplot(two_players, aes(x = x, y = y)) + 
  geom_point() +
  # Assuming a 40x60 field
  lims(x = c(-30,30), y = c(-20, 20))

# Split the players data frame into two observations
player1 <- two_players[1, ]
player2 <- two_players[2, ]

# Calculate and print their distance using the Euclidean Distance formula
player_distance <- sqrt( (player1$x - player2$x)^2 + (player1$y - player2$y)^2 )
player_distance


# Calculate the Distance Between two_players
dist_two_players <- dist(two_players)
dist_two_players

three_players <- data.frame(x = c(5, 15, 0), y = c(4, 10, 20))

# Calculate the Distance Between three_players
dist_three_players <- dist(three_players)
dist_three_players


trees

# Calculate distance for three_trees 
dist_trees <- dist(trees)

# Scale three trees & calculate the distance  
scaled_three_trees <- scale(trees)
dist_scaled_trees <- dist(dist_trees)

# Output the results of both Matrices
print('Without Scaling')
dist_trees

print('With Scaling')
dist_scaled_trees


wine = c(T, F, T)
beer = c(T, T, F)
whiskey = c(F, T, T)
vodka = c(F, T, F)


survey_a <- data.frame(wine=wine, beer=beer, whiskey = whiskey, vodka =vodka)

survey_a %>% as_tibble()

dist(survey_a, method='binary')

color = c('red', 'green', 'blue', 'blue')
sport = c('soccer', 'hockey', 'hockey', 'soccer')

survey_b <- data.frame(color = color, sport = sport)

library(dummies)

dummy_survey_b <- dummy.data.frame(survey_b)

dist(dummy_survey_b, method = 'binary')


job_satisfaction <- c('Low', 'Low', 'Hi', 'Low', 'Mid')
is_happy <- c('No', 'No', 'Yes', 'No', 'No')

job_survey <- data.frame(job_satisfaction = job_satisfaction, is_happy = is_happy)

# Dummify the Survey Data
dummy_survey <- dummy.data.frame(job_survey)

# Calculate the Distance
dist_survey <- dist(dummy_survey, method='binary')

# Print the Original Data
job_survey

# Print the Distance Matrix
dist_survey



dist_players <- dist_three_players

# Extract the pair distances
distance_1_2 <- dist_players[1]
distance_1_3 <- dist_players[2]
distance_2_3 <- dist_players[3]

# Calculate the complete distance between group 1-2 and 3
complete <- max(c(distance_1_3, distance_2_3))
complete

# Calculate the single distance between group 1-2 and 3
single <- min(c(distance_1_3, distance_2_3))
single

# Calculate the average distance between group 1-2 and 3
average <- mean(c(distance_1_3, distance_2_3))
average

