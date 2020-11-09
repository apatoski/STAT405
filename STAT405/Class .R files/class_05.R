## ----echo=FALSE,results='hide'-------------------------------------------
# some setup
options(width=60)  # make the printing fit on the page
set.seed(1121)   # make the results repeatable

## ------------------------------------------------------------------------
# A function to calculate the percent difference between two numbers
# 
percdiff <- function(first,second){ 
result <- (second - first)/first * 100 # The calculation itself

#The "sprintf" function gives you complete control over output formatting 
#Three places of decimals followed by a % sign
#It will return a "character" so not useful for further calculations!
 
final.result <- sprintf("%.3f%%",result) 
return(final.result) #Explicitly return the result
}
percdiff(first = 5, second = 4) # Now call the function

## ------------------------------------------------------------------------
body(percdiff) # The body of the function
formals(percdiff) # The arguments to the function
environment(percdiff) # The environment in which the function was called

## ------------------------------------------------------------------------
#There are many ways to call this function:
percdiff(first = 3, second = 4) # Naming the arguments explicitly
percdiff(3,4) # Dropping the arguments in directly, not named
percdiff(second = 4, first = 3) # When named, order doesn't matter
percdiff(second = 4,3) # Naming one, not the other
percdiff(s = 4, f = 3) # Abbreviating the names (particularly dangerous)

## ------------------------------------------------------------------------
percdiff(first = 3, second = 4) # Naming the arguments explicitly

## ------------------------------------------------------------------------
mostoften <- function(x){
result <- sort(table(x),decreasing=TRUE)[1]
return(result)
}

# Fake some data to illustrate use of the function
set.seed(20160328)
#The "sample" command below will be the workhorse of Monte Carlo
a <- as.factor(sample(x=LETTERS,size=1000,replace=TRUE))
mostoften(x=a) # the argument named "x", takes on the value "a".

## ------------------------------------------------------------------------
mostoften <- function(x,n=1){ #Pick off the top n items, default = 1 item
result <- sort(table(x),decreasing=TRUE)[1:n]
return(result)
}
mostoften(x=a) #Called with the default n = 1
mostoften(x=a,n=3) #Called with the n = 3

## ------------------------------------------------------------------------
mostoften <- function(x,n=1){ #Pick off the top n items, default = 1
#The next line will look at the argument to see if it is a factor variable
#We haven't discussed "if" yet, but will do so soon.
if(!is.factor(x)){ #The "is.factor" function returns TRUE or FALSE
	stop("RW: This function is only meant to work on factors!")
	}
result <- sort(table(x),decreasing=TRUE)[1:n]
return(result)
}
b <- rnorm(100) #Create a numeric variable and try out the function
mostoften(x = b, n = 3)

## ------------------------------------------------------------------------
mostoften <- function(x,n=1){ #Pick off the top n items, default = 1
  if(!is.factor(x)){
    warning("RW: This function is only meant to work on factors!
            I am going to coerce it to one.")
    x <- as.factor(x) #Coercion
  }
  result <- sort(table(x),decreasing=TRUE)[1:n]
  return(result)
}
b <- rnorm(100)#Create a numeric variable and try out the function
mostoften(x = b, n = 3)

## ------------------------------------------------------------------------
a <- 10
f1 <- function(x){ #This is only a  function of x
x + a
}
f1(x = 5)  #This function finds "a" in the global environment
a <- 20    #But, some joker changes a, and now
           #the function no longer gives the same answer as before, 
           #even though the function call is identical. 
f1(x = 5) 		  

## ------------------------------------------------------------------------
mostleast <- function(x){
#The first element in the sorted table
least.freq <- sort(table(x))[1] 
#The last element in the sorted table
most.freq <- sort(table(x))[length(table(x))]
#Now make the list and return it
return(list(LEAST = least.freq, MOST = most.freq)) 
}
set.seed(20160328) #Create some data again
a <- as.factor(sample(x=LETTERS,size=1000,replace=TRUE))
mostleast(x = a)

## ------------------------------------------------------------------------
my.matrix <- matrix(rnorm(100),ncol=10)
apply(X = my.matrix, MARGIN = 1, FUN = mean)

## ------------------------------------------------------------------------
my.matrix[1,1] <- NA # make the first element an NA
apply(X = my.matrix, MARGIN = 1, FUN = mean)

## ------------------------------------------------------------------------
#Using the ... argument.
apply(X = my.matrix, MARGIN = 1, FUN = mean, na.rm = TRUE)

## ------------------------------------------------------------------------
#Passing multiple arguments to the "mean" function
apply(X = my.matrix, MARGIN = 1, FUN = mean, na.rm = TRUE, trim = 0.1)

