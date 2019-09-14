library(openintro)
library(tidyverse)
library(broom)

babies %>% as_tibble()

lm(bwt ~ gestation + age, data = babies)


data_space <- ggplot(babies, aes(x = gestation, y = age)) +
  geom_point(aes(color = bwt))

data_space

library(modelr)

# Tiling the plane
grid <- babies %>%
  modelr::data_grid(
    gestation = seq_range(gestation, by = 1),
    age = seq_range(age, by = 1)
  )

mod <- lm(bwt ~ gestation + age, data = babies)

bwt_hats <- augment(mod, newdata = grid)

data_space + 
  geom_tile(data = bwt_hats, aes(fill = .fitted,  alpha=  .5)) +
  scale_fill_continuous('bwt',  limits = range(babies$bwt))


library(plotly)

# plot_ly(data = babies, z = ~bwt, x = ~gestation, y = ~age, 
#         opacity = .6) %>%
#   add_markers(text = ~case, marker = list(size = 2)) %>%
#   add_surface(x = ~x, y = ~y, z = ~plane, showscale = F,
#               cmax = 1, surfacecolor = 'grey', colorscale = .5)



# Fit the model using duration and startPr
mod <- lm(totalPr ~ duration + startPr, data = mario_kart)

summary(mod)

data_space <- ggplot(mario_kart, aes(x = duration, y = startPr)) +
  geom_point(aes(color = totalPr))


grid <- mario_kart %>%
  modelr::data_grid(
    duration = seq_range(duration, by = .1),
    startPr = seq_range(startPr, by = .1)
  )

grid %>% head()
grid %>% dim()

# add predictions to grid
price_hats <- augment(mod, newdata = grid)

t(outer(grid$duration, grid$startPr, price_hats$.fitted))


# tile the plane
data_space + 
  geom_tile(data = price_hats, aes(fill = .fitted), alpha = .5)


##----
mod <- lm(totalPr ~ duration + startPr, data = mario_kart)
cf.mod <- coef(mod)

x <- mario_kart$duratio
y <- mario_kart$startPr
z <- mario_kart$totalPr

x.seq = seq(min(x), max(x), length.out = 25)
y.seq = seq(min(y), max(y), length.out = 25)

# make a outer product matrix with outer()...
z.mat <- t(outer(x.seq, y.seq, 
                 function(x, y) cf.mod[1] + cf.mod[2]*x +
                   cf.mod[3]*y))

# draw the 3D scatterplot
plot_ly(data = mario_kart, z = ~totalPr, x = ~duration, y = ~startPr, opacity = 0.6) %>%
  add_markers() %>%
  add_surface(x = ~x.seq, y = ~y.seq, z = ~z.mat, showscale = FALSE) -> p

htmlwidgets::saveWidget(as_widget(p), "index.html")

