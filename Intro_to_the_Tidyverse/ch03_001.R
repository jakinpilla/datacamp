
# summarise() -------------------------------------------------------------


##
gapminder %>% summarise(medianLifeExp = median(lifeExp))

gapminder %>%
  filter(year == 1957) %>%
  summarise(medianLifeExp = median(lifeExp))


##
gapminder %>%
  filter(year == 1957) %>%
  summarise(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap))


##
gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)))


##
gapminder %>%
  group_by(year) %>%
  summarise(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap))


##
gapminder %>%
  filter(year == 1957) %>%
  group_by(continent) %>%
  summarise(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))


##
gapminder %>%
  group_by(continent, year) %>%
  summarise(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap))

##
gapminder %>%
  group_by(year) %>%
  summarise(totalPop = sum(pop, na.rm = T)) -> by_year

ggplot(by_year,
       aes(x = year, y = totalPop)) +
  geom_point() + 
  expand_limits(y = 0)


gapminder %>%
  group_by(year, continent) %>%
  summarise(totalPop = sum(as.numeric(pop)),
            meanLifeExp = mean(lifeExp)) -> by_year_continent

by_year_continent

ggplot(by_year_continent, 
       aes(x = year, y = totalPop,
           color = continent)) +
  geom_point() +
  expand_limits(y = 0)


##
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# Create a scatter plot showing the change in medianLifeExp over time
by_year %>% 
  ggplot(aes(year, medianLifeExp)) + 
  geom_point() + 
  expand_limits(y=0)


##

# Summarize medianGdpPercap within each continent within each year: by_year_continent
by_year_continent <- gapminder %>%
  group_by(continent, year) %>%
  summarise(medianGdpPercap = median(gdpPercap))

# Plot the change in medianGdpPercap in each continent over time
by_year_continent %>% 
  ggplot(aes(year, medianGdpPercap, col = continent)) +
  geom_point() +
  expand_limits(y=0)


# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(medianLifeExp = median(lifeExp), 
            medianGdpPercap = median(gdpPercap))

# Use a scatter plot to compare the median GDP and median life expectancy
by_continent_2007 %>%
  ggplot(aes(medianGdpPercap, medianLifeExp, col = continent)) + 
  geom_point() + 
  expand_limits(y=0)

