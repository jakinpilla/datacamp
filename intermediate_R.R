args(sample)

linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

mean(linkedin + facebook)
mean(linkedin + facebook, trim=.2)

pow_two <- function(x, print_info = TRUE) {
  y <- x^2
  if (print_info == T) {
    print(paste(x, "to the power two equals", y))
  }
  return(y)
}

pow_two(5, TRUE)
pow_two(5, F)

two_dice <- function() {
  possibilities <- 1:6
  dice1 <- sample(possibilities, size = 1)
  dice2 <- sample(possibilities, size = 1)
  dice1 + dice2
}

two_dice()

linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

interpret(linkedin[1])
interpret(facebook[2])

interpret_all <- function(views, return_sum = TRUE) {
  count <- 0
  
  for (v in views) {
    count <- count + interpret(v)
  }
  
  if (return_sum == TRUE) {
    return(count)
  } else {
    return(NULL)
  }
}

interpret_all(linkedin)
interpret_all(facebook)

search()
# install.packages("ggvis")
library(ggvis)

# install.packages("rjson")

library(data.table)
# require(rjson)

library("data.table")
# require(rjson)

library(data.table)
# require(rjson, character.only = T)

# library(c("data.table", "rjson"))


## apply----
nyc <- list(poo = 8405837,
            boroughs = c("Manhattan", "Bronx", "Brooklyn",
                         "Queens", "Staten Island"),
            capital = FALSE)

for (info in nyc) {
  print(class(info))
}


lapply(nyc, class)

cities <- c("New York", "Paris", "London", "Tokyo", 
            "Rio de Janeiro", "Cape Town")

num_chars <- c()
for (i in 1:length(cities)) {
  num_chars[i] <- nchar(cities[i])
}

num_chars

lapply(cities, nchar)

unlist(lapply(cities, nchar))

oil_prices <- list(2.37, 2.49, 2.18, 2.22, 2.47, 2.32)
triple <- function(x) {
  3 * x
}

result <- lapply(oil_prices, triple)
str(result)
unlist(result)

multiply <- function(x, factor) {
  x * factor
}

times3 <- lapply(oil_prices, multiply, factor =3)
unlist(times3)

times4 <- lapply(oil_prices, multiply, factor = 4)
unlist(times4)


pioneers <- c("GAUSS:1777", "BAYES:1702", 
              "PASCAL:1623", "PEARSON:1857")

split_math <- strsplit(pioneers, split = ":")

split_low <- lapply(split_math, tolower)

str(split_low)

split_low

names <- lapply(split_low, function(x) {x[1]})
years <- lapply(split_low, function(x) {x[2]})

select_el <- function(x, index) {
  x[index]
}

names <- lapply(split_low, select_el, index = 1)
years <- lapply(split_low, select_el, index = 2)

lapply(list(1, "a", T), str)

str(T)























