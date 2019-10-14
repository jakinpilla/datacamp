# hierarchical clustering...

# botttom-up....

# Create hierarchical clustering model: hclust.out
hclust.out <- hclust(dist(x))

# Inspect the result
summary(hclust.out)


plot(hclust.out)
abline(h = 1.2, col = 'red')

cutree(hclust.out, h = 1.2)

# Cut by height
cutree(hclust.out, h = .7)

# Cut by number of clusters
cutree(hclust.out, k = 3)


# complete, single, average, centroid...

colMeans(x)
apply(x, 2, sd)

scaled_x <- scale(x)

colMeans(scaled_x)
apply(scaled_x, 2, sd)


# Cluster using complete linkage: hclust.complete
hclust.complete <- hclust(dist(x), method = 'complete')

# Cluster using average linkage: hclust.average
hclust.average <- hclust(dist(x), method = 'average')

# Cluster using single linkage: hclust.single
hclust.single <- hclust(dist(x), method = 'single')

# Plot dendrogram of hclust.complete
plot(hclust.complete, main = 'Complete')

# Plot dendrogram of hclust.average
plot(hclust.average, main = 'Average')

# Plot dendrogram of hclust.single
plot(hclust.single, main = 'Single')

# -------------------------------------------------------------------------

# View column means
colMeans(pokemon)

# View column standard deviations
apply(pokemon, 2, sd)

# Scale the data
pokemon.scaled <- scale(pokemon)

# Create hierarchical clustering model: hclust.pokemon
hclust.pokemon <- hclust(dist(pokemon.scaled), method = 'complete')


# Apply cutree() to hclust.pokemon: cut.pokemon
cut.pokemon <- cutree(hclust.pokemon, k = 3)

km.pokemon <- kmeans(pokemon, centers = 3, nstart = 20, iter.max = 50)

# Compare methods
table(km.pokemon$cluster, cut.pokemon)






