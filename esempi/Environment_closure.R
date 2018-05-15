f <- function(x) {
  y <- 2*x
  print(x)
  print(y)
  print(z)
  z <- 37   # at this point, z becomes a local variable
  print(z)
  102       # this is the value that gets returned from the function
}
z <- 84
f(10)
print(z)

#closure
power <- function(exponent) {
  function(x) {
    x ^ exponent
  }
}
square <- power(2)
as.list(environment(square))
square(2)


new_counter <- function() {
  i <- 0
  function() {
    i <<- i + 1
    i
  }
}


i <- 0
new_counter2 <- function() {
  i <<- i + 1
  i
}
new_counter3 <- function() {
  i <- 0
  function() {
    i <- i + 1
    i
  }
}

