import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Analyzing_Police_Activity_with_Pandas') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt

white = ri[ri.driver_race =='White']
white.shape
white.stop_outcome.value_counts(normalize = True)

asian = ri[ri.driver_race == 'Asian']
asian.shape
asian.stop_outcome.value_counts(normalize = True)

# Count the unique values in 'violation'
print(ri.violation.value_counts())

# Express the counts as proportions
print(ri.violation.value_counts(normalize = True))

# Create a DataFrame of female drivers
female = ri[ri.driver_gender == 'F']
female.shape
# Create a DataFrame of male drivers
male = ri[ri.driver_gender == 'M']

# Compute the violations by female drivers (as proportions)
print(female.violation.value_counts(normalize = True))

# Compute the violations by male drivers (as proportions)
print(male.violation.value_counts(normalize = True))

female_and_arrested = ri[(ri.driver_gender == 'F') & (ri.is_arrested == True)]
female_and_arrested.shape

famale_or_arrested = ri[(ri.driver_gender == 'F') |
(ri.is_arrested == True)]

famale_or_arrested.shape

# Ampersand(&)

ri.violation
# Create a DataFrame of female drivers stopped for speeding
female_and_speeding = ri[(ri.driver_gender == 'F') & (ri.violation == 'Speeding')]

# Create a DataFrame of male drivers stopped for speeding
male_and_speeding = ri[(ri.driver_gender == 'M') & (ri.violation == 'Speeding')]

# Compute the stop outcomes for female drivers (as proportions)
print(female_and_speeding.stop_outcome.value_counts(normalize = True))

# Compute the stop outcomes for male drivers (as proportions)
print(male_and_speeding.stop_outcome.value_counts(normalize = True))

ri.is_arrested.value_counts(normalize = True)

ri.is_arrested.mean()

ri.district.unique()

ri[ri.district == 'Zone K1'].is_arrested.mean()
ri[ri.district == 'Zone K2'].is_arrested.mean()

ri.groupby('district').is_arrested.mean()

ri.groupby(['district', 'driver_gender']).is_arrested.mean()
ri.groupby(['driver_gender', 'district']).is_arrested.mean()


# Check the data type of 'search_conducted'
print(ri.search_conducted.dtype)

# Calculate the search rate by counting the values
print(ri.search_conducted.value_counts(normalize = True))

# Calculate the search rate by taking the mean
print(ri.search_conducted.mean())

# Calculate the search rate for female drivers
print(ri[ri.driver_gender == 'F'].search_conducted.mean())

# Calculate the search rate for male drivers
print(ri[ri.driver_gender == 'M'].search_conducted.mean())

# Calculate the search rate for both groups simultaneously
print(ri.groupby('driver_gender').search_conducted.mean())

# Calculate the search rate for each combination of gender and violation
print(ri.groupby(['driver_gender', 'violation']).search_conducted.mean())

# Reverse the ordering to group by violation before gender
print(ri.groupby(['violation', 'driver_gender']).search_conducted.mean())

# Count the 'search_type' values
print(ri.search_type.value_counts())

# Check if 'search_type' contains the string 'Protective Frisk'
ri['frisk'] = ri.search_type.str.contains('Protective Frisk', na=False)

# Check the data type of 'frisk'
print(ri.frisk.dtype)

# Take the sum of 'frisk'
print(ri.frisk.sum())

# Create a DataFrame of stops in which a search was conducted
searched = ri[ri['search_conducted'] == True]
ri.shape
searched.shape

# Calculate the overall frisk rate by taking the mean of 'frisk'
print(searched.frisk.mean())

# Calculate the frisk rate for each gender
print(searched.groupby('driver_gender').frisk.mean())
