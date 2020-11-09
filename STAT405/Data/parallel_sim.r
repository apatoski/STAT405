### Create variables holding the directory and file name
### of the simulation function 
my.location <- "C:\\Users\\richardw\\Dropbox\\Teaching\\705s16\\Data\\"
my.file.name <- "class_10_sim_as_function.r"

#Read in the function itself
source(paste(my.location, my.file.name,sep=""))

#### Check that the effort simulation function is working
#effort.sim(X = 1000, n.infringers = 100000, n.weeks = 52, het.choice=1)

library(parallel) # The parallelization library

# Detect the number of cores on a machine (for curiosity)
num.cores <- detectCores()   

t1 <- timer.start("Parallel computation timer") # Start timing

# Fire up the cluster, making use of 4 cores
my.cluster <- makeCluster(spec = 4) 
#Set the random number generator for the cluster
clusterSetRNGStream(cl = my.cluster, iseed = 19390909) 

#### I am not using either of these commands in this instance, but often do.
### Export objects that the individual nodes need to know about 
# clusterExport(cl = my.cluster, c("to.be.exported")) 
### Code to be executed when each node of the cluster fires up (initialization)
# clusterEvalQ(cl = my.cluster, require(lme4))        

#### The key command. Apply the function on each node of the cluster, 
####                  with varying arguments
results <- parLapplyLB(cl = my.cluster, 
                       X = seq(100,1000,100), 
					   fun = effort.sim, 
					   n.infringers = 10000,
					   het.choice=1)

# Shut down the cluster
stopCluster(cl = my.cluster)

#### Make sure everything returned without any errors by checking we have numeric answers
success <- sapply(results, is.numeric)

#### Combine the individual columns in the result matrices with the "cbind" command
big.result <- do.call(what = cbind, args = results[success])

### Stop timing
timer.stop(t1)

#### Load the animation library
library(animation)
ani.record(reset = TRUE) # clear history before recording
#### Create the plots:
for (i in 1:ncol(big.result)) {
      plot(big.result[,i], 
      main= paste("Effort level",colnames(big.result)[i]),
	  xlab = "Week",
	  ylab = "Infingers",
      ylim = c(0, 10000))
	  ani.record() # record the current frame
    }
oopts = ani.options(interval = 0.25)
ani.replay()
# Create a webpage to display the animation
saveHTML(ani.replay(), img.name = "record_plot")





