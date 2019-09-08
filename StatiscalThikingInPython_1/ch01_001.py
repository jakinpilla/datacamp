# Import plotting modules
import matplotlib.pyplot as plt 
import seaborn as sns

# Set default Seaborn style
sns.set()

# Plot histogram of versicolor petal lengths
_ = plt.hist(versicolor_petal_length)

# Show histogram
plt.show()

import numpy as np
import pandas as dp

iris = pd.read_csv('./data/iris.csv', index_col = [0])
iris.head()

iris.columns = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width', 'species']
iris.head()

versicolor_petal_length_series = iris[iris['species'] == 'versicolor'].petal_length
versicolor_petal_length= np.array(versicolor_petal_length_series.tolist())

# Import plotting modules
import matplotlib.pyplot as plt 
import seaborn as sns

# Set default Seaborn style
sns.set()

plt.clf()

# Plot histogram of versicolor petal lengths
_ = plt.hist(versicolor_petal_length)

# Show histogram
plt.show()

plt.clf()

# Plot histogram of versicolor petal lengths
_ = plt.hist(versicolor_petal_length)

plt.xlabel('petal length (cm)')
plt.ylabel('count')

# Show histogram
plt.show()

plt.clf()
# Import numpy
import numpy as np

# Compute number of data points: n_data
n_data = len(versicolor_petal_length)

# Number of bins is the square root of number of data points: n_bins
n_bins = np.sqrt(n_data)

# Convert number of bins to integer: n_bins
n_bins = int(n_bins)

# Plot the histogram
_ = plt.hist(versicolor_petal_length, bins = n_bins)

# Label axes
_ = plt.xlabel('petal length (cm)')
_ = plt.ylabel('count')

# Show histogram
plt.show()


df = iris

# Create bee swarm plot with Seaborn's default settings
_ = sns.swarmplot(x = 'species', y = 'petal_length', data = df)

# Label the axes
plt.xlabel('species')
plt.ylabel('petal length (cm)')

# Show the plot
plt.show()
