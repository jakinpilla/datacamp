library(gapminder)
data('gapminder')
gapminder %>% head()

# Create dataset of 2007 data
gap2007 <- filter(gapminder, year == 2007)

# Compute groupwise mean and median lifeExp
gap2007 %>%
  group_by(continent) %>%
  summarize(mean(lifeExp),
            median(lifeExp))

# Generate box plots of lifeExp for each continent
gap2007 %>%
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot()

# Compute groupwise measures of spread
gap2007 %>%
  group_by(continent) %>%
  summarize(sd(lifeExp),
            IQR(lifeExp),
            n())

# Generate overlaid density plots
gap2007 %>%
  ggplot(aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.3)

# Filter for Asia, add column indicating outliers
gap_asia <- gap2007 %>%
  filter(continent == 'Asia') %>%
  mutate(is_outlier = lifeExp < 50)

# Remove outliers, create box plot of lifeExp
gap_asia %>%
  filter(is_outlier == FALSE) %>%
  ggplot(aes(x = 1, y = lifeExp)) +
  geom_boxplot()


# Load packages
library(ggplot2)
library(dplyr)
library(openintro)

# install.packages("openintro")

data("email")

# Compute summary statistics
email %>%
  group_by(spam) %>%
  summarise(median(num_char), IQR(num_char))

email %>% str()
email$spam <- as.factor(email$spam)

# Create plot
email %>%
  mutate(log_num_char = log(num_char)) %>%
  ggplot(aes(x = spam, y = log_num_char)) +
  geom_boxplot()

















