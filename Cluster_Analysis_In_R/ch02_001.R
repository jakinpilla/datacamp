x <- c(-1, -2, 8, 7, -12, -15)
y <- c(1, -3, 6, -8, 8, 0)

players <- tibble(x = x, y = y)

dist_players <- dist(players, method = 'euclidean')
dist_players %>% hclust(method = 'complete') -> hc_players

hc_players %>%  cutree(k = 2) -> cluster_assignments

players %>%
  mutate(cluster = cluster_assignments) -> players_clustered

players_clustered

players_clustered %>%
  ggplot(aes(x, y, color = factor(cluster))) + geom_point(size = 3)


lineup <- readRDS('./data/lineup.rds')
# Calculate the Distance
dist_players <- dist(lineup, method = 'euclidean')

# Perform the hierarchical clustering using the complete linkage
hc_players <- hclust(dist_players, method = 'complete')

# Calculate the assignment vector with a k of 2
clusters_k2 <- cutree(hc_players, k = 2)

# Create a new data frame storing these results
lineup_k2_complete <- mutate(lineup, cluster = clusters_k2)


# Count the cluster assignments
count(lineup_k2_complete, cluster)

# Plot the positions of the players and color them using their cluster
ggplot(lineup_k2_complete, aes(x = x, y = y, color = factor(cluster))) +
  geom_point()

# Visualizing the Dendrogram

plot(hc_players)


# Prepare the Distance Matrix
dist_players <- dist(lineup)

# Generate hclust for complete, single & average linkage methods
hc_complete <- hclust(dist_players, method = 'complete')
hc_single <- hclust(dist_players, method = 'single')
hc_average <- hclust(dist_players, method = 'average')

# Plot & Label the 3 Dendrograms Side-by-Side
# Hint: To see these Side-by-Side run the 4 lines together as one command
par(mfrow = c(1,3))
plot(hc_complete, main = 'Complete Linkage')
plot(hc_single, main = 'Single Linkage')
plot(hc_average, main = 'Average Linkage')
