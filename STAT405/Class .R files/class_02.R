
## ------------------------------------------------------------------------
# A sequence of numerics
c(5.2,7.6,15.1)
# A vector of  numerics stored into a variable
my.vec <- c(5.2,7.6,15.1)
# A vector of characters
my.sons <- c("Alex","Tom","David")
# A vector of logicals
logic.vec <- c(FALSE,TRUE,TRUE,FALSE)

## ------------------------------------------------------------------------
my.vec1 <- c(5.2, 7.6, 15.1)  # A vector of  numerics 
my.vec2 <- c(4, 21.2, 10) # A vector of  numerics 
my.vec3 <- c(my.vec1, my.vec2) # The concatenation of the two vectors
print(my.vec3)

### What if you try and combine vectors of different types?
my.sons <- c("Alex","Tom","David")  # A vector of characters
c(my.vec3,my.sons)    # R coerces the numbers to characters
# Note the quotes around the numbers
c(my.vec3,logic.vec)  # And coerces logicals to numerics

## ------------------------------------------------------------------------
a <- c(1:4)       # A consecutive sequence of integers. Use ":"
print(a)
b <- seq(1,4,.5)  # A sequence with spacings of 0.5. The "seq" function.
print(b)
# The "rep" function creates a sequence of replicates
d <- c(rep(10,5),rep(4,2)) 
print(d)
# The "length" function tells you how many elements are in the vector
length(d)

## ------------------------------------------------------------------------
# letters is a built in character vector containing the lowercase letters
# Store them in a variable because I will mess with them
my.letters <- letters 
my.letters  
length(my.letters)

## ------------------------------------------------------------------------
my.letters[1:10]         # The first ten letters
my.letters[c(1,10,26)]   # The first, tenth and last letters

# You can also extract using a logical vector
my.letters[c(1:26) %%2 == 1] # Every other letter

## ------------------------------------------------------------------------
my.letters[c(FALSE,TRUE,rep(FALSE,24))] # Extraction by logicals

## ------------------------------------------------------------------------
# When the extraction logical vector is not of length 26, 
# R will automatically recycle it
# This can give lots of surprising results
my.letters[c(TRUE,FALSE)]  
# You can drop elements of a vector using the "-" prefix 
new.letters <- my.letters[-c(1,2)] #I dropped the first two letters
print(new.letters) 

## ------------------------------------------------------------------------
# A named vector of GPA's 
gpas <- c("Math" = 3.4, "Verbal" = 3.7, "Analytics" = 3.9)

gpas["Verbal"]

## ------------------------------------------------------------------------
# Replacement of vector elements works the same way by using indexing
my.letters[1] <- "A"  # I replaced the first a with A
my.letters
my.letters[c(4, 6, 1)] <- "Hello" # Replacing some arbitrary elements
my.letters

## ----echo=FALSE,results='hide'-------------------------------------------
#### In-class 1

##### Parameters of the simulation
source("in_class_01.r")

## ------------------------------------------------------------------------
# Entering into R
my.matrix <- matrix( # The function is called "matrix"
		data = c(5,8,7,2,6,9,4,2,5,3,5,4),   #The raw data 
		nrow = 4, # The number of rows
		ncol = 3) # The number of columns
print(my.matrix)

## ------------------------------------------------------------------------
my.matrix <- matrix( # The function is called "matrix"
		data = c(5,8,7,2,6,9,4,2,5,3,5,4),   #The raw data
		nrow = 4,   # The number of rows
		ncol = 3,   # The number of columns
		byrow=TRUE) # Filling up the matrix, one row at a time
print(my.matrix)

## ------------------------------------------------------------------------
colnames(my.matrix) <- c("Alpha", "Beta", "Gamma")
rownames(my.matrix) <- c("North","East","South", "West")
print(my.matrix)
colnames(my.matrix)
rownames(my.matrix)

## ------------------------------------------------------------------------
my.matrix[4,2] 		# Extract a single element
my.matrix[,3]  		# Extract a single column
my.matrix[2,]  		# Extract a single row

## ------------------------------------------------------------------------
my.matrix[,c(2,3)]		#Extract columns 2 and 3. 
my.matrix[c(1,3),c(2,3)]	#Extract rows 1 and 3, columns 2 and 3. 

## ------------------------------------------------------------------------
dim(my.matrix)
dim(my.matrix[,3])	# Extract a single column and report dimensions

## ------------------------------------------------------------------------
my.matrix[,3,drop=FALSE]  # Extract a single column, but keep as matrix
dim(my.matrix[,3,drop=FALSE]) # A matrix with just one column.

## ------------------------------------------------------------------------
my.matrix[,c("Alpha","Gamma")]
my.matrix["West",c("Alpha","Gamma"),drop=FALSE]

## ------------------------------------------------------------------------
my.array <- array(c(1:24),dim = c(2,4,3)) # Three, 2 x 4 matrices
print(my.array)

## ------------------------------------------------------------------------
a <- matrix(c(1,3,5,7),ncol=2); b <- matrix(c(4,2,5,3,1,5),ncol=3)
a %*% b  # Matrix multiply (dimensions must be compatable)
t(b)     # Matrix transpose 

## ------------------------------------------------------------------------
solve(a) # matrix inverse
#Many functions will work elementwise on a matrix
log(a)   # The log of each element in the matrix
a > 4    # comparison operator applied to each element

## ------------------------------------------------------------------------
print(b)
# Apply the function "sum" to the rows of the matrix
apply(b,   # the matrix
	  MARGIN = 1,   # The margin,  1 for rows, 2 for columns
	  FUN = sum)    # The chosen function to apply, here "sum"
# Apply the function "mean" to each column.
apply(b,2,mean)

## ------------------------------------------------------------------------
# A list with a vector, a matrix and a logical vector
my.list <- list(x = seq(10), y = matrix(rnorm(16),ncol=4), 
                z = rep(c(TRUE,FALSE),c(3)))
# Pull out the second element
my.list[2]   # But it is still a list!
class(my.list[2])

## ------------------------------------------------------------------------
my.list[[2]] # Is the actual matrix itself, note its class below
class(my.list[[2]])

## ------------------------------------------------------------------------
my.list["z"]   # Accessing by name (note the quotes)
my.list[["z"]]   # Accessing by name (note the quotes)
my.list$z    # Or, another way of accessing a list element by name

## ------------------------------------------------------------------------
lapply(my.list,   # The list
       FUN = sum) # The function I am applying to each element (sum)

## ------------------------------------------------------------------------
my.list[c(1,3)]   # OK
my.list[[c(1,3)]]    # Not what you thought! 
# In fact, this is the third entry in the first element of the list.
# So called "recursive extraction".

## ------------------------------------------------------------------------
my.list[1] <- "Hello"     # Replace the first element
my.list["d"] <- "Goodbye" # Add an element called "d"
my.list$e <- "That's it!" # Add another called "e"

names(my.list) # Returns all the names in the list
names(my.list)[3] <- "Logical array" # Overwrite a name
names(my.list)

## ------------------------------------------------------------------------
x <- rnorm(100); y <- rnorm(100)  # A predictor and outcome variable
lm.out <- lm(y ~ x) # Our first regression model in R!
#lm.out contains the output from the regression model
class(lm.out) # What class is the output?
attributes(lm.out) # This function returns the attributes of an object

## ------------------------------------------------------------------------
lm.out["coefficients"]  # A list with a single element, the coefficients 
lm.out[["coefficients"]] # The actual coefficients themselves
lm.out$coefficients     # The common way to get at the coefficients

## ------------------------------------------------------------------------
codebook <- list() # Start with an empty list

#Now start adding question meta info to it.

codebook[["q1"]] <- list(LENGTH=3, 
                            LONGNAME="Purchase activity",
                            SHORTNAME="Purchase")
codebook[["q2"]]  <- list(LENGTH=2, 
                            LONGNAME="Make of purchased vehicle",
                            SHORTNAME="Make")
codebook[["q3"]]  <- list(LENGTH=3, 
                            LONGNAME="I attend this Auto Show",
                            SHORTNAME="Attendance")
codebook[["q4"]]  <- list(LENGTH=3, 
                            LONGNAME="I decided to attend the Auto Show",
                            SHORTNAME="Attend decision")

## ------------------------------------------------------------------------
codebook[["q4"]] # All the information about a question
codebook[["q4"]][[2]] # The actual question text itself
# Note you can chain the [[ operator to drill further into the structure

