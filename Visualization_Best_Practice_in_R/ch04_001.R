library(tidyverse)

md_speeding %>% 
  filter(vehicle_color == 'RED') %>%
  # Map x and y to gender and speed columns respectively
  ggplot(aes(gender, speed)) + 
  # add a boxplot geometry
  geom_boxplot() +
  # give plot supplied title
  labs(title = 'Speed of red cars by gender of driver')


# -------------------------------------------------------------------------


md_speeding %>% 
  filter(vehicle_color == 'RED') %>%
  ggplot(aes(x = gender, y = speed)) + 
  # add jittered points with alpha of 0.3 and color 'steelblue'
  geom_jitter(alpha = .3, color = 'steelblue') +
  # make boxplot transparent with alpha = 0
  geom_boxplot(alpha = 0) +
  labs(title = 'Speed of red cars by gender of driver')


# -------------------------------------------------------------------------

# remove color filter
md_speeding %>%
  ggplot(aes(x = gender, y = speed)) + 
  geom_jitter(alpha = 0.3, color = 'steelblue') +
  geom_boxplot(alpha = 0) +
  # add a facet_wrap by vehicle_color
  facet_wrap(~vehicle_color) +
  # change title to reflect new faceting
  labs(title = 'Speed of red cars colors, separated by gender of driver')


# -------------------------------------------------------------------------
# install.packages('ggbeeswarm')

# Load library for making beeswarm plots
library(ggbeeswarm)

md_speeding %>% 
  filter(vehicle_color == 'RED') %>%
  ggplot(aes(x = gender, y = speed)) + 
  # change point size to 0.5 and alpha to 0.8
  geom_beeswarm(cex = .5, alpha = .8) +
  # add a transparent boxplot on top of points
  geom_boxplot(alpha = 0)


# -------------------------------------------------------------------------


md_speeding %>% 
  filter(vehicle_color == 'RED') %>%
  ggplot(aes(x = gender, y = speed)) + 
  # Replace beeswarm geometry with a violin geometry with kernel width of 2.5
  geom_violin(bw = 2.5) +
  # add individual points on top of violins
  geom_point(alpha=  .3, size = .5)


# -------------------------------------------------------------------------

md_speeding %>% 
  filter(vehicle_color == 'RED') %>%
  ggplot(aes(x = gender, y = speed)) + 
  geom_violin(bw = 2.5) +
  # add a transparent boxplot and shrink its width to 0.3
  geom_boxplot(alpha = 0, width = .3) +
  # Reset point size to default and set point shape to 95
  geom_point(alpha = 0.3, size = 0.5, shape = 95) +
  # Supply a subtitle detailing the kernel width
  labs(subtitle = 'Gaussian kernel SD = 2.5')


# -------------------------------------------------------------------------

md_speeding %>% 
  ggplot(aes(x = gender, y = speed)) + 
  # replace with violin plot with kernel width of 2.5, change color argument to fill 
  geom_violin(fill = 'steelblue', bw = 2.5) +
  # reduce width to 0.3
  geom_boxplot(alpha = 0, width = .3) +
  facet_wrap(~vehicle_color) +
  labs(
    title = 'Speed of different car colors, separated by gender of driver',
    # add a subtitle w/ kernel width
    subtitle = 'Gaussian kernel width: 2.5'
  )



# -------------------------------------------------------------------------
# install.packages('ggridges')

library(ggridges)

md_speeding %>% 
  mutate(day_of_week = factor(day_of_week, levels = c("Mon","Tues","Wed","Thu","Fri","Sat","Sun") )) %>% 
  ggplot(aes( x = percentage_over_limit, y = day_of_week)) + 
  # Set bandwidth to 3.5
  geom_density_ridges(bandwidth = 3.5) +
  # add limits of 0 to 150 to x-scale
  scale_x_continuous(limits = c(0, 150)) + 
  # provide subtitle with bandwidth
  labs(subtitle = 'Gaussian kernel SD = 3.5')


# -------------------------------------------------------------------------

md_speeding %>% 
  mutate(day_of_week = factor(day_of_week, levels = c("Mon","Tues","Wed","Thu","Fri","Sat","Sun") )) %>% 
  ggplot(aes( x = percentage_over_limit, y = day_of_week)) + 
  # make ridgeline densities a bit see-through with alpha = 0.7
  geom_density_ridges(bandwidth = 3.5, alpha = .7) +
  # set expand values to c(0,0)
  scale_x_continuous(limits = c(0,150), expand = c(0, 0)) +
  labs(subtitle = 'Guassian kernel SD = 3.5') +
  # remove y axis ticks
  theme(axis.ticks.y = element_blank())


# -------------------------------------------------------------------------

md_speeding %>% 
  mutate(day_of_week = factor(day_of_week, levels = c("Mon","Tues","Wed","Thu","Fri","Sat","Sun") )) %>% 
  ggplot(aes( x = percentage_over_limit, y = day_of_week)) + 
  geom_point(
    # make semi-transparent with alpha = 0.2
    # turn points to vertical lines with shape = '|'
    # nudge the points downward by 0.05
    alpha = .2, 
    shape = '|',
    position = position_nudge(y = -.05)
  ) +
  geom_density_ridges(bandwidth = 3.5, alpha = 0.7) +
  scale_x_continuous(limits = c(0,150), expand  = c(0,0)) +
  labs(subtitle = 'Guassian kernel SD = 3.5') +
  theme( axis.ticks.y = element_blank() )
