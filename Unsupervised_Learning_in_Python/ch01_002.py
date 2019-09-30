# Import KMeans
____

# Create a KMeans instance with 3 clusters: model
model = ____

# Fit model to points
____

# Determine the cluster labels of new_points: labels
labels = ____

# Print cluster labels of new_points
print(labels)



# Import pyplot
____

# Assign the columns of new_points: xs and ys
xs = ____
ys = ____

# Make a scatter plot of xs and ys, using labels to define the colors
____

# Assign the cluster centers: centroids
centroids = ____

# Assign the columns of centroids: centroids_x, centroids_y
centroids_x = centroids[:,0]
centroids_y = centroids[:,1]

# Make a scatter plot of centroids_x and centroids_y
____
plt.show()


ks = range(1, 6)
inertias = []

for k in ks:
    # Create a KMeans instance with k clusters: model
    ____
    
    # Fit model to samples
    ____
    
    # Append the inertia to the list of inertias
    ____
    
# Plot ks vs inertias
plt.plot(ks, inertias, '-o')
plt.xlabel('number of clusters, k')
plt.ylabel('inertia')
plt.xticks(ks)
plt.show()
