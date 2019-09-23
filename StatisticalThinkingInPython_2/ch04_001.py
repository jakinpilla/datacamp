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


# import numpy as np
# 
# def diff_frac(data_A, data_B):
#   frac_A = np.sum(data_A) / len(data_A)
#   frac_B = np.sum(data_B) / len(data_B)
#   return frac_B - frac_a
#   
#   
# diff_frac_obs = diff_frac(clickthrough_A, clickthrough_B)

# 
# perm_replicates = np.empty(10000)
# 
# for i in range(10000):
#   perm_replicates[i] = permutation_replicate(
#     clickthrough_A, clickthrough_B, diff_frac
#   )
#   
# p_value= np.sum(perm_replicates >= diff_frac_obs) / 10000
 

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
    
    
def draw_perm_reps(data_1, data_2, func, size=1):
    """Generate multiple permutation replicates."""
    # Initialize array of replicates: perm_replicates
    perm_replicates = np.empty(size)
    for i in range(size):
        # Generate permutation sample
        perm_sample_1, perm_sample_2 = permutation_sample(data_1, data_2)
        # Compute the test statistic
        perm_replicates[i] = func(perm_sample_1, perm_sample_2) # func need to have  two datasets input...
    return perm_replicates
    
    
def diff_of_means(data_1, data_2):
    """Difference in means of two arrays."""
    # The difference of means of data_1, data_2: diff
    diff = np.mean(data_1) - np.mean(data_2)
    return diff


data_1 = np.array([1, 2, 3, 4, 5])
data_2 = np.array([6, 7, 8, 9, 10])

permutation_sample(data_1, data_2)
draw_perm_reps(data_1, data_2, diff_of_means, 10) # diff_of_means(dataset1, dataset2)...


# Construct arrays of data: dems, reps
dems = np.array([True] * 153 + [False] * 91)
reps = np.array([True] * 136 + [False] * 35)

def frac_yea_dems(dems, reps):
    """Compute fraction of Democrat yea votes."""
    frac = np.sum(dems) / len(dems)
    return frac

# Acquire permutation samples: perm_replicates
perm_replicates = draw_perm_reps(dems, reps, frac_yea_dems, 10000)

# Compute and p`````rint p-value: p
p = np.sum(perm_replicates <= 153/244) / len(perm_replicates)
print('p-value =', p)


pd.read_csv('./data/mlb_nohitters.csv')
pd.read_csv('./data/finch_beaks_1975.csv')

# # Compute the observed difference in mean inter-no-hitter times: nht_diff_obs
# nht_diff_obs = diff_of_means(nht_dead, nht_live)
# 
# # Acquire 10,000 permutation replicates of difference in mean no-hitter time: perm_replicates
# perm_replicates = draw_perm_reps(nht_dead, nht_live, diff_of_means, 10000)
# 
# 
# # Compute and print the p-value: p
# p = np.sum(perm_replicates <= nht_diff_obs) / len(perm_replicates)
# print('p-val =', p)


def pearson_r(x, y):
    """Compute Pearson correlation coefficient between two arrays."""
    # Compute correlation matrix: corr_mat
    corr_mat = np.corrcoef(x, y)
    # Return entry [0,1]
    return corr_mat[0,1]


female_df = pd.read_csv('./data/female_literacy_fertility.csv')
illiteracy = np.array(100 - female_df['female literacy'])
fertility = np.array(female_df.fertility)

# Compute observed correlation: r_obs
r_obs = pearson_r(illiteracy, fertility)

# Initialize permutation replicates: perm_replicates
perm_replicates = np.empty(10000)

# Draw replicates
for i in range(10000):
    # Permute illiteracy measurments: illiteracy_permuted
    illiteracy_permuted = np.random.permutation(illiteracy)
    # Compute Pearson correlation
    perm_replicates[i] = pearson_r(illiteracy_permuted, fertility)


# Compute p-value: p
p = np.sum(perm_replicates >= r_obs) / len(perm_replicates)
print('p-val =', p)


# Do neonicotinoid insecticide have unintended consequences? ----

bee = pd.read_csv('./data/bee_sperm.csv')
bee.columns
bee.Treatment.value_counts()

bee.head()

bee[bee['Treatment'] == 'Control']['Sperm Volume per 500 ul']
control = bee[bee['Treatment'] == 'Control']['Alive Sperm Millions']
treated = bee[bee['Treatment'] == 'Pesticide']['Alive Sperm Millions']


def ecdf(data):
    """Compute ECDF for a one-dimensional array of measurements."""
    # Number of data points: n
    n = len(data)
    # x-data for the ECDF: x
    x = np.sort(data)
    # y-data for the ECDF: y
    y = np.arange(1, n+1) / n
    return x, y

# Compute x,y values for ECDFs
x_control, y_control = ecdf(control)
x_treated, y_treated = ecdf(treated)

# Plot the ECDFs
plt.plot(x_control, y_control, marker='.', linestyle='none')
plt.plot(x_treated, y_treated, marker='.', linestyle='none')

# Set the margins
plt.margins(0.02)

# Add a legend
plt.legend(('control', 'treated'), loc='lower right')

# Label axes and show plot
plt.xlabel('millions of alive sperm per mL')
plt.ylabel('ECDF')
plt.show()


# Compute the difference in mean sperm count: diff_means
diff_means = np.mean(control) - np.mean(treated)

# Compute mean of pooled data: mean_count
mean_count = np.concatenate([control, treated]).mean()

# Generate shifted data sets
control_shifted = control - np.mean(control) + mean_count
treated_shifted = treated - np.mean(treated) + mean_count

def bootstrap_replicate_1d(data, func):
  '''Generate bootstrap replicate of 1D data.'''
  bs_sample = np.random.choice(data, len(data))
  return func(bs_sample)

##
def draw_bs_reps(data, func, size=1):
    """Draw bootstrap replicates."""
    # Initialize array of replicates: bs_replicates
    bs_replicates = np.empty(size)
    # Generate replicates
    for i in range(size):
        bs_replicates[i] = bootstrap_replicate_1d(data, func)
    return bs_replicates

# Generate bootstrap replicates
bs_reps_control = draw_bs_reps(control_shifted, np.mean, size=10000)
bs_reps_treated = draw_bs_reps(treated_shifted, np.mean, size=10000)

# Get replicates of difference of means: bs_replicates
bs_replicates = bs_reps_control - bs_reps_treated

# Compute and print p-value: p
p = np.sum(bs_replicates >= np.mean(control) - np.mean(treated)) / len(bs_replicates)
print('p-value =', p)






