Lambda function
================
Daniel\_Kim
2019 8 15

  - Global Scope, Local Scope, Built-in Scope….

<!-- end list -->

``` python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

add_bangs = (lambda  a: a + '!!!')
```

``` python
add_bangs('hello')
```

    ## 'hello!!!'

``` python
# Define echo_word as a lambda function: echo_word
echo_word = (lambda word1, echo: word1 * echo)

# Call echo_word: result
result = echo_word('hey', 5)

# Print result
print(result)
```

    ## heyheyheyheyhey

### Map and lambda function

``` python
# Create a list of strings: spells
spells = ["protego", "accio", "expecto patronum", "legilimens"]

# Use map() to apply a lambda function over spells: shout_spells
shout_spells = map(lambda a: a + '!!!', spells)

# Convert shout_spells to a list: shout_spells_list
shout_spells_list = list(shout_spells)

# Print the result
print(shout_spells_list)
```

    ## ['protego!!!', 'accio!!!', 'expecto patronum!!!', 'legilimens!!!']

### filter()

``` python
# Create a list of strings: fellowship
fellowship = ['frodo', 'samwise', 'merry', 'pippin', 'aragorn', 'boromir', 'legolas', 'gimli', 'gandalf']

# Use filter() to apply a lambda function over fellowship: result
result = filter(lambda a: len(a) > 6, fellowship)

# Convert result to a list: result_list
result_list = list(result)

# Print result_list
print(result_list)
```

    ## ['samwise', 'aragorn', 'boromir', 'legolas', 'gandalf']

### reduce()

``` python
# Import reduce from functools
from functools import reduce

# Create a list of strings: stark
stark = ['robb', 'sansa', 'arya', 'brandon', 'rickon']

# Use reduce() to apply a lambda function over stark: result
result = reduce(lambda item1, item2: item1+item2, stark)

# Print the result
print(result)
```

    ## robbsansaaryabrandonrickon

### try-exept

``` python
# Define shout_echo
def shout_echo(word1, echo=1):
    """Concatenate echo copies of word1 and three
    exclamation marks at the end of the string."""

    # Initialize empty strings: echo_word, shout_words
    echo_word = ''
    shout_words = ''
    

    # Add exception handling with try-except
    try:
        # Concatenate echo copies of word1 using *: echo_word
        echo_word = word1 * echo

        # Concatenate '!!!' to echo_word: shout_words
        shout_words = echo_word + '!!!'
    except:
        # Print error message
        print("word1 must be a string and echo must be an integer.")

    # Return shout_words
    return shout_words

# Call shout_echo
shout_echo("particle", echo=5)
```

    ## 'particleparticleparticleparticleparticle!!!'

``` python
# Call shout_echo
shout_echo(3, echo=5)
```

    ## word1 must be a string and echo must be an integer.
    ## ''

``` python
# Call shout_echo
shout_echo('yaho', echo='arrr')
```

    ## word1 must be a string and echo must be an integer.
    ## ''

``` python
# Define shout_echo
def shout_echo(word1, echo=1):
    """Concatenate echo copies of word1 and three
    exclamation marks at the end of the string."""

    # Raise an error with raise
    if echo < 0:
        raise ValueError('echo must be greater than 0')

    # Concatenate echo copies of word1 using *: echo_word
    echo_word = word1 * echo

    # Concatenate '!!!' to echo_word: shout_word
    shout_word = echo_word + '!!!'

    # Return shout_word
    return shout_word

# Call shout_echo
shout_echo("particle", echo=5)
```

    ## 'particleparticleparticleparticleparticle!!!'

``` python
# Define count_entries()
def count_entries(df, col_name='lang'):
    """Return a dictionary with counts of
    occurrences as value for each key."""
    
    # Raise a ValueError if col_name is NOT in DataFrame
    if col_name not in df.columns:
        raise ValueError('The DataFrame does not have a ' + col_name + ' column.')

    # Initialize an empty dictionary: cols_count
    cols_count = {}
    
    # Extract column from DataFrame: col
    col = df[col_name]
    
    # Iterate over the column in DataFrame
    for entry in col:

        # If entry is in cols_count, add 1
        if entry in cols_count.keys():
            cols_count[entry] += 1
            # Else add the entry to cols_count, set the value to 1
        else:
            cols_count[entry] = 1
        
        # Return the cols_count dictionary
    return cols_count
```

``` r
data("mtcars")
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$am <- as.factor(mtcars$am)
```

``` python
mtcars = r.mtcars
# Call count_entries(): result1
result1 = count_entries(mtcars, 'cyl')

# Print result1
print(result1)
```

    ## {'6': 7, '4': 11, '8': 14}
