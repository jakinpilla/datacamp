# Perform the necessary imports
____
____

# Assign the 0th column of grains: width
width = ____

# Assign the 1st column of grains: length
length = ____

# Scatter plot width vs length
plt.scatter(____, ____)
plt.axis('equal')
plt.show()

# Calculate the Pearson correlation
correlation, pvalue = ____

# Display the correlation
print(correlation)


# loading data....

df_fish = pd.read_csv('./data/fish.csv', header = None).head()
samples = df_fish.iloc[:, 1:].values


# Perform the necessary imports
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import make_pipeline
import matplotlib.pyplot as plt

# Create scaler: scaler
scaler = _______()

# Create a PCA instance: pca
pca = _______()

# Create pipeline: pipeline
pipeline = make_pipeline(scaler, pca)

# Fit the pipeline to 'samples'
pipeline.fit(samples)

pca.n_components_
pca.explained_variance_

plt.clf()
# Plot the explained variances
features = range(_______) # features = range(pca.n_components_)
plt.bar(_______, _______)
plt.xlabel('PCA feature')
plt.ylabel('variance')
plt.xticks(_______)
plt.show()



# Import PCA
____

# Create a PCA model with 2 components: pca
pca = ____

# Fit the PCA instance to the scaled samples
____

# Transform the scaled samples: pca_features
pca_features = ____

# Print the shape of pca_features
print(pca_features.shape)


# Perform the necessary imports
from ____ import ____
from ____ import ____
from ____ import ____

# Create a TruncatedSVD instance: svd
svd = ____

# Create a KMeans instance: kmeans
kmeans = ____

# Create a pipeline: pipeline
pipeline = ____



