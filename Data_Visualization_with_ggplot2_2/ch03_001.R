mtcars$cyl <- mtcars$cyl %>% as.character() %>% as.numeric()
mtcars$cyl <- as.factor(mtcars$cyl)

myCol <- brewer.pal(9, "Blues")[c(3,6,8)]

z <- ggplot(mtcars, aes(wt, mpg, col = cyl)) + 
  geom_point(size = 5, alpha=.8) + 
  geom_smooth(se=F, method = 'lm') + 
  facet_wrap(. ~ cyl, scales = 'free_y') + 
  scale_y_continuous(limits = c(10, 35)) +
  xlab('Weight (lb/1000)') + 
  ylab('Miles/(US) gallon') +
  scale_color_manual(values = myCol)
  
z

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


# -------------------------------------------------------------------------
z

# Original plot
z2 <- z

# Theme layer saved as an object, theme_pink
theme_pink <- theme(panel.background = element_blank(),
                    legend.key = element_blank(),
                    legend.background = element_blank(),
                    strip.background = element_blank(),
                    plot.background = element_rect(fill = myPink, color = "black", size = 3),
                    panel.grid = element_blank(),
                    axis.line = element_line(color = "red"),
                    axis.ticks = element_line(color = "red"),
                    strip.text = element_text(size = 16, color = myRed),
                    axis.title.y = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.title.x = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.text = element_text(color = "black"),
                    legend.position = "none")

# 1 - Apply theme_pink to z2
z2 +
  theme_pink

# 2 - Update the default theme, and at the same time
# assign the old theme to the object old.
old <- theme_update(panel.background = element_blank(),
                    legend.key = element_blank(),
                    legend.background = element_blank(),
                    strip.background = element_blank(),
                    plot.background = element_rect(fill = myPink, color = "black", size = 3),
                    panel.grid = element_blank(),
                    axis.line = element_line(color = "red"),
                    axis.ticks = element_line(color = "red"),
                    strip.text = element_text(size = 16, color = myRed),
                    axis.title.y = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.title.x = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.text = element_text(color = "black"),
                    legend.position = "none")

# 3 - Display the plot z2 - new default theme used
z2

# 4 - Restore the old default theme
theme_set(old)

# Display the plot z2 - old theme restored
z2

# -------------------------------------------------------------------------

# Original plot
z2

# install.packages('ggthemes')
# Load ggthemes
library(ggthemes)

# Apply theme_tufte(), plot additional modifications
custom_theme <- theme_tufte() +
  theme(legend.position = c(.9, .9),
           legend.title = element_text(face = 'italic', size = 12),
           axis.title = element_text(face = 'bold', size = 14))

# Draw the customized plot
z2 + custom_theme

# Use theme set to set custom theme as default
theme_set(custom_theme)

# Plot z2 again
z2








