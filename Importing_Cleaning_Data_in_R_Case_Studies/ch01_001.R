# Import sales.csv: sales
sales <- read.csv('./data/sales.csv', stringsAsFactors = F)

# View dimensions of sales
dim(sales)

# Inspect first 6 rows of sales
head(sales)

# View column names of sales
names(sales)


# Look at structure of sales
str(sales)

# View a summary of sales
summary(sales)

# Load dplyr
library(dplyr)

# Get a glimpse of sales
glimpse(sales)

# Remove the first column of sales: sales2
sales2 <- sales[, -1]

# Define a vector of column indices: keep
# besides the first 4 and last 15 columns

keep <- 5:(ncol(sales2) - 15)

# Subset sales2 using keep: sales3
sales3 <- sales2[, keep]

head(sales3$event_date_time)

# Load tidyr
library(tidyr)

# Split event_date_time: sales4
sales4 <- separate(sales3, event_date_time,
                   c("event_dt", "event_time"), sep = " ")

sales4 %>% head()
sales3 %>% 
  select(event_date_time) %>% head()

sales4 %>%
  select( event_dt, event_time) %>% head()

# head(sales4) %>% View()

# Split sales_ord_create_dttm: sales5
# head(sales4$sales_ord_create_dttm)
sales5 <- separate(sales4, sales_ord_create_dttm,
                   c("ord_create_dt", "ord_create_time"), sep = " ")



# Define an issues vector
issues <- c(2516, 3863, 4082, 4183)

# Print values of sales_ord_create_dttm at these indices
sales3[issues, ]$sales_ord_create_dttm

# Print a well-behaved value of sales_ord_create_dttm
sales3[2517, ]$sales_ord_create_dttm


# Load stringr
library(stringr)

# Find columns of sales5 containing "dt": date_cols
date_cols <- str_detect(names(sales5), "dt")

# Load lubridate
library(lubridate)

lapply(sales5[, date_cols], ymd)

# Coerce date columns into Date objects
sales5[, date_cols] <- lapply(sales5[, date_cols], ymd)


# Find date columns (don't change)
date_cols <- str_detect(names(sales5), "dt")

# Create logical vectors indicating missing values (don't change)
missing <- lapply(sales5[, date_cols], is.na)

# Create a numerical vector that counts missing values: num_missing
num_missing <- sapply(missing, sum)

# Print num_missing
num_missing

?unite()

# Combine the venue_city and venue_state columns
sales6 <- unite(sales5, 'venue_city_state', venue_city, venue_state, sep = ', ') 


# View the head of sales6
head(sales6)


