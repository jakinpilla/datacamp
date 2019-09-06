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




