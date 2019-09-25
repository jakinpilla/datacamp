library(tidyverse)
iris %>%
  rename(sepal_length = Sepal.Length, 
         sepal_width = Sepal.Width, 
         petal_length = Petal.Length,
         petal_width = Petal.Width) %>%
  write_csv('./data/iris.csv')


tmp_vec <- rnorm(150, 0, 1)

1:150 %>% sample() -> vec.tmp

ind_for_na <- vec.tmp[1:20]

tmp_vec[ind_for_na] <- NA

tmp_vec

iris %>%
  rename(sepal_length = Sepal.Length, 
         sepal_width = Sepal.Width, 
         petal_length = Petal.Length,
         petal_width = Petal.Width) %>%
  mutate(with_missing = tmp_vec) -> sample_df


sample_df %>%
  write_csv('./data/sample_df.csv')
