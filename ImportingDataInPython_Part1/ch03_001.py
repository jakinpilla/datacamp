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

# Import necessary module
from sqlalchemy import create_engine



# Create engine: engine

# 'mysql://' + 'root' + 'password' + '@localhost:3306' + 'DB name to be connected'
engine = create_engine('mysql://root:****@localhost:3306/house_price',
convert_unicode = True)

# Save the table names to a list: table_names
table_names = engine.table_names()

# Print the table names to the shell
print(table_names)

conn = engine.connect()

rs = conn.execute('select * from data_house')

df = pd.DataFrame(rs.fetchall())
df.head()

df.columns = rs.keys()
df.head()

conn.close()


engine = create_engine('mysql://root:chr0n3!7!@localhost:3306/breast_cancer',
convert_unicode = True)


engine.table_names()

conn_breast = engine.connect()

rs = conn_breast.execute('select * from breast')

df_breast_cancer = pd.DataFrame(rs.fetchall())
df_breast_cancer.columns = rs.keys()

df_breast_cancer.head()

conn_breast.close()


engine = create_engine('mysql://root:chr0n3!7!@localhost:3306/breast_cancer',
convert_unicode = True)


with engine.connect() as con:
  rs = con.execute('select * from breast')
  df = pd.DataFrame(rs.fetchmany(size = 30))
  df.columns = rs.keys()

df.head()

con.close()


# Open engine in context manager
# Perform query and save results to DataFrame: df
with engine.connect() as con:
    rs = con.execute('select lastname, title from employee')
    df = pd.DataFrame(rs.fetchmany(3))
    df.columns = rs.keys()

# Print the length of the DataFrame df
print(len(df))

# Print the head of the DataFrame df
print(df.head())


# Create engine: engine
engine = create_engine('sqlite:///Chinook.sqlite')

# Open engine in context manager
# Perform query and save results to DataFrame: df
with engine.connect() as con:
    rs = con.execute('select * from employee where employeeid >= 6')
    df = pd.DataFrame(rs.fetchall())
    df.columns = rs.keys

# Print the head of the DataFrame df
print(df.head())


##----

# Create engine: engine
engine = create_engine('sqlite:///Chinook.sqlite')

# Open engine in context manager
with engine.connect() as con:
    rs = con.execute('SELECT * FROM Employee ORDER BY BirthDate')
    df = pd.DataFrame(rs.fetchall())

    # Set the DataFrame's column names
    df.columns = rs.keys()


# Print head of DataFrame
print(df.head())

##----

# Pandas way to query

engine = create_engine('mysql://root:chr0n3!7!@localhost:3306/breast_cancer',
convert_unicode = True)

df = pd.read_sql_query('select * from breast', engine)
df.head()

# Import packages
from sqlalchemy import create_engine
import pandas as pd

# Create engine: engine
engine = create_engine('sqlite:///Chinook.sqlite')

# Execute query and store records in DataFrame: df
df = pd.read_sql_query('SELECT * FROM Album', engine)

# Print head of DataFrame
print(df.head())

# Open engine in context manager and store query result in df1
with engine.connect() as con:
    rs = con.execute("SELECT * FROM Album")
    df1 = pd.DataFrame(rs.fetchall())
    df1.columns = rs.keys()

# Confirm that both methods yield the same result
print(df.equals(df1))


# Import packages
from sqlalchemy import create_engine
import pandas as pd

# Create engine: engine
engine = create_engine('sqlite:///Chinook.sqlite')

# Execute query and store records in DataFrame: df
df = pd.read_sql_query('SELECT * FROM Employee WHERE EmployeeId >= 6 ORDER BY BirthDate', engine)

# Print head of DataFrame
print(df.head())




