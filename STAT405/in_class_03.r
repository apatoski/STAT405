
#### Timer functions
timer.start <- function(name = "Timer 1"){ # A single argument 
  a <- Sys.time() # Save the current time into "a"
  return(list(NAME = name, START = a))  # Return the list
}

timer.stop <- function(st){ # "st" is the output from "timer.start"  
  b <- Sys.time() # Save the current time
  #Now print out the name of the timer and elapsed time
  elapsed.time <- b - st[["START"]]
  print (paste("TIMER [", st[["NAME"]], "] took: ", elapsed.time, " ", attributes(elapsed.time)$units, ".",sep="")) 
  return(invisible(elapsed.time))
}

#Matrix inverse timing
t1 <- timer.start("Matrix inverse timer")
tmp <- solve(matrix(rnorm(4000000),ncol=2000))
timer.stop(t1)


# Some test code
t1 <- timer.start("test")
Sys.sleep(2)
timer.stop(st = t1)

#Sys.sleep(62)
#timer.stop(st = t1)
  

 
 
 
