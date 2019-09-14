library(openintro)
library(tidyverse)
library(broom)

# install.packages('Stat2Data')
library(Stat2Data)
data('MedGPA')

# scatterplot with jitter
data_space <- ggplot(MedGPA, aes(GPA, Acceptance)) + 
  geom_jitter(width = 0, height = 0.05, alpha = 0.5)

# linear regression line
data_space + 
  geom_smooth(method = 'lm', se = F)

# filter
MedGPA_middle <- MedGPA %>%
  filter(GPA >= 3.375, GPA <= 3.770)

# scatterplot with jitter
data_space <- ggplot(data = MedGPA_middle, aes(y = Acceptance, x = GPA)) + 
  geom_jitter(width = 0, height = 0.05, alpha = 0.5)

# linear regression line
data_space + 
  geom_smooth(method = "lm", se = FALSE)


# fit model
glm(Acceptance ~ GPA, data = MedGPA, family = binomial)


# scatterplot with jitter
data_space <- ggplot(MedGPA, aes(GPA, Acceptance)) + 
  geom_jitter(width = 0, height = .05, alpha = .5)

# add logistic curve
data_space +
  geom_smooth(method = 'glm', se = F,
              method.args = list(family = 'binomial'))

MedGPA %>%
  mutate(bin = cut(GPA, breaks = c(2.72, 3.3, 3.44, 3.58, 3.7, 3.87, 3.97))) %>%
  group_by(bin) %>%
  summarise(mean_GPA = mean(GPA),
            acceptance_rate = sum(Acceptance) / n()) %>%
  na.omit() %>% 
  ungroup() -> MedGPA_binned
  
MedGPA_binned

# binned points and line
data_space <- ggplot(MedGPA_binned, 
                     aes(mean_GPA, acceptance_rate)) +
  geom_point() + 
  geom_line()


mod <- glm(Acceptance ~ GPA, data = MedGPA, family = binomial)

# augmented model
MedGPA_plus <- mod %>%
  augment(type.predict = 'response')

# logistic model on probability scale
data_space +
  geom_line(data = MedGPA_plus, 
            aes(x = GPA, y = .fitted), 
            color = "red")


# compute odds for bins
MedGPA_binned <- MedGPA_binned %>%
  mutate(odd = acceptance_rate / (1-acceptance_rate))

# plot binned odds
data_space <- ggplot(MedGPA_binned, 
                     aes(mean_GPA, odd)) +
  geom_point() + geom_line()

# compute odds for observations
MedGPA_plus <- MedGPA_plus %>%
  mutate(odds_hat = .fitted / (1 - .fitted))

# logistic model on odds scale
data_space +
  geom_line(data = MedGPA_plus, 
            aes(x = GPA,  y = odds_hat), 
            color = "red")

# compute log odds for bins
MedGPA_binned <- MedGPA_binned %>%
  mutate(log_odd = log(odd))
  
# plot binned log odds
data_space <- ggplot(MedGPA_binned, 
                     aes(x = mean_GPA, y = log_odd)) +
  geom_point() + geom_line()

# compute log odds for observations
MedGPA_plus <- MedGPA_plus %>%
  mutate(log_odds_hat = log(.fitted / (1 - .fitted)))

# logistic model on log odds scale
data_space +
  geom_line(data = MedGPA_plus, 
            aes(x = GPA, y = log_odds_hat),
            color = "red")

0.0326 / (1 - 0.0326)

exp(5.45*2.9) / (1+exp(5.45*2.9))


mod

# create new data frame
new_data <- data.frame(GPA = 3.51)

# make predictions
augment(mod, newdata = new_data, 
        type.predict = 'response')

augment(mod, type.predict = 'response') %>%
  mutate(Acceptance_hat = ifelse(.fitted >= .5, 1, 0)) %>% View()
  

# data frame with binary predictions
tidy_mod <- augment(mod, type.predict = 'response') %>%
  mutate(Acceptance_hat = ifelse(.fitted >= .5, 1, 0)) 

# confusion matrix
tidy_mod %>%
  select(Acceptance, Acceptance_hat) %>% 
  table()
