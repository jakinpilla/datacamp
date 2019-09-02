library(tidyverse)
library(reticulate)

df <- read_csv("./dob_job_application_filings_subset.csv")
df %>% colnames()


subset_nm <- c('Job #', 'Doc #', 'Borough', 'Initial Cost', 'Total Est. Fee', 'Existing Zoning Sqft', 'Proposed Zoning Sqft', 'Enlargement SQ Footage', 'Street Frontage', 'ExistingNo. of Stories', 'Proposed No. of Stories','Street Frontage', 'ExistingNo. of Stories', 'Proposed No. of Stories',
'Existing Height', 'Proposed Height')

df %>%
  select(subset_nm) -> df_subset


colnames(df) <- df %>% colnames() %>% tolower() %>%
  gsub(" ", "_", .)

colnames(df) <- df %>% colnames() %>% tolower() %>%
  gsub(" \\.", "", .)

colnames(df) <- df %>% colnames() %>% tolower() %>%
  gsub(" \\-", "", .)

df %>%
  rename(total_est_fee = total_est._fee) -> df_1


df_1$initial_cost <- gsub("\\$", "", df_1$initial_cost) %>% as.numeric()

df_1$total_est_fee <- gsub("\\$", "", df_1$total_est_fee) %>% as.numeric()

head(df_1)

df_1 %>% write_csv("./dob_job_application_filings_subset_1.csv")


colnames(df_subset) <- df_subset %>% colnames() %>% tolower() %>%
  gsub(" ", "_", .)

colnames(df_subset) <- df_subset %>% colnames() %>% tolower() %>%
  gsub(" \\.", "", .)

colnames(df_subset) <- df_subset %>% colnames() %>% tolower() %>%
  gsub(" \\-", "", .)

df_subset %>%
  rename(total_est_fee = total_est._fee) -> df_subset_1


df_subset_1$initial_cost <- gsub("\\$", "", df_subset_1$initial_cost) %>% as.numeric()

df_subset_1$total_est_fee <- gsub("\\$", "", df_subset_1$total_est_fee) %>% as.numeric()

head(df_subset_1)

df_subset_1 %>% write_csv("./dob_job_application_filings_subset_subset.csv")



# Uber --------------------------------------------------------------------

df <- read_csv("./nyc_uber_2014.csv")
colnames(df) <- df %>% colnames() %>% tolower()
colnames(df) <- c("x1", "date/time", "lat", "lon", "base")

df %>%
  separate(`date/time`, into = c("date", "time"), sep = " ") %>%
  mutate(date_1 = lubridate::mdy(date)) -> df_1

df_1 %>%
  filter(lubridate::month(date_1) == 4) -> uber1

df_1 %>%
  filter(lubridate::month(date_1) == 5) -> uber2

df_1 %>%
  filter(lubridate::month(date_1) == 6) -> uber3

uber1 %>% write_csv("./uber1.csv")
uber2 %>% write_csv("./uber2.csv")
uber3 %>% write_csv("./uber3.csv")



name = c("DR-1", "DR-3", "MSK-4")
lat = c(-49.85, -46.15, -48.87)
long = c(-128.57, -126.72, -123.40)

data.frame(name = name,
           lat = lat, 
           long = long) -> site

write_csv(site, 'site.csv')


# ident = c(619, 734, 837)
# site = c('DR-1', 'DR-3', 'MSK-4')
# dated = c('1927-02-08', '1939-01-07', '1932-01-14')

ident = c(619, 734, 837, 735, 751, 752, 837, 844)
length(ident)

site = c('DR-1', 'DR-1', 'DR-3', 'DR-3', 'DR-3', 'DR-3', 'MSK-4', 'DR-1')
length(site)

dated = c('1927-02-08', '1927-02-10', '1939-01-07', '1930-01-12', 
          '1930-02-26', NA, '1932-01-14', '1932-03-22')
length(dated)

data.frame(ident = ident, 
           site = site,
           dated = dated) -> visited

write_csv(visited, 'visited.csv')



taken = c(619, 619, 622, 622, 734, 734, 734, 735, 735, 735, 751, 
          751, 751, 752, 752, 752, 752, 837, 837, 837, 844)
length(taken)

person = c('dyer', 'dyer', 'dyer', 'dyer', 'pb', 'lake', 'pb', 'pb', 
           NA, NA, 'pb', 'pb', 'lake', 'lake','lake', 'lake', 'roe',
           'lake', 'lake', 'roe', 'roe')
length(person)

quant = c('rad', 'sal', 'rad', 'sal', 'rad', 'sal', 'temp', 'rad',
          'sal', 'temp', 'rad', 'temp', 'sal', 'rad', 'sal', 'temp', 
          'sal', 'rad','sal', 'sal', 'rad')

length(quant)

reading = c(9.82, 0.13, 7.80, 0.09, 8.41, 0.05, -21.50, 7.22, 0.06,
            -26.00, 4.35, -18.50, 0.0, 2.19, 0.09, -16.00, 41.60,
            1.46, 0.21, 22.50, 11.25)

length(reading)

survey <-  data.frame(
  taken = taken,
  person = person,
  quant = quant,
  reading = reading
)

survey

write_csv(survey, './survey.csv')


tips <- read_csv('tips.csv')

tips %>% 
  mutate(total_dollar = paste0('$', as.character(total_bill))) -> tips_with_total_dollar 

tips_with_total_dollar %>%
  write_csv('./tips_with_total_dollar.csv')


df.tmp <- read_csv("./billboard_clean.csv")
df.tmp %>% 
  rename(artist = artist_inverted) %>%
  select(-X1) %>% write_csv('./billboard_cleaned.csv')


gapminder <- read_csv("./gapminder.csv")
gapminder %>% colnames()
gapminder %>% head() %>% View()
gapminder %>%
  select('Life expectancy', starts_with("18")) -> g1800s_1


g1800s_1 %>%
  distinct(`Life expectancy`)

g1800s_1 %>% 
  group_by(`Life expectancy`) %>%
  slice(1) -> g1800s

g1800s %>% write_csv('./g1800s.csv')


gapminder %>%
  select('Life expectancy', starts_with("19")) %>%
  group_by(`Life expectancy`) %>%
  slice(1) -> g1900s

g1900s %>% 
  write_csv('./g1900s.csv')

gapminder %>%
  select('Life expectancy', starts_with("20")) %>%
  group_by(`Life expectancy`) %>%
  slice(1) -> g2000s

g2000s %>% 
  write_csv('./g2000s.csv')
