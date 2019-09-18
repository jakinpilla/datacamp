import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\StatisticalThinkingInPython_2') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

# Import plotting modules
import matplotlib.pyplot as plt 
import seaborn as sns

np.random.choice([1, 2, 3, 4, 5], size = 5)

michelson_speed_of_light = np.array(pd.read_csv('./data/michelson_speed_of_light.csv')['velocity of light in air (km/s)'])

bs_sample = np.random.choice(michelson_speed_of_light, size = 100)

np.mean(bs_sample)
np.median(bs_sample)
np.std(bs_sample)

##----
def ecdf(data):
    """Compute ECDF for a one-dimensional array of measurements."""
    # Number of data points: n
    n = len(data)
    # x-data for the ECDF: x
    x = np.sort(data)
    # y-data for the ECDF: y
    y = np.arange(1, n+1) / n
    return x, y
    
weather_station = pd.read_csv('./data/sheffield_weather_station.csv')
rainfall = np.array(weather_station.rain)
plt.clf()

for _ in range(50):
    # Generate bootstrap sample: bs_sample
    bs_sample = np.random.choice(rainfall, size=len(rainfall))
    # Compute and plot ECDF from bootstrap sample
    x, y = ecdf(bs_sample)
    _ = plt.plot(x, y, marker='.', linestyle='none',
                 color='gray', alpha=0.1)

# Compute and plot ECDF from original data
x, y = ecdf(rainfall)
_ = plt.plot(x, y, marker='.')


# Make margins and label axes
plt.margins(0.02)
_ = plt.xlabel('yearly rainfall (mm)')
_ = plt.ylabel('ECDF')

# Show the plot
plt.show()


# Boostrap confidence intervals...

def bootsrap_replicate_1d(data, func):
  '''Generate bootstrap replicate of 1D data.'''
  bs_sample = np.random.choice(data, len(data))
  return func(bs_sample)


bootsrap_replicate_1d(michelson_speed_of_light, np.mean)
bootsrap_replicate_1d(michelson_speed_of_light, np.mean)
bootsrap_replicate_1d(michelson_speed_of_light, np.mean)

bs_replicates = np.empty(10000)

for i in range(10000):
  bs_replicates[i] = bootsrap_replicate_1d(michelson_speed_of_light, np.mean)
  
bs_replicates


plt.clf()
_ = plt.hist(bs_replicates, bins = 30, normed = True)
_ = plt.xlabel('mean speed of light (km/s)')
_ = plt.ylabel('PDF')

plt.show()

conf_int = np.percentile(bs_replicates, [2.5, 97.5])
conf_int


def draw_bs_reps(data, func, size=1):
    """Draw bootstrap replicates."""
    # Initialize array of replicates: bs_replicates
    bs_replicates = ____

    # Generate replicates
    for i in ____:
        bs_replicates[i] = ____

    return bs_replicates










