library(readxl)

mbta <- read_excel('./data/mbta.xlsx', skip=1)


# View the structure of mbta
str(mbta)

# View the first 6 rows of mbta
head(mbta)

# View a summary of mbta
summary(mbta)


# Remove rows 1, 7, and 11 of mbta: mbta2
mbta2 <- mbta[-c(1, 7, 11), ]

# Remove the first column of mbta2: mbta3
mbta3 <- mbta2[, -1]


# Load tidyr
library(tidyr)

# Gather columns of mbta3: mbta4
mbta4 <- gather(mbta3, month, thou_riders, -mode)

# View the head of mbta4
head(mbta4)


# Coerce thou_riders to numeric
mbta4$thou_riders <- as.numeric(mbta4$thou_riders)


# Spread the contents of mbta4: mbta5
mbta5 <- spread(mbta4, mode, thou_riders)

# View the head of mbta5
head(mbta5)


# View the head of mbta5
head(mbta5)

# Split month column into month and year: mbta6
mbta6 <- separate(mbta5, month, c('year', 'month'))

# View the head of mbta6
head(mbta6)



# View a summary of mbta6
summary(mbta6)

# Generate a histogram of Boat column
hist(mbta6$Boat)


# Find the row number of the incorrect value: i
i <- which(mbta6$Boat > 30)

# Replace the incorrect value with 4
mbta6[i, 'Boat'] <- 4

# Generate a histogram of Boat column
hist(mbta6$Boat)

mbta6 %>%
  unite("month", year, month, sep='') %>%
  select(month, Boat, `Trackless Trolley`) %>%
  gather('mode', 'thou_riders', -month) %>%
  arrange(month) -> mbta_boat

library(ggplot2)
# Look at Boat and Trackless Trolley ridership over time (don't change)
ggplot(mbta_boat, aes(x = month, y = thou_riders, col = mode)) +  geom_point() + 
  scale_x_discrete(name = "Month", breaks = c(200701, 200801, 200901, 201001, 201101)) + 
  scale_y_continuous(name = "Avg Weekday Ridership (thousands)")

mbta6 %>%
  unite("month", year, month, sep='') %>%
  gather('mode', 'thou_riders', -month) %>%
  arrange(month) -> mbta_all

mbta_all %>% head()

# Look at all T ridership over time (don't change)
ggplot(mbta_all, aes(x = month, y = thou_riders, col = mode)) + geom_point() + 
  scale_x_discrete(name = "Month", breaks = c(200701, 200801, 200901, 201001, 201101)) +  
  scale_y_continuous(name = "Avg Weekday Ridership (thousands)")



library(data.table)
food <- fread('./data/food.csv')
dim(food)

# View summary of food
summary(food)

# View head of food
head(food)

# View structure of food
str(food)


# Load dplyr
library(dplyr)

# View a glimpse of food
glimpse(food)

# View column names of food
names(food)

food %>% as.data.frame() -> food
# Define vector of duplicate cols (don't change)
duplicates <- c(4, 6, 11, 13, 15, 17, 18, 20, 22, 
                24, 25, 28, 32, 34, 36, 38, 40, 
                44, 46, 48, 51, 54, 65, 158)

# Remove duplicates from food: food2
food2 <- food[, -duplicates]
# head(food2)

# Define useless vector (don't change)
useless <- c(1, 2, 3, 32:41)

# Remove useless columns from food2: food3
food3 <- food2[, -useless]

library(stringr) 
# Create vector of column indices: nutrition
nutrition <- str_detect(names(food3), "100g")

# View a summary of nutrition columns
summary(food3[, nutrition])


# Find indices of sugar NA values: missing
missing <- is.na(food3$sugars_100g)

# Replace NA values with 0
food3$sugars_100g[missing] <- 0

# Create first histogram
hist(food3$sugars_100g, breaks = 100)

# Create food4
food4 <- food3[food3$sugars_100g > 0, ]

# Create second histogram
hist(food4$sugars_100g, breaks=100)


# Find entries containing "plasti": plastic
plastic <- str_detect(food3$packaging, 'plasti')

# Print the sum of plastic
sum(plastic)


# Load the gdata package
library(gdata)


perl <- 'C:/Strawberry/perl/bin/perl.exe'


# Import the spreadsheet: att
att <- read.xls('./data/attendance.xls', perl = perl)
?read.xls()


# Print the column names 
names(att)

# Print the first 6 rows
head(att)

# Print the last 6 rows
tail(att)

# Print the structure
str(att)

# Create remove
remove <- c(3, 56, 57, 58, 59)

# Create att2
att2 <- att[-remove, ]

# Create remove
remove <- c(3, 5, 7, 9, 11, 13, 15, 17)

# Create att3
att3 <- att2[, -remove]

# Subset just elementary schools: att_elem
att_elem <- att3[, c(1, 6, 7)]

# Subset just secondary schools: att_sec
att_sec <- att3[, c(1, 8, 9)]

# Subset all schools: att4
att4 <- att3[, c(1:5)]


# Define cnames vector (don't change)
cnames <- c("state", "avg_attend_pct", "avg_hr_per_day", 
            "avg_day_per_yr", "avg_hr_per_yr")

# Assign column names of att4
colnames(att4) <- cnames

# Remove first two rows of att4: att5
att5 <- att4[-c(1, 2), ]

# View the names of att5
names(att5)


# Remove all periods in state column
att5$state <- str_replace_all(att5$state, "\\.", "")

# Remove white space around state names
att5$state <- str_trim(att5$state)

# View the head of att5
head(att5)
dim(att5)

# Change columns to numeric using dplyr (don't change)
library(dplyr)
example <- mutate_at(att5, vars(-state), funs(as.numeric))

# Define vector containing numerical columns: cols
cols <- -1

# Use sapply to coerce cols to numeric
att5[, cols] <- sapply(att5[, cols], as.numeric)

head(att5)
str(att5)
att5 %>% View()
