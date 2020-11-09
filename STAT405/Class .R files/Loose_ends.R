#### What does invisible do?

#### A very simple function:

myfun1 <- function(x){
  return(x)
}
myfun1(rnorm(10))

#### When the "invisible" command is used on the object to be returned, 
#### it is returned but not printed. However it can still be assigned.

myfun2 <- function(x){
  return(invisible(x))
}
myfun2(rnorm(10))

####################################
#### The difference between & and &&
####################################

a <- c(TRUE,TRUE,FALSE,FALSE)
b <- c(TRUE,FALSE,TRUE,FALSE)

a & b   # All elements are compared
a && b  # Only the first is compared

FALSE & 1         # This returns FALSE, by coercion of 1 to TRUE.  
FALSE & print(1)  # Both arguments are evaluated and we get to see the "1" printed.

FALSE && 1
FALSE && print(1) # Notice that this time, the print statement is not evaluated,
                  # because the first element being FALSE, is enough to know that the answer must be FALSE.
                  # So the "long form", "&&", doesn't evaluate both arguments unless it has to.
                  # Likewise with "||" rather than "|".



