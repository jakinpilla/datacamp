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

def bootstrap_replicate_1d(data, func):
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
    bs_replicates = np.empty(size)
    # Generate replicates
    for i in range(size):
        bs_replicates[i] = bootstrap_replicate_1d(data, func)
    return bs_replicates
    
# Take 10,000 bootstrap replicates of teh mean: bs_replicates
bs_replicates = draw_bs_reps(rainfall, np.mean, 10000)

# Compute and print SEM
sem = np.std(rainfall) / np.sqrt(len(rainfall))
print(sem)

# Compute and print standard deviation of bootstrap replicates
bs_std = np.std(bs_replicates)
print(bs_std)

# plt.clf()
# Make a histogram of the results
_ = plt.hist(bs_replicates, bins=50, normed=True)
_ = plt.xlabel('mean annual rainfall (mm)')
_ = plt.ylabel('PDF')

# Show the plot
plt.show()



# Generate 10,000 bootstrap replicates of the variance: bs_replicates
bs_replicates = draw_bs_reps(rainfall, np.var, 10000)

# Put the variance in units of square centimeters
bs_replicates = bs_replicates / 100

# plt.clf()
# Make a histogram of the results
_ = plt.hist(bs_replicates, bins = 50, normed = True)
_ = plt.xlabel('variance of annual rainfall (sq. cm)')
_ = plt.ylabel('PDF')

# Show the plot
plt.show()

##----

nohit = pd.read_csv('./data/mlb_nohitters.csv')
nohitter_times = nohit.game_number.diff().loc[1:]
nohitter_times

# Draw bootstrap replicates of the mean no-hitter time (equal to tau): bs_replicates
bs_replicates = draw_bs_reps(nohitter_times, np.mean, 10000)

# Compute the 95% confidence interval: conf_int
conf_int = np.percentile(bs_replicates, [2.5, 97.5])

# Print the confidence interval
print('95% confidence interval =', conf_int, 'games')

# plt.clf()
# Plot the histogram of the replicates
_ = plt.hist(bs_replicates, bins=50, normed=True)
_ = plt.xlabel(r'$\tau$ (games)')
_ = plt.ylabel('PDF')

# Show the plot
plt.show()


## Pairs Bootstrap ----

np.arange(7)

swing_states = pd.read_csv('./data/2008_swing_states.csv')
total_votes = np.array(swing_states.total_votes)
dem_share = np.array(swing_states.dem_share)

inds = np.arange(len(total_votes))

bs_inds = np.random.choice(inds, len(inds))

bs_total_votes = total_votes[bs_inds]

bs_dem_share = dem_share[bs_inds]


bs_slope, bs_intercept = np.polyfit(bs_total_votes, bs_dem_share, 1)

bs_slope, bs_intercept

np.polyfit(total_votes, dem_share, 1)



def draw_bs_pairs_linreg(x, y, size=1):
    """Perform pairs bootstrap for linear regression."""
    # Set up array of indices to sample from: inds
    inds = np.arange(len(x))
    # Initialize replicates: bs_slope_reps, bs_intercept_reps
    bs_slope_reps = np.empty(size)
    bs_intercept_reps = np.empty(size)
    # Generate replicates
    for i in range(size):
        bs_inds = np.random.choice(inds, size=len(inds))
        bs_x, bs_y = x[bs_inds], y[bs_inds]
        bs_slope_reps[i], bs_intercept_reps[i] = np.polyfit(bs_x, bs_y, 1)
    return bs_slope_reps, bs_intercept_reps


female_liter_fer = pd.read_csv('./data/female_literacy_fertility.csv')
female_liter_fer

illiteracy = np.array(100 - female_liter_fer['female literacy'])
fertility = np.array(female_liter_fer.fertility)

# Generate replicates of slope and intercept using pairs bootstrap
bs_slope_reps, bs_intercept_reps = draw_bs_pairs_linreg(illiteracy, fertility, 1000)

# Compute and print 95% CI for slope
print(np.percentile(bs_slope_reps, [2.5, 97.5]))

# plt.clf()
# Plot the histogram
_ = plt.hist(bs_slope_reps, bins=50, normed=True)
_ = plt.xlabel('slope')
_ = plt.ylabel('PDF')
plt.show()


# Generate array of x-values for bootstrap lines: x
x = np.array([0, 100])

plt.clf()
# Plot the bootstrap lines
for i in range(100):
    _ = plt.plot(x, 
                 bs_slope_reps[i]*x + bs_intercept_reps[i],
                 linewidth=0.5, alpha=0.2, color='red')

# Plot the data
_ = plt.plot(illiteracy, fertility, marker = '.', linestyle=  'none')

# Label axes, set the margins, and show the plot
_ = plt.xlabel('illiteracy')
_ = plt.ylabel('fertility')
plt.margins(0.02)
plt.show()


votes = pd.read_csv('./data/2008_swing_states.csv')
dem_share_PA = np.array(votes[votes.state == 'PA'].dem_share)
dem_share_OH = np.array(votes[votes.state == 'OH'].dem_share)

dem_share_both = np.concatenate((dem_share_PA, dem_share_OH))

dem_share_perm = np.random.permutation(dem_share_both)

perm_sample_PA = dem_share_perm[:len(dem_share_PA)]


def permutation_sample(data1, data2):
    """Generate a permutation sample from two data sets."""
    # Concatenate the data sets: data
    data = np.concatenate((data1, data2))
    # Permute the concatenated array: permuted_data
    permuted_data = np.random.permutation(data)
    # Split the permuted array into two: perm_sample_1, perm_sample_2
    perm_sample_1 = permuted_data[:len(data1)]
    perm_sample_2 = permuted_data[len(data1):]
    return perm_sample_1, perm_sample_2


weather = pd.read_csv('./data/sheffield_weather_station.csv')

rain_june = np.array(weather[weather.mm == 6].rain)
rain_november = np.array(weather[weather.mm == 11].rain)

plt.clf()

for _ in range(50):
    # Generate permutation samples
    perm_sample_1, perm_sample_2 = permutation_sample(rain_june, rain_november)
    # Compute ECDFs
    x_1, y_1 = ecdf(perm_sample_1)
    x_2, y_2 = ecdf(perm_sample_2)
    # Plot ECDFs of permutation sample
    _ = plt.plot(x_1, y_1, marker='.', linestyle='none',
                 color='red', alpha=0.02)
    _ = plt.plot(x_2, y_2, marker='.', linestyle='none',
                 color='blue', alpha=0.02)

plt.show()
                 
# Create and plot ECDFs from original data
x_1, y_1 = ecdf(rain_june)
x_2, y_2 = ecdf(rain_november)
_ = plt.plot(x_1, y_1, marker='.', linestyle='none', color='red')
_ = plt.plot(x_2, y_2, marker='.', linestyle='none', color='blue')

# Label axes, set margin, and show plot
plt.margins(0.02)
_ = plt.xlabel('monthly rainfall (mm)')
_ = plt.ylabel('ECDF')
plt.show()

# Test Statics and p-values

perm_sample_PA, perm_sample_OH= permutation_sample(dem_share_PA, dem_share_OH)

np.mean(perm_sample_PA) - np.mean(perm_sample_OH)

np.mean(dem_share_PA) - np.mean(dem_share_OH)

# p-value: The probability of obtaining a value of your test statistic that is
# at least as extreme as what was observed, under the assumption the null hypothesis is true...


def draw_perm_reps(data_1, data_2, func, size=1):
    """Generate multiple permutation replicates."""
    # Initialize array of replicates: perm_replicates
    perm_replicates = np.empty(size)
    for i in range(size):
        # Generate permutation sample
        perm_sample_1, perm_sample_2 = permutation_sample(data_1, data_2)
        # Compute the test statistic
        perm_replicates[i] = func(perm_sample_1, perm_sample_2)
    return perm_replicates
    
    

frog = pd.read_csv('./data/frog_tongue.csv')

frog = frog[['ID', 'impact force (mN)']]

id = ['A', 'B', 'C', 'D']

frog['ID'] = np.array(id).repeat(20)
frog

frog['impact_force'] = frog['impact force (mN)'] / 1000
df = frog[['ID', 'impact_force']]
df['ID'] = df.ID.astype('category')
df.info()

plt.clf()

# Make bee swarm plot
_ = sns.swarmplot('ID', 'impact_force', data = df)

# Label axes
_ = plt.xlabel('frog')
_ = plt.ylabel('impact force (N)')

# Show the plot
plt.show()


def diff_of_means(data_1, data_2):
    """Difference in means of two arrays."""
    # The difference of means of data_1, data_2: diff
    diff = np.mean(data_1) - np.mean(data_2)
    return diff

# Compute difference of mean impact force from experiment: empirical_diff_means
empirical_diff_means = ____

# Draw 10,000 permutation replicates: perm_replicates
perm_replicates = draw_perm_reps(____, ____,
                                 ____, size=10000)

# Compute p-value: p
p = np.sum(____ >= ____) / len(____)

# Print the result
print('p-value =', p)
