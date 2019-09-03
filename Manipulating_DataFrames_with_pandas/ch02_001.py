import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Manipulating_DataFrames_with_pandas') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt

sales = pd.read_csv('./data/sales.csv', index_col="month")

new_idx = [i.upper() for i in sales.index]
sales.index = new_idx
print(sales)

# Assign the string 'MONTHS' to sales.index.name
sales.index.name = 'MONTHS'

# Print the sales DataFrame
print(sales)

# Assign the string 'PRODUCTS' to sales.columns.name 
sales.columns.name = 'PRODUCTS'

# Print the sales dataframe again
print(sales)


# Generate the list of months: months
months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']

# Assign months to sales.index


# Print the modified sales DataFrame
print(sales)



sales = pd.read_csv('./data/sales.csv')
sales = sales[['eggs', 'salt', 'spam']]

sales.index = months

print(sales)


sales = pd.read_csv('./data/sales.csv')

sales['state'] = ['CA', 'CA', 'NY', 'NY', 'TX', 'TX']
sales['month'] = [1, 2, 1, 2, 1, 2]

sales = sales.set_index(['state', 'month'])

# Print sales.loc[['CA', 'TX']]
print(sales.loc[['CA', 'TX']])

# Print sales['CA':'TX']
print(sales.loc['CA':'TX'])

sales = pd.read_csv('./data/sales.csv')
sales['state'] = ['CA', 'CA', 'NY', 'NY', 'TX', 'TX']


# Set the index to the column 'state': sales
sales = sales.set_index(['state'])

# Print the sales DataFrame
print(sales)

# Access the data from 'NY'
print(sales.loc['NY'])

sales = pd.read_csv('./data/sales.csv')
sales['state'] = ['CA', 'CA', 'NY', 'NY', 'TX', 'TX']
sales['month'] = [1, 2, 1, 2, 1, 2]
sales = sales.set_index(['state', 'month'])

# Look up data for NY in month 1: NY_month1
NY_month1 = sales.loc[('NY', 1)]

# Look up data for CA and TX in month 2: CA_TX_month2
CA_TX_month2 = sales.loc[(['CA', 'TX'], 2), :]

# Access the inner month index and look up data for all states in month 2: all_month2
all_month2 = sales.loc[(slice(None), 2), :]
 
