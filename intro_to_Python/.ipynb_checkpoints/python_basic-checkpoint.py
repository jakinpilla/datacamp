print(18 % 8)
print(100*1.1**7)

height = 1.79
weight = 68.7

bmi = weight / height**2
bmi

# sPython Type...
type(bmi)

'ab' + 'cd'
# Different type = different behavior!

savings = 100
result = 100*1.10**7

print("I started with $"+ str(savings) + "and now have $" + str(result) + ". Aewsome!")

# List...[a, b, c]

fam = ["liz", 1.73, "emma", 1.86, "mom", 1.71, "dad", 189]
fam

# sublist...
fam2 = [["liz", 1.73], ["emma", 1.86], ["mom", 1.71], ["dad", 189]]


type(fam)
type(fam2)

fam[3]
fam[-1]
fam[-2]
fam[3:5]
fam[1:4]
fam[:4]
fam[5:]

fam[7] = 1.86
fam

fam_ext = fam + ["me", 1.79]
fam_ext
del(fam[2])
fam
del(fam[2])
fam

x = ["a", "b", "c"]
y = x
y[1] = "z"

y
x

x = ["a", "b", "c"]
y = list(x)
y = x[:]
y[1] = "z"
y
x


round(1.68, 1)
round(1.68)

help(round)
help(sorted)

# list methods...

fam = ['liz', 1.73, 'emna', 1.68, 'mom', 1.71, 'dad', 1.89]
fam.index("mom")
fam.count(1.73)

sister = 'liz'
sister.capitalize()
sister.replace('z', 'sa')

fam.append("me")
fam.append(1.79)

place = "poolhouse"
place_up = place.upper()

print(place, place_up)
place.count('o')


areas = [11.25, 18.0, 20.0, 10.75, 9.50]
areas.append(24.5)
areas.append(15.45)

print(areas)

areas.reverse()

print(areas)

# from numpy import array...

r = .43
import math

C = 2*math.pi*r
A = math.pi*r**2

print("Circumference: " + str(C))
print("Area: " + str(A))

## ------
r = 192500

from math import radians

dist = r*radians(12)

print(dist)

from scipy.linalg import inv as my_inv
my_inv([[1,2], [3,4]])


import numpy as np

height = [1.73, 1.68, 1.71, 1.89, 1.79]
np_height = np.array(height)

weight = [65.4, 59.2, 63.6, 88.4, 68.7]
np_weight = np.array(weight)

bmi = np_weight / np_height ** 2
bmi

# Numpy arrays : contain only one type
np.array([1.0, "is", True])

python_list = [1, 2, 3]
numpy_array = np.array([1, 2, 3])

python_list + python_list
numpy_array + numpy_array

bmi
bmi[1]
bmi > 23
bmi[bmi > 23]

baseball = [180, 215, 210, 210, 188, 176, 209, 200]
import numpy as np
np_baseball = np.array(baseball)
print(np_baseball)

np.array([True, 1, 2]) + np.array([3, 4, False])

# ndarray = N-dimensional array

np_2d = np.array([[1.73, 1.68, 1.71, 1.89, 1.79],[65.4, 59.2, 63.6, 88.4, 68.7]])
np_2d
np_2d.shape

np_2d[0]
np_2d[0][2]
np_2d[0, 2]
np_2d[:, 1:3]

np_2d[1, :]


# Creat baseball, a list of lists...
baseball = [[180, 78.4], [215, 102.7], [210, 98.5], [188, 75.2]]
np_baseball = np.array(baseball)
print(type(np_baseball))
np_baseball.shape

np_mat = np.array([[1, 2], [3, 4], [5, 6]])
np_mat * 2
np_mat + np.array([10, 10])
np_mat + np_mat

# Generate data....
# distribution mean,  distribution std, number of samples...
height = np.round(np.random.normal(1.75, 0.20, 5000), 2)
weight = np.round(np.random.normal(60.32, 15, 5000), 2)
np_city = np.column_stack((height, weight))

np.mean(np_city[:, 0])
np.median(np_city[:, 1])
np.std(np_city[:, 0])
corr = np.corrcoef(np_city[:, 0], np_city[:, 1])
corr


















