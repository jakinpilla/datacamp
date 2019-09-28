# -------------------------------------------------------------------------
# Use pipes to check for names in sw_films
data('sw_films')
sw_films %>%
  names()

# Set names so each element of the list is named for the film title
sw_films_named <- sw_films %>% 
  set_names(map_chr(sw_films, "title"))

# Check to see if the names worked/are correct
names(sw_films_named)

# Create a list of values from 1 through 10
numlist <- list(1:10)

# Iterate over the numlist 
map(numlist, ~.x %>% sqrt() %>% sin())


# -------------------------------------------------------------------------

list(5)

list_of_means <- c(list(5), list(2), list(300), list(15))
list_of_means

list_of_df <- map(list_of_means, 
                  ~ data.frame(a = rnorm(mean = .x,
                                         n = 200,
                                         sd = (5/2))))

list_of_df[[1]] %>% head()


# -------------------------------------------------------------------------


# List of sites north, east, and west
sites <- list("north", "east", "west")

# Create a list of dataframes, each with a years, a, and b column 
list_of_df <-  map(sites,  
                   ~ data.frame(sites = .x,
                                a = rnorm(mean = 5, n = 200, sd = (5/2)), 
                                b = rnorm(mean = 200, n = 200, sd = 15)))

list_of_df

# Map over the models to look at the relationship of a vs b
list_of_df %>%
  map(~ lm(a ~ b, data = .x)) %>%
  map(summary)



# Pull out the director element of sw_films in a list and character vector
map(sw_films, ~.x[["director"]]) # list

map_chr(sw_films, ~.x[["director"]]) # vector


# Pull out the director element of sw_films in a list and character vector
map(sw_films, ~.x[["director"]])
map_chr(sw_films, ~.x[["director"]])

# Compare outputs when checking if director is George Lucas
map(sw_films, ~.x[["director"]] == "George Lucas")
map_lgl(sw_films, ~.x[["director"]] == "George Lucas")

# Pull out episode_id element as list
map(sw_films, ~.x[["episode_id"]])

# Pull out episode_id element as double vector
map_dbl(sw_films, ~.x[["episode_id"]])

# Pull out episode_id element as list
map(sw_films, ~.x[["episode_id"]])

# Pull out episode_id element as integer vector
map_int(sw_films, ~.x[["episode_id"]])


# map2() and pmap() ---------------------------------------------------------

list_of_means <- list(5, 2, 300, 15)

list_of_sd <- list(.5, .01, 20, 1)


simdata <- map2(list_of_means, 
                list_of_sd, 
                ~ data.frame(a = rnorm(mean = .x, n =200, sd=.y),
                             b = rnorm(mean=200, n = 200, sd=15)))

simdata[[1]] %>% head()


list_of_means <- list(5, 2, 300, 15)
list_of_sd <- list(.5, .01, 20, 1)
list_of_samplesize <- list(200, 50, 500, 100)


list(
  means = list_of_means,
  sd = list_of_sd, 
  samplesize   = list_of_samplesize
) -> input_list

str(input_list)

pmap(input_list, 
     function(means, sd, samplesize)
       data.frame(a = rnorm(mean = means,
                            n = samplesize,
                            sd = sd))) -> simdata

head(simdata[[1]])



# ------------------------------------------------------------------------

# List of 1, 2 and 3
means <- list(1, 2 ,3)

# Create sites list
sites <- list('north', 'west', 'east')

# Map over two arguments: sites and means
list_of_files_map2 <- map2(sites, means, ~data.frame(sites = .x,
                                          a = rnorm(mean = .y, n = 200, sd = (5/2))))

list_of_files_map2

# -------------------------------------------------------------------------
sites <- list('north', 'west', 'east')
means <- list(1, 2 ,3)
sigma <- list(1, 2, 3)
means2 <- list(.5, 1, 1.5)
sigma2 <- list(.5, 1, 1/5)

# Create a master list, a list of lists
pmapinputs <- list(sites = sites,  means = means, sigma = sigma, 
                   means2 = means2, sigma2 = sigma2)

# master list...
# Map over the master list
list_of_files_pmap <- pmap(pmapinputs, 
                              function(sites, means, sigma, means2, sigma2) 
                                data.frame(sites = sites,
                                           a = rnorm(mean = means, n = 200, sd = sigma),
                                           b = rnorm(mean = means2, n = 200, sd = sigma2)))

list_of_files_pmap