# Import pandas
import pandas as pd

# Create a pandas DataFrame: df
df = pd.DataFrame(nmf_feater)

# Print the row for 'Anne Hathaway'
print(____)

# Print the row for 'Denzel Washington'
print(____)



# Import NMF
____

# Create an NMF model: model
model = ____

# Apply fit_transform to samples: features
features = ____

# Call show_as_image on each component
for component in model.components_:
    ____

# Assign the 0th row of features: digit_features
digit_features = ____

# Print digit_features
print(digit_features)


# Import PCA
____

# Create a PCA instance: model
model = ____

# Apply fit_transform to samples: features
features = ____

# Call show_as_image on each component
for component in ____:
    ____



import pandas as pd
from sklearn.preprocessing import normalize

# Normalize the NMF features: norm_features
norm_features = ___________(___________)

# Create a DataFrame: df
df = pd.DataFrame(___________, index = ___________)

# Select the row corresponding to 'Cristiano Ronaldo': article
article = df.loc['___________']

# Compute the dot products: similarities
similarities = ___________(___________)

# Display those with the largest cosine similarity
print(similarities.___________)


# Perform the necessary imports
from ____ import ____
from ____ import ____, ____
from ____ import ____

# Create a MaxAbsScaler: scaler
scaler = ____

# Create an NMF model: nmf
nmf = ____

# Create a Normalizer: normalizer
normalizer = ____

# Create a pipeline: pipeline
pipeline = ____

# Apply fit_transform to artists: norm_features
norm_features = ____



# Import pandas
____

# Create a DataFrame: df
df = ____

# Select row of 'Bruce Springsteen': artist
artist = df.loc[____]

# Compute cosine similarities: similarities
similarities = ____

# Display those with highest cosine similarity
____

