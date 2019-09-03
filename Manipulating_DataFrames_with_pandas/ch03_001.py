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

