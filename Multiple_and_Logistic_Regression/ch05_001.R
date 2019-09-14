library(openintro)
library(tidyverse)
library(broom)

# install.packages('Stat2Data')
library(Stat2Data)

nyc <- read_csv('./data/nyc.csv')
glimpse(nyc)
nyc %>% select(-Restaurant) %>% pairs()


# Price by Food plot
ggplot(nyc, aes(Food, Price)) + geom_point()

# Price by Food model
lm(Price ~ Food, data = nyc)


lm(Price ~ Food + East, data = nyc)

lm(Price ~ Food + Service, data = nyc)
mod <- lm(Price ~ Food + Service, data = nyc)

cf.mod <- coef(mod)

x <- nyc$Food
y <- nyc$Service
z <- nyc$Price

x.seq = seq(min(x), max(x), length.out = 25)
y.seq = seq(min(y), max(y), length.out = 25)

# make a outer product matrix with outer()...
z.mat <- t(outer(x.seq, y.seq, 
                 function(x, y) cf.mod[1] + cf.mod[2]*x + cf.mod[3]*y))

# draw the 3D scatterplot
plot_ly(data = nyc, z = ~Price, x = ~Food, y = ~Service, opacity = 0.6) %>%
  add_markers(size = .5) %>%
  add_surface(x = ~x.seq, y = ~y.seq, z = ~z.mat, showscale = FALSE) -> p

htmlwidgets::saveWidget(as_widget(p), "nyc_1.html")


# Price by Food and Service and East
lm(Price ~ Food + Service + East, data = nyc)



## with East variables...-----

# draw the 3D scatterplot
plot_ly(data = nyc, z = ~Price, x = ~Food, y = ~Service, opacity = 0.6) %>%
  add_markers(size = .5, color = ~ factor(East)) -> p


## make surfaces....

mod <- lm(Price ~ Food + Service + East, data = nyc)
cf.mod <- coef(mod)
cf.mod[1]
cf.mod[2]
cf.mod[3]
cf.mod[4]

## plane0 : East == 0
nyc %>%
  filter(East == 0) -> nyc_e_0

x_0 <- nyc_e_0$Food
y_0 <- nyc_e_0$Service
z_0 <- nyc_e_0$Price

x_0.seq = seq(min(x_0), max(x_0), length.out = 25)
y_0.seq = seq(min(y_0), max(y_0), length.out = 25)

# make a outer product matrix with outer()...
z_0.mat <- t(outer(x_0.seq, y_0.seq, 
                 function(x, y) cf.mod[1] + cf.mod[2]*x + cf.mod[3]*y))


p %>%
  add_surface(x = ~x_0.seq, y = ~y_0.seq, z = ~z_0.mat, showscale = FALSE) -> p_with_plane_0


htmlwidgets::saveWidget(as_widget(p_with_plane_0), "nyc_2_with_plane_0.html")


## plane0 : East == 0
nyc %>%
  filter(East == 1) -> nyc_e_1

x_1 <- nyc_e_1$Food
y_1 <- nyc_e_1$Service
z_1 <- nyc_e_1$Price

x_1.seq = seq(min(x_1), max(x_1), length.out = 25)
y_1.seq = seq(min(y_1), max(y_1), length.out = 25)

# make a outer product matrix with outer()...
z_1.mat <- t(outer(x_1.seq, y_1.seq, 
                   function(x, y) cf.mod[1] + cf.mod[2]*x + cf.mod[3]*y + cf.mod[4]))

p_with_plane_0 %>%
  add_surface(x = ~x_1.seq, y = ~y_1.seq, z = ~z_1.mat, showscale = FALSE) -> p_with_plane_0_1

# p %>%
#   add_surface(x = ~x_0.seq, y = ~y_0.seq, z = ~z_0.mat, showscale = FALSE) -> p_with_plane_0


htmlwidgets::saveWidget(as_widget(p_with_plane_0_1), "nyc_2_with_plane_0_1.html")


lm(Price ~ Food + Service + East, data = nyc)
lm(Price ~ Food + Service + Decor + East, data = nyc)
