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

# Open a file: file
file = open('./data/seaslug.txt', mode = 'r')

# Print it
print(file.read())

# Check whether file is closed
print(file.closed)

# Close file
file.close()

# Check whether file is closed
print(file.closed)

# Read & print the first 3 lines
with open('./data/seaslug.txt') as file:
    print(file.readline())
    print(file.readline())
    print(file.readline())


# Import package
import numpy as np

# Assign filename to variable: file
file = './data/mnist_kaggle_some_rows.csv'

pd.read_csv(file)

# Load file as array: digits
digits = np.loadtxt(file, delimiter=',')

# Print datatype of digits
print(type(digits))

# Select and reshape a row
im = digits[21, 1:]
im_sq = np.reshape(im, (28, 28))

# Plot reshaped data (matplotlib.pyplot already loaded as plt)
plt.clf()
plt.imshow(im_sq, cmap='Greys', interpolation='nearest')
plt.show()


# Import numpy
import numpy as np

# Assign the filename: file
file = 'digits_header.txt'

# Load the data: data
data = np.loadtxt(file, delimiter='\t', skiprows=1, usecols=[0, 2])

# Print data
print(data)

# Assign filename: file
file = './data/seaslug.txt'

# Import file: data
data = np.loadtxt(file, delimiter='\t', dtype=str)

# Print the first element of data
print(data[0])

# Import data as floats and skip the first row: data_float
data_float = np.loadtxt(file, delimiter='\t', dtype='float', skiprows=1)

# Print the 10th element of data_float
print(data_float)

# Plot a scatterplot of the data
plt.clf()
plt.scatter(data_float[:, 0], data_float[:, 1])
plt.xlabel('time (min.)')
plt.ylabel('percentage of larvae')
plt.show()

