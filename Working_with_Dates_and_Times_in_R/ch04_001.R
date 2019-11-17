Sys.timezone()

# IANA Timezones...
OlsonNames()

length(OlsonNames())

# Manipulating timezones...
mar_11 <- ymd_hms("2017-03-11 12:00:00", 
                  tz = "America/Los_Angeles")

mar_11

# force_tz() :: change the timezone without changing the clock time...
force_tz(mar_11, tzone = 'America/New_York')

# with_tz() :: view the same intant in a different timezone...
with_tz(mar_11, tzone = 'America/New_York')



# -------------------------------------------------------------------------

# Game2: CAN vs NZL in Edmonton
game2 <- mdy_hm("June 11 2015 19:00")

# Game3: CHN vs NZL in Winnipeg
game3 <- mdy_hm("June 15 2015 18:30")

# Set the timezone to "America/Edmonton"
game2_local <- force_tz(game2, tzone = 'America/Edmonton')
game2_local

# Set the timezone to "America/Winnipeg"
game3_local <- force_tz(game3, tzone = 'America/Winnipeg')
game3_local

# How long does the team have to rest?
as.period(game2_local %--% game3_local)

#  Unlike force_tz(), with_tz() isn't changing the underlying moment of time, just how it is displayed.

now <- now()
with_tz(now, "America/Los_Angeles")
with_tz(now, "America/New_York")
with_tz(now, "Pacific/Auckland")

with_tz(now, "America/Los_Angeles") - with_tz(now,  "Pacific/Auckland")

# What time is game2_local in NZ?
with_tz(game2_local, tzone = 'Pacific/Auckland')

# What time is game2_local in Corvallis, Oregon?
with_tz(game2_local, tzone = 'America/Los_Angeles')

# What time is game3_local in NZ?
with_tz(game3_local, tzone = 'Pacific/Auckland')


# -------------------------------------------------------------------------
akl_hourly <- read_csv('./data/akl_weather_hourly_2016.csv')

akl_hourly  <- akl_hourly_raw  %>% 
  mutate(date = make_date(year = year, month = month, day = mday),
    datetime_string = paste(date, time, sep = "T"),
    datetime = ymd_hms(datetime_string)
  )


# Examine datetime and date_utc columns
head(akl_hourly$datetime)
head(akl_hourly$date_utc)

# Force datetime to Pacific/Auckland
akl_hourly <- akl_hourly %>%
  mutate(
    datetime = force_tz(datetime, tzone = 'Pacific/Auckland'))

# Reexamine datetime
head(akl_hourly$datetime)

# Are datetime and date_utc the same moments
table(akl_hourly$datetime - akl_hourly$date_utc)


# 4 rows they are different. Can you guess which? Yup, the times where DST kicks in.


# hms ---------------------------------------------------------------------


# Import auckland hourly data 
akl_hourly <- read_csv('./data/akl_weather_hourly_2016.csv')

# Examine structure of time column
str(akl_hourly$time)

# Examine head of time column
head(akl_hourly$time)

# A plot using just time
ggplot(akl_hourly, aes(x = time, y = temperature)) +
  geom_line(aes(group = make_date(year, month, mday)), alpha = 0.2)


# -------------------------------------------------------------------------

# parse_date_time() can be slow....

# install.packages('fasttime')
library(fasttime)
fastPOSIXct('2003-02-27')

x <- '2001-02-27'
parse_date_time(x, order = 'ymd')

fast_strptime(x, format = '%Y-%m-%d')
fast_strptime(x, format = '%y-%m-%d')

# Formatting datetimes....
my_stamp <- stamp('Tuesday October 10 2017')

my_stamp(ymd('2003-02-27'))
##??

# install.packages('microbenchmark')
library(microbenchmark)
library(fasttime)

dates <- akl_hourly$date_utc%>% as.character()

# Examine structure of dates
str(dates)

# Use fastPOSIXct() to parse dates
fastPOSIXct(dates) %>% str()

# Compare speed of fastPOSIXct() to ymd_hms()
microbenchmark(
  ymd_hms = ymd_hms(dates),
  fasttime = fastPOSIXct(dates),
  times = 20)


# Head of dates

dates <- akl_hourly$date_utc%>% as.character()
head(dates)

# Parse dates with fast_strptime
fast_strptime(dates, 
              format = '%Y-%m-%d %H:%M:%S') %>% str()



# Comparse speed to ymd_hms() and fasttime
microbenchmark(
  ymd_hms = ymd_hms(dates),
  fasttime = fastPOSIXct(dates),
  fast_strptime = fast_strptime(dates, 
                      format = '%Y-%m-%d'),
  times = 20)


# stamp() -----------------------------------------------------------------

# stamp() takes a string which should be an example of how the date should be formatted, and returns a function that can be used to format dates.


# Create a stamp based on "Sep 20 2017"
date_stamp <- stamp('Sep 20 2017')

# Print date_stamp
date_stamp

# Call date_stamp on today()
date_stamp(today())

# Create and call a stamp based on "09/20/2017"
stamp("09/20/2017")(today())

finished <- "I finished 'Dates and Times' in R on Thursday, September 20, 2017!" 

# Use string finished for stamp()
stamp(finished)(today())

















