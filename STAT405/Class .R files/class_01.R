## ------------------------------------------------------------------------
# Notice that comments are started with the "#" character
# The basic arithmetic operators (+, - , * , /, ^ [power], %% [modulus])
# The functions will operate element-wise on vectors too
# This code will add these two numbers together
2 + 2

## ------------------------------------------------------------------------
# Here's the exponential and log functions (base e by default)
exp(1) # Exponential function
log(3) # Natural log

## ------------------------------------------------------------------------
help(rt) # Learn about the command for the t-distribution

help.search("rt") # Objects matching rt (note the quotes)

                  # apropos returns a vector of objects that fuzzy match 
apropos("which")  # "which" in the search list (note the quotes)

?glm  # A short cut to the help command for glm

??glm # Everything matching glm on the search path 

## ------------------------------------------------------------------------
# Set the seed of the random number generator to my Mum's birthday
set.seed(19390909)
# Generate some standard normals (in this case 25 Z's)
rnorm(25)
# You can assign (save) the results of a calculation into a variable
# The variable "a" will be a vector with 25 elements
a <-  rnorm(25)

## ------------------------------------------------------------------------
# Have a look at what is in "a" now
print(a)
# Basic statistical summaries of "a"
summary(a)
# Manipulate a: here we are squaring it
b <- a^2

## ----basic-plots,fig.width=4,fig.height=4,out.width='.45\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
# Create histograms of "a" and "b"
hist(a)
hist(b)

## ------------------------------------------------------------------------
# Make a vector of values by using the "c" (combine) function 
var1 <- c(21.2,15.6)
var2 <- c("Ford F-150", "Corvette")
var3 <- c(TRUE,FALSE)
# You can ask what type of data R thinks any variable is with 
# the "class" function.
# You can  have multiple commands on the same line separated by ";"
class(var1); class(var2); class(var3)

## ------------------------------------------------------------------------
# A named vector of GPA's 

gpas <- c("Math" = 3.4, "Verbal" = 3.7, "Analytics" = 3.9)

print(gpas) # Note the output contains the names

## ------------------------------------------------------------------------
# Create two vectors, x and y 
x <- c(1,2,3,4); y <- c(1,4,2,6)

# Add the numbers element-wise
x + y

# Multiply the numbers element-wise
x * y

# Divide x by y element-wise
x / y

## ------------------------------------------------------------------------
# We will apply the "sum" function to each of the three vectors 
sum(var1)
sum(var2)
# Notice that you can't add up character data
 sum(var3)
# Notice that TRUE/FALSE is converted/coerced to 1/0 for summing

## ------------------------------------------------------------------------
mean(var1); mean(var2) ;mean(var3)

## ------------------------------------------------------------------------
# Entering this data as a factor 
# Notice below that you can add comments at the end of a line too
opinions <- factor(
	x = c(4,5,3,4,4,5,2,4,1,3),   # the data
	levels = c(1,2,3,4,5),        # the possible values
	labels = c("definitely no","probably no",
			"maybe", "probably yes",
			"definitely yes"),# labels for each level
	ordered = TRUE)
print(opinions)

## ------------------------------------------------------------------------
x <- c(1,2,3); y <- c(3,2,1)
x < y ; x <= y
x > y ; x >= y
x == y; x != y

## ------------------------------------------------------------------------
x <- c(TRUE,TRUE,FALSE,FALSE); y <- c(TRUE,FALSE,TRUE,FALSE)
x | y 
x & y
!y

