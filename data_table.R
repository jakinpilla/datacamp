#' ---
#' title: "data table"
#' output: rmarkdown::github_document
#' ---

## .SD----
library(data.table)
data("iris")
DT <- as.data.table(iris) 
DT[, .(Sepal.Length = median(Sepal.Length),
       Sepal.Width = median(Sepal.Width),
       Petal.Length = median(Petal.Length),
       Petal.Width = median(Petal.Width)),
   by = Species][order(-Species)]

data.table(x = c(2, 1, 2, 1, 2, 2, 1),
           y = c(1, 3, 5, 7, 9, 11, 13),
           z = c(2, 4, 6, 8, 10, 12, 14)) -> DT

DT[, lapply(.SD, mean), by = x]
DT[, lapply(.SD, median), by = x]

## .SDcols----
data.table(grp = c(6, 6, 8, 8, 8),
           Q1 = c(3, 1, 5, 2, 4),
           Q2 = c(4, 3, 5, 3, 3),
           Q3 = c(1, 3, 1, 5, 3),
           H1 = c(4, 5, 5, 3, 4),
           H2 = c(2, 2, 4, 4, 4)) -> DT

DT[, lapply(.SD, sum), .SDcols = 2:4]
DT[, lapply(.SD, sum), .SDcols = paste0("H", 1:2)]
DT[, .SD[-1], by = grp, .SDcols = paste0("Q", 1:3)]

## Mixing it together : lapply, .SD, .SDcols and .N----
data.table(x = c(2, 1, 2, 1, 2, 2, 1),
           y = c(1, 3, 5, 7, 9, 11, 13),
           z = c(2, 4, 6, 8, 10, 12, 14)) -> DT
DT

DT[ , c(lapply(.SD, sum), .N), by = x, .SDcols = c("x", "y", "z")]

DT[, lapply(.SD, cumsum), 
   by = .(by1 = x, by2 = z > 8), .SDcols = c("x", "y")]

# Add/update columnes in j using := ----
data.table(x = c(1, 1, 1, 2, 2),
           y = c(6, 7, 8, 9, 10)) -> DT
DT[, c("x", "z") := .(rev(x), 10:6)]
DT[, c("a") := .(10:6)]

## remove columns using :=
DT[, c("y", "z") := NULL]
DT

data.table(x = c(1, 1, 1, 2, 2),
           y = c(6, 7, 8, 9, 10)) -> DT
DT[, c("x", "z") := .(rev(x), 10:6)]
DT[, c("a") := .(10:6)]
MyCols = c("y", "z")
DT[, (MyCols) := NULL]
DT

## Funtional :=
DT[, `:=`(y = 6:10, # y (kg)
          z=1)]
DT

## := combined with i and by
data.table(x = c(2, 2, 1, 1, 1),
           y = c(6, 7, 8, 9, 10),
           z = NA) -> DT

# DT[2:4, z := sum(y), by = x] # not working with error message

## The data.table DT
DT <- data.table(A = letters[c(1, 1, 1, 2, 2)], B =  1:5)

## Add column by reference : Total
DT[ , Total := sum(B), by = A]

## Add 1L to the values in column B, but only in the rows 2 and 4
DT[2:4, B := B + 1L]

## Add a new column Total2 that contains sum(B) grouped by A but just over rows 2, 3 and 4
DT[2:4, Total2 := sum(B), by = A]

## remove the Total colomn
DT[, Total := NULL]

## select the third column using "[["
DT[[3]]

## the functional form
DT <- data.table(A  = c(1, 1, 1, 2, 2), B = 1:5)

## udpate B, add C and D
DT[, `:=`(B = B + 1, C = A + B, D = 2)]

## delete my_cols
my_cols <- c("B", "C")
DT[, (my_cols) := NULL]

## delete column 2 by number 
DT[, 2 := NULL]

# Using set()----
data.table(x = c(1, 2, 3, 4, 5),
           y = c(1, 8, 1, 1, 1),
           z = c(2, 5, 4, 2, 3)) -> DT

for (i in 1:5) DT[i, z := i + 1]
DT

data.table(x = c(1, 2, 3, 4, 5),
           y = c(1, 8, 1, 1, 1),
           z = c(2, 5, 4, 2, 3)) -> DT

for (i in 1:5) set(DT, i, 3L, i+1)
DT

## setnaems()
data.table(x = 1:5, y = letters[1:5]) -> DT; DT
setnames(DT, "y", "z"); DT

## setcolorder()
data.table(x = 1:5, y = letters[1:5]) -> DT; DT
setcolorder(DT, c("y", "x")); DT

set.seed(1)
data.table(A = sample(5, 10, replace = T, set.seed(1)), 
           B = sample(5, 10, replace = T, set.seed(2)),
           C = sample(5, 10, replace = T, set.seed(3)),
           D = sample(5, 10, replace = T, set.seed(4))) -> DT

# set(DT, index, column, value)
for (i in 2:4) set(DT, sample(10, 3), i, NA); DT

# change the column names to lowercase
setnames(DT, tolower(names(DT))); DT

DT <- data.table(a = letters[c(1, 1, 1, 2, 2)], b = 1); DT

# add a suffix "_2" to all column names
names(DT)
paste0(names(DT), "_2")
setnames(DT, paste0(names(DT), "_2")); DT

# change column name "a_2" to "A2"
setnames(DT, "a_2", "A2"); DT

# reverse the order of the columns
setcolorder(DT, rev(names(DT))); DT

# using column names in i
data.table(A = c("c", "b", "a"), B = 1:6) -> DT; DT

DT[A == "a"]
DT[A %in% c("a", "c")]

# select rows the data.table way
data("iris")
iris <- as.data.table(iris)
iris
iris[Species == "virginica"]
iris[Species == "virginica" | Species == "versicolor"]

# remove the "Sepal." prefix
names(iris)
gsub("Sepal.", "", names(iris))
setnames(iris, gsub("Sepal.", "", names(iris))); iris

# remove the two columns starting with "Petal"
grep("^Petal.", names(iris))
iris[, grep("^Petal.", names(iris)) := NULL]; iris

# area is greateer than 20 
iris <- iris[Length*Width > 20]

iris[, is.large := Length * Width > 25]

iris[(is.large)]

# creating and using a key
data.table(A = c("c", "b", "a"), B = 1:6) -> DT; DT
setkey(DT, A)
DT

# mult
setkey(DT, A)
DT["b", mult = "first"]
DT["b", mult = "last"]

# no match
setkey(DT, A)
DT[c("b", "d")]
DT[c("b", "d"), nomatch = 0]

# two column key
DT
setkey(DT, A, B)
DT[.("b", 5)]
DT[.("b", 6)]
DT[.("b")]

#
data.table(A = c("b", "a", "b", "c", "a", "b", "c"),
           B = c(2, 4, 1, 7, 5, 3, 6),
           C = c(6, 7, 8, 9, 10, 11, 12)) -> DT
DT

DT[A == "b"]
setkey(DT, A, B)
DT[A == "b"]

data.table(A = letters[c(2, 1, 2, 3, 1, 2, 3)],
           B = c(5, 4, 1, 9, 8, 8, 6),
           C = 6:12) -> DT

setkey(DT, A, B)

DT[A == "b"]
DT[c("b", "c")]
DT[c("b", "c"), mult= "first"]
DT[c("b", "c"), .SD[c(1, .N)], by = .EACHI]
# print out the group before returning the first and last row from it
DT[c("b", "c"), {print(.SD); .SD[c(1, .N)]}, by = .EACHI]

# rolling joins
data.table(A = rep(c("a", "b", "c"), each=2),
           B = c(2, 6, 1, 5, 3, 4),
           C = c(6, 3, 2, 5, 4, 1)) -> DT; DT
setkey(DT, A, B)

DT[.("b", 4)]
DT[.("b", 4), roll = T]
DT[.("b", 4), roll = "nearest"]
DT[.("b", 4), roll = +Inf]
DT[.("b", 4), roll = -Inf]
DT[.("b", 4), roll = 2]
DT[.("b", 4), roll = -2]

# Control ends
setkey(DT, A, B)
DT
DT[.("b", 7:8), roll = T]
DT[.("b", 7:8), roll = T, rollends= F]

DT <- data.table(A = letters[c(2, 1, 2, 3, 1, 2, 3)],
                 B = c(5, 4, 1, 9, 8, 8, 6),
                 C = 6:12,
                 key = "A,B")
DT

key(DT)

# Row where A == "b" and B == 6
DT[.("b", 6)]

# return the prevailing row
DT[.("b", 6), roll = T]

# return the nearest row
DT[.("b", 6), roll = "nearest"]

# print the sequence for the "b" group
DT[.("b", (-2):10)]

# roll the prevailing values forward to replace the NAs
DT[.("b", (-2):10), roll = T]

# roll the first observation backwards
DT[.("b", (-2):10), roll = T, rollends = T]
