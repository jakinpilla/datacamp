# t-SNE: create a 2D map of a dataset
# Hierarchical clustering



euro = pd.read_csv('./data/eurovision-2016.csv')
euro.head()
pd.read_csv('./data/artists.csv').head()


# With 5 data samples, there would be 4 merge operations, and with 6 data samples, there would be 5 merges, and so on.

samples = iris.iloc[:, 0:4].values
species = iris.species.values

import matplotlib.pyplot as plt
from scipy.cluster.hierarchy import linkage, dendrogram

mergings = linkage(samples, method = 'complete')

plt.clf()
dendrogram(mergings, labels = species, leaf_rotation=90, leaf_font_size = 6)
plt.show()


# data loading...
samples_df = pd.read_csv('./data/seeds.csv', header = None)
samples_df.head()
samples = samples_df.values


list_1 = ['Kama wheat']*70
list_2 = ['Rosa wheat']*70
list_3 = ['Canadian wheat']*70

varieties = list_1 + list_2 + list_3


# Perform the necessary imports
from scipy.cluster.hierarchy import linkage, dendrogram
import matplotlib.pyplot as plt

# Calculate the linkage: mergings
mergings = linkage(samples, method = 'complete')

plt.clf()
# Plot the dendrogram, using varieties as labels
dendrogram(mergings,
           labels=varieties,
           leaf_rotation=90,
           leaf_font_size=6,
)
plt.show()


# SciPy hierarchical clustering doesn't fit into a sklearn pipeline, 
#so you'll need to use the normalize() function from sklearn.preprocessing instead of Normalizer.

movements
companies

# Import normalize
from sklearn.preprocessing import normalize

# Normalize the movements: normalized_movements
normalized_movements = normalize(movements)

# Calculate the linkage: mergings
mergings = linkage(normalized_movements, method = 'complete')

plt.clf()
# Plot the dendrogramd
dendrogram(mergings, labels = companies, leaf_rotation=90, leaf_font_size=6)

plt.show()


## fcluster..

# loading data..

samples
varieties

from scipy.cluster.hierarchy import linkage

mergings = linkage(samples, method = 'complete')

from scipy.cluster.hierarchy import fcluster


# Calculate the linkage: mergings
mergings = linkage(samples, method = 'complete')

plt.clf()
# Plot the dendrogram, using varieties as labels
dendrogram(mergings,
           labels=varieties,
           leaf_rotation=90,
           leaf_font_size=6,
)
plt.show()

labels = fcluster(mergings, 5, criterion='distance')

pairs = pd.DataFrame({'labels': labels, 'varieties': varieties})

print(pairs.sort_values('labels'))



# Perform the necessary imports
import matplotlib.pyplot as plt
from scipy.cluster.hierarchy import linkage, dendrogram

# Calculate the linkage: mergings
mergings = linkage(samples, method = 'single')


# plt.clf()
# Plot the dendrogram
dendrogram(mergings, labels = varieties, leaf_rotation=90, leaf_font_size=6)
plt.show()


# Perform the necessary imports
import pandas as pd
from scipy.cluster.hierarchy import fcluster

# Use fcluster to extract labels: labels
labels = fcluster(mergings, 1.25, criterion = 'distance')

# Create a DataFrame with labels and varieties as columns: df
df = pd.DataFrame({'labels': labels, 'varieties': varieties})

# Create crosstab: ct
ct = pd.crosstab(df['labels'], df['varieties'])

# Display ct
print(ct)


# t_SNE for 2-dimensional maps...
# t-SNE : t-distributed stochastic neighbor embeddiing....

iris.head()
iris.species = 


samples = iris.iloc[:, 0:4].values
species = iris.species.values



from sklearn.manifold import TSNE

model = TSNE(learning_rate = 100)

transformed = model.fit_transform(samples)

xs = transformed[:, 0]
ys = transformed[:, 1]

plt.clf()
plt.scatter(xs, ys, c = species)





