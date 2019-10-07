# set default in the signature...

toss_coin <- function(n_flips, p_head = .5) {
  coin_sides <- c('head', 'tail')
  weights <- c(p_head, 1-p_head)
  sample(coin_side, n_flips, replace = T, prob = weights)
}

# Set the default for n to 5
cut_by_quantile <- function(x, n=5, na.rm, labels, interval_type) {
  probs <- seq(0, 1, length.out = n + 1)
  qtiles <- quantile(x, probs, na.rm = na.rm, names = FALSE)
  right <- switch(interval_type, "(lo, hi]" = TRUE, "[lo, hi)" = FALSE)
  cut(x, qtiles, labels = labels, right = right, include.lowest = TRUE)
}

n_visits <- snake_river_visits$n_visits

# Remove the n argument from the call
cut_by_quantile(
  n_visits, 
  na.rm = FALSE, 
  labels = c("very low", "low", "medium", "high", "very high"),
  interval_type = "(lo, hi]"
)


# Set the default for na.rm to FALSE
cut_by_quantile <- function(x, n = 5, na.rm=FALSE, labels, interval_type) {
  probs <- seq(0, 1, length.out = n + 1)
  qtiles <- quantile(x, probs, na.rm = na.rm, names = FALSE)
  right <- switch(interval_type, "(lo, hi]" = TRUE, "[lo, hi)" = FALSE)
  cut(x, qtiles, labels = labels, right = right, include.lowest = TRUE)
}

# Remove the na.rm argument from the call
cut_by_quantile(
  n_visits, 
  labels = c("very low", "low", "medium", "high", "very high"),
  interval_type = "(lo, hi]"
)


# Set the default for labels to NULL
cut_by_quantile <- function(x, n = 5, na.rm = FALSE, labels=NULL, interval_type) {
  probs <- seq(0, 1, length.out = n + 1)
  qtiles <- quantile(x, probs, na.rm = na.rm, names = FALSE)
  right <- switch(interval_type, "(lo, hi]" = TRUE, "[lo, hi)" = FALSE)
  cut(x, qtiles, labels = labels, right = right, include.lowest = TRUE)
}

# Remove the labels argument from the call
cut_by_quantile(
  n_visits,
  interval_type = "(lo, hi]"
)

# "open on the left, closed on the right", or (lo, hi]. 
# "closed on the left, open on the right", or [lo, hi). 


# Set the categories for interval_type to "(lo, hi]" and "[lo, hi)"
cut_by_quantile <- function(x, n = 5, na.rm = FALSE, labels = NULL, 
                            interval_type = c('(lo, hi]', '[lo, hi)')) {
  # Match the interval_type argument
  interval_type <- match.arg(interval_type)
  probs <- seq(0, 1, length.out = n + 1)
  qtiles <- quantile(x, probs, na.rm = na.rm, names = FALSE)
  right <- switch(interval_type, "(lo, hi]" = TRUE, "[lo, hi)" = FALSE)
  cut(x, qtiles, labels = labels, right = right, include.lowest = TRUE)
}

# Remove the interval_type argument from the call
cut_by_quantile(n_visits)


std_and_poor500 <- readRDS('./data/std_and_poor500_with_pe_2019-06-21.rds')
std_and_poor500 %>% head()

get_reciprocal <- function(x) {
  1/x
}

calc_harmonic_mean <- function(x) {
  x %>%
    get_reciprocal() %>%
    mean() %>%
    get_reciprocal() 
}


std_and_poors500 %>% 
  # Group by sector
  group_by(sector) %>% 
  # Summarize, calculating harmonic mean of P/E ratio
  summarise(hmean_pe_ratio = calc_harmonic_mean(pe_ratio))



# Add an na.rm arg with a default, and pass it to mean()
calc_harmonic_mean <- function(x, na.rm = F) {
  x %>%
    get_reciprocal() %>%
    mean(na.rm = na.rm) %>%
    get_reciprocal()
}


std_and_poors500 %>% 
  # Group by sector
  group_by(sector) %>% 
  # Summarize, calculating harmonic mean of P/E ratio
  summarise(hmean_pe_ratio = calc_harmonic_mean(pe_ratio, na.rm =T))


# Swap na.rm arg for ... in signature and body
calc_harmonic_mean <- function(x, ...) {
  x %>%
    get_reciprocal() %>%
    mean(...) %>%
    get_reciprocal()
}


std_and_poor500 %>% 
  # Group by sector
  group_by(sector) %>% 
  # Summarize, calculating harmonic mean of P/E ratio
  summarise(hmean_pe_ratio = calc_harmonic_mean(pe_ratio, na.rm = T))


calc_geometric_mean <- function(x, na.rm = FALSE) {
  if(!is.numeric(x)) {
    stop("x is not of class 'numeric'; it has class", class(x), "'.")
  }
  
  x %>%
    log() %>%
    mean(na.rm = na.rm) %>%
    exp()
}

calc_geometric_mean(letters)

library(assertthat)

# install.packages('assertive')
library(assertive)


calc_geometric_mean <- function(x, na.rm = FALSE) {
  assert_is_numeric(x)
  if(any(is_non_positive(x), na.rm = TRUE)) {
    stop('x contains non-positive values, so the geometric makes no sense.')
  }
  
  x %>%
    log() %>%
    mean(na.rm = na.rm) %>%
    exp()
}

calc_geometric_mean(c(1, -1))

use_first(c(1, 4, 9, 16))

coerce_to(c(1, 4, 9, 16), 'character')

calc_geometric_mean <- function(x, na.rm = FALSE) {
  assert_is_numeric(x)
  if(any(is_non_positive(x), na.rm = TRUE)) {
    stop('x contains non-positive values, so the geometric mean makes no sense.')
  }
  
  na.rm <- coerce_to(use_first(na.rm), target_class = 'logical')
  
  
  x %>%
    log() %>%
    mean(na.rm = na.rm) %>%
    exp()
}

calc_geometric_mean(1:5, na.rm = 1:5)



calc_harmonic_mean <- function(x, na.rm = FALSE) {
  # Assert that x is numeric
  assert_is_numeric(x)
  x %>%
    get_reciprocal() %>%
    mean(na.rm = na.rm) %>%
    get_reciprocal()
}

# See what happens when you pass it strings
calc_harmonic_mean(std_and_poor500$sector)



# Update the function definition to fix the na.rm argument
calc_harmonic_mean <- function(x, na.rm = FALSE) {
  assert_is_numeric(x)
  if(any(is_non_positive(x), na.rm = TRUE)) {
    stop("x contains non-positive values, so the harmonic mean makes no sense.")
  }
  # Use the first value of na.rm, and coerce to logical
  na.rm <- coerce_to(use_first(na.rm), target_class = 'logical')
  x %>%
    get_reciprocal() %>%
    mean(na.rm = na.rm) %>%
    get_reciprocal()
}

# See what happens when you pass it malformed na.rm
calc_harmonic_mean(std_and_poor500$pe_ratio, na.rm = 1:5)







