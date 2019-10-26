# Load the gapminder package
library(gapminder)

# Load the dplyr package
library(dplyr)

# Look at the gapminder dataset
gapminder

gapminder %>%
  filter(year == 2007, country == 'United States')


# arrange() ---------------------------------------------------------------

gapminder %>% 
  arrange(gdpPercap)

gapminder %>%
  arrange(desc(gdpPercap))

# Filter for the year 1957, then arrange in descending order of population
gapminder %>%
  filter(year == 1957) %>%
  arrange(desc(pop))


# mutate() ----------------------------------------------------------------

gapminder %>%
  mutate(pop = pop/1000000)


gapminder %>%
  mutate(gdp = gdpPercap * pop) %>%
  filter(year == 2007) %>%
  arrange(desc(gdp))


# Use mutate to change lifeExp to be in months
gapminder %>%
  mutate(lifeExp = 12*lifeExp)

# Use mutate to create a new column called lifeExpMonths
gapminder %>%
  mutate(lifeExpMonths = 12*lifeExp)


# Filter, mutate, and arrange the gapminder dataset
gapminder %>%
  filter(year == 2007) %>%
  mutate(lifeExpMonths = 12*lifeExp) %>%
  arrange(desc(lifeExpMonths))
