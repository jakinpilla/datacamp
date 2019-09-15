import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Analyzing_Police_Activity_with_Pandas') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt


# apple.date_and_time.dt.month

# apple.set_index('date_and_time', inplace = True)
# apple.index
# apple.index.month

# apple.groupby(apples.index.month).price.mean()
# monthly_price = apple.groupby(apple.index.month).price.mean()

# monthly_price.plot()
# plt.xlabel
# plt.ylabel


# Calculate the overall arrest rate
print(ri.is_arrested.mean())

# Calculate the hourly arrest rate
print(ri.is_arrested.groupby(ri.index.hour).mean())

# Save the hourly arrest rate
hourly_arrest_rate = ri.is_arrested.groupby(ri.index.hour).mean()

# Import matplotlib.pyplot as plt
import matplotlib.pyplot as plt

plt.clf()
# Create a line plot of 'hourly_arrest_rate'
hourly_arrest_rate.plot()

# Add the xlabel, ylabel, and title
plt.xlabel('Hour')
plt.ylabel('Arrest Rate')
plt.title('Arrest Rate by Time of Day')

# Display the plot
plt.show()

# apple.groupby(apple.index.month).price.mean()
# apple.price.resample('M').mean()
# 
# monthly_price = apple.price.resample('M').mean()
# monthly_volume = apple.volume.resample('M').mean()
# 
# monthly = pd.concat([monthly_price, monthly_volume], axis ='columns')

# monthly.plot()
# plt.show()
# monthly.plot(subplots = True)
# plt.show()


# Calculate the annual rate of drug-related stops
print(ri.drugs_related_stop.resample('A').mean())

# Save the annual rate of drug-related stops
annual_drug_rate = ri.drugs_related_stop.resample('A').mean()

plt.clf()
# Create a line plot of 'annual_drug_rate'
annual_drug_rate.plot()

# Display the plot
plt.show()


# Calculate and save the annual search rate
annual_search_rate = ri.search_conducted.resample('A').mean()

# Concatenate 'annual_drug_rate' and 'annual_search_rate'
annual = pd.concat([annual_drug_rate, annual_search_rate], 
axis='columns')

plt.clf()
# Create subplots from 'annual'
annual.plot(subplots = True)

# Display the subplots
plt.show()

##----
pd.crosstab(ri.driver_race, ri.driver_gender) # frequency table...

ri[(ri.driver_race == 'Asian') & (ri.driver_gender == 'F')].shape

table = pd.crosstab(ri.driver_race, ri.driver_gender)

table.loc['Asian':'Hispanic']

table = table.loc['Asian':'Hispanic']


plt.clf()
table.plot()
plt.show()

plt.clf()
table.plot(kind = 'bar')
plt.show()

plt.clf()
table.plot(kind = 'bar', stacked = True)
plt.show()

# Create a frequency table of districts and violations
print(pd.crosstab(ri.district, ri.violation))

# Save the frequency table as 'all_zones'
all_zones = pd.crosstab(ri.district, ri.violation)

# Select rows 'Zone K1' through 'Zone K3'
print(all_zones.loc['Zone K1':'Zone K3'])

# Save the smaller table as 'k_zones'
k_zones = all_zones.loc['Zone K1':'Zone K3']

# plt.clf()
# Create a bar plot of 'k_zones'
k_zones.plot(kind = 'bar')

# Display the plot
plt.show()

plt.clf()
# Create a stacked bar plot of 'k_zones'
k_zones.plot(kind = 'bar', stacked = True)

# Display the plot
plt.show()

mapping = {'up':True, 'down':False}
apple['is_up'] = apple.change.map(mapping)

apple.is_up.mean()

