# Load the readr package
library(readr)

# Import potatoes.csv with read_csv(): potatoes
potatoes <- read_csv('potatoes.csv')

# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")

# Import potatoes.txt: potatoes
potatoes <- read_tsv('potatoes.txt', col_names = properties)

# Call head() on potatoes
head(potatoes)


# read_delim() ------------------------------------------------------------

# more lower level than read_csv or read_tsv....

# col_types = 'ccddiill'
## c : chr
## d : dbl
## i : int
## l : lgl
## _ : skip the column...

# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")

# Import potatoes.txt using read_delim(): potatoes
potatoes <- read_delim('potatoes.txt', delim = '\t', 
                       col_names = properties)

# Print out potatoes
potatoes

# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")

# Import 5 observations from potatoes.txt: potatoes_fragment
# with skip, n_max arguments...
potatoes_fragment <- read_tsv("potatoes.txt", 
                              skip = 6, # 위에서 6줄은 생략...
                              n_max = 5, # 5줄의 데이터만 사용...
                              col_names = properties)


# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")

# Import all data, but force all columns to be character: potatoes_char
potatoes_char <- read_tsv("potatoes.txt", 
                          col_types = "cccccccc",  # 모두 chr 형으로 불러옴...
                          col_names = properties)

# Print out structure of potatoes_char
str(potatoes_char)


# -------------------------------------------------------------------------

# Import without col_types
hotdogs <- read_tsv("hotdogs.txt", col_names = c("type", "calories", "sodium"))

# Display the summary of hotdogs
summary(hotdogs)

# The collectors you will need to import the data
fac <- col_factor(levels = c("Beef", "Meat", "Poultry"))
int <- col_integer()

# Edit the col_types argument to import the data correctly: hotdogs_factor
hotdogs_factor <- read_tsv("hotdogs.txt",
                           col_names = c("type", "calories", "sodium"),
                           col_types = list(fac, int, int))

# Display the summary of hotdogs_factor
summary(hotdogs_factor)

# data.table...

# load the data.table package
library(data.table)

# Import potatoes.csv with fread(): potatoes
potatoes <- fread('potatoes.csv')

# Print out potatoes
potatoes

# fread is already loaded

# Import columns 6 and 8 of potatoes.csv: potatoes
potatoes <- fread('potatoes.csv', select = c(6, 8))

# Plot texture (x) and moistness (y) of potatoes
plot(potatoes$texture, potatoes$moistness)
