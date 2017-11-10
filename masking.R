circumference <- function(radius) 2*pi*radius
pi <- 0
circumference(1)
get("pi", envir = as.environment(globalenv()))
get("pi", envir = as.environment(baseenv()))
circumference <- function(radius) 2*base::pi*radius
circumference(1)