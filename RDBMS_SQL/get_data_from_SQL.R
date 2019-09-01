library(RMySQL)
rm(con)

con <- dbConnect(
  MySQL(),
  user = "root", 
  password = "chr0n3!7!",
  dbname = "employees",
)

dbGetQuery(con, "show tables;")

data <- dbGetQuery(con, "select * from employees;")
head(data)
