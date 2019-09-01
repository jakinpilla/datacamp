import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\CleaningDataInPython') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt

# loading data
tips = pd.read_csv('./tips.csv')

# Convert the sex column to type 'category'
tips.sex = tips.sex.astype('category')

# Convert the smoker column to type 'category'
tips.smoker = tips.smoker.astype('category')

# Print the info of tips
print(tips.info())

# Convert 'total_bill' to a numeric dtype
tips['total_bill'] = pd.to_numeric(tips['total_bill'], errors='coerce')

# Convert 'tip' to a numeric dtype
tips['tip'] = pd.to_numeric(tips['tip'], errors='coerce')

# Print the info of tips
print(tips.info())

# \d* 
# \$\d*
# \$\d*\.\d*
# \$\d*\.\d{2}
# ^\$d*\.\d{2}$

# Import the regular expression module
import re

# Compile the pattern: prog
prog = re.compile('\d{3}-\d{3}-\d{4}')

# See if the pattern matches
result = prog.match('123-456-7890')
print(bool(result))

# See if the pattern matches
result2 = prog.match('1123-456-7890')
print(bool(result2))

# Import the regular expression module
import re

# Find the numeric values: matches
matches = re.findall('\d+', 'the recipe calls for 10 strawberries and 1 banana')

# Print the matches
print(matches)

# Write the first pattern
pattern1 = bool(re.match(pattern='\d{3}-\d{3}-\d{4}', string='123-456-7890'))
print(pattern1)

# Write the second pattern
pattern2 = bool(re.match(pattern='\$\d{3}\.\d{2}', string='$123.45'))
print(pattern2)

# Write the third pattern
# \w* : to match arbitrary number of alphanumeric characters...
pattern3 = bool(re.match(pattern='[A-Z]\w*', string='Australia'))
print(pattern3)


# Define recode_gender()
def recode_gender(gender):

    # Return 0 if gender is 'Female'
    if gender == 'Female':
        return 0
    
    # Return 1 if gender is 'Male'    
    elif gender == 'Male':
        return 1
    
    # Return np.nan    
    else:
        return np.nan

# Apply the function to the sex column
tips['recode'] = tips.sex.apply(recode_gender) #**

# Print the first five rows of tips
print(tips.head())

tips = pd.read_csv('./tips_with_total_dollar.csv')

# Write the lambda function using replace
tips['total_dollar_replace'] = tips.total_dollar.apply(lambda x: x.replace('$', ''))

# Write the lambda function using regular expressions
tips['total_dollar_re'] = tips.total_dollar.apply(lambda x: re.findall('\d+\.\d+', x)[0])
# IndexError: list index out of range...Why??

# https://www.jeannicholashould.com/tidy-data-in-python.html

df = pd.read_csv('./billboard.csv', encoding="mac_latin2")
df.head(10)

id_vars = ["year", "artist_inverted", "track", "time", 
"genre", "date_entered", "date_peaked"]

df = pd.melt(df, id_vars=id_vars, var_name="week", value_name="rank")
df = df.dropna()

df = df[["year", "artist_inverted","track",
         "time", "genre", "week", "rank"]]

df = df.sort_values(ascending=True, by=["year","artist_inverted","track","week","rank"])

df.to_csv('./billboard_clean.csv')

# Assigning the tidy dataset to a variable for future usage
billboard = df

billboard.head(10)

billboard = pd.read_csv('./billboard_cleaned.csv')
billboard.columns

tracks = billboard[['year', 'artist', 'track', 'time']]
print(tracks.info())

tracks_no_duplicates = tracks.drop_duplicates()
print(tracks_no_duplicates.info())

airquality = pd.read_csv('./airquality.csv')
print(airquality.info())

# Calculate the mean of the Ozone column: oz_mean
oz_mean = airquality.Ozone.mean()

# Replace all the missing values in the Ozone column with the mean
airquality['Ozone'] = airquality['Ozone'].fillna(oz_mean)

# Print the info of airquality
print(airquality.info())

ebola = pd.read_csv('ebola.csv')

# Assert that there are no missing values
assert pd.notnull(ebola).all().all()

# Assert that all values are >= 0
assert (ebola >= 0).all().all()
