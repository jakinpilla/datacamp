Comprehension
================
Daniel\_Kim
2019 8 20

  - Global Scope, Local Scope, Built-in Scope….

<!-- end list -->

``` python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
```

``` python
[(num1, num2) for num1 in range(0, 2) for num2 in range(6, 8)]
```

    ## [(0, 6), (0, 7), (1, 6), (1, 7)]

``` python
[i**2 for i in range(0, 10)]
```

    ## [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]

``` python
# Create a 5 x 5 matrix using a list of lists: matrix
matrix = [[col for col in range(5)] for row in range(5)]

# Print the matrix
for row in matrix:
    print(row)
```

    ## [0, 1, 2, 3, 4]
    ## [0, 1, 2, 3, 4]
    ## [0, 1, 2, 3, 4]
    ## [0, 1, 2, 3, 4]
    ## [0, 1, 2, 3, 4]

### Conditional list comprehension

``` python
# Create a list of strings: fellowship
fellowship = ['frodo', 'samwise', 'merry', 'aragorn', 'legolas', 'boromir', 'gimli']

# Create list comprehension: new_fellowship
new_fellowship = [member for member in fellowship if len(member) >= 7]

# Print the new list
print(new_fellowship)
```

    ## ['samwise', 'aragorn', 'legolas', 'boromir']

``` python
# Create a list of strings: fellowship
fellowship = ['frodo', 'samwise', 'merry', 'aragorn', 'legolas', 'boromir', 'gimli']

# Create list comprehension: new_fellowship
new_fellowship = [member if len(member) >= 7 else '' for member in fellowship]

# Print the new list
print(new_fellowship)
```

    ## ['', 'samwise', '', 'aragorn', 'legolas', 'boromir', '']

### dic comprehesion

``` python
# Create a list of strings: fellowship
fellowship = ['frodo', 'samwise', 'merry', 'aragorn', 'legolas', 'boromir', 'gimli']

# Create dict comprehension: new_fellowship
new_fellowship = { member : len(member) for member in fellowship }

# Print the new dictionary
print(new_fellowship)
```

    ## {'frodo': 5, 'samwise': 7, 'merry': 5, 'aragorn': 7, 'legolas': 7, 'boromir': 7, 'gimli': 5}
