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


