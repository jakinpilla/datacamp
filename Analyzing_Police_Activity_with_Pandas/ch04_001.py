import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Analyzing_Police_Activity_with_Pandas') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt


import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Analyzing_Police_Activity_with_Pandas') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt


weather = pd.read_csv('./data/weather.csv')
weather.head()

weather[['AWND', 'WSF2']].head()
weather[['AWND', 'WSF2']].describe()

plt.clf()
weather[['AWND', 'WSF2']].plot(kind = 'box')
plt.show()

weather['WDIFF'] = weather.WSF2 - weather.AWND

plt.clf()
weather.WDIFF.plot(kind = 'hist')
plt.show()

plt.clf()
weather.WDIFF.plot(kind = 'hist', bins = 20)
plt.show()

# Read 'weather.csv' into a DataFrame named 'weather'
weather = pd.read_csv('./data/weather.csv')

# Describe the temperature columns
print(weather[['TMIN', 'TAVG', 'TMAX']].describe())

plt.clf()
# Create a box plot of the temperature columns
weather[['TMIN', 'TAVG', 'TMAX']].plot(kind = 'box')

# Display the plot
plt.show()

# Create a 'TDIFF' column that represents temperature difference
weather['TDIFF'] = weather.TMAX  - weather.TMIN

# Describe the 'TDIFF' column
print(weather['TDIFF'].describe())

plt.clf()
# Create a histogram with 20 bins to visualize 'TDIFF'
weather['TDIFF'].plot(kind = 'hist', bins = 20)

# Display the plot
plt.show()

weather.shape
weather.columns

temp = weather.loc[:, 'TAVG':'TMAX']

temp.head()
temp.sum()
temp.sum(axis = 'columns').head()

ri.stop_duration.unique()

mapping = {'0-15 Min': 'short', '16-30 Min': 'medium', '30+ Min': 'long'}

ri['stop_length'] = ri.stop_duration.map(mapping)

ri.stop_length.dtype

ri.stop_length.unique()


ri.stop_length.memory_usage(deep = True)

cats = ['short', 'medium', 'long']

ri['stop_length'] = ri.stop_length.astype('category', ordered = True, categories = cats)

ri.stop_length.memory_usage(deep = True)

ri.stop_length.head()

ri[ri.stop_length > 'short'].shape

ri.groupby('stop_length').is_arrested.mean()


# Copy 'WT01' through 'WT22' to a new DataFrame
WT = weather.loc[:, 'WT01': 'WT22']

# Calculate the sum of each row in 'WT'
weather['bad_conditions'] = WT.sum(axis = 'columns')

# Replace missing values in 'bad_conditions' with '0'
weather['bad_conditions'] = weather.bad_conditions.fillna(0).astype('int')

# Create a histogram to visualize 'bad_conditions'
weather['bad_conditions'].plot(kind = 'hist')

# Display the plot
plt.show()


# Count the unique values in 'bad_conditions' and sort the index
print(weather.bad_conditions.value_counts().sort_index())

# Create a dictionary that maps integers to strings
mapping = {0:'good', 1:'bad', 2:'bad', 3:'bad', 4:'bad', 5:'worse', 6:'worse', 
7: 'worse', 8: 'worse', 9: 'worse'}

# Convert the 'bad_conditions' integers to strings using the 'mapping'
weather['rating'] = weather.bad_conditions.map(mapping)

# Count the unique values in 'rating'
print(weather.rating.value_counts())


# Create a list of weather ratings in logical order
cats = ['good', 'bad', 'worse']

# Change the data type of 'rating' to category
weather['rating'] = weather.rating.astype('category', ordered = True, categories = cats)

# Examine the head of 'rating'
print(weather.rating.head())

## Merging Dataset----

# Reset the index of 'ri'
ri.reset_index(inplace=True)

# Examine the head of 'ri'
print(ri.head())

# Create a DataFrame from the 'DATE' and 'rating' columns
weather_rating = weather[['DATE', 'rating']]

# Examine the head of 'weather_rating'
print(weather_rating.head())


# Examine the shape of 'ri'
print(ri.shape)

# Merge 'ri' and 'weather_rating' using a left join
ri_weather = pd.merge(left=ri, right=weather_rating, left_on='stop_date', right_on='DATE', how='left')

# Examine the shape of 'ri_weather'
print(ri_weather.shape)

# Set 'stop_datetime' as the index of 'ri_weather'
ri_weather.set_index('stop_date', inplace=True)

# Calculate the overall arrest rate
print(ri_weather.is_arrested.mean())

# Calculate the arrest rate for each 'rating'
print(ri_weather.groupby('rating').is_arrested.mean())

# Calculate the arrest rate for each 'violation' and 'rating'
print(ri_weather.groupby(['violation', 'rating']).is_arrested.mean())


# Save the output of the groupby operation from the last exercise
arrest_rate = ri_weather.groupby(['violation', 'rating']).is_arrested.mean()

# Print the 'arrest_rate' Series
print(arrest_rate)

# Print the arrest rate for moving violations in bad weather
print(arrest_rate['Moving violation', 'bad'])

# Print the arrest rates for speeding violations in all three weather conditions
print(arrest_rate['Speeding'])


# Unstack the 'arrest_rate' Series into a DataFrame
print(arrest_rate.unstack())

# Create the same DataFrame using a pivot table
print(ri_weather.pivot_table(index='violation', columns='rating', values='is_arrested'))

