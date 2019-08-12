# random walking...

import numpy as np

# Initialize random_walk
random_walk = [0]

for x in range(100):
  step = random_walk[-1]
  dice = np.random.randint(1, 7)
  
  if dice <= 2:
    # Replace below : use max to make sure step can't go blow 0
    step = max(0, step-1)
  elif dice <= 5:
    step = step + 1
  else :
    step = step + np.random.randint(1, 7)
    
  random_walk.append(step)


# print(random_walk)

import matplotlib.pyplot as plt

plt.plot(random_walk)
plt.show()

all_walks = []

for i in range(10) :
  
  random_walk = [0]
  for x in range(100):
    step = random_walk[-1]
    dice = np.random.randint(1, 7)
    
    if dice <= 2:
      step = max(0, step - 1)
    elif dice <= 5:
      step = step + 1
    else:
      step = step + np.random.randint(1, 7)
    random_walk.append(step)
    
  all_walks.append(random_walk)
  
print(all_walks)


np_aw = np.array(all_walks)
plt.clf()
plt.plot(np_aw)
plt.show()

# Transpose np_aw : np_aw_t
plt.clf()
np_aw_t = np.transpose(np_aw)
plt.plot(np_aw_t)
plt.show()

for i in range(250) :
  
  random_walk = [0]
  for x in range(100):
    step = random_walk[-1]
    dice = np.random.randint(1, 7)
    
    if dice <= 2:
      step = max(0, step - 1)
    elif dice <= 5:
      step = step + 1
    else:
      step = step + np.random.randint(1, 7)
    random_walk.append(step)
    
    # Implement clumsiness
    if np.random.rand() <= 0.01:
      step = 0
    
  all_walks.append(random_walk)



plt.clf()
# Plotting...
np_aw_t = np.transpose(np.array(all_walks))
plt.plot(np_aw_t)
plt.show()


all_walks = []
# Plot distribution...
for i in range(500) :
  
  random_walk = [0]
  for x in range(100):
    step = random_walk[-1]
    dice = np.random.randint(1, 7)
    
    if dice <= 2:
      step = max(0, step - 1)
    elif dice <= 5:
      step = step + 1
    else:
      step = step + np.random.randint(1, 7)
    random_walk.append(step)
    
    # Implement clumsiness
    if np.random.rand() <= 0.01:
      step = 0
    
  all_walks.append(random_walk)

# select last row from np_aw_t: ends
np_aw_t = np.transpose(np.array(all_walks))
ends = np_aw_t[100, :]

plt.clf()
plt.hist(ends)
plt.show()

ends.shape
sum(ends >= 60) / 500


