## ----echo=FALSE,results='hide'-------------------------------------------
# some setup
options(width=60)  # make the printing fit on the page
set.seed(1121)   # make the results repeatable

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
mostleast(a)

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

## ------------------------------------------------------------------------
#How long does it take to invert a 2000 x 2000 random matrix? 
system.time(
solve(matrix(rnorm(4000000),ncol=2000))
)

## ------------------------------------------------------------------------
Sys.time() #What's the time?

## ------------------------------------------------------------------------
a <- Sys.time()
print ("I am reading a book for 5 seconds")
Sys.sleep(5) #This command suspends R for 5 seconds.

b <- Sys.time()
b - a # The elapsed time

## ------------------------------------------------------------------------
var1 <- "Richard"
var2 <- "Penn"
var3 <- 45
out.text <- paste(var1, "works at", var2 , 
				"and it takes him", var3, 
				"minutes to drive to work") 
print(out.text)

## ------------------------------------------------------------------------
t1 <- timer.start("Matrix inverse timer")
tmp <- solve(matrix(rnorm(4000000),ncol=2000))
timer.stop(t1)


## ------------------------------------------------------------------------
#Step 3. #Read in the database connection library
library(RODBC)  
#Step 4. connect to database 
my.channel <- odbcConnect("STAT705X", uid="stat705_student", 
					pwd="$[h0CC*TtKO~")
#Step 5. Run the SQL query using the SELECT SQL command to get data 
query.result <- sqlQuery(channel = my.channel, 
                 query = "SELECT * FROM TIMINGS")
head(query.result,3) # A look at what's in the result data frame
close(my.channel) # Closing the connection

## ------------------------------------------------------------------------
#Load in the ".Rdata" structure that contains this data frame 
#Note the slightly different format than reading in a .csv file 
#with "read.table"
 
load(url("http://mathmba.com/richardw/infection.Rdata"))
dim(infection) # Lots of columns to look at.

## ------------------------------------------------------------------------
is.dichotomous <- function(x){ #x is the input column
tmp <- table(x) # Make a table of the frequencies of the values in x
if(length(tmp) == 2){
  return(TRUE) #If there are two elements then it is dichotomous
  }            #and we immediately quit and return the result 
return(FALSE)  # Otherwise, it is not dichotomous and we return FALSE
}

## ------------------------------------------------------------------------
# Do some checking of the function
is.dichotomous(c(1,1,1))
is.dichotomous(c(1,1,1,2,2,2,2,2))
is.dichotomous(c("B","B","B","A","A","C"))
is.dichotomous(c("B","B","B","A","A","A"))

## ------------------------------------------------------------------------
#This code will identify the dichotomous columns
dichot.cols <- apply(infection,2,is.dichotomous) 
dichot.cols

## ------------------------------------------------------------------------
table(infection[,"Y"])   # Yes, dichotomous
table(infection[,"X3"]) # Yes, dichotomous
table(infection[,"X4"])# Not dichotomous

## ------------------------------------------------------------------------
#### This will create the example 2 x 2 table we saw earlier
x1 <- c( rep("NO",5),rep("YES",7))
y1 <- c(rep("NO",4),"YES",rep("NO",2),rep("YES",5)) 
table(x1,y1)   # Check the table to make sure it is correct

## ------------------------------------------------------------------------
logodds <- function(x,y){
  if (! (is.dichotomous(x) & is.dichotomous(y))){ #check arguments
    stop("RW: Both inputs need to be dichotomous!")
  }
  tmp.table <- table(x,y) # This is the 2 by 2 table
  lor <- log( # Here's where the calculation happens
    (tmp.table[1,1] * tmp.table[2,2]) / 
      (tmp.table[1,2] * tmp.table[2,1])  
  )
  return(lor)
}

## ------------------------------------------------------------------------
#### Test the function
#### It's a good idea to have some test cases for which you know the answer
#### Recall, we created x1 and y1 earlier on
table(x1,y1) #The inputs
logodds(x1, y1)# Check the  calculation. It should equal log(10)  

## ------------------------------------------------------------------------
result <- #We'll put the answer into "result"
sort( # Find the columns with the highest log odds ratios
  apply(
    infection[,dichot.cols], # Only work with the dichotomous columns
    2, # The function works on columns, not rows
    logodds, # The function we are applying
    y=infection[,"Y"] # But, our log-odds function takes two arguments.
    # We specify the second argument by using the ... slots	
  ), 
  decreasing = TRUE #The order in which I want the sort
)

## ------------------------------------------------------------------------
result[1:20] # The top 20 variables.
table(infection$X3,infection$Y) # have a look at one of the top variables
# Yes, it is hugely predictive

## ------------------------------------------------------------------------
ort <- timer.start("Odds ratio timer") #Start the timer

result <- #We'll put the answer into "result"
sort( # Find the columns with the highest log odds ratios
  apply(
    infection[,dichot.cols], # Only work with the dichotomous columns
    2, # The function works with columns, not rows
    logodds, # The function we are applying
    y=infection[,"Y"] # But, our function takes two arguments.
    # We specify the second argument by using the ...	
  ), 
  decreasing = TRUE #The order in which I want the sort
)
timer.stop(ort) #Stop the timer

