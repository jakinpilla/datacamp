# Visualizing the PCA transformation...

# Dimension reduction...
# more efficient storage and computation
# Remove less-informative 'noise' features...


# PCA

wine.head()
wine.iloc[:, 1:].head()

df_sample = wine[['nonflavanoid_phenols', 'od280']]
df_sample['nonflavanoid_phenols_10'] = df_sample['nonflavanoid_phenols'] *10 
samples = df_sample[['nonflavanoid_phenols_10', 'od280']].values

from sklearn.decomposition import PCA
model = PCA()

model.fit(samples)

transformed = model.transform(samples)

# Resulting PCA featrues are not linearly correlated('decorrelation')

model.components_

# loading data....
samples_df = pd.read_csv('./data/seeds.csv', header = None)
samples_df.head()
samples = samples_df.values
grains = samples_df.iloc[:, [4, 3]].values

list_1 = ['Kama wheat']*70
list_2 = ['Rosa wheat']*70
list_3 = ['Canadian wheat']*70

varieties = list_1 + list_2 + list_3

di = {'Kama wheat' : 1, 'Rosa wheat': 2, 'Canadian wheat' : 3}
variety_numbers = pd.DataFrame({'varieties' : varieties})['varieties'].map(di).values


# Perform the necessary imports
import matplotlib.pyplot as plt
from scipy.stats import pearsonr

# Assign the 0th column of grains: width
width = grains[:, 0]

# Assign the 1st column of grains: length
length = grains[:, 1]

plt.clf()
# Scatter plot width vs length
plt.scatter(width, length)
plt.axis('equal')
plt.show()

# Calculate the Pearson correlation
correlation, pvalue = pearsonr(width, length)

# Display the correlation
print(correlation)


# Import PCA
from sklearn.decomposition import PCA

# Create PCA instance: model
model = PCA()

# Apply the fit_transform method of model to grains: pca_features
pca_features = model.fit_transform(grains)

# Assign 0th column of pca_features: xs
xs = pca_features[:,0]

# Assign 1st column of pca_features: ys
ys = pca_features[:,1]

plt.clf()
# Scatter plot xs vs ys
plt.scatter(xs, ys)
plt.axis('equal')
plt.show()

# Calculate the Pearson correlation of xs and ys
correlation, pvalue = pearsonr(xs, ys)

# Display the correlation
print(correlation)


# Intrinsic dimension...

iris.head()

samples = iris.iloc[:, [0, 1, 3]].values

from sklearn.decomposition import PCA

pca = PCA()

pca.fit(samples)

features = range(pca.n_components_)

pca.explained_variance_

plt.clf()
plt.bar(features, pca.explained_variance_)
plt.xticks(features)
plt.ylabel('variance')
plt.xlabel('PCA feature')

plt.show()

# data checking...
grains

plt.clf()
# Make a scatter plot of the untransformed points
plt.scatter(grains[:,0], grains[:,1])
plt.show()

# Create a PCA instance: model
model = PCA()

# Fit model to points
model.fit(grains)

# Get the mean of the grain samples: mean
mean = model.mean_

# Get the first principal component: first_pc
first_pc = model.components_[0, :]

# Plot first_pc as an arrow, starting at mean
plt.arrow(mean[0], mean[1], first_pc[0], first_pc[1], color='red', width=0.01)

# Keep axes on same scale
plt.axis('equal')
plt.show()

# loading data....

df_fish = pd.read_csv('./data/fish.csv', header = None).head()
samples = df_fish.iloc[:, 1:].values


# Perform the necessary imports
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import make_pipeline
import matplotlib.pyplot as plt

# Create scaler: scaler
scaler = StandardScaler()

# Create a PCA instance: pca
pca = PCA()

# Create pipeline: pipeline
pipeline = make_pipeline(scaler, pca)

# Fit the pipeline to 'samples'
pipeline.fit(samples)

pca.n_components_
pca.explained_variance_

plt.clf()
# Plot the explained variances
features = range(5) # features = range(pca.n_components_)
plt.bar(features, pca.explained_variance_)
plt.xlabel('PCA feature')
plt.ylabel('variance')
plt.xticks(features)
plt.show()


# PCA(n_components=2): keep the first 2 PCA features...

iris_samples = iris.iloc[:, 0:4].values

di = {'setosa' : 1, 'versicolor' : 2, 'virginica' : 3} 
species = iris.iloc[:, 4].map(di)

from sklearn.decomposition import PCA
pca = PCA(n_components=2)

pca.fit(samples)

transformed = pca.transform(samples)

transformed.shape

xs = transformed[:, 0]
ys = transformed[:, 1]

plt.clf()
plt.scatter(xs, ys, c = species)
plt.show()

# Assume the high variance features are informative...

## With word frequency arrays...

# scipy.sparse.csr_matrix instead Numpy array...

# sklearn PCA doesn't support csr_matrix..Use sklearn TruncatedSVD instead...

wiki_vec = pd.read_csv('./data/wikipedia-vectors.csv', index_col=0).iloc[:, 1:]
wiki_vec.head()
wiki_vec.shape

from sklearn.decomposition import TruncatedSVD

model = TruncatedSVD(n_components=3)

model.fit(wiki_vec)

transformed = model.transform(wiki_vec)

## fish data loading...
samples = pd.read_csv('./data/fish.csv', header = None).iloc[:, 1:].values

# Import PCA
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler

standard = StandardScaler()
scaled_samples = standard.fit_transform(samples)

# Create a PCA model with 2 components: pca
pca = PCA(n_components=2)


# Fit the PCA instance to the scaled samples
pca.fit(scaled_samples)

# Transform the scaled samples: pca_features
pca_features = pca.transform(scaled_samples)

# Print the shape of pca_features
print(pca_features.shape)


toy_doc = ['cats say meow', 'dogs say woof', 'dogs chase cats']

# Import TfidfVectorizer
from sklearn.feature_extraction.text import TfidfVectorizer

# Create a TfidfVectorizer: tfidf
tfidf = TfidfVectorizer()

# Apply fit_transform to document: csr_mat
csr_mat = tfidf.fit_transform(toy_doc)

# Print result of toarray() method
print(csr_mat.toarray())

# Get the words: words
words = tfidf.get_feature_names()

# Print words
print(words)


## 

wiki_vec.head()

from sklearn.decomposition import TruncatedSVD
from sklearn.cluster import KMeans
from sklearn.pipeline import make_pipeline

svd = TruncatedSVD(n_components=50)

# Create a KMeans instance: kmeans
kmeans = KMeans(n_clusters=6)

# Create a pipeline: pipeline
pipeline = make_pipeline(svd, kmeans)


# Import pandas
import pandas as pd

# Fit the pipeline to articles
pipeline.fit(articles)

# Calculate the cluster labels: labels
labels = pipeline.predict(articles)

# Create a DataFrame aligning labels and titles: df
df = pd.DataFrame({'label': labels, 'article': titles})

# Display df sorted by cluster label
print(df.sort_values('label'))
