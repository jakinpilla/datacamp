library(gapminder)
library(dplyr)
library(ggplot2)

# Summarize the median gdpPercap by year, then save it as by_year
by_year <- gapminder %>% 
  group_by(year) %>%
  summarise(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
by_year %>%
ggplot(aes(year, medianGdpPercap)) + 
  geom_line() + 
  expand_limits(y = 0)


# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap by continent over time
by_year_continent %>%
  ggplot(aes(year, medianGdpPercap, col = continent)) + 
  geom_line() + expand_limits(y = 0)



# Bar plots... ------------------------------------------------------------

# Summarize the median gdpPercap by year and continent in 1952
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarise(medianGdpPercap = median(gdpPercap))

# Create a bar plot showing medianGdp by continent
by_continent %>% 
  ggplot(aes(continent, medianGdpPercap)) + geom_col()


# Filter for observations in the Oceania continent in 1952
oceania_1952 <- gapminder %>%
  filter(continent == "Oceania", year == 1952)

# Create a bar plot of gdpPercap by country
oceania_1952 %>% ggplot(aes(country, gdpPercap)) + geom_col()



# Histograms --------------------------------------------------------------

gapminder_1952 <- gapminder %>%
  filter(year == 1952) %>%
  mutate(pop_by_mil = pop / 1000000)

# Create a histogram of population (pop)
gapminder_1952 %>% 
  ggplot(aes(x = pop_by_mil)) + geom_histogram(bins = 50)


##
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a histogram of population (pop), with x on a log scale
gapminder_1952 %>% 
  ggplot(aes(pop)) + geom_histogram() + scale_x_log10()


# Boxplots... -------------------------------------------------------------

ggplot(gapminder_2007, 
       aes(x = continent, y = lifeExp)) +
  geom_boxplot()


gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a boxplot comparing gdpPercap among continents
gapminder_1952 %>%
  ggplot(aes(continent, gdpPercap)) + 
  geom_boxplot() + 
  scale_y_log10()


##
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Add a title to this graph: "Comparing GDP per capita across continents"
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10() + 
  ggtitle("Comparing GDP per capita across continents")












