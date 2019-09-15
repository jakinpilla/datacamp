import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Analyzing_Police_Activity_with_Pandas') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt

ri = pd.read_csv('./data/police.csv')
ri.head()

ri.isnull()
ri.isnull().sum()
ri.shape

ri.drop('county_name', axis = 'columns', inplace = True)

ri.dropna(subset=['stop_date', 'stop_time'], inplace = True)


# Import the pandas library as pd
import pandas as pd

# Read 'police.csv' into a DataFrame named ri
ri = pd.read_csv('./data/police.csv')

# Examine the head of the DataFrame
print(ri.head())

# Count the number of missing values in each column
print(ri.isnull().sum())

# Count the number of missing values in each column
print(ri.isnull().sum())

# Examine the shape of the DataFrame
print(ri.shape)

# Drop the 'county_name' and 'state' columns
ri.drop(['county_name', 'state'], axis='columns', inplace=True)

# Examine the shape of the DataFrame (again)
print(ri.shape)

# Count the number of missing values in each column
print(ri.isnull().sum())

# Drop all rows that are missing 'driver_gender'
ri.dropna(subset=['driver_gender'], inplace=True)

# Count the number of missing values in each column (again)
print(ri.isnull().sum())

# Examine the shape of the DataFrame
print(ri.shape)

## Using proper data types...

ri.dtypes

# apple
# date time price
# apple.price.dtype
# 
# apple['price'] = apple.price.dtype('float')
# apple.price.dtype

# ri.dtypes
# ri.head()
# ri.search_conducted.dtype
# ri.is_arrested.dtype
# ri.district.dtype

# Examine the head of the 'is_arrested' column
print(ri.is_arrested.head())

# Check the data type of 'is_arrested'
print(ri.is_arrested.dtype)

# Change the data type of 'is_arrested' to 'bool'
ri['is_arrested'] = ri.is_arrested.astype('bool')

# Check the data type of 'is_arrested' (again)
print(ri.is_arrested.dtype)

## Creating a DatetimeIndex...
ri.head()

# apple.date.str.replace('/', '-')
# combined = apple.date.str.cat(apple.time, sep = ' ')
# apple['date_and_time'] = pd.to_datetime(combined)
# apple.set_index('date_and_time', inplace = True)
# apple.index

combined = ri.stop_date.str.cat(ri.stop_time, sep = ' ')

ri['stop_datetime'] = pd.to_datetime(combined)

print(ri.dtypes)

# Set 'stop_datetime' as the index
ri.set_index('stop_datetime', inplace=True)

# Examine the index
print(ri.index)

# Examine the columns
print(ri.columns)

ri.stop_outcome.value_counts()
ri.stop_outcome.value_counts().sum()
ri.shape

ri.stop_outcome.value_counts(normalize=True)

ri.driver_race.value_counts()
