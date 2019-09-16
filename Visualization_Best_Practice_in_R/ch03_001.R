library(tidyverse)
library(data.table)

md_speeding <- fread('./data/Traffic_Violations.csv')

md_speeding %>% dim()
md_speeding %>% head()

md_speeding %>% as_tibble() -> md_speeding
md_speeding %>% colnames() %>% sort()
md_speeding %>% str()
md_speeding %>% mutate(year_of_stop = substr(`Date Of Stop`, 7, 10)) %>% select(year_of_stop) -> md_speeding

md_speeding %>% filter(year_of_stop == 2017) -> md_speeding

md_speeding %>% fwrite('./data/md_speeding.csv')
fread('./data/md_speeding.csv') %>% as_tibble() -> md_speeding

# md_speeding %>% 
#   select('Work Zone', 'VechicleType', 'Year', 'Color', 'Race', 'Gender', 'Driver State')


# where is the speed columns??



ggplot(md_speeding) + 
  # Add the histogram geometry 
  geom_histogram(
    # Map speed_over to x
    aes(x = speed_over),
    # Lower alpha to 0.7
    alpha = .7
  ) +
  # Add minimal theme
  theme_minimal()


ggplot(md_speeding) +
  geom_histogram(
    # set x and y aesthetics to hour_of_day and stat(density) respectively.
    aes(x = hour_of_day, y= stat(density)),
    # make points see-through by setting alpha to 0.8
    alpha = .8
  )

# Load md_speeding into ggplot
ggplot(md_speeding) +
  # add a geom_histogram with x mapped to percentage_over_limit
  geom_histogram(
    aes(x = percentage_over_limit),
    bins = 40,     # set bin number to 40
    alpha = .8)    # reduce alpha to 0.8


ggplot(md_speeding) +
  geom_histogram(
    aes(x = percentage_over_limit),
    bins = 100 ,         # switch to 100 bins
    fill = 'steelblue',                 # set the fill of the bars to 'steelblue'
    alpha = 0.8 )


ggplot(md_speeding,aes(x = hour_of_day)) +
  geom_histogram(
    binwidth = 1,  # set binwidth to 1
    center = .5  # Center bins at the half (0.5) hour
  ) +
  scale_x_continuous(breaks = 0:24)

# kernel density estimator...


# filter data to just heavy duty trucks
truck_speeding <- md_speeding %>% 
  filter(vehicle_type == "Heavy Duty Truck")

ggplot(truck_speeding, aes(x = hour_of_day)) +
  # switch to density with bin width of 1.5, keep fill 
  geom_density(fill = 'steelblue', bw = 1.5) +
  # add a subtitle stating binwidth
  labs(title = 'Citations by hour', 
       subtitle = 'Gaussian kernel SD = 1.5')


ggplot(truck_speeding, aes(x = hour_of_day)) +
  # Adjust opacity to see gridlines with alpha = 0.7
  geom_density(bw = 1.5, fill = 'steelblue', alpha = .7) +
  # add a rug plot using geom_rug to see individual datapoints, set alpha to 0.5.
  geom_rug(alpha = .5) +
  labs(title = 'Citations by hour', subtitle = "Gaussian kernel SD = 1.5")


ggplot(md_speeding, aes(x = percentage_over_limit)) +
  # Increase bin width to 2.5
  geom_density(fill = 'steelblue', bw = 2.5,  alpha = 0.7) + 
  # lower rugplot alpha to 0.05
  geom_rug(alpha = 0.05) + 
  labs(
    title = 'Distribution of % over speed limit', 
    # modify subtitle to reflect change in kernel width
    subtitle = "Gaussian kernel SD = 2.5"
  )