# Taking differences of datetimes..

# datetime_1 - datetime_2
# datetime_1 + (2*timespan)
# timespan1 / timespan2

releases <- read_csv('./data/rversions.csv')

last_release <- filter(releases, date == max(date))

Sys.Date() - last_release$date

# difftime()....
difftime(Sys.Date(), last_release$date)

# units = 'secs', 'mins', 'hours', 'days', 'weeks'...
difftime(Sys.Date(), last_release$date, units = 'secs')
difftime(Sys.Date(), last_release$date, units = 'weeks')

# now(), today()..
now()
today()


# The date of landing and moment of step
date_landing <- mdy("July 20, 1969")
moment_step <- mdy_hms("July 20, 1969, 02:56:15", tz = "UTC")

# How many days since the first man on the moon?
difftime(today(), date_landing, units = 'days')

# How many seconds since the first man on the moon?
difftime(now(), moment_step, units = 'secs')


# -------------------------------------------------------------------------


# Three dates
mar_11 <- ymd_hms("2017-03-11 12:00:00", 
                  tz = "America/Los_Angeles")
mar_12 <- ymd_hms("2017-03-12 12:00:00", 
                  tz = "America/Los_Angeles")
mar_13 <- ymd_hms("2017-03-13 12:00:00", 
                  tz = "America/Los_Angeles")

# Difference between mar_13 and mar_12 in seconds
difftime(mar_13, mar_12, units = 'secs')

# Difference between mar_12 and mar_11 in seconds
difftime(mar_12, mar_11, units = 'secs')



# Time spans... -----------------------------------------------------------

# period - for numan...
# duration - like stop watch...

# Create a time span...
days()

days(x = 2)

ddays(2)

# Arithmetic with time spans...
2*days()
days() + days()

ymd('2011-01-01') + days()

# Duration()...
# dseconds(), dminutes(), dhours(), ddays(), dweeks(), dyears()...

# Period()...
# seconds(), minutes(), hours(), days(), weeks(), months(), years()...

mar_11 + days(1)

mar_11 + days(2)

mar_11 + ddays(1)


# Add a period of one week to mon_2pm
mon_2pm <- dmy_hm("27 Aug 2018 14:00")
mon_2pm + weeks(1)

# Add a duration of 81 hours to tue_9am
tue_9am <- dmy_hm("28 Aug 2018 9:00")
tue_9am + dhours(81)

# Subtract a period of five years from today()
today() - years(5)

# Subtract a duration of five years from today()
today() - dyears(5)


# -------------------------------------------------------------------------

# Time of North American Eclipse 2017
eclipse_2017 <- ymd_hms("2017-08-21 18:26:40")

# Duration of 29 days, 12 hours, 44 mins and 3 secs
synodic <- ddays(29) + dhours(12) + dminutes(44) + dseconds(3)

# 223 synodic months
saros <- 223*synodic

# Add saros to eclipse_2017
eclipse_2017 + saros


# -------------------------------------------------------------------------

1:10 * days(1)

today() + 1:10 * days(1)


# Add a period of 8 hours to today
today_8am <- today() + hours(8)

# Sequence of two weeks from 1 to 26
every_two_weeks <- 1:26*weeks(2)

# Create datetime for every two weeks for a year
today_8am + every_two_weeks


ymd('2018-01-31') + months(1) # return NA because there isn't 2018-02-31...

ymd('2018-01-31') %m+%  months(1)
ymd('2018-01-31') %m-%  months(1)


jan_31 <- ymd('2019-01-31')

# A sequence of 1 to 12 periods of 1 month
month_seq <- 1:12*months(1)

# Add 1 to 12 months to jan_31
jan_31 + month_seq

# Replace + with %m+%
jan_31 %m+% month_seq

# Replace + with %m-%
jan_31 %m-% month_seq

# Intervals...

# Creating intervals..
# datetime1 %--% datetime2
# interval(datetime1, datetime2)

dmy('5 January 1961') %--% dmy('30 January 1969')
interval(dmy('5 January 1961'), dmy('30 January 1969'))

# Operating on an interval....

beatles <- dmy('5 January 1961') %--% dmy('30 January 1969')
int_start(beatles)
int_end(beatles)
int_length(beatles)
as.period(beatles)
as.duration(beatles)

hendrix_at_woodstock <- mdy('August 17 1969')
hendrix_at_woodstock %within% beatles

hendrix <- dmy('01 October 1966') %--% dmy('16 September 1970')

int_overlaps(beatles, hendrix)


# install.packages('learningr')
# library(learningr)
# str(english_monarchs)
# english_monarchs %>% head()

# source("https://goo.gl/SSvqZF")
# source("https://goo.gl/2aojPM")
# 
# monarchs %>% write_csv('./data/monarchs.csv')
# halleys %>% write_csv('./data/halleys.csv')

monarchs <- read_csv('./data/monarchs.csv')
halleys <- read_csv('./data/halleys.csv')

# Print monarchs
monarchs

# Create an interval for reign
monarchs <- monarchs %>%
  mutate(reign = from %--% to) 

str(monarchs)

# Find the length of reign, and arrange
monarchs %>%
  mutate(length = int_length(reign)) %>% 
  arrange(desc(length)) %>%
  select(name, length, dominion)


# %within% ----------------------------------------------------------------

y2001 <- ymd('2001-01-01') %--% ymd('2001-12-31')
ymd('2001-03-30') %within% y2001
ymd('2002-03-30') %within% y2001

# -------------------------------------------------------------------------

# Print halleys
halleys

# New column for interval from start to end date
halleys <- halleys %>% 
  mutate(visible = start_date %--% end_date)

# The visitation of 1066
halleys_1066 <- halleys[14, ] 

# Monarchs in power on perihelion date
monarchs %>% 
  filter(halleys_1066$perihelion_date %within% monarchs$reign) %>%
  select(name, from, to, dominion)

# Monarchs whose reign overlaps visible time
monarchs %>% 
  filter(int_overlaps(monarchs$reign, halleys_1066$visible)) %>%
  select(name, from, to, dominion) %>% View()


# -------------------------------------------------------------------------

# New columns for duration and period
monarchs <- monarchs %>%
  mutate(
    duration = as.duration(reign),
    period = as.period(reign)) 

# Examine results    
monarchs %>%
  select(name, duration, period)



