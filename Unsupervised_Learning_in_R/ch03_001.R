# PCA...

# Perform scaled PCA: pr.out
# pokemon_total %>%
#   select(HitPoints, Attack, Defense, Speed) -> pokemon

pr.out <- prcomp(pokemon, scale = T, center = T)  

# Inspect model output
summary(pr.out)

pr.out$rotation
pr.out$x


# Biplot....
biplot(pr.out)

pr.var <- pr.out$sdev^2
pve <- pr.var / sum(pr.var)

plot(pve, type = 'b')



# Plot variance explained for each principal component
plot(pve, xlab = "Principal Component",
        ylab = "Proportion of Variance Explained",
        ylim = c(0, 1), type = "b")

# Plot cumulative proportion of variance explained
plot(cumsum(pve), xlab = "Principal Component",
        ylab = "Cumulative Proportion of Variance Explained",
        ylim = c(0, 1), type = "b")


# Mean of each variable
colMeans(pokemon)

# Standard deviation of each variable
apply(pokemon, 2, sd)

# PCA model with scaling: pr.with.scaling
pr.with.scaling <- prcomp(pokemon, scale = T)

# PCA model without scaling: pr.without.scaling
pr.without.scaling <- prcomp(pokemon, scale = F)

# Create biplots of both for comparison
biplot(pr.with.scaling)
biplot(pr.without.scaling)

