import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\CleaningDataInPython') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

import matplotlib.pyplot as plt

# import rpy2.robjects as robjects

uber1 = pd.read_csv('./uber1.csv')
uber2 = pd.read_csv('./uber2.csv')
uber3 = pd.read_csv('./uber3.csv')


# Concatenate uber1, uber2, and uber3: row_concat
row_concat = pd.concat([uber1, uber2, uber3])

# Print the shape of row_concat
print(row_concat.shape)

# Print the head of row_concat
print(row_concat.head())


ebola = pd.read_csv('./ebola.csv')

# Melt ebola: ebola_melt
ebola_melt = pd.melt(ebola, id_vars=['Date', 'Day'], 
var_name='type_country', value_name='counts')

# status_country...
status = ebola_melt.type_country.str.split("_").str.get(0)
country = ebola_melt.type_country.str.split("_").str.get(1)

status_country = pd.concat([status, country], axis = 1)

# Concatenate ebola_melt and status_country column-wise: ebola_tidy
ebola_tidy = pd.concat([ebola_melt, status_country], axis = 1)

# Print the shape of ebola_tidy
print(ebola_tidy.shape)

# Print the head of ebola_tidy
print(ebola_tidy.head())


# Globbing...
# *.csv, file_?.csv

import glob
import os
os.getcwd()


glob.glob("uber?.csv")

# Write the pattern: pattern
pattern = 'uber?.csv'

# Save all file matches: csv_files
csv_files = glob.glob(pattern)

# Print the file names
print(csv_files)

# Load the second file into a DataFrame: csv2
csv2 = pd.read_csv(csv_files[1])

# Print the head of csv2
print(csv2.head())


# Create an empty list: frames
frames = []

#  Iterate over csv_files
for csv in csv_files:

    #  Read csv into a DataFrame: df
    df = pd.read_csv(csv)
    
    # Append df to frames
    frames.append(df)

# Concatenate frames into a single DataFrame: uber
uber = pd.concat(frames)

# Print the shape of uber
print(uber.shape)

# Print the head of uber
print(uber.head())

# Merge Data...
site = pd.read_csv('site.csv')
visited = pd.read_csv('visited.csv')

# Merge the DataFrames: o2o
o2o = pd.merge(left=site, right=visited, left_on='name', right_on='site')

# Print o2o
print(o2o)


site = pd.read_csv('site.csv')
visited = pd.read_csv('visited.csv')
survey = pd.read_csv('survey.csv')

# Merge the DataFrames: o2o
m2o = pd.merge(left=site, right=visited, left_on='name', right_on='site')

# Print o2o
print(m2o)

# Merge site and visited: m2m
m2m = pd.merge(left=site, right=visited, left_on='name', right_on='site')

# Merge m2m and survey: m2m
m2m = pd.merge(left=m2m, right=survey, left_on='ident', 
right_on='taken')

# Print the first 20 lines of m2m
print(m2m.head(20))

