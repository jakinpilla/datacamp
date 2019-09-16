library(tidyverse)
who_disease <- read_csv('./data/who_disease.csv')
who_disease %>% head()

# print dataframe to inspect
who_disease

# set x aesthetic to region column
ggplot(who_disease, aes(region)) +
  geom_bar()

# filter data to AMR region. 
amr_region <- who_disease %>%
  filter(region == 'AMR')

# map x to year and y to cases. 
ggplot(amr_region, aes(x = year, y = cases)) + 
  # lower alpha to 0.5 to see overlap.   
  geom_point(alpha = .5)


# Wrangle data into form we want. 
disease_counts <- who_disease %>%
  mutate(disease = ifelse(disease %in% c('measles', 'mumps'), disease, 'other')) %>%
  group_by(disease) %>%
  summarise(total_cases = sum(cases))

ggplot(disease_counts, aes(x = 1, y = total_cases, fill = disease)) +
  # Use a column geometry.
  geom_col() + 
  # Change coordinate system to polar and set theta to 'y'.
  coord_polar(theta = 'y')



ggplot(disease_counts, aes(x = 1, y = total_cases, fill = disease)) +
  # Use a column geometry.
  geom_col() +
  # Change coordinate system to polar.
  coord_polar(theta = "y") +
  # Clean up the background with theme_void and give it a proper title with ggtitle.
  theme_void() +
  ggtitle('Proportion of diseases')



disease_counts <- who_disease %>%
  group_by(disease) %>%
  summarise(total_cases = sum(cases)) %>% 
  mutate(percent = round(total_cases/sum(total_cases)*100))

# Create an array of rounded percentages for diseases.
case_counts <- disease_counts$percent

# Name the percentage array with disease_counts$disease
names(case_counts) <- disease_counts$disease

# install.packages('waffle')
# library(waffle)
# Pass case_counts vector to the waffle function to plot
waffle(case_counts)


## When use bars ----

disease_counts <- who_disease %>%
  mutate(disease = ifelse(disease %in% c('measles', 'mumps'), disease, 'other')) %>%
  group_by(disease, year) %>% # note the addition of year to the grouping.
  summarise(total_cases = sum(cases))

# add the mapping of year to the x axis. 
ggplot(disease_counts, aes(x = year, y = total_cases, fill = disease)) +
  # Change the position argument to make bars full height
  geom_col(position = 'fill')


disease_counts <- who_disease %>%
  mutate(
    disease = ifelse(disease %in% c('measles', 'mumps'), disease, 'other') %>% 
      factor(levels = c('measles', 'other', 'mumps')) # change factor levels to desired ordering
  ) %>%
  group_by(disease, year) %>%
  summarise(total_cases = sum(cases)) 

# plot
ggplot(disease_counts, aes(x = year, y = total_cases, fill = disease)) +
  geom_col(position = 'fill')


disease_counts <- who_disease %>%
  # Filter to on or later than 1999
  filter(year >= 1999) %>% 
  mutate(disease = ifelse(disease %in% c('measles', 'mumps'), disease, 'other')) %>%
  group_by(disease, region) %>%    # Add region column to grouping
  summarise(total_cases = sum(cases))

# Set aesthetics so disease is the stacking variable, region is the x-axis and counts are the y
ggplot(disease_counts, aes(x = region, y = total_cases, fill = disease)) +
  # Add a column geometry with the proper position value.
  geom_col(position = 'fill')



