import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\StatiscalThikingInPython_1') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt


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

plt.clf()

def ecdf(data):
    """Compute ECDF for a one-dimensional array of measurements."""
    # Number of data points: n
    n = len(data)
    x = np.sort(data)
    y = np.arange(1, n+1) / n
    return x, y

# Compute ECDF for versicolor data: x_vers, y_vers
x_vers, y_vers = ecdf(versicolor_petal_length)

# Generate plot
plt.plot(x_vers, y_vers, marker = '.', linestyle='none')

# Label the axes
plt.xlabel('petal length (cm)')
plt.ylabel('ECDF')

# Display the plot
plt.show()
plt.clf()


setosa_petal_length_series = iris[iris['species'] == 'setosa'].petal_length
setosa_petal_length= np.array(setosa_petal_length_series.tolist())

virginica_petal_length_series = iris[iris['species'] == 'virginica'].petal_length
virginica_petal_length= np.array(virginica_petal_length_series.tolist())


# Compute ECDFs
x_set, y_set =  ecdf(setosa_petal_length)
x_vers, y_vers = ecdf(versicolor_petal_length)
x_virg, y_virg = ecdf(virginica_petal_length)

# Plot all ECDFs on the same plot
_ = plt.plot(x_set, y_set, marker='.', linestyle='none')
_ = plt.plot(x_vers, y_vers, marker='.', linestyle='none')
_ = plt.plot(x_virg, y_virg, marker='.', linestyle = 'none')

# Annotate the plot
plt.legend(('setosa', 'versicolor', 'virginica'), loc='lower right')
_ = plt.xlabel('petal length (cm)')
_ = plt.ylabel('ECDF')

# Display the plot
plt.show()

