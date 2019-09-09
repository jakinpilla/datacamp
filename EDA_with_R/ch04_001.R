library(openintro)

# install.packages("openintro")

data("email")



# Compute center and spread for exclaim_mess by spam
email %>%
  group_by(spam) %>%
  summarize(median(exclaim_mess),
            IQR(exclaim_mess))

# Create plot for spam and exclaim_mess
email %>%
  mutate(log_exclaim_mess = log(exclaim_mess + 0.01)) %>%
  ggplot(aes(x = log_exclaim_mess)) +
  geom_histogram() +
  facet_wrap(~ spam)

# Alternative plot: side-by-side box plots
email %>%
  mutate(log_exclaim_mess = log(exclaim_mess + 0.01)) %>%
  ggplot(aes(x = 1, y = log_exclaim_mess)) +
  geom_boxplot() +
  facet_wrap(~ spam)

# Alternative plot: Overlaid density plots
email %>%
  mutate(log_exclaim_mess = log(exclaim_mess + .01)) %>%
  ggplot(aes(x = log_exclaim_mess, fill = spam)) +
  geom_density(alpha = 0.3)

email %>% colnames()
email$image[1:5]
email$spam[1:5] %>% class()
email$spam <- as.factor(email$spam)

# Create plot of proportion of spam by image
email %>%
  mutate(has_image = image > 0) %>%
  ggplot(aes(x = has_image, fill = spam)) +
  geom_bar(position = 'fill')


email %>%
  filter(dollar > 0) %>%
  group_by(spam) %>%
  summarise(median(dollar))


email %>%
  filter(dollar > 10) %>%
  ggplot(aes(x=spam)) +
  geom_bar()

# Reorder levels
email$number <- factor(email$number, levels = c('none', 'small', 'big'))

# Construct plot of number
ggplot(email, aes(x = number)) +
    geom_bar() +
    facet_wrap(~spam)


