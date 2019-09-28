
# How to purrr safely -----------------------------------------------------

list('unknown', 10) %>%
  map(safely(function(x)
    x * 10, 
    otherwise = NA_real_))


list('unknown', 10) %>%
  map(safely(function(x)
    x * 10, 
    otherwise = NA_real_)) %>%
  transpose()


list(-10, 1, 10, 0) %>% 
  map(safely(log, otherwise = NA_real_))

# Map safely over log
a <- list(-10, 1, 10, 0) %>% 
  map(safely(log, otherwise = NA_real_)) %>%
  # Transpose the result
  transpose() 

a[['result']]

a[['error']]


# Load sw_people data
data(sw_people)
names(sw_people)

sw_people[[1]]

map(sw_people, 'height')

# Map over sw_people and pull out the height element
height_cm <- map(sw_people, 'height') %>%
  map(function(x){
    ifelse(x == "unknown",NA,
              as.numeric(x))
  })

# Map over sw_people and pull out the height element
height_ft <- map(sw_people , "height") %>% 
  map(safely(function(x){
    x * 0.0328084
  }, quiet = FALSE)) %>% 
  transpose()

# Print your list, the result element, and the error element
height_ft
height_ft[["result"]]
height_ft[["error"]]


# Another way to possibly() purrr -----------------------------------------

a <- list(-10, 'unknown', 10) %>%
  map(safely(function(x)
    x * 10, 
    otherwise = NA_real_))

a

a <- list(-10, 'unknown', 10) %>%
  map(possibly(function(x)
    x * 10, 
    otherwise = NA_real_))

a


# Take the log of each element in the list
a <- list(-10, 1, 10, 0) %>% 
  map(possibly(function(x){
    log(x)
  }, otherwise = NA_real_))

a


# Create a piped workflow that returns double vectors
height_cm %>%  
  map_dbl(possibly(function(x){
    # Convert centimeters to feet
    x * 0.0328084
  }, otherwise = NA_real_)) 


# purrr is a walk() in the park -------------------------------------------

short_list <- list(-10, 1, 10)
short_list


walk(short_list, print)

data(gap_split)

gap_split[1:10]
gap_split[1:10] %>% names()


# Load the gap_split data
data(gap_split)

# Map over the first 10 elements of gap_split
plots <- map2(gap_split[1:10], 
              names(gap_split[1:10]), 
              ~ ggplot(.x, aes(year, lifeExp)) + 
                geom_line() +
                labs(title = .y))

# Object name, then function name
walk(plots, print)



