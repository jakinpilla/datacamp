import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\ImportingDataInPython_Part1') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

# Import plotting modules
import matplotlib.pyplot as plt 
import seaborn as sns

# Serialize = convert object to bytestream

import pickle

##
file = './data/battledeath.xlsx'

data = pd.ExcelFile(file)
print(data.sheet_names)


# Import pickle package
import pickle

# Open pickle file and load data: d
with open('data.pkl', 'rb') as file:
    d = pickle.load(file)

# Print d
print(d)

# Print datatype of d
print(type(d))

# Import pandas
import pandas as pd

# Assign spreadsheet filename: file
file = './data/battledeath.xlsx'

# Load spreadsheet: xl
xls = pd.ExcelFile(file)

# Print sheet names
print(xls.sheet_names)


# Load a sheet into a DataFrame by name: df1
df1 = xls.parse('2004')

# Print the head of the DataFrame df1
print(df1.head())

# Load a sheet into a DataFrame by index: df2
df2 = xls.parse(0)

# Print the head of the DataFrame df2
print(df2.head())

# Parse the first sheet and rename the columns: df1
df1 = xls.parse(0, skiprows=[0], 
names=['Country', 'AAM due to War (2002)'])

# Print the head of the DataFrame df1
print(df1.head())

# Parse the first column of the second sheet and rename the column: df2
df2 = xls.parse(1, usecols=[0], skiprows=[0], 
names=['Country'])

# Print the head of the DataFrame df2
print(df2.head())

import pandas as pd

from sas7bdat import SAS7BDAT

with SAS7BDAT('./data/sales.sas7bdat') as file:
  df_sas = file.to_data_frame()
  
df_sas.head()

import pandas as pd
data = pd.read_stata('./data/disarea.dta')
data.head()
data.columns

# Import sas7bdat package
from sas7bdat import SAS7BDAT

# Save file to a DataFrame: df_sas
with SAS7BDAT('./data/sales.sas7bdat') as file:
    df_sas = file.to_data_frame()

# Print head of DataFrame
print(df_sas.head())

# Plot histogram of DataFrame features (pandas and pyplot already imported)
pd.DataFrame.hist(df_sas[['P']])
plt.ylabel('count')
plt.show()

# Import pandas
import pandas as pd

# Load Stata file into a pandas DataFrame: df
df = pd.read_stata('./data/disarea.dta')

# Print the head of the DataFrame df
print(df.head())

# Plot histogram of one column of the DataFrame
pd.DataFrame.hist(df[['disa10']])
plt.xlabel('Extent of disease')
plt.ylabel('Number of countries')
plt.show()

import h5py

filename = './data/L-L1_LOSC_4_V1-1126259446-32.hdf5'

data = h5py.File(filename, 'r')

print(type(data))

for key in data.keys():
  print(key)
  
print(type(data['meta']))

for key in data['meta'].keys():
  print(key)
  
  
print(data['meta']['Description'].value, 
data['meta']['Detector'].value)

# Get the HDF5 group: group
group= data['strain']

# Check out keys of group
for key in group.keys():
    print(key)

# Set variable equal to time series data: strain
strain = data['strain']['Strain'].value

# Set number of time points to sample: num_samples
num_samples = 10000

# Set time vector
time = np.arange(0, 1, 1/num_samples)

# Plot data
plt.clf()
plt.plot(time, strain[:num_samples])
plt.xlabel('GPS Time (s)')
plt.ylabel('strain')
plt.show()


import scipy.io

filename = './data/ja_data2.mat'

mat = scipy.io.loadmat(filename)

print(type(mat))

# print(type(mat['x']))


# Print the keys of the MATLAB dictionary
print(mat.keys())

# Print the type of the value corresponding to the key 'CYratioCyt'
print(type(mat['CYratioCyt']))

# Print the shape of the value corresponding to the key 'CYratioCyt'
print(mat['CYratioCyt'].shape)

# Subset the array and plot it
data = mat['CYratioCyt'][25, 5:]
fig = plt.figure()
plt.plot(data)
plt.xlabel('time (min.)')
plt.ylabel('normalized fluorescence (measure of expression)')
plt.show()

