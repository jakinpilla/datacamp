import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Merging dataframes with pandas') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt

# Import pandas
import pandas as pd

# Read 'Bronze.csv' into a DataFrame: bronze
bronze = pd.read_csv('./data/Bronze.csv')

# Read 'Silver.csv' into a DataFrame: silver
silver = pd.read_csv('./data/Silver.csv')

# Read 'Gold.csv' into a DataFrame: gold
gold = pd.read_csv('./data/Gold.csv')

# Print the first five rows of gold
print(gold.head())


# Import pandas
import pandas as pd

# Create the list of file names: filenames
filenames = ['./data/Gold.csv', './data/Silver.csv', './data/Bronze.csv']

# Create the list of three DataFrames: dataframes
dataframes = []
for filename in filenames:
    dataframes.append(pd.read_csv(filename))

# Print top 5 rows of 1st DataFrame in dataframes
print(dataframes[0].head())


# Import pandas
import pandas as pd

# Make a copy of gold: medals
medals = gold.copy()

# Create list of new column labels: new_labels
new_labels = ['NOC', 'Country', 'Gold']

# Rename the columns of medals using new_labels
medals.columns = new_labels

# Add columns 'Silver' & 'Bronze' to medals
medals['Silver'] = silver['Total']
medals['Bronze'] = bronze['Total']

# Print the head of medals
print(medals.head())

##----

# Import pandas
import pandas as pd

weather1 = pd.read_csv('./data/pittsburgh2013.csv', index_col = 'Date', parse_dates=True)[['Max TemperatureF']]
weather1.index.tz_localize('US/Central').strftime('%B')

# Read 'monthly_max_temp.csv' into a DataFrame: weather1
weather1 = pd.read_csv('./data/pittsburgh2013.csv')[['Date', 'Max TemperatureF']]

weather1.set_index(weather1[['Date']].strftime('%b'))

# Print the head of weather1
print(weather1.head())

# Sort the index of weather1 in alphabetical order: weather2
weather2 = ____

# Print the head of weather2
print(weather2.head())

# Sort the index of weather1 in reverse alphabetical order: weather3
weather3 = ____

# Print the head of weather3
print(weather3.head())

# Sort weather1 numerically using the values of 'Max TemperatureF': weather4
weather4 = ____

# Print the head of weather4
print(weather4.head())

## ----

# Import pandas
import pandas as pd

# Reindex weather1 using the list year: weather2
weather2 = weather1.reindex(year)

# Print weather2
print(weather2)

# Reindex weather1 using the list year with forward-fill: weather3
weather3 = weather1.reindex(year).ffill()

# Print weather3
print(weather3)

##----

names_1981 = pd.read_csv('./data/names1981.csv', header=None, 
names=['name','gender','count'], index_col=(0,1))

names_1881 = pd.read_csv('./data/names1881.csv', header=None, 
names=['name','gender','count'], index_col=(0,1))

# Import pandas
import pandas as pd

# Reindex names_1981 with index of names_1881: common_names
common_names = names_1981.reindex(names_1881.index)

# Print shape of common_names
print(common_names.shape)

# Drop rows with null counts: common_names
common_names = common_names.dropna()

# Print shape of new common_names
print(common_names.shape)

##----

weather = pd.read_csv('./data/pittsburgh2013.csv', index_col = 'Date', parse_dates=True)
# Extract selected columns from weather as new DataFrame: temps_f
temps_f = weather[['Min TemperatureF', 'Mean TemperatureF', 
'Max TemperatureF']]

# Convert temps_f to celsius: temps_c
temps_c = (temps_f - 32) * 5/9

# Rename 'F' in column names with 'C': temps_c.columns
temps_c.columns = temps_c.columns.str.replace('F', 'C')

# Print first 5 rows of temps_c
print(temps_c.head())

import pandas as pd

## No data...----

# Read 'GDP.csv' into a DataFrame: gdp
gdp = pd.read_csv('./data/gdp_china.csv')

gdp = pd.read_csv('./data/gdp_china.csv', index_col = 'DATE', 
parse_dates=True)

# Slice all the gdp data from 2008 onward: post2008
post2008 = ____

# Print the last 8 rows of post2008
print(post2008.tail(8))

# Resample post2008 by year, keeping last(): yearly
yearly = ____

# Print yearly
print(yearly)

# Compute percentage growth of yearly: yearly['growth']
yearly['growth'] = ____

# Print yearly again
print(yearly)

## ----

# Import pandas
import pandas as pd

# Read 'sp500.csv' into a DataFrame: sp500
sp500 = pd.read_csv('./data/sp500.csv', 
index_col = 'Date', parse_dates = True)

# Read 'exchange.csv' into a DataFrame: exchange
exchange = pd.read_csv('./data/exchange.csv', 
index_col = 'Date', parse_dates = True)

# Subset 'Open' & 'Close' columns from sp500: dollars
dollars = sp500[['Open', 'Close']]

# Print the head of dollars
print(dollars.head())

# Convert dollars to pounds: pounds
pounds = dollars.multiply(exchange['GBP/USD'], axis='rows')

# Print the head of pounds
print(pounds.head())
