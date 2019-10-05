# Selective importing...

con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")


# Import tweat_id column of comments where user_id is 1: elisabeth
elisabeth <- dbGetQuery(con, 'select tweat_id from comments where user_id = 1')


# Print elisabeth
elisabeth



# Import post column of tweats where date is higher than '2015-09-21': latest
latest <- dbGetQuery(con, "select post from tweats where date > '2015-09-21'")

# Print latest
latest


# Create data frame specific
specific <- dbGetQuery(con, 'select message from comments where tweat_id = 77 and user_id > 4')

# Print specific
specific



# Create data frame short
short <- dbGetQuery(con, 
                    'select id, name from users where char_length(name) < 5')

# Print short
short


dbGetQuery(con, 
           'SELECT post, message
  FROM tweats INNER JOIN comments on tweats.id = tweat_id
    WHERE tweat_id = 77')


# DBI internals...


# Send query to the database
res <- dbSendQuery(con, "SELECT * FROM comments WHERE user_id > 4")

# Use dbFetch() twice
dbFetch(res, n = 2)
dbFetch(res)

# Clear res
dbClearResult(res)


# Create the data frame  long_tweats
long_tweats <- dbGetQuery(con, 
                          'select post, date from tweats where char_length(post) > 40')

# Print long_tweats
print(long_tweats)

# Disconnect from the database
dbDisconnect(con)




