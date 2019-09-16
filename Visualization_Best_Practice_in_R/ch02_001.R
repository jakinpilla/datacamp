who_disease %>% 
  # filter to india in 1980
  filter(country == 'India', year == 1980) %>% 
  # map x aesthetic to disease and y to cases
  ggplot(aes(disease, cases)) +
  # use geom_col to draw
  geom_col()


who_disease %>%
  # filter data to observations of greater than 1,000 cases
  filter(cases > 1000) %>%
  # map the x-axis to the region column
  ggplot(aes(region)) +
  # add a geom_bar call
  geom_bar()


## Point Charts ----

interestingCountries  = c('NGA', 'SDN', 'FRA', 'NPL', 'MYS', 'TZA', 'YEM', 'UKR', 
                          'BGD', 'VNM')

who_subset <- who_disease %>% 
  filter(
    countryCode %in% interestingCountries,
    disease == 'measles',
    year %in% c(2006, 2016) # Modify years to 1992 and 2002
  ) %>% 
  mutate(year = paste0('cases_', year)) %>% 
  spread(year, cases)

# Reorder y axis and change the cases year to 1992
ggplot(who_subset, aes(x = log10(cases_2006), y = country)) +
  geom_point()


who_subset <- who_disease %>% 
  filter(
    countryCode %in% interestingCountries,
    disease == 'measles',
    year %in% c(1992, 2002) # Modify years to 1992 and 2002
  ) %>% 
  mutate(year = paste0('cases_', year)) %>% 
  spread(year, cases)

# Reorder y axis and change the cases year to 1992
ggplot(who_subset, aes(x = log10(cases_1992), y = reorder(country, cases_1992))) +
  geom_point()



