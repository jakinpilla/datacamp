# Dynamite plot....
msleep %>% distinct(vore)

msleep %>%
  select(vore, sleep_total, sleep_rem) %>%
  rename(total = sleep_total,
         rem = sleep_rem) %>%
  mutate(vore = recode(vore, 
                       carni = 'Carnivore',
                       omni = 'Omnivore',
                       herbi = 'Herbivore',
                       insecti = 'Insectivore')) %>%
  filter(!is.na(vore)) %>%
  # na.omit() %>%
  mutate(vore = as.factor(vore)) -> sleep

str(sleep)

d <- ggplot(sleep, aes(vore, total)) +
  scale_y_continuous('Total sleep time (h)',
                     limits = c(0, 24),
                     breaks = seq(0, 24, 3),
                     expand = c(0, 0)) +
  scale_x_discrete('Eating habits') +
  theme_classic()


d + 
  stat_summary(fun.y= mean, geom = 'bar', fill = 'grey50') +
  stat_summary(fun.data = mean_sdl, mult = 1,
               geom = 'errorbar', width = .2)


d +
  geom_point(alpha = .6, position= position_jitter(width = .2))


# Bar plot1 ---------------------------------------------------------------
mtcars %>% str()

# Base layers
m <- ggplot(mtcars, aes(x = cyl, y = wt))

# Draw dynamite plot
m +
  stat_summary(fun.y = mean, geom = 'bar', fill = 'skyblue') +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.1)


mtcars %>% str()

# Base layers
m <- ggplot(mtcars, aes(x = cyl,y = wt, col = am, fill = am))

# Plot 1: Draw dynamite plot
m +
  stat_summary(fun.y = mean, geom = "bar") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.1)

# Plot 2: Set position dodge in each stat function
m +
  stat_summary(fun.y = mean, geom = "bar", position = 'dodge') +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), 
               geom = "errorbar", width = 0.1, position = 'dodge')

# Set your dodge posn manually
posn.d <- position_dodge(0.9)

# Plot 3: Redraw dynamite plot
m +
  stat_summary(fun.y = mean, geom = "bar", position = posn.d) +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.1, position = posn.d)


# Bar Plot 3 --------------------------------------------------------------

mtcars %>%
  group_by(cyl) %>%
  summarise(wt.avg = mean(wt),
            sd = sd(wt),
            n = n(),
            prop = n()/nrow(mtcars)) -> mtcars.cyl


mtcars.cyl

# Base layers
m <- ggplot(mtcars.cyl, aes(x = factor(cyl), y = wt.avg))

# Plot 1: Draw bar plot with geom_bar
m + geom_bar(stat = 'identity', fill = 'skyblue')

# Plot 2: Draw bar plot with geom_col
m + geom_col(fill = 'skyblue')

# Plot 3: geom_col with variable widths.
m + geom_col(fill = 'skyblue', width = mtcars.cyl$prop)

# Plot 4: Add error bars
m + 
  geom_col(fill = 'skyblue', width = mtcars.cyl$prop) +
  geom_errorbar(aes(ymin = wt.avg - sd, ymax = wt.avg + sd), width = .1)


# Best Praactices: Pie Chart ----------------------------------------------
# Bar chart
ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar(position = "fill")

# Convert bar chart to pie chart
ggplot(mtcars, aes(x = factor(1), fill = am)) +
  geom_bar(position = "fill") +
  facet_grid(. ~ cyl) + # Facets
  coord_polar(theta = 'y') + # Coordinates
  theme_void() # theme


# Pie chart 2 -------------------------------------------------------------

# Parallel coordinates plot using GGally
library(GGally)

# All columns except am
group_by_am <- 9
my_names_am <- (1:11)[-group_by_am]

str(mtcars)
# Basic parallel plot - each variable plotted as a z-score transformation
ggparcoord(mtcars, my_names_am, groupColumn = group_by_am, alpha = .8)

ggplot(mtcars, aes(cyl, disp)) + geom_boxplot()


# Heat Map-------------------------------------------------------------------------
library(lattice)
str(barley)


# Create color palette
myColors <- brewer.pal(9, "Reds")

# Build the heat map from scratch
ggplot(barley, aes(x = year, y = variety, fill = yield)) +
  geom_tile() + # Geom layer
  facet_wrap( ~ site, ncol = 1) + # Facet layer
  scale_fill_gradientn(colors = myColors) # Adjust colors

# Line plot; set the aes, geom and facet
ggplot(barley, aes(x = year, y = yield, col = variety, group = variety)) +
  geom_line() +
  facet_wrap( ~ site, nrow = 1) +
  scale_fill_gradientn(colors = myColors)


# Create overlapping ribbon plot from scratch
ggplot(barley, aes(x = year, y = yield, col = site, group = site, fill = site)) +
  stat_summary(fun.y = mean, geom = 'line') +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult=1), geom = 'ribbon', col =NA, alpha = .1)




