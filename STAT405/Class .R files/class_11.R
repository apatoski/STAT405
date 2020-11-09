## ----echo=FALSE,results='hide'-------------------------------------------
# some setup
options(width=60)  # make the printing fit on the page
set.seed(1121)   # make the results repeatable

## ------------------------------------------------------------------------
timer.start <- function(name = "Timer 1"){ # A single argument 
  a <- Sys.time() # Save the current time into "a"
  return(list(NAME = name, START = a))  # Return the list
}

timer.stop <- function(st){ # "st" is the output from "timer.start"  
  b <- Sys.time() # Save the current time
  elapsed.time <- b - st[["START"]] # Work out the elapsed time
  print (paste(st[["NAME"]], "took:", # A human readable message
               elapsed.time, attributes(elapsed.time)$units)) 
  invisible(elapsed.time) # Return the timer difference invisibly
}

## ------------------------------------------------------------------------
# Read in the function and check out its arguments
source('C:/Users/richardw/Dropbox (Penn)/Teaching/705s2019/Data/class_10_sim_as_function.r')
args(effort.sim) # Print out the arguments

## ------------------------------------------------------------------------
### Create variables holding the directory and file name
### of the simulation function 
my.location <- 'C:/Users/richardw/Dropbox (Penn)/Teaching/705s2019/Data/'
my.file.name <- "class_10_sim_as_function.r"

#Read in the function itself
source(paste(my.location, my.file.name,sep=""))

#### Check that the effort simulation function is working
res1 <- effort.sim(X = 10, n.infringers = 1000, 
                   n.weeks = 52, het.choice=1)

## ------------------------------------------------------------------------
# Load the "parallel" package 
library(parallel) # The parallelization package

# Detect the number of cores on a machine (for curiosity)
num.cores <- detectCores()   
print(num.cores) # How many do we have?
# Get the timer started
t1 <- timer.start("Parallel computation timer") # Start timing

## ------------------------------------------------------------------------
# Fire up the cluster, making use of 4 cores
my.cluster <- makeCluster(spec = 4) 
# Set the random number generator for the cluster.
# This is subtle as you would not want each node to 
# use the same seed.
clusterSetRNGStream(cl = my.cluster, iseed = 19390909) 

#### I am not using either of these commands in this instance, 
#### but often do.
#### Export objects that the individual nodes need to know about 
# clusterExport(cl = my.cluster, c("objects.to.be.exported")) 

####  Code to be executed when each node of the cluster 
####  fires up (initialization)
####  "require" is an alternative to the "library" function
####  If the package doesn't exist, it returns a warning, not an error.
# clusterEvalQ(cl = my.cluster, expr = require(lme4))
####  Now the "lme4" package is  loaded on each node        

## ------------------------------------------------------------------------
#### The key command for the parallel implementation. 
#### Apply the function "fun" on each node of the cluster, 
#### with an argument, X, that varies with the level
#### of effort
#### par(allel)L(ist)applyL(oad)B(alance)

results <- parLapplyLB(cl = my.cluster, 
                       X = seq(100,1000,100), 
                       fun = effort.sim, 
                       n.infringers = 10000,
                       het.choice=1)
# Shut down the cluster
stopCluster(cl = my.cluster)

## ------------------------------------------------------------------------
#### Make sure everything returned without any errors by 
#### checking we have numeric answers
success <- sapply(results, is.numeric)
print(success)

#### Combine the individual columns in the result matrices 
#### with the "cbind" command
#### "do.call" creates a function call from "what" and "args"
big.result <- do.call(what = cbind, args = results[success])

### Stop timing
timer.stop(t1)

## ------------------------------------------------------------------------
head(big.result,4)

## ------------------------------------------------------------------------
library(animation)
ani.record(reset = TRUE) # clear history before recording
#### Create the plots:
for (i in 1:ncol(big.result)) { # Iterate over the columns
      plot(big.result[,i],      # Make a plot for each column
      main= paste("Effort level",colnames(big.result)[i]),
      xlab = "Week",
      ylab = "Infingers",
      ylim = c(0, 10000),
	  )                 
      ani.record()              # Record the current frame
    }

## ------------------------------------------------------------------------
oopts = ani.options(interval = 0.25)
# Have a look at the animation  in R
# ani.replay()

# Create a webpage to display the animation
saveHTML(ani.replay(), img.name = "record_plot")

# The animation package has many other options 
# for saving the output, animated GIFs etc.

