seq(1, 9, by = 2)
seq(17)
seq(1, 10, along.with=c(1:5))

seq_along(c(1:5))

?seq_along()
#  인자로 주어진 벡터의 길이만큼 1, 2, 3, ..., N으로 구성된
# 숫자 벡터를 생성하는 함수임.

files <- list.files(pattern = "data_from.*\\.csv", recursive = T %>%
  as.list()

files

# Load purrr library
library(purrr)

# Use map to iterate
all_files_purrr <- map(files, read_csv) 

# Output size of list object
length(all_files_purrr)


# -------------------------------------------------------------------------


list_of_df <- c()
for(i in 1:10) {
  list_of_df <- c(list_of_df, list(c('1', '2', '3', '4')))
}


# Check the class type of the first element
class(list_of_df[[1]])

# Change each element from a character to a number
for(i in seq_along(list_of_df)){
  list_of_df[[i]] <- as.numeric(list_of_df[[i]])
}

# Check the class type of the first element
class(list_of_df[[1]])

# Print out the list
list_of_df


# -------------------------------------------------------------------------

list_of_df <- c()
for(i in 1:10) {
  list_of_df <- c(list_of_df, list(c('1', '2', '3', '4')))
}


# Check the class type of the first element
class(list_of_df[[1]])  

# Change each character element to a number
list_of_df <- map(list_of_df, as.numeric)

# Check the class type of the first element again
class(list_of_df[[1]])

# Print out the list
list_of_df


# Subsetting lists: it's not that hard
lo <- list()

lo[['data']] <- data.frame(
  bird = c('robin', 'sparrow', 'jay'),
  weight = c(76, 14, 130),
  wing_length = c(100, 35, 130)
)

lo[['data']]

lo[['model']] <- lm(weight ~ wing_length, 
                    lo[['data']])

lo[['plot']] <- ggplot(
  data = lo[['model']], aes(x = weight, y = wing_length)) +
    geom_point()

lo


# -------------------------------------------------------------------------

lo[[2]]


lo[['model']]


survey_data


# Load repurrrsive package, to get access to the wesanderson dataset
library(repurrrsive)

# Load wesanderson dataset
data(wesanderson)

# Get structure of first element in wesanderson
str(wesanderson)

# Get structure of GrandBudapest element in wesanderson
str(wesanderson$GrandBudapest)


# Third element of the first wesanderson vector
wesanderson[[1]][3]

# Fourth element of the GrandBudapest wesanderson vector
wesanderson$GrandBudapest[4]

data("sw_films")

# Subset the first element of the sw_films data
sw_films[[1]]

# Subset the first element of the sw_films data, title column 
sw_films[[1]]$title


# list output...
map(all_files_purrr, ~nrow(.x))

# Double, a type of numeric...
map_dbl(all_files_purrr, ~nrow(.x))

# Determine if elements have 14 rows...
map_lgl(all_files_purrr, ~nrow(.x) == 200)

list('LakeErieS' = 'Green Frog',
     'LakeErieN' = 'American Bullfrog',
     'LakeErieW' = 'Gray Treefrog',
     'LakeErieE' = 'Mudpuppy') -> species_names

map(species_names, ~.x)

map_chr(species_names, ~.x)

all_files_purrr


# -------------------------------------------------------------------------

wesanderson

# Map over wesanderson to get the length of each element
map(wesanderson, length)


# map(list, ~ function(.x))

# Map over wesanderson, and determine the length of each element
map(wesanderson, ~length(.x))


# Create a numcolors column and fill with length of each wesanderson element
data.frame(numcolors = map_dbl(wesanderson, ~length(.x)))


# Working with unnamed lists...

