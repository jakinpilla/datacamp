library(ggplot2)

gapminder %>%
  filter(year == 2007) -> gapminder_2007

gapminder_2007 %>% colnames()

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Create gapminder_1952
gapminder_1952 <- gapminder %>% filter(year == 1952)

# Change to put pop on the x-axis and gdpPercap on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point()


gapminder_1952 %>% ggplot(aes(pop, lifeExp)) + geom_point()


ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10()


ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() + scale_x_log10()


gapminder_1952 %>% 
  ggplot(aes(pop, gdpPercap)) + geom_point() + scale_x_log10() + scale_y_log10()


ggplot(gapminder_2007, 
       aes(x = gdpPercap, y = lifeExp, 
           color = continent,
           size = pop)) +
  geom_point() + 
  scale_x_log10()


##
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Scatter plot comparing pop and lifeExp, with color representing continent
gapminder_1952 %>% ggplot(aes(pop, lifeExp, col = continent)) + geom_point() + scale_x_log10()


##
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size = gdpPercap)) +
  geom_point() +
  scale_x_log10()



# Faceting... -------------------------------------------------------------

ggplot(gapminder_2007, 
       aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent)  # ~ means `by`...



gapminder_1952 %>% 
  ggplot(aes(pop, lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  facet_wrap(~continent)


gapminder %>% 
  ggplot(aes(gdpPercap, lifeExp, col = continent, size = pop)) +
  geom_point() + 
  scale_x_log10() + 
  facet_wrap( ~ year)

