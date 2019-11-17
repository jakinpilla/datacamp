library(lubridate)
library(tidyverse)
# ymd()

ymd('2013.02.27')


library(lubridate)

# Parse x 
x <- "2010 September 20th" # 2010-09-20
ymd(x)

# Parse y 
y <- "02.01.2010"  # 2010-01-02
dmy(y)

# Parse z 
z <- "Sep, 12th 2010 14:00"  # 2010-09-12T14:00
mdy_hm(z)


# Specify an order string to parse x
x <- "Monday June 1st 2010 at 4pm"
parse_date_time(x, orders = "mdyh")

# Specify order to include both "mdy" and "dmy"
two_orders <- c("October 7, 2001", "October 13, 2002", "April 13, 2003", 
                "17 April 2005", "23 April 2017")

parse_date_time(two_orders, orders = c('mdy', 'dmy'))

# Specify order to include "dOmY", "OmY" and "Y"
short_dates <- c("11 December 1282", "May 1372", "1253")
parse_date_time(short_dates, orders = c("dOmY", "OmY", "Y"))


# Specify an order string to parse x
x <- "Monday June 1st 2010 at 4pm"
parse_date_time(x, orders = "ABdyIp") # A: Monday, B: June, d: 1st,  y: year, Ip: pm # not working....

# Specify order to include both "mdy" and "dmy"
two_orders <- c("October 7, 2001", "October 13, 2002", "April 13, 2003", 
                "17 April 2005", "23 April 2017")
parse_date_time(two_orders, orders = c("mdy", "dmy"))

# Specify order to include "dOmY", "OmY" and "Y"
short_dates <- c("11 December 1282", "May 1372", "1253")
parse_date_time(short_dates, orders = c("dOmY", "OmY", "Y"))

# -------------------------------------------------------------------------

weather <- read_csv('./data/akl_weather_daily.csv')
weather %>% head()

weather %>% dim()

weather_1 <- read_csv('./data/akl_weather_hourly_2016.csv')
weather_1 %>% head()

weather_1 %>% dim()

# make_date(year, month, day)...

make_date(year = 2013, month = 2, day = 27)



# -------------------------------------------------------------------------

library(lubridate)
library(readr)
library(dplyr)
library(ggplot2)

# Import "akl_weather_hourly_2016.csv"
akl_hourly_raw <- read_csv("./data/akl_weather_hourly_2016.csv")

# Print akl_hourly_raw
akl_hourly_raw

# Use make_date() to combine year, month and mday 
akl_hourly  <- akl_hourly_raw  %>% 
  mutate(date = make_date(year = year, month = month, day = mday))

# Parse datetime_string 
akl_hourly <- akl_hourly  %>% 
  mutate(
    datetime_string = paste(date, time, sep = "T"),
    datetime = ymd_hms(datetime_string)
  )

# Print date, time and datetime columns of akl_hourly
akl_hourly %>% select(date, time, datetime)

# Plot to check work
ggplot(akl_hourly, aes(x = datetime, y = temperature)) +
  geom_line()

# -------------------------------------------------------------------------

akl_daily <- read_csv('./data/akl_weather_daily.csv')
head(akl_daily)
akl_daily$date
str(akl_daily)

?month()

library(ggplot2)
library(dplyr)
library(ggridges)
library(lubridate)

# Add columns for year, yday and month
akl_daily <- akl_daily %>%
  mutate(
    year = year(date),
    yday = day(date),
    month = lubridate::month(date, label = TRUE))

akl_daily %>% head() %>% as.data.frame()
akl_daily$date %>% lubridate::month(label =T) 

# Plot max_temp by yday for all years
ggplot(akl_daily, aes(x = yday, y = max_temp)) +
  geom_line(aes(group = year), alpha = 0.5)

# Examine distribtion of max_temp by month
ggplot(akl_daily, aes(x = max_temp, y = month , height = ..density..)) +
  geom_density_ridges(stat = "density")


##----
# Import "akl_weather_hourly_2016.csv"
akl_hourly_raw <- read_csv("./data/akl_weather_hourly_2016.csv")

# Print akl_hourly_raw
akl_hourly_raw

# Use make_date() to combine year, month and mday 
akl_hourly  <- akl_hourly_raw  %>% 
  mutate(date = make_date(year = year, month = month, day = mday))

akl_hourly$date
akl_hourly$time

# Parse datetime_string 
akl_hourly <- akl_hourly  %>% 
  mutate(
    datetime_string = paste(date, time, sep = "T"),
    datetime = ymd_hms(datetime_string)
  )


# -------------------------------------------------------------------------

akl_hourly$datetime %>% hour()
akl_hourly$datetime %>% month(label = T)
akl_hourly$date

# Create new columns hour, month and rainy
akl_hourly <- akl_hourly %>%
  mutate(
    hour = hour(datetime),
    month = month(datetime, label = TRUE),
    rainy = weather == "Precipitation"
  )

# Filter for hours between 8am and 10pm (inclusive)
akl_day <- akl_hourly %>% 
  filter(hour >= 8, hour <= 22)

# akl_day %>% colnames()
# akl_day$date

# Summarise for each date if there is any rain
rainy_days <- akl_day %>% 
  group_by(month, date) %>%
  summarise(
    any_rain = any(rainy)
  )

# Summarise for each month, the number of days with rain
rainy_days%>% 
  summarise(
    days_rainy = sum(any_rain)
  )

# rounding datetimes...
releases <- read_csv('./data/rversions.csv')

release_time <- releases$datetime
head(release_time)

release_time %>% hour()
head(release_time) %>% floor_date(unit = 'hour')

# round_date() - round to nearest
# ceiling_date() - round up
# floor_date() - round to down...

r_3_4_1 <- ymd_hms("2016-05-03 07:13:28 UTC")

# Round down to day
floor_date(r_3_4_1, unit = 'day')

# Round to nearest 5 minutes
round_date(r_3_4_1, unit = '5 minutes')

# Round up to week 
ceiling_date(r_3_4_1, unit = 'week')

# Subtract r_3_4_1 rounded down to day
r_3_4_1 - floor_date(r_3_4_1, unit = 'day')



# Create day_hour, datetime rounded down to hour
akl_hourly <- akl_hourly %>%
  mutate(
    day_hour = floor_date(datetime, unit = 'hour')
  )

# akl_hourly$day_hour

# Count observations per hour  
akl_hourly %>% 
  count(day_hour) 

# Find day_hours with n != 2  
akl_hourly %>% 
  count(day_hour) %>%
  filter(n != 2) %>% 
  arrange(desc(n))

