# Load the jsonlite package
library(jsonlite)

# wine_json is a JSON
wine_json <- '{"name":"Chateau Migraine", "year":1997, "alcohol_pct":12.4, "color":"red", "awarded":false}'

# Convert wine_json into a list: wine
wine <- fromJSON(wine_json) # return list...

# Print structure of wine
str(wine)


# jsonlite is preloaded

# Definition of quandl_url
quandl_url <- "https://www.quandl.com/api/v3/datasets/WIKI/FB/data.json?auth_token=i83asDsiWUUyfoypkgMz"

# Import Quandl data: quandl_data
quandl_data <- fromJSON(quandl_url)

# Print structure of quandl_data
str(quandl_data)

column_nm <- quandl_data$dataset_data$column_names
column_nm %>% length()
quandl_data$dataset_data$data %>% dim

quandl_data$dataset_data$data %>%
  as_tibble() -> tbl_tmp

colnames(tbl_tmp) <- column_nm
tbl_tmp

# ?as_tibble()

# Definition of the URLs
url_sw4 <- "http://www.omdbapi.com/?apikey=72bc447a&i=tt0076759&r=json"
url_sw3 <- "http://www.omdbapi.com/?apikey=72bc447a&i=tt0121766&r=json"

# Import two URLs with fromJSON(): sw4 and sw3
sw4 <- fromJSON(url_sw4)
sw3 <- fromJSON(url_sw3)

# Print out the Title element of both lists
sw4$Title
sw3$Title

# Is the release year of sw4 later than sw3?
sw4$Year > sw3$Year


# JSON object
# name : string...
# value : string, number, boolean, null, JSON object, JSON array...

'[4, "a", 4, 6, 4, "b", 10, 6,  false, null]' %>% fromJSON()

'{"id": 1, "name" : "Frank", "age": 23, "married": false, 
  "parter": {"id": 4, "name": "Julie"}}' %>% fromJSON() -> r

str(r)

'[
  {"id":1, "name": "Frank"},
  {"id":4, "name": "Julie"},
  {"id":12, "name": "Zach"}
]' -> array_json

array_json %>% fromJSON()

iris %>% toJSON()


# JSON array

c(1, 2, 3) %>% toJSON()
c(1, 2, 3) %>% toJSON() %>% class()


# Challenge 1
json1 <- '[1, 2, 3, 4, 5, 6]'
fromJSON(json1)

# Challenge 2
json2 <- '{"a": [1, 2, 3], "b": [4, 5, 6]}'
fromJSON(json2)


# jsonlite is already loaded

# Challenge 1
json1 <- '[[1, 2], [3, 4]]'
fromJSON(json1)

# Challenge 2
json2 <- '[{"a": 1, "b": 2}, {"a": 5, "b": 6}]'
fromJSON(json2)


# URL pointing to the .csv file
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/water.csv"

# Import the .csv file located at url_csv
water <- read.csv(url_csv, stringsAsFactors = F)

water %>% as_tibble()

# Convert the data file according to the requirements
water_json <- toJSON(water)

# Print out water_json
water_json
str(water_json)

# Convert mtcars to a pretty JSON: pretty_json
pretty_json <- toJSON(mtcars, pretty = T)

# Print pretty_json
pretty_json

# Minify pretty_json: mini_json
mini_json <- minify(pretty_json)

# Print mini_json
mini_json


# haven...

# install.packages('haven')
library(haven)

ontime <- read_sas('./data/sales.sas7bdat')
str(ontime)
class(ontime)

trade <- read_dta('./data/trade.dta')
class(trade)

international <- read_sav('./data/international.sav')


# Load the haven package
library(haven)

# Import sales.sas7bdat: sales
sales <- read_sas('./data/sales.sas7bdat')

# Display the structure of sales
str(sales)


# haven is already loaded

# Import the data from the URL: sugar
url <- 'http://assets.datacamp.com/production/course_1478/datasets/trade.dta'

sugar <- read_dta(url)

# Structure of sugar
str(sugar)

# Convert values in Date column to dates
sugar$Date <- as.Date(as_factor(sugar$Date))

# Structure of sugar again
str(sugar)

plot(sugar$Import, sugar$Weight_I)



# haven is already loaded

# Import person.sav: traits
traits <- read_sav('./data/person.sav')

# Summarize traits
summary(traits)

# Print out a subset
subset(traits, Extroversion > 40 & Agreeableness > 40)


# haven is already loaded

# Import SPSS data from the URL: work
url <- 'http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/employee.sav'

work <- read_sav(url)

# Display summary of work$GENDER
summary(work$GENDER)


# Convert work$GENDER to a factor
work$GENDER <- as_factor(work$GENDER)


# Display summary of work$GENDER again
summary(work$GENDER)


# foreign...



# Load the foreign package
library(foreign)

# Import florida.dta and name the resulting data frame florida
florida <- read.dta('florida.dta')


# Check tail() of florida
tail(florida)


# foreign is already loaded

# Specify the file path using file.path(): path
path <- file.path("worldbank", "edequality.dta")

# Create and print structure of edu_equal_1
edu_equal_1 <- read.dta(path)
str(edu_equal_1)

# Create and print structure of edu_equal_2
edu_equal_2 <- read.dta(path, convert.factors = F)
str(edu_equal_2)

# Create and print structure of edu_equal_3
edu_equal_3 <- read.dta(path, convert.underscore = T)
str(edu_equal_3)

# foreign is already loaded

# Import international.sav as a data frame: demo
demo <- read.spss('./data/international.sav', to.data.frame = T)

# Create boxplot of gdp variable of demo
boxplot(demo$gdp)


# Import international.sav as demo_1
demo_1 <- read.spss('./data/international.sav', to.data.frame = T)

# Print out the head of demo_1
head(demo_1)

# Import international.sav as demo_2
demo_2 <- read.spss('./data/international.sav', to.data.frame = T, use.value.labels = F)

# Print out the head of demo_2
head(demo_2)

