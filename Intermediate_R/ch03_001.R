library(ggplot2)

search()

# Chunk 1
library(data.table)
require(rjson)

# Chunk 2
library("data.table")
require(rjson)

# Chunk 3
library(data.table)
require(rjson, character.only = TRUE) # Error in paste0("package:", package) : object 'rjson' not found

# Chunk 4
library(c("data.table", "rjson")) # Error in paste0("package:", package) : object 'rjson' not found

# lapply ------------------------------------------------------------------

nyc <- list(pop = 8405837, 
            boroughs = c('Manhattan', 'Bronx', 'Brooklyn', 'Queens', 'Staten Island'),
            capital = F)

lapply(nyc, class)

cities <- c('New York', 'Paris', 'London', 'Tokyo', 'Rio de Janeiro', 'Cape Town')

num_chars <- c()
for (i in 1:length(cities)) {
  num_chars <- c(num_chars, nchar(cities[i]))
}

num_chars


cities <- c('New York', 'Paris', 'London', 'Tokyo', 'Rio de Janeiro', 'Cape Town')
lapply(cities, nchar)

unlist(lapply(cities, nchar))

