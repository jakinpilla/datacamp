users = pd.read_csv('./data/users.csv', index_col = [0])

# Pivot the users DataFrame: visitors_pivot
visitors_pivot = users.pivot(index = 'weekday', columns = 'city', values = 'visitors')

# Print the pivoted DataFrame
print(visitors_pivot)

# Pivot users with signups indexed by weekday and city: signups_pivot
signups_pivot = users.pivot(index = 'weekday', columns = 'city', 
values = 'signups')

# Print signups_pivot
print(signups_pivot)

# Pivot users pivoted by both signups and visitors: pivot
pivot = users.pivot(index = 'weekday', columns = 'city')

# Print the pivoted DataFrame
print(pivot)

users = pd.read_csv('./data/users.csv', index_col = [0])
users = users.set_index(['city', 'weekday']).sort_index()

# Unstack users by 'weekday': byweekday
byweekday = users.unstack(['weekday'])

# Print the byweekday DataFrame
print(byweekday)

# Stack byweekday by 'weekday' and print it
print(byweekday.stack(['weekday']))

users

# Unstack users by 'city': bycity
bycity = users.unstack(['city'])

# Print the bycity DataFrame
print(bycity)

# Stack bycity by 'city' and print it
print(bycity.stack(['city']))

# Stack 'city' back into the index of bycity: newusers
newusers = bycity.stack(['city'])

# Swap the levels of the index of newusers: newusers
newusers = newusers.swaplevel(1, 0)

# Print newusers and verify that the index is not sorted
print(newusers)

# Sort the index of newusers: newusers
newusers = newusers.sort_index()

# Print newusers and verify that the index is now sorted
print(newusers)

# Verify that the new DataFrame is equal to the original
print(newusers.equals(users))

visitors_by_city_weekday = users[['visitors']].unstack(['city'])

# Reset the index: visitors_by_city_weekday
visitors_by_city_weekday = visitors_by_city_weekday.reset_index() 

# Print visitors_by_city_weekday
print(visitors_by_city_weekday)

# Melt visitors_by_city_weekday: visitors
visitors = pd.melt(visitors_by_city_weekday, id_vars=['weekday'], value_name='visitors')

# Print visitors
print(visitors)


# Melt users: skinny
users = pd.read_csv('./data/users.csv', index_col = [0])

skinny = pd.melt(users, id_vars=['weekday', 'city'])

# Print skinny
print(skinny)

users

# Set the new index: users_idx
users_idx = users.set_index(['city', 'weekday'])

# Print the users_idx DataFrame
print(users_idx)

# Obtain the key-value pairs: kv_pairs
kv_pairs = pd.melt(users_idx, col_level=0)

# Print the key-value pairs
print(kv_pairs)

users

# Create the DataFrame with the appropriate pivot table: by_city_day
by_city_day = pd.pivot_table(users, index=['weekday'], columns=['city'])

# Print by_city_day
print(by_city_day)


# Use a pivot table to display the count of each column: count_by_weekday1
count_by_weekday1 = pd.pivot_table(users, index=['weekday'], aggfunc = 'count')

# Print count_by_weekday
print(count_by_weekday1)

# Replace 'aggfunc='count'' with 'aggfunc=len': count_by_weekday2
count_by_weekday2 = pd.pivot_table(users, index=['weekday'], aggfunc = len)

# Verify that the same result is obtained
print('==========================================')
print(count_by_weekday1.equals(count_by_weekday2))


# Create the DataFrame with the appropriate pivot table: signups_and_visitors
signups_and_visitors = pd.pivot_table(users,
index = ['weekday', 'city'],
aggfunc = sum)

# Print signups_and_visitors
print(signups_and_visitors)

# Add in the margins: signups_and_visitors_total 
signups_and_visitors_total = pd.pivot_table(users,
index = ['weekday', 'city'],
aggfunc = sum, margins = True)

# Print signups_and_visitors_total
print(signups_and_visitors_total)
