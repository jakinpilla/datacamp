is_leap_year <- function(year) {
  # If year is div. by 400 return TRUE
  if(year %% 400 == 0) {
    return(TRUE)
  }
  # If year is div. by 100 return FALSE
  if(year%%100 == 0) {
    return(FALSE)
  }  
  # If year is div. by 4 return TRUE
  if(year%%4 == 0) {
    return(TRUE)
  }
  
  # Otherwise return FALSE
  else return(FALSE)
}

data('cars')
head(cars)

# Using cars, draw a scatter plot of dist vs. speed
plt_dist_vs_speed <- plot(dist ~ speed, data = cars)

# Oh no! The plot object is NULL
plt_dist_vs_speed


# Define a scatter plot fn with data and formula args
pipeable_plot <- function(data, formula) {
  # Call plot() with the formula interface
  plot(formula, data)
  # Invisibly return the input dataset
  invisible(data)
}

# Draw the scatter plot of dist vs. speed again
plt_dist_vs_speed <- cars %>% 
  pipeable_plot(dist ~ speed)

# Now the plot object has a value
plt_dist_vs_speed




R.version.string

session <- function() {
  list(
    r_version = R.version.string,
    operating_system = Sys.info()[c('sysname', 'release')],
    loaded_plgs = loadedNamespaces()
  )
}

session()

library(zeallot)

# multi assignment operator : %<-%
c(vrsn, os, pkgs) %<-% session()

vrsn

os

month_no <- setNames(1:12, month.abb)
month_no

attributes(month_no)

attr(month_no, 'names')

attr(month_no, 'names') <- month.name

month_no


orange_trees <- Orange

attributes(orange_trees)

library(dplyr)
orange_trees %>%
  group_by(Tree) %>%
  attributes()


library(broom)

# glance() / model / DF
# tidy() / coefficient / p-values
# augment() / observation / residuals


snake_river_visits <- readRDS('./data/snake_river_visits.rds')
head(snake_river_visits)

# Run a generalized linear regression 
model <- glm(
  # Model no. of visits vs. gender, income, travel
  n_visits ~ gender + income + travel, 
  # Use the snake_river_visits dataset
  data = snake_river_visits, 
  # Make it a Poisson regression
  family = 'poisson'
)


# Look at the structure of model (it's a mess!)
str(model)

# Use broom tools to get a list of 3 data frames
list(
  # Get model-level values
  model = glance(model),
  # Get coefficient-level values
  coefficients = tidy(model),
  # Get observation-level values
  observations = augment(model)
)


# Wrap this code into a function, groom_model
groom_model <- function(model) {
  list(
    model = glance(model),
    coefficients = tidy(model),
    
    
    observations = augment(model)
  )
}

c(mdl, cff, obs) %<-% groom_model(model)
mdl
cff
obs



pipeable_plot <- function(data, formula) {
  plot(formula, data)
  # Add a "formula" attribute to data
  attr(data, 'formula') <- formula
  invisible(data)
}

# From previous exercise
plt_dist_vs_speed <- cars %>% 
  pipeable_plot(dist ~ speed)

# Examine the structure of the result
str(plt_dist_vs_speed)



# Environment...

datacamp_lst <- list(
  name = 'DataCamp',
  founding_year = 2013,
  website = 'https://www.datacamp.com'
)

ls.str(datacamp_lst)


datacamp_env <- list2env(datacamp_lst)
ls.str(datacamp_env)


parent <- parent.env(datacamp_env)
environmentName(parent)


grandparent <- parent.env(parent)
environmentName(grandparent)

search()


datacamp_lst <- list(
  name = 'DataCamp',
  founding_year = 2013,
  website = 'https://www.datacamp.com'
)


datacamp_env <- list2env(datacamp_lst)
founding_year <- 2013

exists('founding_year', envir = datacamp_env)

exists('founding_year', envir = datacamp_env, inherits = FALSE)


# Add capitals, national_parks, & population to a named list
rsa_lst <- list(
  capitals = capitals,
  national_parks = national_parks,
  population = population
)

# List the structure of each element of rsa_lst
ls.str(rsa_lst)


# Convert the list to an environment
rsa_env <- list2env(rsa_lst)

# List the structure of each variable
ls.str(rsa_env)


# Find the parent environment of rsa_env
parent <- parent.env(rsa_env)

# Print its name
environmentName(parent)



# Compare the contents of the global environment and rsa_env
ls.str(globalenv())
ls.str(rsa_env)

# Does population exist in rsa_env?
exists("population", envir = rsa_env)

# Does population exist in rsa_env, ignoring inheritance?
exists("population", envir = rsa_env, inherits = F)

