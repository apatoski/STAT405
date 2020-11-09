#### In-class 1

##### Parameters of the simulation
num.its <- 10000    # The number of iterations
set.seed(20180828)  # Set the seed for reproducibility

##### The average number of hurricanes in Tokyo and the US
mean.tokyo <- 3
mean.us    <- 1.75

##### The out-of-business cut-off
aob <- 8

##### The number of total hurricanes across the two countries
total.hurricanes <- rpois(num.its, mean.tokyo) + rpois(num.its, mean.us)

##### Did a year have "aob" (out-of-business) or more hurricanes?
bad.years <- (total.hurricanes >= aob)

##### What proportion of years was this?
##### You can add logical variables (they are converted to 0 for FALSE and 1 for TRUE)
est.prob <- sum(bad.years)/num.its

##### Print out the result
print(est.prob)

#### The problem as stated is completed.

