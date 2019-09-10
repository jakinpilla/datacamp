Questions of ch04
================

Loding dataset…

``` r
library(tidyverse)
library(rsample)
gapminder <- readRDS('./data/gapminder.rds')
gapminder %>% head()
```

    ## # A tibble: 6 x 7
    ##   country  year infant_mortality life_expectancy fertility population
    ##   <fct>   <int>            <dbl>           <dbl>     <dbl>      <dbl>
    ## 1 Algeria  1960             148.            47.5      7.65   11124892
    ## 2 Algeria  1961             148.            48.0      7.65   11404859
    ## 3 Algeria  1962             148.            48.6      7.65   11690152
    ## 4 Algeria  1963             148.            49.1      7.65   11985130
    ## 5 Algeria  1964             149.            49.6      7.65   12295973
    ## 6 Algeria  1965             149.            50.1      7.66   12626953
    ## # ... with 1 more variable: gdpPercap <int>

Prepare the initial split object

``` r
set.seed(42)
gap_split <- initial_split(gapminder, prop = .75)
```

Extract the training and testing dataframe

``` r
training_data <- training(gap_split)

testing_data <- testing(gap_split)

# Calculate the dimensions of both training_data and testing_data
dim(training_data)
```

    ## [1] 3003    7

``` r
dim(testing_data)
```

    ## [1] 1001    7

Prepare the dataframe containing the cross validation partitions

``` r
set.seed(42)

cv_split <- vfold_cv(training_data, v = 5)

cv_data <- cv_split %>% 
  mutate(
    # Extract the train dataframe for each split
    train = map(splits, ~training(.x)), 
    # Extract the validate dataframe for each split
    validate = map(splits, ~testing(.x))
  )
```

Use head() to preview cv\_data

``` r
head(cv_data)
```

    ## # A tibble: 5 x 4
    ##   splits             id    train                validate          
    ## * <list>             <chr> <list>               <list>            
    ## 1 <split [2.4K/601]> Fold1 <tibble [2,402 x 7]> <tibble [601 x 7]>
    ## 2 <split [2.4K/601]> Fold2 <tibble [2,402 x 7]> <tibble [601 x 7]>
    ## 3 <split [2.4K/601]> Fold3 <tibble [2,402 x 7]> <tibble [601 x 7]>
    ## 4 <split [2.4K/600]> Fold4 <tibble [2,403 x 7]> <tibble [600 x 7]>
    ## 5 <split [2.4K/600]> Fold5 <tibble [2,403 x 7]> <tibble [600 x 7]>

Build the model using all training data and the best performing
parameter…

``` r
best_model <- ranger(formula = ___, data = ___,
                     mtry = ___, num.trees = 100, seed = 42)

# Prepare the test_actual vector
test_actual <- testing_data$___

# Predict life_expectancy for the testing_data
test_predicted <- predict(___, ___)$predictions

# Calculate the test MAE
mae(___, ___)
```
