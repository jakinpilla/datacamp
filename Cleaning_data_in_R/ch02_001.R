library(tidyverse)

bmi

bmi %>%
  gather(year, bmi_val, -Country) -> bmi_long

head(bmi_long, 20)  

bmi_wide <- spread(bmi_long, year, bmi_val)
head(bmi_wide) %>% View()



census <- read_csv('census-retail.csv')
head(census)

census %>%
  gather(month, amount, -YEAR) %>%
  arrange(YEAR) -> census_long


census_long %>%
  unite("yr_month", c('YEAR', 'month'), sep = "_") -> census_long_1

census_long_1 %>%
  separate(yr_month, c('year', 'month'))
