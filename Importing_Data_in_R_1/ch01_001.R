
# file.path ---------------------------------------------------------------


path <- file.path("~/Datacamp/Importing_Data_in_R_1/", "data", "potatoes.csv")
read.csv(path, stringsAsFactors = F)



# -------------------------------------------------------------------------

dir()

# Import swimming_pools.csv: pools
pools <- read.csv('./data/swimming_pools.csv')

# Print the structure of pools
str(pools)

# Import swimming_pools.csv correctly: pools
pools <- read.csv('./data/swimming_pools.csv', stringsAsFactors = F)

# Check the structure of pools
str(pools)



# read.delim(), read.table() -------------------------------------------------------------------------

# Import hotdogs.txt: hotdogs
hotdogs <- read.delim('./data/hotdogs.txt', header = F)

# Summarize hotdogs
summary(hotdogs)

# utils::read.table() -------------------------------------------------------------------------

# Path to the hotdogs.txt file: path
path <- file.path("data", "hotdogs.txt")

# Import the hotdogs.txt file: hotdogs
hotdogs <- read.table(path, 
                      sep = '\t', 
                      col.names = c("type", "calories", "sodium"))

# Call head() on hotdogs
head(hotdogs)


# which.min(), which.max() -------------------------------------------------------------------------

# Finish the read.delim() call
hotdogs <- read.delim("./data/hotdogs.txt", 
                      header = F, 
                      col.names = c("type", "calories", "sodium"))


hotdogs[which(hotdogs$calories == 175), ]
hotdogs[which(hotdogs$type == "Poultry"), ]

# Select the hot dog with the least calories: lily
lily <- hotdogs[which.min(hotdogs$calories), ]

# Select the observation with the most sodium: tom
tom <- hotdogs[which.max(hotdogs$sodium), ]

# Print lily and tom
print(lily)
print(tom)


# -------------------------------------------------------------------------

# Previous call to import hotdogs.txt
hotdogs <- read.delim("./data/hotdogs.txt", header = FALSE, col.names = c("type", "calories", "sodium"))

# Display structure of hotdogs
str(hotdogs)

# Edit the colClasses argument to import the data correctly: hotdogs2
hotdogs2 <- read.delim("./data/hotdogs.txt", header = FALSE, 
                       col.names = c("type", "calories", "sodium"),
                       colClasses = c("factor", "NULL", "numeric"))


# Display structure of hotdogs2
str(hotdogs2)



