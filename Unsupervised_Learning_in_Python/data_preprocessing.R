iris %>%
  rename(sepal_length = Sepal.Length, 
         sepal_width = Sepal.Width,
         petal_length = Petal.Length,
         petal_width = Petal.Width,
         species = Species) -> iris_renamed

iris_renamed %>% write_csv('./data/iris.csv')
