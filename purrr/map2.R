library(purrr)
means <- list(1, 2, 3)
sites <- list("noth", "west", "east")

list_of_files_map2 <- map2(sites, means, 
                           ~data.frame(sites = .x,
                                       a = rnorm(mean = .y, 
                                                 n = 10,
                                                 sd = (5/2))))

list_of_files_map2

# pmap()...
means <- list(1, 2, 3)
sites <- list("noth", "west", "east")
sigma <- list(1, 2, 3)
means2 <- list(.5, 1, 1.5)
sigma2 <- list(.5, 1, 1.5)

# make master list...
pmapinputs <- list(sites = sites, means = means, sigma = sigma, 
                   means2 = means2, sigma2 = sigma2)

# Map over the master list...
list_of_files_pmap <- pmap(
  pmapinputs,
  function(sites, means, sigma, means2, sigma2)
    data.frame(sites = sites,
               a = rnorm(mean = means, n = 5, sd = sigma),
               b = rnorm(mean = means2, n = 5, sd = sigma2))
)

list_of_files_pmap

# safely()...
library(purrr)
a <- list(-10, 1, 10, 0) %>%
  map(safely(log, otherwise = NA_real_)) %>%
  transpose()

a # not working...why???

list(1, 10, 0) %>%
  map(safely(log, otherwise = NA_real_)) 

list(1, 10, 0) %>%
  map(log)

list(-10, 1, 10, 0) %>%
  map(log) %>%
  transpose() -> b

b

# convert data to numeric with purrr...
# install.packages("repurrrsive")
library(repurrrsive)
library(purrr)

data("sw_people")
sw_people

map(sw_people, "height") %>%
  map(function(x) {
    ifelse(x == "unknown", NA, as.numeric(x))
  }) -> height_cm

height_cm


# Finding teh problem areas...
map(sw_people, "height") %>%
  map(safely(function(x) {
    x * 0.0328084
  }, quiet = F)) %>%
  transpose() -> height_ft

height_ft
height_ft[["result"]]
height_ft[["error"]]


# possibly() --------------------------------------------------------------

a <- list(-10, 1, 10, 0) %>%
  map(possibly(function(x) {
    log(x)
  }, otherwise = NA_real_))
a

map(sw_people, "height")



# walk() ------------------------------------------------------------------

# people_by_film
# 
# walk(people_by_film, print)



# walk() for printing cleaner list outputs... -----------------------------

data("gap_split")
gap_split[1:10]

library(ggplot2)

plots <- map2(gap_split[1:10],
              names(gap_split[1:10]),
              ~ggplot(.x, aes(year, lifeExp)) +
                geom_line() +
                labs(title = .y)
              )

walk(plots, print)

# Using purrr in your workflow...----------------------------

data(sw_films)
names(sw_films)

sw_films <- sw_films %>%
  set_names(map_chr(sw_films, "title"))

names(sw_films)

map_chr(sw_films, ~.x[["episode_id"]])

map_chr(sw_films, ~.x[["episode_id"]]) %>%
  set_names(map_chr(sw_films, "title")) 

map_chr(sw_films, ~.x[["episode_id"]]) %>%
  set_names(map_chr(sw_films, "title")) %>%
  sort()

data(gh_users)
names(gh_users)
gh_users[1:5]

map(gh_users, ~.x[["name"]]) %>%
  set_names(map_chr(gh_users, "name"))

data(gh_repos)
gh_repos[1:5]
str(gh_repos)


gh_repos_named <- gh_repos %>%
  map_chr(~.[[1]]$owner$login) %>%
  set_names(gh_repos, .)

# Determine who joined github first...
map_chr(gh_users, ~.x[["created_at"]]) %>%
  set_names(map_chr(gh_users, "name")) %>% sort

# Determine user versus organization...
map_lgl(gh_users, ~.x[["type"]] == "User")

# Determine who has the most public repositories...
map_int(gh_users, ~.x[["public_repos"]]) %>%
  set_names(map_chr(gh_users, "name")) %>%
  sort()


# Map over gh_repos to generate numeric output...
map(gh_repos, 
    ~map_dbl(.x, ~.x[["size"]])) %>%
  map(~max(.x))

# Graph in purrr...





































































