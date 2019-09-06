import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Merging dataframes with pandas') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt

bronze = pd.read_csv('./data/bronze_top5.csv', index_col = 'Country')
silver = pd.read_csv('./data/silver_top5.csv', index_col = 'Country')

combined = bronze.append(silver)

combined.loc['United States']


# Import pandas
import pandas as pd

# Load 'sales-jan-2015.csv' into a DataFrame: jan
jan = pd.read_csv('./data/sales-jan-2015.csv', 
index_col = 'Date', parse_dates =True)

# Load 'sales-feb-2015.csv' into a DataFrame: feb
feb = pd.read_csv('./data/sales-feb-2015.csv', 
index_col = 'Date', parse_dates =True)

# Load 'sales-mar-2015.csv' into a DataFrame: mar
mar = pd.read_csv('./data/sales-mar-2015.csv', 
index_col = 'Date', parse_dates =True)

# Extract the 'Units' column from jan: jan_units
jan_units = jan['Units']

# Extract the 'Units' column from feb: feb_units
feb_units = feb['Units']

# Extract the 'Units' column from mar: mar_units
mar_units = mar['Units']

# Append feb_units and then mar_units to jan_units: quarter1
quarter1 = jan_units.append(feb_units).append(mar_units)

# Print the first slice from quarter1
print(quarter1.loc['jan 27, 2015':'feb 2, 2015'])

# Print the second slice from quarter1
print(quarter1.loc['feb 26, 2015':'mar 7, 2015'])

# Compute & print total sales in quarter1
print(quarter1.sum())


# Initialize empty list: units
units = []

# Build the list of Series
for month in [jan, feb, mar]:
    units.append(month['Units'])

# Concatenate the list: quarter1
quarter1 = pd.concat(units)

# Print slices from quarter1
print(quarter1.loc['jan 27, 2015':'feb 2, 2015'])
print(quarter1.loc['feb 26, 2015':'mar 7, 2015'])

names_1881 = pd.read_csv('./data/names1881.csv')
names_1881.head()
names_1881.columns = ['name', 'gender', 'count']

names_1981 = pd.read_csv('./data/names1981.csv')
names_1981.head()
names_1981.columns = ['name', 'gender', 'count']

# Add 'year' column to names_1881 and names_1981
names_1881['year'] = 1881
names_1981['year'] = 1981

names_1881.head()
names_1981.head()

# Append names_1981 after names_1881 with ignore_index=True: combined_names
combined_names = names_1881.append(names_1981, ignore_index=True)

# Print shapes of names_1981, names_1881, and combined_names
print(names_1981.shape)
print(names_1881.shape)
print(combined_names.shape)

combined_names.head()

# Print all rows that contain the name 'Morgan'
print(combined_names.loc[combined_names['name'] == 'Morgan'])

# Create a list of weather_max and weather_mean
weather_list = [weather_max, weather_mean]

# Concatenate weather_list horizontally
weather = pd.concat(weather_list, axis=1)

# Print weather
print(weather)

medal_types = ['bronze', 'silver', 'gold']

#Initialize an empyy list: medals
medals =[]

for medal in medal_types:
    # Create the file name: file_name
    file_name = "./data/%s_top5.csv" % medal
    # Create list of column names: columns
    columns = ['Country', medal]
    # Read file_name into a DataFrame: medal_df
    medal_df = pd.read_csv(file_name, header = 0, index_col = 'Country',
    names=columns)
    # Append medal_df to medals
    medals.append(medal_df)

# Concatenate medals horizontally: medals_df
medals_df = pd.concat(medals, axis=1)

# Print medals_df
print(medals_df)

##

medals = []

for medal in medal_types:

    file_name = "./data/%s_top5.csv" % medal
    
    # Read file_name into a DataFrame: medal_df
    medal_df = pd.read_csv(file_name, index_col = 'Country')
    
    # Append medal_df to medals
    medals.append(medal_df)
    
# Concatenate medals: medals
medals = pd.concat(medals, keys=['bronze', 'silver', 'gold'])

# Print medals in entirety
print(medals)


# Sort the entries of medals: medals_sorted
medals_sorted = medals.sort_index(level=0)

# Print the number of Bronze medals won by Germany
print(medals_sorted.loc[('bronze','Germany')])

# Print data about silver medals
print(medals_sorted.loc['silver'])

# Create alias for pd.IndexSlice: idx
idx = pd.IndexSlice

# Print all the data on medals won by the United Kingdom
print(medals_sorted.loc[idx[:, 'United Kingdom'], :])


hardware = pd.read_csv('./data/feb-sales-Hardware.csv', index_col = 'Date')
software = pd.read_csv('./data/feb-sales-Software.csv', index_col = 'Date')
service = pd.read_csv('./data/feb-sales-Service.csv', index_col = 'Date')

dataframes = [hardware, software, service]

# Concatenate dataframes: february
february = pd.concat(dataframes, keys=['Hardware', 'Software',
'Service'], axis=1)

# Print february.info()
print(february.info())

# Assign pd.IndexSlice: idx
idx = pd.IndexSlice

# Create the slice: slice_2_8
slice_2_8 = february.loc['Feb. 2, 2015':'Feb. 8, 2015', idx[:, 'Company']]

# Print slice_2_8
print(slice_2_8)

# Make the list of tuples: month_list
month_list = [('january', jan) , ('february', feb), ('march', mar)]

# Create an empty dictionary: month_dict
month_dict = {}

for month_name, month_data in month_list:

    # Group month_data: month_dict[month_name]
    month_dict[month_name] = month_data.groupby('Company').sum()

# Concatenate data in month_dict: sales
sales = pd.concat(month_dict)

# Print sales
print(sales)

# Print all sales by Mediacore
idx = pd.IndexSlice
print(sales.loc[idx[:, 'Mediacore'], :])

bronze

# Create the list of DataFrames: medal_list
medal_list = [bronze, silver, gold]

# Concatenate medal_list horizontally using an inner join: medals
medals = pd.concat(medal_list, 
keys=['bronze', 'silver', 'gold'], 
axis = 1, 
join = 'inner')

# Print medals
print(medals)


## ----

# Resample and tidy china: china_annual
china_annual = china.resample('A').last().pct_change(10).dropna()

# Resample and tidy us: us_annual
us_annual = us.resample('A').last().pct_change(10).dropna()

# Concatenate china_annual and us_annual: gdp
gdp = pd.concat([china_annual, us_annual], join='inner', axis=1)

# Resample gdp and print
print(gdp.resample('10A').last())

