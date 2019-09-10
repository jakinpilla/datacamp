

# Extract the coefficient statistics of each model into nested dataframes
model_coef_nested <- gap_models %>% 
  mutate(coef = map(model, ~tidy(.x)))

# Simplify the coef dataframes for each model    
model_coef <- model_coef_nested %>%
  unnest(coef)

# Plot a histogram of the coefficient estimates for year         
model_coef %>% 
  filter(term == "year") %>% 
  ggplot(aes(x = estimate)) +
  geom_histogram()

model_coef %>%
  filter(term == "year", estimate < 0) %>% nrow()

model_coef %>%
  filter(term == "year", estimate > 0) %>% nrow()

model_coef %>% 
  filter(term == "year") %>% View()


# ------------------------------------------------------------------------

# Extract the fit statistics of each model into dataframes
model_perf_nested <- gap_models %>% 
  mutate(fit = map(model, ~glance(.x)))

# Simplify the fit dataframes for each model    
model_perf <- model_perf_nested %>% 
  unnest(fit)

# Look at the first six rows of model_perf
head(model_perf)

# Plot a histogram of rsquared for the 77 models    
model_perf %>% 
  ggplot(aes(x = r.squared)) + 
  geom_histogram()  

# Extract the 4 best fitting models
best_fit <- model_perf %>% 
  top_n(n = 4, wt = r.squared)

# Extract the 4 models with the worst fit
worst_fit <- model_perf %>% 
  top_n(n = -4, wt = r.squared)


# -------------------------------------------------------------------------

best_augmented <- best_fit %>% 
  # Build the augmented dataframe for each country model
  mutate(augmented = map(model, ~augment(.x))) %>% 
  # Expand the augmented dataframes
  unnest(augmented)

worst_augmented <- worst_fit %>% 
  # Build the augmented dataframe for each country model
  mutate(augmented = map(model, ~augment(.x))) %>% 
  # Expand the augmented dataframes
  unnest(augmented)

# Compare the predicted values with the actual values of life expectancy 
# for the top 4 best fitting models
best_augmented %>% 
  ggplot(aes(x = year)) +
  geom_point(aes(y = life_expectancy)) + 
  geom_line(aes(y = .fitted), color = "red") +
  facet_wrap(~country, scales = "free_y")


# Compare the predicted values with the actual values of life expectancy 
# for the top 4 worst fitting models
worst_augmented %>% 
  ggplot(aes(x = year)) +
  geom_point(aes(y = life_expectancy)) + 
  geom_line(aes(y = .fitted), color = "red") +
  facet_wrap(~country, scales = "free_y")

##----

# -------------------------------------------------------------------------

gapminder %>% View()

gapminder %>% 
  select_if(is.numeric) %>% ncol()

gapminder %>% 
  select_if(is.character) %>% ncol()

gapminder %>% ncol()

gapminder %>% 
  select_if(is.numeric) %>% 
  filter(!complete.cases(.))

gapminder %>% 
  select_if(is.factor) %>% 
  filter(!complete.cases(.))

gapminder %>%
  replace(is.na(.), 0) -> gapminder

gap_nested <- gapminder %>% 
  group_by(country) %>% 
  nest()

gapminder %>%
  filter(!complete.cases(.))

summary(gapminder)
gapminder %>% colnames()
gapminder %>%
  mutate(gdpPercap = gdp/population) %>%
  select(country, year, infant_mortality, life_expectancy,
         fertility, population, gdpPercap) -> gapminder

gapminder %>%
  group_by(country) %>% 
  nest() -> gap_nested

# Build a linear model for each country using all features
gap_fullmodel <- gap_nested %>%
  mutate(model = map(data, ~lm(life_expectancy~., data = .x)))

fullmodel_perf <- gap_fullmodel %>% 
  # Extract the fit statistics of each model into dataframes
  mutate(fit = map(model, ~glance(.x))) %>% 
  # Simplify the fit dataframes for each model
  unnest(fit)

# View the performance for the four countries with the worst fitting 
# four simple models you looked at before
fullmodel_perf %>% 
  filter(country %in% worst_fit$country) %>% 
  select(country, adj.r.squared)
