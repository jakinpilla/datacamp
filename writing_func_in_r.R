#' ---
#' title: "Write func in R"
#' output: rmarkdown::github_document
#' ---
  
f <- function(x) {
  y <- 5
  x + y
}

f(5)

# install.packages("purrrlyr")
# install.packages('yaml')
library(purrrlyr)
library(tidyverse)

data("mtcars")
head(mtcars)

mtcars %>%
  group_by(mpg) %>%
  by_slice(.collate = "list",
           ..f = function(x) {
             mtcars %>%
               filter(between(disp, 
                              mean(x$disp) - 100,
                              mean(x$disp) + 100))
           }) -> tmp
 tmp$.out
 
# install.packages("installr")
# installr::updateR()
R.home()
Sys.getenv("Home")
Sys.getenv("R_LIBS_USER")
getwd()
file.edit("~/.Rprofile")
file.edit("~/.Renviron")

x <- c(1, NA, NA, NA)

show_missings <- function(x) {
  n <- sum(is.na(x))
  cat("Missing values : ", n, "\n", sep = "")
  x
}

show_missings(x)

seq_along(c(1, NA, NA))

plot_missing <- function(x) {
  plot(seq_along(x), is.na(x))
  x
}

plot_missing(x)

replace_missing <- function(x, replacement) {
  x[is.na(x)] <- replacement
  x
}

replace_missing(x, 0)
x

exclude_missings <- function() {
  options(na.action = "na.exclude")
}

df <- data.frame(
  a = 1L,
  b = 1.5,
  y = Sys.time(),
  z = ordered(1)
)

A <- sapply(df[1:4], class)
B <- sapply(df[3:4], class)

df
library(purrr)
class_list <- map(df, class)

map_dbl(class_list, length)
any(map_dbl(class_list, length) > 1)



# http://rpubs.com/hadley/157957
# Non-standard evaluation
my_label <- function(x) deparse(substitute(x))
my_label(x)
my_label(x+y)
my_label({
  a+b
  c+d
})

my_label2 <- function(x) my_label(x)
my_label2(a+b)

library(lazyeval)
my_label <- function(x) expr_text(x)
my_label2 <- function(x) my_label(x)

my_label({
  a+b
  c+d
})

expr_label(x)
expr_label(a+b+c)
expr_label(foo({
  x+y
}))

f <- ~x+y+z
typeof(f)
attributes(f)

length(f)
f[[1]]
f[[2]]

g <- y~x+z
length(g)
g[[1]]
g[[2]]
g[[3]]

f_rhs(f)
f_lhs(f)
f_env(f)

f_rhs(g)
f_lhs(g)
f_env(g)

f <- ~ 1+2+3
f
f_eval(f)

x <- 1
add_1000 <- function(x) {
  ~ 1000 + x
}

add_1000(3)
f_eval(add_1000(3))
f_unwrap(add_1000(3))

# Non-standard scoping
y <- 100
f_eval(~y)
f_eval(~y, data = list(y = 10))

# can mix variables in environment and data argument
f_eval(~ x+y, data = list(x = 10))

# can even supply functions
f_eval(~ f(y), data = list(f=function(x) x*3))

f_eval(~mean(cyl), data = mtcars)

# f_eval(~x, data= mydata)

mydata <- data.frame(x=100, y=1)
x <- 10

f_eval(~.env$x, data = mydata)
f_eval(~.data$x, data = mydata)

# f_eval(~.env$z, data= mydata)
# f_eval(~.data$z, data= mydata)

df_mean <- function(df, variable) {
  f_eval(~mean(uq(variable)), data=df)
}

df_mean(mtcars, ~ cyl)
df_mean(mtcars, ~ disp * 0.01638)
df_mean(mtcars, ~ sqrt(mpg))

variable <- ~cyl
f_interp(~mean(uq(variable)))

variable <- ~disp * 0.01638
f_interp(~mean(uq(variable)))

formula <- y~x
f_interp(~lm(uq(formula), data = df))
f_interp(~lm(uqf(formula), data = df))

variable <- ~x
extra_args <- list(na.rm= T, trim= .9)
f_interp((~mean(uq(variable), uqs(extra_args))))









