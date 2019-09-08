city_1 = ['Austin', 'Denver', 'Springfield', 'Mendocino']
branch_id_1 = [10, 20, 30, 47]
state_1 = ['TX', 'CO', 'IL', 'CA']
revenue_1 = [100, 83, 4, 200]

city_2 = ['Austin', 'Denver', 'Mendocino' ,'Springfield']
branch_id_2 = [10, 20, 37, 31]
state_2 = ['TX', 'CO', 'CA', 'MO']
manager_2 = ['Charlers', 'Joel', 'Brett', 'Sally']

dict_1 = {'city':city_1, 'branch_id' : branch_id_1, 
'state' : state_1, 'revenue' : revenue_1}

dict_2 = {'city' : city_2, 'branch_id' : branch_id_2,
'state' : state_2, 'manager' : manager_2}

revenue = pd.DataFrame(dict_1)
managers = pd.DataFrame(dict_2)

revenue
managers

# Merge revenue with managers on 'city': merge_by_city
merge_by_city = pd.merge(revenue, managers, on = 'city')

# Print merge_by_city
print(merge_by_city)

# Merge revenue with managers on 'branch_id': merge_by_id
merge_by_id = pd.merge(revenue, managers, on = 'branch_id')

# Print merge_by_id
print(merge_by_id)

## -----

city_1 = ['Austin', 'Denver', 'Springfield', 'Mendocino']
branch_id_1 = [10, 20, 30, 47]
state_1 = ['TX', 'CO', 'IL', 'CA']
revenue_1 = [100, 83, 4, 200]

branch_2 = ['Austin', 'Denver', 'Mendocino' ,'Springfield']
branch_id_2 = [10, 20, 37, 31]
state_2 = ['TX', 'CO', 'CA', 'MO']
manager_2 = ['Charlers', 'Joel', 'Brett', 'Sally']

dict_1 = {'city':city_1, 'branch_id' : branch_id_1, 
'state' : state_1, 'revenue' : revenue_1}

dict_2 = {'branch' : branch_2, 'branch_id' : branch_id_2,
'state' : state_2, 'manager' : manager_2}

revenue = pd.DataFrame(dict_1)
managers = pd.DataFrame(dict_2)

revenue
managers


# Merge revenue & managers on 'city' & 'branch': combined
combined = pd.merge(revenue, managers, left_on = 'city', 
right_on = 'branch')

# Print combined
print(combined)

## ----
revenue
managers.columns = ['city', 'branch_id', 'state', 'manager']

# Add 'state' column to revenue: revenue['state']
revenue['state'] = ['TX', 'CO', 'IL', 'CA']

# Add 'state' column to managers: managers['state']
managers['state'] = ['TX', 'CO', 'CA', 'MO']

# Merge revenue & managers on 'branch_id', 'city', & 'state': combined
combined = pd.merge(revenue, managers, on = ['branch_id', 
'city', 'state'])

# Print combined
print(combined)


## ----

city_1 = ['Austin', 'Denver', 'Springfield', 'Mendocino']
branch_id_1 = [10, 20, 30, 47]
state_1 = ['TX', 'CO', 'IL', 'CA']
revenue_1 = [100, 83, 4, 200]

branch_2 = ['Austin', 'Denver', 'Mendocino' ,'Springfield']
branch_id_2 = [10, 20, 47, 31]
state_2 = ['TX', 'CO', 'CA', 'MO']
manager_2 = ['Charlers', 'Joel', 'Brett', 'Sally']

dict_1 = {'city':city_1, 'branch_id' : branch_id_1, 
'state' : state_1, 'revenue' : revenue_1}

dict_2 = {'branch' : branch_2, 'branch_id' : branch_id_2,
'state' : state_2, 'manager' : manager_2}

revenue = pd.DataFrame(dict_1)
managers = pd.DataFrame(dict_2)

revenue
managers

revenue = revenue.set_index('branch_id')
managers = managers.set_index('branch_id')

pd.merge(revenue, managers, on = 'branch_id')

pd.merge(managers, revenue, how = 'left')

revenue.join(managers, lsuffix='_rev', 
rsuffix='_mng', how='outer')

managers.join(revenue, lsuffix='_mgn', rsuffix='_rev', how='left')


## ----

city_1 = ['Austin', 'Denver', 'Springfield', 'Mendocino']
branch_id_1 = [10, 20, 30, 47]
state_1 = ['TX', 'CO', 'IL', 'CA']
revenue_1 = [100, 83, 4, 200]

branch_2 = ['Austin', 'Denver', 'Mendocino' ,'Springfield']
branch_id_2 = [10, 20, 47, 31]
state_2 = ['TX', 'CO', 'CA', 'MO']
manager_2 = ['Charlers', 'Joel', 'Brett', 'Sally']

city_3 = ['Mendocino', 'Denver', 'Austin', 'Springfield', 'Springfield']
state_3 = ['CA', 'CO', 'TX', 'MO', 'IL']
units_3 = [1, 4, 2, 5, 1]

dict_1 = {'city':city_1, 'branch_id' : branch_id_1, 
'state' : state_1, 'revenue' : revenue_1}

dict_2 = {'branch' : branch_2, 'branch_id' : branch_id_2,
'state' : state_2, 'manager' : manager_2}

dict_3 = {'city': city_3, 'state' : state_3, 'units': units_3}

revenue = pd.DataFrame(dict_1)
managers = pd.DataFrame(dict_2)
sales = pd.DataFrame(dict_3)

revenue_and_sales = pd.merge(revenue, sales, how='right', on = ['city', 'state'])

# Print revenue_and_sales
print(revenue_and_sales)

# Merge sales and managers: sales_and_managers
sales_and_managers = pd.merge(sales, managers, how = 'left', 
left_on = ['city', 'state'], right_on = ['branch', 'state'])

# Print sales_and_managers
print(sales_and_managers)

 # Perform the first merge: merge_default
merge_default = pd.merge(sales_and_managers, revenue_and_sales)

# Print merge_default
print(merge_default)

# Perform the second merge: merge_outer
merge_outer = pd.merge(sales_and_managers, revenue_and_sales, 
how = 'outer')

# Print merge_outer
print(merge_outer)

# Perform the third merge: merge_outer_on
merge_outer_on = pd.merge(sales_and_managers, revenue_and_sales, 
how = 'outer')

# Print merge_outer_on
print(merge_outer_on)


## 
date_1 = ['2016-01-01', '2016-02-08', '2016-01-17']
ratings_1 = ['Cloudy', 'Cloudy' , 'Sunny']

dict_1 = {'date': date_1, 'ratings' : ratings_1}
austin = pd.DataFrame(dict_1)

date_2 = ['2016-01-04', '2016-01-01', '2016-03-01']
ratings_2 = ['Rainy', 'Cloudy' , 'Sunny']

dict_2 = {'date': date_2, 'ratings' : ratings_2}
houston = pd.DataFrame(dict_2)

# Perform the first ordered merge: tx_weather
tx_weather = pd.merge_ordered(austin, houston)

# Print tx_weather
print(tx_weather)

# Perform the second ordered merge: tx_weather_suff
tx_weather_suff = pd.merge_ordered(austin, houston, on='date',
suffixes = ['_aus', '_hus'])

# Print tx_weather_suff
print(tx_weather_suff)

# Perform the third ordered merge: tx_weather_ffill
tx_weather_ffill = pd.merge_ordered(austin, houston, on='date',
suffixes = ['_aus', '_hus'], fill_method = 'ffill')


# Print tx_weather_ffill
print(tx_weather_ffill)

##----

oil = pd.read_csv('./data/oil_price.csv').iloc[0:5, :]
auto = pd.read_csv('./data/automobiles.csv').iloc[0:5, :]

pd.merge_asof(auto, oil, left_on = 'yr', 
right_on='Date')

# Merge auto and oil: merged
merged = pd.merge_asof(auto, oil, left_on = 'yr', 
right_on = 'Date')

# Print the tail of merged
print(merged.tail())

# Resample merged: yearly
yearly = merged.resample('A', on = 'Date')[['mpg', 'Price']].mean()

# Print yearly
print(yearly)

# print yearly.corr()
print(yearly.corr())








