## .SD----
library(data.table)
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
DT
DT[, c("x", "z") := .(rev(x), 10:6)]
DT[, c("a") := .(10:6)]

## remove columns using :=
DT[, c("y", "z") := NULL]
DT
