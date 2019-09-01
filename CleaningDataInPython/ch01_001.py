import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt

# Read the file into a DataFrame: df
df = pd.read_csv("./dob_job_application_filings_subset.csv")

# Print the head of df
print(df.head())

# Print the tail of df
print(df.tail())

# Print the shape of df
print(df.shape)

# Print the columns of df
print(df.columns)

# Print the head and tail of df_subset
print(df_subset.head())
print(df_subset.tail())

df_subset = df.loc[:, ['Job #', 'Doc #', 'Borough', 'Initial Cost', 'Total Est. Fee',
'Existing Zoning Sqft', 'Proposed Zoning Sqft', 'Enlargement SQ Footage',
'Street Frontage', 'ExistingNo. of Stories', 'Proposed No. of Stories',
'Street Frontage', 'ExistingNo. of Stories', 'Proposed No. of Stories',
'Existing Height', 'Proposed Height']]

df_subset.columns
df_subset.head()
df_subset.tail()

df.info()
df_subset.info()

df[['Job #']].describe()
df[['Proposed No. of Stories']].describe()
df[['Proposed No. of Stories', 'Existing Height',
'Street Frontage', 'Proposed Height']].describe()

# Print the value counts for 'Borough'
print(df['Borough'].value_counts(dropna=False))

# Print the value_counts for 'State'
print(df['State'].value_counts(dropna=False))

# Print the value counts for 'Site Fill'
print(df['Site Fill'].value_counts(dropna=False))


df['Job #'].plot('hist')
plt.show()
df[df['Job #'] > 300000000]


df.boxplot(column='Job #', by = 'State')
plt.show()


# Describe the column
df['Existing Zoning Sqft'].describe()

# Plot the histogram
plt.clf()
df['Existing Zoning Sqft'].plot(kind='hist', rot=70, logx=True, logy=True)

# Display the histogram
plt.show()
plt.clf()


df[['Initial Cost']]
# Create the boxplot
df = pd.read_csv('./dob_job_application_filings_subset_1.csv')
df.boxplot(column='initial_cost', by='borough', rot=90)

# Display the plot
plt.show()
plt.clf()


# Create and display the first scatter plot
df.plot(kind='scatter', x='initial_cost', y='total_est_fee', rot=70)
plt.show()

# Create and display the second scatter plot
df.plot(kind='scatter', x='initial_cost', y='total_est_fee', rot=70)
plt.show()
plt.clf()


df_subset = pd.read_csv('./dob_job_application_filings_subset_subset.csv')
df_subset.columns
df_subset.plot(kind='scatter', x='initial_cost', y='total_est_fee', rot=70)
plt.show()













