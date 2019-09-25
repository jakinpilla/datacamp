import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Machine_Learning_With_The_Experts_School_Budgets') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

# Import plotting modules
import matplotlib.pyplot as plt 
import seaborn as sns


sample_df = pd.read_csv('sample_data.csv')
sample_df.head()
sample_df.info()
sample_df.describe()


df = pd.read_csv('./data/TrainingData.csv')
# Print the summary statistics
print(df.describe())

# Import matplotlib.pyplot as plt
import matplotlib.pyplot as plt

plt.clf()
# Create the histogram
plt.hist(df['FTE'].dropna())

df['FTE'].max()
df['FTE'].min()

# Add title and labels
plt.title('Distribution of %full-time \n employee works')
plt.xlabel('% of full-time')
plt.ylabel('num employees')

# Display the histogram
plt.show()

## ----

# sample_df.label.head(2)
# sample_df.label = sample_df.label.astype('category')
# 
# sample_df.label.head(2)


# dummies = pd.get_dummies(sample_df[['label']], prefix_sep = '_')


square = lambda x : x*x
square(2)

categorize_label = lambda x : x.astype('category')

# sample_df.label = sample_df[['label']].apply(categorical_label, axis = 0)

## ----
# df = pd.read_csv('./data/TrainingData.csv')
df.shape
df.dtypes.value_counts()

# Define the lambda function: categorize_label
categorize_label = lambda x: x.astype('category')

df.columns

LABELS = ['Function', 'Use', 'Sharing', 'Reporting', 'Student_Type', 'Position_Type',
       'Object_Type', 'Pre_K', 'Operating_Status']


# Convert df[LABELS] to a categorical type
df[LABELS] = df[LABELS].apply(categorize_label, axis=0)

# Print the converted dtypes
print(df[LABELS].dtypes)

##----
# Import matplotlib.pyplot
import matplotlib.pyplot as plt

# Calculate number of unique values for each label: num_unique_labels
num_unique_labels = df[LABELS].apply(pd.Series.nunique, axis=0)


plt.clf()
# Plot number of unique values for each label
num_unique_labels.plot(kind = 'bar')

# Label the axes
plt.xlabel('Labels')
plt.ylabel('Number of unique values')

# Display the plot
plt.show()


import numpy as np

def compute_log_loss(predicted, actual, eps=1e-14):
  '''Compute the logarithmic loss between predicted and actual when these are 1D arrays.
    
    :param predicted: The predicted probabilities as floats between 0-1
    :param actual: The actual binary labels. Either 0 or 1
    :param eps (optional): log(0) is inf, so we need to offset our predicted values slightly by eps from 0 or 1.
  '''
  predicted = np.clip(predicted, eps, 1-eps)
  loss = -1 * np.mean(actual * np.log(predicted) + (1-actual )* np.log(1-predicted))
  return loss
  

# Compute and print log loss for 1st case

correct_confident = [.95, .95, .95, .95, .95, .05, .05, .05, .05, .05]
actual_labels = [1, 1, 1, 1, 1, 0, 0, 0, 0, 0]
correct_not_confident = [.65, .65, .65, .65, .65, .35, .35, .35, .35, .35]
wrong_not_confident = [.35,.35, .35, .35, .35, .65, .65, .65, .65, .65]
wrong_confident = [.05, .05, .05, .05, .05, .95, .95, .95, .95, .95]


correct_confident = np.array(correct_confident)
actual_labels = np.array(actual_labels)
correct_not_confident = np.array(correct_not_confident)
wrong_not_confident = np.array(wrong_not_confident)
wrong_confident = np.array(wrong_confident)

correct_confident_loss = compute_log_loss(correct_confident, actual_labels)
print("Log loss, correct and confident: {}".format(correct_confident_loss)) 

# Compute log loss for 2nd case
correct_not_confident_loss = compute_log_loss(correct_not_confident, actual_labels)
print("Log loss, correct and not confident: {}".format(correct_not_confident_loss)) 

# Compute and print log loss for 3rd case
wrong_not_confident_loss = compute_log_loss(wrong_not_confident, actual_labels)
print("Log loss, wrong and not confident: {}".format(wrong_not_confident_loss)) 

# Compute and print log loss for 4th case
wrong_confident_loss = compute_log_loss(wrong_confident, actual_labels)
print("Log loss, wrong and confident: {}".format(wrong_confident_loss)) 

# Compute and print log loss for actual labels
actual_labels_loss = compute_log_loss(actual_labels, actual_labels)
print("Log loss, actual labels: {}".format(actual_labels_loss)) 


# StratifiedShuffleSplit

# multilabel_train_test_split()...

NUMERIC_COLUMNS = ['FTE', 'Total']

data_to_train = df[NUMERIC_COLUMNS].fillna(-1000)

label_to_use = pd.get_dummies(df[LABELS])

X_train, X_test, y_train, y_test = multi_train_test_split(
  data_to_train, labels_to_use, size= .2, seed = 123
)

from sklearn.linear_model import LogisticRegression

from sklearn.multiclass import OneVsRestClassifier

import multilabel as mll

# OneVsRestClassifier:
# Treats each column of y  independently
# Fits a separte classifier for each of the columns

clf = OneVsRestClassifier(LogisticRegression())

clf.fit(X_train, y_train)


# ----

# Create the new DataFrame: numeric_data_only
numeric_data_only = df[NUMERIC_COLUMNS].fillna(-1000)

# Get labels and convert to dummy variables: label_dummies
label_dummies = pd.get_dummies(df[LABELS])

# Create training and test sets
X_train, X_test, y_train, y_test = mll.multilabel_train_test_split(numeric_data_only,
                                                               label_dummies,
                                                               size=.2, 
                                                               seed=123)

# Print the info
print("X_train info:")
print(X_train.info())
print("\nX_test info:")  
print(X_test.info())
print("\ny_train info:")  
print(y_train.info())
print("\ny_test info:")  
print(y_test.info()) 



# Import classifiers
from sklearn.linear_model import LogisticRegression
from sklearn.multiclass import OneVsRestClassifier

# Create the DataFrame: numeric_data_only
numeric_data_only = df[NUMERIC_COLUMNS].fillna(-1000)

# Get labels and convert to dummy variables: label_dummies
label_dummies = pd.get_dummies(df[LABELS])

# Create training and test sets
X_train, X_test, y_train, y_test = multilabel_train_test_split(numeric_data_only,
                                                               label_dummies,
                                                               size=0.2, 
                                                               seed=123)

# Instantiate the classifier: clf
clf = OneVsRestClassifier(LogisticRegression())

# Fit the classifier to the training data
clf.fit(X_train, y_train)

# Print the accuracy
print("Accuracy: {}".format(clf.score(X_test, y_test)))

















