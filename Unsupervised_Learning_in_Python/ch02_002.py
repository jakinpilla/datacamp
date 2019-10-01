# data loading...
samples_df = pd.read_csv('./data/seeds.csv', header = None)
samples_df.head()
samples = samples_df.values


list_1 = ['Kama wheat']*70
list_2 = ['Rosa wheat']*70
list_3 = ['Canadian wheat']*70

varieties = list_1 + list_2 + list_3


# Perform the necessary imports
from _______ import _______, _______
import matplotlib.pyplot as plt

# Calculate the linkage: mergings
mergings = _______(samples, method = '_______')

plt.clf()
# Plot the dendrogram, using varieties as labels
_______(mergings,
           _______=_______,
           _______=_______,
           leaf_font_size=_______,
)
plt.show()


# SciPy hierarchical clustering doesn't fit into a sklearn pipeline, 
#so you'll need to use the normalize() function from sklearn.preprocessing instead of Normalizer.

# loading data...
movements
companies

# Import normalize
____

# Normalize the movements: normalized_movements
normalized_movements = ____

# Calculate the linkage: mergings
mergings = ____

# Plot the dendrogram
____
plt.show()


# Perform the necessary imports
import matplotlib.pyplot as plt
from ____ import ____, ____

# Calculate the linkage: mergings
mergings = ____

# Plot the dendrogram
____
plt.show()


# Perform the necessary imports
import ____ as ____
from ____ import ____

# Use fcluster to extract labels: labels
labels = ____

# Create a DataFrame with labels and varieties as columns: df
df = pd.DataFrame({'labels': labels, 'varieties': varieties})

# Create crosstab: ct
ct = ____

# Display ct
print(ct)


