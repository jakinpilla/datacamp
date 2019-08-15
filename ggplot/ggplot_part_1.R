library(tidyverse)

# iris.wide ---------------------------------------------------------------


iris %>% colnames()

iris %>%
  as_tibble() %>%
  select(contains("Sepal"), Species) -> df.sepal

df.sepal %>% 
  mutate(Part = "Sepal") %>%
  rename(Length = Sepal.Length, 
         Width = Sepal.Width) -> df.sepal_1
  
iris %>%
  as_tibble() %>%
  select(contains("Petal"), Species) -> df.petal

df.petal %>% 
  mutate(Part = "Petal") %>%
  rename(Length = Petal.Length, 
         Width = Petal.Width) -> df.petal_1

df.sepal_1 %>%
  bind_rows(df.petal_1) %>%
  select(Species, Part, Length, Width) -> iris.wide

ggplot(iris.wide, aes(Length, Width, col = Part)) + geom_point()


# iris.wide2 --------------------------------------------------------------
iris %>% dim()

iris.wide %>%
  gather(Length, Width, key = "Measure", 
         value = "value", -Species, -Part) %>%
  select(Measure, Part, Species, value)

?gather


