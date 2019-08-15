Scope and User defined functions
================
Daniel\_Kim
2019 8 15

  - Global Scope, Local Scope, Built-in Scope….

<!-- end list -->

``` python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def square(value):
  """Return the square of a number"""
  new_val = value**2
  return new_val
  
square(3)
```

    ## 9

``` python
new_val = 20


def square(value):
  """Return the square of a number"""
  new_value2 = new_val**2
  return new_value2
  
square(3)
```

    ## 400

``` python
num = 5
```

``` python
def func1():
  num = 3
  print(num)
```

``` python
def func2():
  global num
  double_num = num * 2
  num = 6
  print(double_num)
```

``` python
func1()
```

    ## 3

``` python
func2()
```

    ## 10

``` python
team = "teen titans"

def change_team():
  """Change the value of the global variable team."""
  
  # Use team in global scope
  global team
  
  # Change the value of team in global: team
  team = "justice league"
```

``` python
print(team)
```

    ## teen titans

``` python
change_team()
```

  - `change_team()` changes the value of the name team\!

<!-- end list -->

``` python
print(team)
```

    ## justice league

  - Python builtin scope…

<!-- end list -->

``` python
import builtins

dir(builtins)
```

    ## ['ArithmeticError', 'AssertionError', 'AttributeError', 'BaseException', 'BlockingIOError', 'BrokenPipeError', 'BufferError', 'BytesWarning', 'ChildProcessError', 'ConnectionAbortedError', 'ConnectionError', 'ConnectionRefusedError', 'ConnectionResetError', 'DeprecationWarning', 'EOFError', 'Ellipsis', 'EnvironmentError', 'Exception', 'False', 'FileExistsError', 'FileNotFoundError', 'FloatingPointError', 'FutureWarning', 'GeneratorExit', 'IOError', 'ImportError', 'ImportWarning', 'IndentationError', 'IndexError', 'InterruptedError', 'IsADirectoryError', 'KeyError', 'KeyboardInterrupt', 'LookupError', 'MemoryError', 'ModuleNotFoundError', 'NameError', 'None', 'NotADirectoryError', 'NotImplemented', 'NotImplementedError', 'OSError', 'OverflowError', 'PendingDeprecationWarning', 'PermissionError', 'ProcessLookupError', 'RecursionError', 'ReferenceError', 'ResourceWarning', 'RuntimeError', 'RuntimeWarning', 'StopAsyncIteration', 'StopIteration', 'SyntaxError', 'SyntaxWarning', 'SystemError', 'SystemExit', 'TabError', 'TimeoutError', 'True', 'TypeError', 'UnboundLocalError', 'UnicodeDecodeError', 'UnicodeEncodeError', 'UnicodeError', 'UnicodeTranslateError', 'UnicodeWarning', 'UserWarning', 'ValueError', 'Warning', 'WindowsError', 'ZeroDivisionError', '_', '__build_class__', '__debug__', '__doc__', '__import__', '__loader__', '__name__', '__package__', '__spec__', 'abs', 'all', 'any', 'ascii', 'bin', 'bool', 'bytearray', 'bytes', 'callable', 'chr', 'classmethod', 'compile', 'complex', 'copyright', 'credits', 'delattr', 'dict', 'dir', 'divmod', 'enumerate', 'eval', 'exec', 'exit', 'filter', 'float', 'format', 'frozenset', 'getattr', 'globals', 'hasattr', 'hash', 'help', 'hex', 'id', 'input', 'int', 'isinstance', 'issubclass', 'iter', 'len', 'license', 'list', 'locals', 'map', 'max', 'memoryview', 'min', 'next', 'object', 'oct', 'open', 'ord', 'pow', 'print', 'property', 'quit', 'range', 'repr', 'reversed', 'round', 'set', 'setattr', 'slice', 'sorted', 'staticmethod', 'str', 'sum', 'super', 'tuple', 'type', 'vars', 'zip']

## Nested functions…

``` python
def raise_val(n):
  """Return the inner functions"""
  
  def inner(x):
    """Raise x to the power of n."""
    raised = x ** n
    return raised
    
  return inner
```

``` python
square = raise_val(2)
cube = raise_val(3)
print(square(2), cube(3))
```

    ## 4 27

  - Using nonlocal

<!-- end list -->

``` python
def outer():
  """Print the value of n."""
  n = 1
  
  def inner():
    nonlocal n
    n = 2
    print(n)
    
  inner()
  print(n)
```

``` python
outer()
```

    ## 2
    ## 2

``` python
def three_shouts(word1, word2, word3):
  """Return a tuple of strings concatenated with '!!!'"""
  
  # Define inner
  def inner(word):
    """Return a string concatenated with '!!!'."""
    return word + '!!!'
    
  # Return a tuple of strings
  return (inner(word1), inner(word2), inner(word3))
```

``` python
print(three_shouts('a', 'b', 'c'))
```

    ## ('a!!!', 'b!!!', 'c!!!')
