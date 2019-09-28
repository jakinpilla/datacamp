
# Using purrr in your worlflow --------------------------------------------

library(repurrrsive)
data(sw_films)
names(sw_films)

str(sw_films)

sw_films %>% 
  set_names(map_chr(sw_films, 'title')) -> sw_films

names(sw_films)

map_chr(sw_films, ~.x[['episode_id']]) 

## Setting names while asking question -----------------------------------
data(sw_films)

map_chr(sw_films, ~.x[['episode_id']])

map_chr(sw_films, ~.x[['episode_id']]) %>%
  set_names(map_chr(sw_films, 'title')) %>% sort()


# -------------------------------------------------------------------------

data("gh_users")

names(gh_users)

map(gh_users, ~.x[['name']])


# Name gh_users with the names of the users
gh_users_named <- gh_users %>% 
  set_names(map_chr(gh_users, 'name'))

# Check gh_repos structure
str(gh_repos)

gh_repos[[1]]$owner$login

# Name gh_repos with the names of the repo owner 
gh_repos_named <- gh_repos %>% 
  map_chr(~ .[[1]]$owner$login) %>% 
  set_names(gh_repos, .)


# Determine who joined github first
map_chr(gh_users, ~.x[["created_at"]]) %>%
  set_names(map_chr(gh_users, "name")) %>%
  sort()

# Determine user versus organization
map_lgl(gh_users, ~.x[['type']] == "User") 


# Determine who has the most public repositories
map_int(gh_users, ~.x[['public_repos']]) %>%
  set_names(map_chr(gh_users, 'name')) %>%
  sort()



# Even more complex problems ----------------------------------------------

data(gh_repos)

gh_repos %>%
  map(~map(.x, 'forks')) -> forks

forks


map(gh_repos, 
    ~map_dbl(.x, 
             ~.x[['size']]))

# Map over gh_repos to generate numeric output
map(gh_repos, 
       ~map_dbl(.x, 
                  ~.x[['size']])) %>%
  # Grab the largest element
  map(~max(.x))


# Graphs in purrr ---------------------------------------------------------

# Scatter plot of public repos and followers
ggplot(data = gh_users_df, 
       aes(x = public_repos, y = followers))+
  geom_point()


# Create a dataframe with four columns
map_df(gh_users, `[`, 
       c("login","name","followers","public_repos"))
  

# Create a dataframe with four columns
map_df(gh_users, `[`, 
       c("login","name","followers","public_repos")) %>%
  # Plot followers by public_repos
  ggplot(., 
         aes(x = followers, y = public_repos)) + 
  # Create scatter plots
  geom_point()


# Turn data into correct dataframe format

tibble(filmtitle = map_chr(sw_films, "title"))
map(sw_films, 'characters')


film_by_character <- tibble(filmtitle = map_chr(sw_films, "title")) %>%
  mutate(filmtitle, characters = map(sw_films, "characters")) %>%
  unnest()

# Pull out elements from sw_people
sw_characters <- map_df(sw_people, `[`, c("height", "mass", "name", "url"))

# Join the two new objects
character_data <- inner_join(film_by_character, sw_characters, by = c("characters" = "url")) %>%
  # Make sure the columns are numbers
  mutate(height = as.numeric(height), mass = as.numeric(mass))

# Plot the heights, faceted by film title
ggplot(character_data, aes(x = height)) +
  geom_histogram(stat = "count") +
  facet_wrap(~ filmtitle)


