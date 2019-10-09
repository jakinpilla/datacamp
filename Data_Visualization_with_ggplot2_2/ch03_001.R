mtcars$cyl <- mtcars$cyl %>% as.character() %>% as.numeric()
mtcars$cyl <- as.factor(mtcars$cyl)

z <- ggplot(mtcars, aes(wt, mpg, col = cyl)) + 
  geom_point() + 
  geom_smooth(se=F, method = 'lm') + 
  facet_grid(. ~ cyl)

myPink <- '#FEE0D2'

# Starting point
z

# Plot 1: Change the plot background fill to myPink
z +
  theme(plot.background = element_rect(fill = myPink))

# Plot 2: Adjust the border to be a black line of size 3
z +
  theme(plot.background = element_rect(fill = myPink, color = 'black', size = 3)) # expanded from plot 1

# Theme to remove all rectangles
no_panels <- theme(rect = element_blank())

# Plot 3: Combine custom themes
z +
  no_panels +
  theme(plot.background = element_rect(fill = myPink, color = 'black', size = 3)) # from plot 2


z_1 <- z +
  no_panels +
  theme(plot.background = element_rect(fill = myPink, color = 'black', size = 3))

z_1 +
  theme(panel.grid = element_blank(),
        axis.line = element_line(color = 'red'),
        axis.ticks = element_line(color = 'red'))


# -------------------------------------------------------------------------

myRed <- '#99000D'

z_2 <- z_1 +
  theme(panel.grid = element_blank(),
        axis.line = element_line(color = 'red'),
        axis.ticks = element_line(color = 'red'))


z_2 + 
  theme(strip.text = element_text(size=16, color = myRed),
        axis.title = element_text(color = myRed, hjust = 0, face = 'italic'), 
        axis.text = element_text(color = 'black'))



# -------------------------------------------------------------------------

z_3 <- z_2 + 
  theme(strip.text = element_text(size=16, color = myRed),
        axis.title = element_text(color = myRed, hjust = 0, face = 'italic'), 
        axis.text = element_text(color = 'black'))


# Move legend by position
z_3 +
  theme(legend.position = c(.85, .85))

# Change direction
z_3 +
  theme(legend.direction = 'horizontal')

# Change location by name
z_3 +
  theme(legend.position = 'bottom')

# Remove legend entirely
z_3 +
  theme(legend.position = 'none')


# -------------------------------------------------------------------------

z_4 <- z_3 +
  theme(legend.position = 'none')

z_4
library(grid)
# Increase spacing between facets
z_4 +
  theme(panel.spacing.x = unit(2, 'cm'))


# Adjust the plot margin
z_4 +
  theme(panel.spacing.x = unit(2, 'cm'),
        plot.margin = unit(c(1, 2, 1, 1), 'cm'))












