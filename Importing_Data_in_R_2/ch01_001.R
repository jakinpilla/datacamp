# RDBMS...

# Load the DBI package
library(DBI)

# Edit dbConnect() call
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")


# -------------------------------------------------------------------------



users <- dbReadTable(con, 'users')

users


table_names <- dbListTables(con)
table_names

# "comments" "tweats"   "users"  

tables <- lapply(table_names, dbReadTable, conn = con)
tables

# comment 1012 awesome! thanks!, tweat_id 87, user_id 1

# tweat_id 87 --> which is posted by user_id 5
# user_id 5 is oliver olivander...

dbDisconnect(con)

# -------------------------------------------------------------------------

con_mine <- dbConnect(RMySQL::MySQL(), 
                      dbname = "house_price", 
                      host = "localhost", 
                      port = 3306,
                      user = "root",
                      password = "chr0n3!7!")

dbListTables(con_mine)
dbReadTable(con_mine, 'data_house')
dbDisconnect(con_mine)


# -------------------------------------------------------------------------



con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")



# Build a vector of table names: tables
tables <- dbListTables(con)

# Display structure of tables
str(tables)


# Import the users table from tweater: users
users <- dbReadTable(con, 'users')

# Print users
users


# Get table names
table_names <- dbListTables(con)

# Import all tables
tables <- lapply(table_names, dbReadTable, conn = con)

# Print out tables
tables


tables[[1]]


