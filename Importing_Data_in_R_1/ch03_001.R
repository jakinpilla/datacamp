# Load the readxl package
library(readxl)

dir()
# Print the names of all worksheets
excel_sheets('urbanpop.xlsx')

# Read the sheets, one by one
pop_1 <- read_excel("urbanpop.xlsx", sheet = 1)
pop_2 <- read_excel("urbanpop.xlsx", sheet = 2)
pop_3 <- read_excel("urbanpop.xlsx", sheet = 3)

# Put pop_1, pop_2 and pop_3 in a list: pop_list
pop_list <- list(pop_1, pop_2, pop_3)

# Display the structure of pop_list
str(pop_list)


# The readxl package is already loaded

# Read all Excel sheets with lapply(): pop_list
pop_list <- lapply(excel_sheets('urbanpop.xlsx'), 
       read_excel, 
       path = 'urbanpop.xlsx')

pop_list %>% length()

# Display the structure of pop_list
str(pop_list)


# Import the first Excel sheet of urbanpop_nonames.xlsx (R gives names): pop_a
pop_a <- read_excel('urbanpop.xlsx', sheet = 1, col_names = F)

# Import the first Excel sheet of urbanpop_nonames.xlsx (specify col_names): pop_b
cols <- c("country", paste0("year_", 1960:1966))
pop_b <- read_excel('urbanpop.xlsx', sheet = 1, 
                    col_names = cols)

# Print the summary of pop_a
summary(pop_a)

# Print the summary of pop_b
summary(pop_b)

# Import the second sheet of urbanpop.xlsx, skipping the first 21 rows: urbanpop_sel
urbanpop_sel <- read_excel('urbanpop.xlsx', 
                           skip = 21, 
                           col_names = F, 
                           sheet = 2)

# Print out the first observation from urbanpop_sel
urbanpop_sel[1, ]


# gdata...

# XLS -- Perl --> csv -- read.csv()--> R data frame...



# Load the gdata package
library(gdata)

# Import the second sheet of urbanpop.xls: urban_pop
urban_pop <- read.xls('urbanpop.xls', sheet = '1967-1974')

# Print the first 11 observations using head()
head(urban_pop, 11)

# Column names for urban_pop
columns <- c("country", paste0("year_", 1967:1974))

# Finish the read.xls call
urban_pop <- read.xls("urbanpop.xls", sheet = 2,
                      skip = 50, 
                      header = F, 
                      stringsAsFactors = F,
                      col.names = columns)

# Print first 10 observation of urban_pop
head(urban_pop, 10)

# Add code to import data from all three sheets in urbanpop.xls
path <- "urbanpop.xls"
urban_sheet1 <- read.xls(path, sheet = 1, stringsAsFactors = FALSE)
urban_sheet2 <- read.xls(path, sheet = 2, stringsAsFactors = FALSE)
urban_sheet3 <- read.xls(path, sheet = 3, stringsAsFactors = FALSE)

# Extend the cbind() call to include urban_sheet3: urban
urban <- cbind(urban_sheet1, urban_sheet2[-1], urban_sheet3[-1])

# Remove all rows with NAs from urban: urban_clean
urban_clean <- na.omit(urban)

# Print out a summary of urban_clean
summary(urban_clean)


