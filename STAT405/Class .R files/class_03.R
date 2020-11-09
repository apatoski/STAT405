## ----echo=FALSE,results='hide'-------------------------------------------
# some setup
options(width=60)  # make the printing fit on the page
set.seed(1121)   # make the results repeatable

## ------------------------------------------------------------------------
my.vec1 <- c(5.2, 7.6, 15.1,12)  # A vector of  numerics 
my.vec2 <- c("Male","Male","Female","Female") # A vector of  characters 
my.vec3 <- c(TRUE, FALSE,TRUE,FALSE) # A vector of logicals

my.df      <- data.frame(
		Numbers = my.vec1,
		Gender = my.vec2,
		Logicals = my.vec3
		)
summary(my.df) #The summary function describes each variable		

## ------------------------------------------------------------------------
#### Extract the Gender column and look at its type 
class(my.df$Gender) 

## ------------------------------------------------------------------------
#### You can coerce a factor to a character vector if you want.
new.gender <- as.character(my.df$Gender)
class(new.gender)
#### This can be important because some functions only work on characters. 

## ------------------------------------------------------------------------
#Extract the 2nd & 3rd columns, 1st & 2nd rows
my.df[c(1,2),c(2,3)] # A piece of the data frame
#The dim command tells you the size of the data frame
dim(my.df)

## ------------------------------------------------------------------------
my.df <- cbind(my.df,"New column" = c(1,2,3,4)) #Add a column
my.df <- rbind(my.df, c(1,"Male",FALSE,1.1))    # Add a row
print(my.df)

#### Be careful. For factors you can't directly add new levels. 
#### The levels must already exist.

my.df <- rbind(my.df, c(1,"No answer",FALSE,1.3))

## ------------------------------------------------------------------------
my.df[6,"Gender"] <- "Male"
print(my.df) 

## ------------------------------------------------------------------------
#You need to substitute your own directory path here
#Note the double \\. An alternative is to use "/" in the path  
my.data <- read.csv(
file = 
 "C:\\Users\\richardw\\Dropbox (Penn)\\Teaching\\705s2019\\Data\\Pharma_EV.csv"
	)
head(my.data,5) #The head command lets you see the top of a file. 

## ------------------------------------------------------------------------
# Note the http prefix indicating a remote source
gala.data <- read.csv(file="http://mathmba.com/richardw/gala.csv")
head(gala.data,n=3)
# It would be a good idea to fix up the column names 
# with the colnames command

## ------------------------------------------------------------------------
ip.table <- table(gala.data$IP.Address) #Create the table  
print(ip.table[1:10]) # Look at just the first 10 entries

## ------------------------------------------------------------------------
# The sort command has an argument, "decreasing" that controls the order
# We sort first, then pull off the top 15
sort(ip.table,decreasing = TRUE)[1:15]

## ------------------------------------------------------------------------
#Special characters may need to be escaped \\. for .
strsplit(gala.data[,"IP.Address"],"\\.") 
# But strsplit will only work on characters, not factors
# This works and returns a list (I'm just getting the first 3 elements)
strsplit(as.character(gala.data[,"IP.Address"]),"\\.")[1:3] 

## ------------------------------------------------------------------------
# Notice how you can chain the functions together.
# The output of one command becomes the input to the next. 
unlist(strsplit(as.character(gala.data[,"IP.Address" ]),"\\.")) 

## ------------------------------------------------------------------------
#Step 3. #Read in the database connection library
library(RODBC)
#Step 4. connect to database 
my.channel <- odbcConnect("STAT705X", uid="stat705_student", 
					pwd="$[h0CC*TtKO~");
#Step 5. Run the SQL query using the SELECT SQL command to get data 
query.result <- sqlQuery(channel = my.channel, 
                 query = "SELECT * FROM RESPONSES")
head(query.result,3) # A look at what's in the result data frame
close(my.channel);

## ----basic-plots,fig.width=4,fig.height=4,out.width='.75\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
pie(table(query.result$Q3)) # Just for fun, make a pie chart

