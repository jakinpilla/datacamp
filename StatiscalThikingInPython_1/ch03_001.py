import numpy as np
import pandas as pd

# Seed the random number generator
np.random.seed(42)

# Initialize random numbers: random_numbers
random_numbers = np.empty(100000)

# Generate random numbers by looping over range(100000)
for i in range(100000):
    random_numbers[i] = np.random.random()

plt.clf()
# Plot a histogram
_ = plt.hist(random_numbers)

# Show the plot
plt.show()


def perform_bernoulli_trials(n, p):
    """Perform n Bernoulli trials with success probability p
    and return number of successes."""
    # Initialize number of successes: n_success
    n_success = 0
    # Perform trials
    for i in range(n):
        # Choose random number between zero and one: random_number
        random_number = np.random.random()
        # If less than p, it's a success so add one to n_success
        if random_number < p:
            n_success += 1
    return n_success
    
perform_bernoulli_trials(100, .5)

# # Seed random number generator
# np.random.seed(42)
# 
# # Initialize the number of defaults: n_defaults
# n_defaults = np.empty(1000)
# 
# # Compute the number of defaults
# for i in range(1000):
#     n_defaults[i] = np.random.random()
# 
# plt.clf()
# # Plot the histogram with default number of bins; label your axes
# _ = plt.hist(n_defaults, normed = True)
# _ = plt.xlabel('number of defaults out of 100 loans')
# _ = plt.ylabel('probability')
# 
# # Show the plot
# plt.show()


# Seed random number generator
np.random.seed(42)

# Initialize the number of defaults: n_defaults
n_defaults = np.empty(1000)

# Compute the number of defaults
for i in range(1000):
    n_defaults[i] = perform_bernoulli_trials(100, 0.05)

plt.clf()
# Plot the histogram with default number of bins; label your axes
_ = plt.hist(n_defaults, normed=True)
_ = plt.xlabel('number of defaults out of 100 loans')
_ = plt.ylabel('probability')

# Show the plot
plt.show()

def ecdf(data):
    """Compute ECDF for a one-dimensional array of measurements."""
    # Number of data points: n
    n = len(data)
    x = np.sort(data)
    y = np.arange(1, n+1) / n
    return x, y

for i in range(1000):
    n_defaults[i] = perform_bernoulli_trials(100, 0.05)

n_defaults
len(n_defaults)

# Compute ECDF: x, y
x, y = ecdf(n_defaults)

plt.clf()
# Plot the ECDF with labeled axes
_ = plt.plot(x, y, marker = '.', linestyle = 'none')
plt.xlabel('number of defaults out of 100')
plt.ylabel('CDF')

# Show the plot
plt.show()

# Compute the number of 100-loan simulations with 10 or more defaults: n_lose_money
n_lose_money = np.sum(n_defaults >= 10)

# Compute and print probability of losing money
print('Probability of losing money =', n_lose_money / len(n_defaults))


# Take 10,000 samples out of the binomial distribution: n_defaults
n_defaults = np.random.binomial(100, .05, size = 10000)

# Compute CDF: x, y
x, y = ecdf(n_defaults)

# Plot the CDF with axis labels
plt.clf()

_ = plt.plot(x, y, marker = '.', linestyle ='none')
plt.xlabel('number of defaults out of 100 loans')
plt.ylabel('CDF')

# Show the plot
plt.show()


# Compute bin edges: bins
bins = np.arange(min(n_defaults), max(n_defaults) + 1.5) - 0.5

# Generate histogram
plt.clf()
_ = plt.hist(n_defaults, normed =True, bins = bins)


# Label axes
plt.xlabel('number of defaults out of 100 loans')
plt.ylabel('PMF')

# Show the plot
plt.show()

# Poisson process

# The number r of arrivals of a Poisson process in a given time interval with average
# rate of 'lambda' arrivals per interval is Poisson distributed...

# The number r  of hits on a website in one hour with an average hit rate of 6 hits
# per hour is Poisson distributed...


# Draw 10,000 samples out of Poisson distribution: samples_poisson
samples_poisson = np.random.poisson(10, size = 10000)

# Print the mean and standard deviation
print('Poisson:     ', np.mean(samples_poisson),
                       np.std(samples_poisson))

# Specify values of n and p to consider for Binomial: n, p
n = [20, 100, 1000]
p = [.5, .1, .01]

# Draw 10,000 samples for each n,p pair: samples_binomial
for i in range(3):
    samples_binomial = np.random.binomial(n[i], p[i])
    # Print results
    print('n =', n[i], 'Binom:', np.mean(samples_binomial),
                                 np.std(samples_binomial))


