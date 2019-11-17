# http://www.rebeccabarter.com/blog/2019-01-23_scoped-verbs/

# _if: allows you to pick variables that satisfy some logical criteria such as is.numeric() or is.character() (e.g. summarising only the numeric columns)
# 
# _at: allows you to perform an operation only on variables specified by name (e.g. mutating only the columns whose name ends with "_date")
# 
# _all: allows you to perform an operation on all variables at once (e.g. calculating the number of missing values in every column)

library(tidyverse)
library(lubridate)

av_survey <- read_csv('./data/bikepghpublic.csv')

set.seed(2019)

av_survey_sample <- av_survey %>%
  select(id = `Response ID`, 
         start_date = `Start Date`,
         end_date = `End Date`,
         interacted_with_av_as_pedestrian = InteractPedestrian,
         interacted_with_av_as_cyclist = InteractBicycle,
         circumstances_of_interaction = CircumstancesCoded,
         approve_av_testing_pgh = FeelingsProvingGround)  %>%
  sample_n(10) %>%
  as.data.frame()

av_survey_sample
av_survey_sample %>% glimpse()

# count  the number of missing values in each column of a data frame...
sapply(av_survey_sample, function(x) sum(is.na(x)))

av_survey_sample %>% map_dbl(function(x) sum(is.na(x)))

av_survey_sample %>% map_dbl(~sum(is.na(.x)))



# select_if ---------------------------------------------------------------


av_survey_sample %>% select_if(is.numeric)

# We could also apply use more complex logical statements, for example by selecting columns that have at least one missing value.
av_survey_sample %>%
  select_if(~sum(is.na(.x)) > 0)


# rename_if ---------------------------------------------------------------


av_survey_sample %>%
  rename_if(is.numeric, ~paste0('num_', .x))


# mutate_if ---------------------------------------------------------------


av_survey_sample %>%
  mutate_if(~sum(is.na(.x)) > 0, 
                 ~if_else(is.na(.x), 'missing', as.character(.x)))



# summarise_if ------------------------------------------------------------


mode <- function(x) {
  names(sort(table(x)))[1]
}

av_survey_sample %>%
  summarise_if(is.character, mode)



# select helpers ----------------------------------------------------------


av_survey_sample %>% select(start_date, end_date)

av_survey_sample %>% select(contains("date"))

variable <- "start_date"
av_survey_sample %>% select(matches(variable))

variables <- c('start_date', 'end_date')
av_survey_sample %>% select(one_of(variables))


# '_at' needs 'vars'...
# select_at ---------------------------------------------------------------


av_survey_sample %>%
  select_at(vars(start_date, end_date))



# renname_at ------------------------------------------------------------

av_survey_sample %>%
  rename_at(vars(contains("av")), 
            ~gsub("av", "AV", .x))


# mutate_at ---------------------------------------------------------------

av_survey_sample %>%
  mutate(start_date = mdy_hms(start_date),
         end_date = mdy_hms(end_date))

av_survey_sample %>%
  mutate_at(vars(start_date, end_date), mdy_hms)

av_survey_sample %>%
  mutate_at(vars(contains('date')), mdy_hms)


av_survey_sample %>%
  summarise_at(vars(contains('interacted')), ~sum(.x == 'Yes'))


# rename_all ------------------------------------------------------------

av_survey_sample %>%
  rename_all(~gsub("_", ".", .x))



# mutate_all --------------------------------------------------------------

av_survey_sample %>%
  mutate_all(as.numeric)


# summarise_all ------------------------------------------------------------

av_survey_sample %>%
  summarise_all(n_distinct)




