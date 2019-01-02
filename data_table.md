data table
================
Daniel
Wed Jan 02 22:29:50 2019

``` r
## .SD----
library(data.table)
data("iris")
DT <- as.data.table(iris) 
DT[, .(Sepal.Length = median(Sepal.Length),
       Sepal.Width = median(Sepal.Width),
       Petal.Length = median(Petal.Length),
       Petal.Width = median(Petal.Width)),
   by = Species][order(-Species)]
```

    ##       Species Sepal.Length Sepal.Width Petal.Length Petal.Width
    ## 1:  virginica          6.5         3.0         5.55         2.0
    ## 2: versicolor          5.9         2.8         4.35         1.3
    ## 3:     setosa          5.0         3.4         1.50         0.2

``` r
data.table(x = c(2, 1, 2, 1, 2, 2, 1),
           y = c(1, 3, 5, 7, 9, 11, 13),
           z = c(2, 4, 6, 8, 10, 12, 14)) -> DT

DT[, lapply(.SD, mean), by = x]
```

    ##    x        y        z
    ## 1: 2 6.500000 7.500000
    ## 2: 1 7.666667 8.666667

``` r
DT[, lapply(.SD, median), by = x]
```

    ##    x y z
    ## 1: 2 7 8
    ## 2: 1 7 8

``` r
## .SDcols----
data.table(grp = c(6, 6, 8, 8, 8),
           Q1 = c(3, 1, 5, 2, 4),
           Q2 = c(4, 3, 5, 3, 3),
           Q3 = c(1, 3, 1, 5, 3),
           H1 = c(4, 5, 5, 3, 4),
           H2 = c(2, 2, 4, 4, 4)) -> DT

DT[, lapply(.SD, sum), .SDcols = 2:4]
```

    ##    Q1 Q2 Q3
    ## 1: 15 18 13

``` r
DT[, lapply(.SD, sum), .SDcols = paste0("H", 1:2)]
```

    ##    H1 H2
    ## 1: 21 16

``` r
DT[, .SD[-1], by = grp, .SDcols = paste0("Q", 1:3)]
```

    ##    grp Q1 Q2 Q3
    ## 1:   6  1  3  3
    ## 2:   8  2  3  5
    ## 3:   8  4  3  3

``` r
## Mixing it together : lapply, .SD, .SDcols and .N----
data.table(x = c(2, 1, 2, 1, 2, 2, 1),
           y = c(1, 3, 5, 7, 9, 11, 13),
           z = c(2, 4, 6, 8, 10, 12, 14)) -> DT
DT
```

    ##    x  y  z
    ## 1: 2  1  2
    ## 2: 1  3  4
    ## 3: 2  5  6
    ## 4: 1  7  8
    ## 5: 2  9 10
    ## 6: 2 11 12
    ## 7: 1 13 14

``` r
DT[ , c(lapply(.SD, sum), .N), by = x, .SDcols = c("x", "y", "z")]
```

    ##    x x  y  z N
    ## 1: 2 8 26 30 4
    ## 2: 1 3 23 26 3

``` r
DT[, lapply(.SD, cumsum), 
   by = .(by1 = x, by2 = z > 8), .SDcols = c("x", "y")]
```

    ##    by1   by2 x  y
    ## 1:   2 FALSE 2  1
    ## 2:   2 FALSE 4  6
    ## 3:   1 FALSE 1  3
    ## 4:   1 FALSE 2 10
    ## 5:   2  TRUE 2  9
    ## 6:   2  TRUE 4 20
    ## 7:   1  TRUE 1 13

``` r
# Add/update columnes in j using := ----
data.table(x = c(1, 1, 1, 2, 2),
           y = c(6, 7, 8, 9, 10)) -> DT
DT[, c("x", "z") := .(rev(x), 10:6)]
DT[, c("a") := .(10:6)]

## remove columns using :=
DT[, c("y", "z") := NULL]
DT
```

    ##    x  a
    ## 1: 2 10
    ## 2: 2  9
    ## 3: 1  8
    ## 4: 1  7
    ## 5: 1  6

``` r
data.table(x = c(1, 1, 1, 2, 2),
           y = c(6, 7, 8, 9, 10)) -> DT
DT[, c("x", "z") := .(rev(x), 10:6)]
DT[, c("a") := .(10:6)]
MyCols = c("y", "z")
DT[, (MyCols) := NULL]
DT
```

    ##    x  a
    ## 1: 2 10
    ## 2: 2  9
    ## 3: 1  8
    ## 4: 1  7
    ## 5: 1  6

``` r
## Funtional :=
DT[, `:=`(y = 6:10, # y (kg)
          z=1)]
DT
```

    ##    x  a  y z
    ## 1: 2 10  6 1
    ## 2: 2  9  7 1
    ## 3: 1  8  8 1
    ## 4: 1  7  9 1
    ## 5: 1  6 10 1

``` r
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
```

    ## [1] NA  7  7  5 NA

``` r
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
```

    ##    x y z
    ## 1: 1 1 2
    ## 2: 2 8 3
    ## 3: 3 1 4
    ## 4: 4 1 5
    ## 5: 5 1 6

``` r
## setnaems()
data.table(x = 1:5, y = letters[1:5]) -> DT; DT
```

    ##    x y
    ## 1: 1 a
    ## 2: 2 b
    ## 3: 3 c
    ## 4: 4 d
    ## 5: 5 e

``` r
setnames(DT, "y", "z"); DT
```

    ##    x z
    ## 1: 1 a
    ## 2: 2 b
    ## 3: 3 c
    ## 4: 4 d
    ## 5: 5 e

``` r
## setcolorder()
data.table(x = 1:5, y = letters[1:5]) -> DT; DT
```

    ##    x y
    ## 1: 1 a
    ## 2: 2 b
    ## 3: 3 c
    ## 4: 4 d
    ## 5: 5 e

``` r
setcolorder(DT, c("y", "x")); DT
```

    ##    y x
    ## 1: a 1
    ## 2: b 2
    ## 3: c 3
    ## 4: d 4
    ## 5: e 5

``` r
set.seed(1)
data.table(A = sample(5, 10, replace = T, set.seed(1)), 
           B = sample(5, 10, replace = T, set.seed(2)),
           C = sample(5, 10, replace = T, set.seed(3)),
           D = sample(5, 10, replace = T, set.seed(4))) -> DT

# set(DT, index, column, value)
for (i in 2:4) set(DT, sample(10, 3), i, NA); DT
```

    ##     A  B  C  D
    ##  1: 2 NA  1  3
    ##  2: 2  4  5  1
    ##  3: 3 NA  2  2
    ##  4: 5  1 NA  2
    ##  5: 2  5  4  5
    ##  6: 5  5  4 NA
    ##  7: 5  1  1  4
    ##  8: 4 NA  2 NA
    ##  9: 4  3 NA  5
    ## 10: 1  3 NA NA

``` r
# change the column names to lowercase
setnames(DT, tolower(names(DT))); DT
```

    ##     a  b  c  d
    ##  1: 2 NA  1  3
    ##  2: 2  4  5  1
    ##  3: 3 NA  2  2
    ##  4: 5  1 NA  2
    ##  5: 2  5  4  5
    ##  6: 5  5  4 NA
    ##  7: 5  1  1  4
    ##  8: 4 NA  2 NA
    ##  9: 4  3 NA  5
    ## 10: 1  3 NA NA

``` r
DT <- data.table(a = letters[c(1, 1, 1, 2, 2)], b = 1); DT
```

    ##    a b
    ## 1: a 1
    ## 2: a 1
    ## 3: a 1
    ## 4: b 1
    ## 5: b 1

``` r
# add a suffix "_2" to all column names
names(DT)
```

    ## [1] "a" "b"

``` r
paste0(names(DT), "_2")
```

    ## [1] "a_2" "b_2"

``` r
setnames(DT, paste0(names(DT), "_2")); DT
```

    ##    a_2 b_2
    ## 1:   a   1
    ## 2:   a   1
    ## 3:   a   1
    ## 4:   b   1
    ## 5:   b   1

``` r
# change column name "a_2" to "A2"
setnames(DT, "a_2", "A2"); DT
```

    ##    A2 b_2
    ## 1:  a   1
    ## 2:  a   1
    ## 3:  a   1
    ## 4:  b   1
    ## 5:  b   1

``` r
# reverse the order of the columns
setcolorder(DT, rev(names(DT))); DT
```

    ##    b_2 A2
    ## 1:   1  a
    ## 2:   1  a
    ## 3:   1  a
    ## 4:   1  b
    ## 5:   1  b

``` r
# using column names in i
data.table(A = c("c", "b", "a"), B = 1:6) -> DT; DT
```

    ##    A B
    ## 1: c 1
    ## 2: b 2
    ## 3: a 3
    ## 4: c 4
    ## 5: b 5
    ## 6: a 6

``` r
DT[A == "a"]
```

    ##    A B
    ## 1: a 3
    ## 2: a 6

``` r
DT[A %in% c("a", "c")]
```

    ##    A B
    ## 1: c 1
    ## 2: a 3
    ## 3: c 4
    ## 4: a 6

``` r
# select rows the data.table way
data("iris")
iris <- as.data.table(iris)
iris
```

    ##      Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
    ##   1:          5.1         3.5          1.4         0.2    setosa
    ##   2:          4.9         3.0          1.4         0.2    setosa
    ##   3:          4.7         3.2          1.3         0.2    setosa
    ##   4:          4.6         3.1          1.5         0.2    setosa
    ##   5:          5.0         3.6          1.4         0.2    setosa
    ##  ---                                                            
    ## 146:          6.7         3.0          5.2         2.3 virginica
    ## 147:          6.3         2.5          5.0         1.9 virginica
    ## 148:          6.5         3.0          5.2         2.0 virginica
    ## 149:          6.2         3.4          5.4         2.3 virginica
    ## 150:          5.9         3.0          5.1         1.8 virginica

``` r
iris[Species == "virginica"]
```

    ##     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
    ##  1:          6.3         3.3          6.0         2.5 virginica
    ##  2:          5.8         2.7          5.1         1.9 virginica
    ##  3:          7.1         3.0          5.9         2.1 virginica
    ##  4:          6.3         2.9          5.6         1.8 virginica
    ##  5:          6.5         3.0          5.8         2.2 virginica
    ##  6:          7.6         3.0          6.6         2.1 virginica
    ##  7:          4.9         2.5          4.5         1.7 virginica
    ##  8:          7.3         2.9          6.3         1.8 virginica
    ##  9:          6.7         2.5          5.8         1.8 virginica
    ## 10:          7.2         3.6          6.1         2.5 virginica
    ## 11:          6.5         3.2          5.1         2.0 virginica
    ## 12:          6.4         2.7          5.3         1.9 virginica
    ## 13:          6.8         3.0          5.5         2.1 virginica
    ## 14:          5.7         2.5          5.0         2.0 virginica
    ## 15:          5.8         2.8          5.1         2.4 virginica
    ## 16:          6.4         3.2          5.3         2.3 virginica
    ## 17:          6.5         3.0          5.5         1.8 virginica
    ## 18:          7.7         3.8          6.7         2.2 virginica
    ## 19:          7.7         2.6          6.9         2.3 virginica
    ## 20:          6.0         2.2          5.0         1.5 virginica
    ## 21:          6.9         3.2          5.7         2.3 virginica
    ## 22:          5.6         2.8          4.9         2.0 virginica
    ## 23:          7.7         2.8          6.7         2.0 virginica
    ## 24:          6.3         2.7          4.9         1.8 virginica
    ## 25:          6.7         3.3          5.7         2.1 virginica
    ## 26:          7.2         3.2          6.0         1.8 virginica
    ## 27:          6.2         2.8          4.8         1.8 virginica
    ## 28:          6.1         3.0          4.9         1.8 virginica
    ## 29:          6.4         2.8          5.6         2.1 virginica
    ## 30:          7.2         3.0          5.8         1.6 virginica
    ## 31:          7.4         2.8          6.1         1.9 virginica
    ## 32:          7.9         3.8          6.4         2.0 virginica
    ## 33:          6.4         2.8          5.6         2.2 virginica
    ## 34:          6.3         2.8          5.1         1.5 virginica
    ## 35:          6.1         2.6          5.6         1.4 virginica
    ## 36:          7.7         3.0          6.1         2.3 virginica
    ## 37:          6.3         3.4          5.6         2.4 virginica
    ## 38:          6.4         3.1          5.5         1.8 virginica
    ## 39:          6.0         3.0          4.8         1.8 virginica
    ## 40:          6.9         3.1          5.4         2.1 virginica
    ## 41:          6.7         3.1          5.6         2.4 virginica
    ## 42:          6.9         3.1          5.1         2.3 virginica
    ## 43:          5.8         2.7          5.1         1.9 virginica
    ## 44:          6.8         3.2          5.9         2.3 virginica
    ## 45:          6.7         3.3          5.7         2.5 virginica
    ## 46:          6.7         3.0          5.2         2.3 virginica
    ## 47:          6.3         2.5          5.0         1.9 virginica
    ## 48:          6.5         3.0          5.2         2.0 virginica
    ## 49:          6.2         3.4          5.4         2.3 virginica
    ## 50:          5.9         3.0          5.1         1.8 virginica
    ##     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species

``` r
iris[Species == "virginica" | Species == "versicolor"]
```

    ##      Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
    ##   1:          7.0         3.2          4.7         1.4 versicolor
    ##   2:          6.4         3.2          4.5         1.5 versicolor
    ##   3:          6.9         3.1          4.9         1.5 versicolor
    ##   4:          5.5         2.3          4.0         1.3 versicolor
    ##   5:          6.5         2.8          4.6         1.5 versicolor
    ##   6:          5.7         2.8          4.5         1.3 versicolor
    ##   7:          6.3         3.3          4.7         1.6 versicolor
    ##   8:          4.9         2.4          3.3         1.0 versicolor
    ##   9:          6.6         2.9          4.6         1.3 versicolor
    ##  10:          5.2         2.7          3.9         1.4 versicolor
    ##  11:          5.0         2.0          3.5         1.0 versicolor
    ##  12:          5.9         3.0          4.2         1.5 versicolor
    ##  13:          6.0         2.2          4.0         1.0 versicolor
    ##  14:          6.1         2.9          4.7         1.4 versicolor
    ##  15:          5.6         2.9          3.6         1.3 versicolor
    ##  16:          6.7         3.1          4.4         1.4 versicolor
    ##  17:          5.6         3.0          4.5         1.5 versicolor
    ##  18:          5.8         2.7          4.1         1.0 versicolor
    ##  19:          6.2         2.2          4.5         1.5 versicolor
    ##  20:          5.6         2.5          3.9         1.1 versicolor
    ##  21:          5.9         3.2          4.8         1.8 versicolor
    ##  22:          6.1         2.8          4.0         1.3 versicolor
    ##  23:          6.3         2.5          4.9         1.5 versicolor
    ##  24:          6.1         2.8          4.7         1.2 versicolor
    ##  25:          6.4         2.9          4.3         1.3 versicolor
    ##  26:          6.6         3.0          4.4         1.4 versicolor
    ##  27:          6.8         2.8          4.8         1.4 versicolor
    ##  28:          6.7         3.0          5.0         1.7 versicolor
    ##  29:          6.0         2.9          4.5         1.5 versicolor
    ##  30:          5.7         2.6          3.5         1.0 versicolor
    ##  31:          5.5         2.4          3.8         1.1 versicolor
    ##  32:          5.5         2.4          3.7         1.0 versicolor
    ##  33:          5.8         2.7          3.9         1.2 versicolor
    ##  34:          6.0         2.7          5.1         1.6 versicolor
    ##  35:          5.4         3.0          4.5         1.5 versicolor
    ##  36:          6.0         3.4          4.5         1.6 versicolor
    ##  37:          6.7         3.1          4.7         1.5 versicolor
    ##  38:          6.3         2.3          4.4         1.3 versicolor
    ##  39:          5.6         3.0          4.1         1.3 versicolor
    ##  40:          5.5         2.5          4.0         1.3 versicolor
    ##  41:          5.5         2.6          4.4         1.2 versicolor
    ##  42:          6.1         3.0          4.6         1.4 versicolor
    ##  43:          5.8         2.6          4.0         1.2 versicolor
    ##  44:          5.0         2.3          3.3         1.0 versicolor
    ##  45:          5.6         2.7          4.2         1.3 versicolor
    ##  46:          5.7         3.0          4.2         1.2 versicolor
    ##  47:          5.7         2.9          4.2         1.3 versicolor
    ##  48:          6.2         2.9          4.3         1.3 versicolor
    ##  49:          5.1         2.5          3.0         1.1 versicolor
    ##  50:          5.7         2.8          4.1         1.3 versicolor
    ##  51:          6.3         3.3          6.0         2.5  virginica
    ##  52:          5.8         2.7          5.1         1.9  virginica
    ##  53:          7.1         3.0          5.9         2.1  virginica
    ##  54:          6.3         2.9          5.6         1.8  virginica
    ##  55:          6.5         3.0          5.8         2.2  virginica
    ##  56:          7.6         3.0          6.6         2.1  virginica
    ##  57:          4.9         2.5          4.5         1.7  virginica
    ##  58:          7.3         2.9          6.3         1.8  virginica
    ##  59:          6.7         2.5          5.8         1.8  virginica
    ##  60:          7.2         3.6          6.1         2.5  virginica
    ##  61:          6.5         3.2          5.1         2.0  virginica
    ##  62:          6.4         2.7          5.3         1.9  virginica
    ##  63:          6.8         3.0          5.5         2.1  virginica
    ##  64:          5.7         2.5          5.0         2.0  virginica
    ##  65:          5.8         2.8          5.1         2.4  virginica
    ##  66:          6.4         3.2          5.3         2.3  virginica
    ##  67:          6.5         3.0          5.5         1.8  virginica
    ##  68:          7.7         3.8          6.7         2.2  virginica
    ##  69:          7.7         2.6          6.9         2.3  virginica
    ##  70:          6.0         2.2          5.0         1.5  virginica
    ##  71:          6.9         3.2          5.7         2.3  virginica
    ##  72:          5.6         2.8          4.9         2.0  virginica
    ##  73:          7.7         2.8          6.7         2.0  virginica
    ##  74:          6.3         2.7          4.9         1.8  virginica
    ##  75:          6.7         3.3          5.7         2.1  virginica
    ##  76:          7.2         3.2          6.0         1.8  virginica
    ##  77:          6.2         2.8          4.8         1.8  virginica
    ##  78:          6.1         3.0          4.9         1.8  virginica
    ##  79:          6.4         2.8          5.6         2.1  virginica
    ##  80:          7.2         3.0          5.8         1.6  virginica
    ##  81:          7.4         2.8          6.1         1.9  virginica
    ##  82:          7.9         3.8          6.4         2.0  virginica
    ##  83:          6.4         2.8          5.6         2.2  virginica
    ##  84:          6.3         2.8          5.1         1.5  virginica
    ##  85:          6.1         2.6          5.6         1.4  virginica
    ##  86:          7.7         3.0          6.1         2.3  virginica
    ##  87:          6.3         3.4          5.6         2.4  virginica
    ##  88:          6.4         3.1          5.5         1.8  virginica
    ##  89:          6.0         3.0          4.8         1.8  virginica
    ##  90:          6.9         3.1          5.4         2.1  virginica
    ##  91:          6.7         3.1          5.6         2.4  virginica
    ##  92:          6.9         3.1          5.1         2.3  virginica
    ##  93:          5.8         2.7          5.1         1.9  virginica
    ##  94:          6.8         3.2          5.9         2.3  virginica
    ##  95:          6.7         3.3          5.7         2.5  virginica
    ##  96:          6.7         3.0          5.2         2.3  virginica
    ##  97:          6.3         2.5          5.0         1.9  virginica
    ##  98:          6.5         3.0          5.2         2.0  virginica
    ##  99:          6.2         3.4          5.4         2.3  virginica
    ## 100:          5.9         3.0          5.1         1.8  virginica
    ##      Sepal.Length Sepal.Width Petal.Length Petal.Width    Species

``` r
# remove the "Sepal." prefix
names(iris)
```

    ## [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 
    ## [5] "Species"

``` r
gsub("Sepal.", "", names(iris))
```

    ## [1] "Length"       "Width"        "Petal.Length" "Petal.Width" 
    ## [5] "Species"

``` r
setnames(iris, gsub("Sepal.", "", names(iris))); iris
```

    ##      Length Width Petal.Length Petal.Width   Species
    ##   1:    5.1   3.5          1.4         0.2    setosa
    ##   2:    4.9   3.0          1.4         0.2    setosa
    ##   3:    4.7   3.2          1.3         0.2    setosa
    ##   4:    4.6   3.1          1.5         0.2    setosa
    ##   5:    5.0   3.6          1.4         0.2    setosa
    ##  ---                                                
    ## 146:    6.7   3.0          5.2         2.3 virginica
    ## 147:    6.3   2.5          5.0         1.9 virginica
    ## 148:    6.5   3.0          5.2         2.0 virginica
    ## 149:    6.2   3.4          5.4         2.3 virginica
    ## 150:    5.9   3.0          5.1         1.8 virginica

``` r
# remove the two columns starting with "Petal"
grep("^Petal.", names(iris))
```

    ## [1] 3 4

``` r
iris[, grep("^Petal.", names(iris)) := NULL]; iris
```

    ##      Length Width   Species
    ##   1:    5.1   3.5    setosa
    ##   2:    4.9   3.0    setosa
    ##   3:    4.7   3.2    setosa
    ##   4:    4.6   3.1    setosa
    ##   5:    5.0   3.6    setosa
    ##  ---                       
    ## 146:    6.7   3.0 virginica
    ## 147:    6.3   2.5 virginica
    ## 148:    6.5   3.0 virginica
    ## 149:    6.2   3.4 virginica
    ## 150:    5.9   3.0 virginica

``` r
# area is greateer than 20 
iris <- iris[Length*Width > 20]

iris[, is.large := Length * Width > 25]

iris[(is.large)]
```

    ##    Length Width   Species is.large
    ## 1:    5.7   4.4    setosa     TRUE
    ## 2:    7.2   3.6 virginica     TRUE
    ## 3:    7.7   3.8 virginica     TRUE
    ## 4:    7.9   3.8 virginica     TRUE

``` r
# creating and using a key
data.table(A = c("c", "b", "a"), B = 1:6) -> DT; DT
```

    ##    A B
    ## 1: c 1
    ## 2: b 2
    ## 3: a 3
    ## 4: c 4
    ## 5: b 5
    ## 6: a 6

``` r
setkey(DT, A)
DT
```

    ##    A B
    ## 1: a 3
    ## 2: a 6
    ## 3: b 2
    ## 4: b 5
    ## 5: c 1
    ## 6: c 4

``` r
# mult
setkey(DT, A)
DT["b", mult = "first"]
```

    ##    A B
    ## 1: b 2

``` r
DT["b", mult = "last"]
```

    ##    A B
    ## 1: b 5

``` r
# no match
setkey(DT, A)
DT[c("b", "d")]
```

    ##    A  B
    ## 1: b  2
    ## 2: b  5
    ## 3: d NA

``` r
DT[c("b", "d"), nomatch = 0]
```

    ##    A B
    ## 1: b 2
    ## 2: b 5

``` r
# two column key
DT
```

    ##    A B
    ## 1: a 3
    ## 2: a 6
    ## 3: b 2
    ## 4: b 5
    ## 5: c 1
    ## 6: c 4

``` r
setkey(DT, A, B)
DT[.("b", 5)]
```

    ##    A B
    ## 1: b 5

``` r
DT[.("b", 6)]
```

    ##    A B
    ## 1: b 6

``` r
DT[.("b")]
```

    ##    A B
    ## 1: b 2
    ## 2: b 5

``` r
#
data.table(A = c("b", "a", "b", "c", "a", "b", "c"),
           B = c(2, 4, 1, 7, 5, 3, 6),
           C = c(6, 7, 8, 9, 10, 11, 12)) -> DT
DT
```

    ##    A B  C
    ## 1: b 2  6
    ## 2: a 4  7
    ## 3: b 1  8
    ## 4: c 7  9
    ## 5: a 5 10
    ## 6: b 3 11
    ## 7: c 6 12

``` r
DT[A == "b"]
```

    ##    A B  C
    ## 1: b 2  6
    ## 2: b 1  8
    ## 3: b 3 11

``` r
setkey(DT, A, B)
DT[A == "b"]
```

    ##    A B  C
    ## 1: b 1  8
    ## 2: b 2  6
    ## 3: b 3 11

``` r
data.table(A = letters[c(2, 1, 2, 3, 1, 2, 3)],
           B = c(5, 4, 1, 9, 8, 8, 6),
           C = 6:12) -> DT

setkey(DT, A, B)

DT[A == "b"]
```

    ##    A B  C
    ## 1: b 1  8
    ## 2: b 5  6
    ## 3: b 8 11

``` r
DT[c("b", "c")]
```

    ##    A B  C
    ## 1: b 1  8
    ## 2: b 5  6
    ## 3: b 8 11
    ## 4: c 6 12
    ## 5: c 9  9

``` r
DT[c("b", "c"), mult= "first"]
```

    ##    A B  C
    ## 1: b 1  8
    ## 2: c 6 12

``` r
DT[c("b", "c"), .SD[c(1, .N)], by = .EACHI]
```

    ##    A B  C
    ## 1: b 1  8
    ## 2: b 8 11
    ## 3: c 6 12
    ## 4: c 9  9

``` r
# print out the group before returning the first and last row from it
DT[c("b", "c"), {print(.SD); .SD[c(1, .N)]}, by = .EACHI]
```

    ##    B  C
    ## 1: 1  8
    ## 2: 5  6
    ## 3: 8 11
    ##    B  C
    ## 1: 6 12
    ## 2: 9  9

    ##    A B  C
    ## 1: b 1  8
    ## 2: b 8 11
    ## 3: c 6 12
    ## 4: c 9  9

``` r
# rolling joins
data.table(A = rep(c("a", "b", "c"), each=2),
           B = c(2, 6, 1, 5, 3, 4),
           C = c(6, 3, 2, 5, 4, 1)) -> DT; DT
```

    ##    A B C
    ## 1: a 2 6
    ## 2: a 6 3
    ## 3: b 1 2
    ## 4: b 5 5
    ## 5: c 3 4
    ## 6: c 4 1

``` r
setkey(DT, A, B)

DT[.("b", 4)]
```

    ##    A B  C
    ## 1: b 4 NA

``` r
DT[.("b", 4), roll = T]
```

    ##    A B C
    ## 1: b 4 2

``` r
DT[.("b", 4), roll = "nearest"]
```

    ##    A B C
    ## 1: b 4 5

``` r
DT[.("b", 4), roll = +Inf]
```

    ##    A B C
    ## 1: b 4 2

``` r
DT[.("b", 4), roll = -Inf]
```

    ##    A B C
    ## 1: b 4 5

``` r
DT[.("b", 4), roll = 2]
```

    ##    A B  C
    ## 1: b 4 NA

``` r
DT[.("b", 4), roll = -2]
```

    ##    A B C
    ## 1: b 4 5

``` r
# Control ends
setkey(DT, A, B)
DT
```

    ##    A B C
    ## 1: a 2 6
    ## 2: a 6 3
    ## 3: b 1 2
    ## 4: b 5 5
    ## 5: c 3 4
    ## 6: c 4 1

``` r
DT[.("b", 7:8), roll = T]
```

    ##    A B C
    ## 1: b 7 5
    ## 2: b 8 5

``` r
DT[.("b", 7:8), roll = T, rollends= F]
```

    ##    A B  C
    ## 1: b 7 NA
    ## 2: b 8 NA

``` r
DT <- data.table(A = letters[c(2, 1, 2, 3, 1, 2, 3)],
                 B = c(5, 4, 1, 9, 8, 8, 6),
                 C = 6:12,
                 key = "A,B")
DT
```

    ##    A B  C
    ## 1: a 4  7
    ## 2: a 8 10
    ## 3: b 1  8
    ## 4: b 5  6
    ## 5: b 8 11
    ## 6: c 6 12
    ## 7: c 9  9

``` r
key(DT)
```

    ## [1] "A" "B"

``` r
# Row where A == "b" and B == 6
DT[.("b", 6)]
```

    ##    A B  C
    ## 1: b 6 NA

``` r
# return the prevailing row
DT[.("b", 6), roll = T]
```

    ##    A B C
    ## 1: b 6 6

``` r
# return the nearest row
DT[.("b", 6), roll = "nearest"]
```

    ##    A B C
    ## 1: b 6 6

``` r
# print the sequence for the "b" group
DT[.("b", (-2):10)]
```

    ##     A  B  C
    ##  1: b -2 NA
    ##  2: b -1 NA
    ##  3: b  0 NA
    ##  4: b  1  8
    ##  5: b  2 NA
    ##  6: b  3 NA
    ##  7: b  4 NA
    ##  8: b  5  6
    ##  9: b  6 NA
    ## 10: b  7 NA
    ## 11: b  8 11
    ## 12: b  9 NA
    ## 13: b 10 NA

``` r
# roll the prevailing values forward to replace the NAs
DT[.("b", (-2):10), roll = T]
```

    ##     A  B  C
    ##  1: b -2 NA
    ##  2: b -1 NA
    ##  3: b  0 NA
    ##  4: b  1  8
    ##  5: b  2  8
    ##  6: b  3  8
    ##  7: b  4  8
    ##  8: b  5  6
    ##  9: b  6  6
    ## 10: b  7  6
    ## 11: b  8 11
    ## 12: b  9 11
    ## 13: b 10 11

``` r
# roll the first observation backwards
DT[.("b", (-2):10), roll = T, rollends = T]
```

    ##     A  B  C
    ##  1: b -2  8
    ##  2: b -1  8
    ##  3: b  0  8
    ##  4: b  1  8
    ##  5: b  2  8
    ##  6: b  3  8
    ##  7: b  4  8
    ##  8: b  5  6
    ##  9: b  6  6
    ## 10: b  7  6
    ## 11: b  8 11
    ## 12: b  9 11
    ## 13: b 10 11
