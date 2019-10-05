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

dbListTables(con)

dbReadTable(con, 'users')

dbDisconnect(con)



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
