import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Unsupervised_Learning_in_Python') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

# Import plotting modules
import matplotlib.pyplot as plt 
import seaborn as sns


## ----

iris = pd.read_csv('./data/iris.csv')
iris.head()

iris_tmp = iris.iloc[:, 0:4]
samples = iris_tmp.values

print(samples)

from sklearn.cluster import KMeans

model = KMeans(n_clusters = 3)

model.fit(samples)

labels = model.predict(samples)

print(labels)

new_samples = np.array([[5.7, 4.4, 1.5, 0.4],
[6.5, 3.0, 5.5, 1.8],
[5.8, 2.7, 5.1, 1.9]])

print(new_samples)

new_labels = model.predict(new_samples)

# plotting with pandas ---------------------------------------------------------

# adding 'color' column

plt.clf()

iris['color'] = np.where(iris.species == 'setosa', 'red', 
                         np.where(iris.species =='versicolor', 
                         'green', 
                         'blue'))

# scatter plot

iris.plot(kind='scatter',
          x='sepal_length', 
          y='petal_length', 
          s=10, # marker size
          c=iris['color']) # marker color by group


plt.title('Scatter Plot of iris by pandas', fontsize=20)
plt.xlabel('Petal Length', fontsize=14)
plt.ylabel('Petal Width', fontsize=14)

plt.show()


# plotting with sns ------------------------------------------------------------
plt.clf()
sns.scatterplot(x='petal_length', y='petal_width', 
                hue='species', # different colors by group
                s=30, # marker size
                data=iris)

plt.show()


# Import KMeans
from sklearn.cluster import KMeans

# Create a KMeans instance with 3 clusters: model
model = KMeans(n_clusters=3)

# Fit model to points
model.fit(points)

# Determine the cluster labels of new_points: labels
labels = model.predict(new_points)

# Print cluster labels of new_points
print(labels)

# Import pyplot
import matplotlib.pyplot as plt 

# Assign the columns of new_points: xs and ys
xs = new_point[:, 0]
ys = new_point[:, 1]

# Make a scatter plot of xs and ys, using labels to define the colors
plt.scatter(xs, ys, c = labels, alpha=.5)

# Assign the cluster centers: centroids
centroids = model.cluster_centers_

# Assign the columns of centroids: centroids_x, centroids_y
centroids_x = centroids[:,0]
centroids_y = centroids[:,1]

# Make a scatter plot of centroids_x and centroids_y
plt.scatter(centroids_x, centroids_y, marker = 'D', s=50)
plt.show()


# Evaluatin a clustering...
iris.head()

species = iris.species.tolist()
print(species)



iris = pd.read_csv('./data/iris.csv')
iris.head()

iris_tmp = iris.iloc[:, 0:4]
samples = iris_tmp.values

print(samples)

from sklearn.cluster import KMeans

model = KMeans(n_clusters = 3)

model.fit(samples)

labels = model.predict(samples)

labels = labels.tolist()

df = pd.DataFrame({
  'labels' :labels,
  'species': species
})

ct = pd.crosstab(df['labels'], df['species'])
ct

# Inertia : Distance from each sample to centroid of its cluster

model.inertia_


ks = range(1, 6)
inertias = []

for k in ks:
    # Create a KMeans instance with k clusters: model
    model = KMeans(n_clusters=k)
    
    # Fit model to samples
    model.fit(samples)
    
    # Append the inertia to the list of inertias
    inertias.append(model.inertia_)

plt.clf()    
# Plot ks vs inertias
plt.plot(ks, inertias, '-o')
plt.xlabel('number of clusters, k')
plt.ylabel('inertia')
plt.xticks(ks)
plt.show()


samples_df = pd.read_csv('./data/seeds.csv', header = None)
samples_df.head()
samples = samples_df.values

len(labels)

list_1 = ['Kama wheat']*70
list_2 = ['Rosa wheat']*70
list_3 = ['Canadian wheat']*70

varieties = list_1 + list_2 + list_3

# Create a KMeans model with 3 clusters: model
model = KMeans(n_clusters=3)

# Use fit_predict to fit model and obtain cluster labels: labels
labels = model.fit_predict(samples)

# Create a DataFrame with labels and varieties as columns: df
df = pd.DataFrame({'labels': labels, 'varieties': varieties})

# Create crosstab: ct
ct = pd.crosstab(df['labels'], df['varieties'])

# Display ct
print(ct)


wine = pd.read_csv('./data/wine.csv')
wine.head()

varieties = wine.class_name.values

samples = wine.iloc[:, 2: ].values

# In kmeans: feature variance = feature influence

# StandardScaler: transforms each feature to have mean 0 and variance 1 : standized

from sklearn.preprocessing import StandardScaler

scaler = StandardScaler()

scaler.fit(samples)

samples_scaled = scaler.transform(samples)

# with pipeline...

from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans

scaler = StandardScaler()
kmeans = KMeans(n_clusters=3)

from sklearn.pipeline import make_pipeline

pipeline = make_pipeline(scaler, kmeans)

pipeline.fit(samples)

labels = pipeline.predict(samples)

df = pd.DataFrame({'labels' : labels, 'varieties' : varieties})

ct = pd.crosstab(df['labels'], df['varieties'])
print(ct)

fish = pd.read_csv('./data/fish.csv', header = None)
fish.head()
samples = fish.iloc[:, 1:].values
species = fish.iloc[:, 0]

# Perform the necessary imports
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans

# Create scaler: scaler
scaler = StandardScaler()

# Create KMeans instance: kmeans
kmeans = KMeans(n_clusters = 4)

# Create pipeline: pipeline
pipeline = make_pipeline(scaler, kmeans)

# Import pandas
import pandas as pd

# Fit the pipeline to samples
pipeline.fit(samples)

# Calculate the cluster labels: labels
labels = pipeline.predict(samples)

# Create a DataFrame with labels and species as columns: df
df = pd.DataFrame({'labels': labels, 'species': species})

# Create crosstab: ct
ct = pd.crosstab(df['labels'], df['species'])

# Display ct
print(ct)

stock = pd.read_csv('./data/company-stock-movements-2010-2015-incl.csv', index_col = 0)
stock.head()
movements = stock.values
companies = stock.index.values

# Import Normalizer
from sklearn.preprocessing import Normalizer

# Create a normalizer: normalizer
normalizer = Normalizer()

# Create a KMeans model with 10 clusters: kmeans
kmeans = KMeans(n_clusters = 10)

# Make a pipeline chaining normalizer and kmeans: pipeline
pipeline = make_pipeline(normalizer, kmeans)

# Fit pipeline to the daily price movements
pipeline.fit(movements)

# Which company have stock prices that tend to change in the same way?

# Import pandas
import pandas as pd

# Predict the cluster labels: labels
labels = pipeline.predict(movements)

# Create a DataFrame aligning labels and companies: df
df = pd.DataFrame({'labels': labels, 'companies': companies})

# Display df sorted by cluster label
print(df.sort_values(by = 'labels'))


















