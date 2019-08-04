rep(3,3)
rep(4,4)
seq(2, 6, by = 2)
seq(1, 5, by = 2)
c(3,3,3)
c(4,4,4,4)
c(2,4,6)
c(1,3,5)

x <- c(1:7)
y <- seq(2, 14, by = 2)
z <- c(1, 1, 2)

print(x + y)
print(2*z)
print(x*y)
print(x + z)

matrix(1, nrow = 2, ncol = 3)
print(matrix(2, nrow = 3, ncol = 2))

B <- matrix(c(1, 2, 3, 2), nrow = 2, ncol = 2, byrow = F)
B <- matrix(c(1, 2, 3, 2), nrow = 2, ncol = 2, byrow = T)

A <- matrix(1, nrow = 2, ncol = 2)
A + B









