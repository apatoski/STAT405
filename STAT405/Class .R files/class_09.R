## ------------------------------------------------------------------------
#### Ten realizations:
set.seed(20190221)
rbinom(n = 10, size = 1,prob = 0.5) #10 Bernoullis with probability of success 0.5
rbinom(n = 10, size = 5, prob =  0.5) #10 Binomials, size = 5, with probability of success 0.5
rpois(n = 10,lambda = 4) # 10 Poisson with mean  = 4

## ------------------------------------------------------------------------
#### Ten realizations:
                 # 10 hypergeometric rvs. Draw 3 from an urn with 
rhyper(nn=10,m=5,n=5,k=3) # 5 whites and 5 blacks, and count the whites.
rgeom(n = 10,prob = 0.2)    # 10 geometrics, with probability of success 0.2. 

## ------------------------------------------------------------------------
#### Ten realizations:
rnorm(n=10,mean=5,sd=2) # 10 normals with mean 5, sd 2.
runif(n=10,min=2,max=4) # 10 uniforms between 2 and 4. 
rbeta(n=10,shape1=2,shape2=3) # 10 betas with shape parameters 2 and 3.

## ------------------------------------------------------------------------
rexp(n=10,rate=3) # 10 exponentials with rate 3.
rgamma(n=10,shape=2,rate=3) # 10 gammas with shape 2 and rate 3
rweibull(n=10,shape=2,scale=3) # 10 Weibulls with shape 2 and scale 3

## ----basic-plots,fig.width=4,fig.height=2.5,out.width='.75\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
hist(rweibull(10000,2,3))   # Have a look at the distribution

## ------------------------------------------------------------------------
rpois(n=10,lambda = 1) # Generate 10 Poissons, all with mean 1.
# generate 10 Poissons each with their own mean.
rpois(n=10,lambda=c(1,2,3,4,5,6,7,8,9,10)) 

## ------------------------------------------------------------------------
n.people  <- 1000 # The number of people

pers.acc.rate <- rgamma(n = n.people, 
                        shape = 4/9, rate = 4/9) #Personal accident rates
actual.accidents <- rpois(n = n.people,
                              lambda = pers.acc.rate) #Actual accidents

## ----pois-mix,fig.width=4,fig.height=2.5,out.width='.45\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
hist(rpois(1000,1))
hist(actual.accidents)

## ------------------------------------------------------------------------
#Read in some data
my.fx <- read.csv(file=
         'C:/Users/richardw/Dropbox (Penn)/Teaching/705s2019/Data/FX_OIL_CAD.csv')
#Create returns
USO.ret <- diff(my.fx$USO)/my.fx$USO[-length(my.fx$USO)]
FXC.ret <- diff(my.fx$FXC)/my.fx$FXC[-length(my.fx$FXC)]
cor(USO.ret,FXC.ret) # The correlation between returns

## ----USO.FXC,fig.width=4,fig.height=2.5,out.width='.75\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
plot(USO.ret,FXC.ret)
lm.out <- lm(FXC.ret ~ USO.ret) # Find the regression line
abline(lm.out) # add it to the plot

## ------------------------------------------------------------------------
mean.uso <-  mean(USO.ret) # Mean of USO returns
mean.fxc <-  mean(FXC.ret) # Mean of FXC returns 
covar.uso.fxc <- var(cbind(USO.ret,FXC.ret)) # The var/covar matrix
mean.uso
mean.fxc
covar.uso.fxc

## ------------------------------------------------------------------------
library(MASS) #More on libraries later
n.days <- 250
rets <- mvrnorm(n.days, mu = c(mean.uso, mean.fxc), Sigma = covar.uso.fxc)
apply(rets,2,mean)
 #We get the right mean
var(rets)  # We get the right var/covar structure 

## ----sim.USO.FXC,fig.width=4,fig.height=2.5,out.width='.75\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
plot(rets[,1],rets[,2],xlab="USO.ret",ylab="FXC.rt") # Plot the simulated returns 
lm.out.two <- lm(rets[,2] ~ rets[,1]) # Find the regression line
abline(lm.out.two) # add it to the plot

## ------------------------------------------------------------------------
sample(x=10) # A random permutation of the numbers 1:10
# sample of size 20 from the numbers 1 though 10
sample(x=10,size = 20, replace=TRUE)  
sample(x=10,size = 20, replace=FALSE) # Bombs

## ------------------------------------------------------------------------
#Sample 20 observations, from 3 categories with specific probabilities
sample(x = c("YES","NO","MAYBE"),
       size= 20,
	   replace=TRUE,
	   prob = c(0.1,0.2,0.7) 
)

## ------------------------------------------------------------------------
# What's the probability that a Z is less than -1? 
pnorm(q = -1, mean = 0, sd = 1) 

## ------------------------------------------------------------------------
# What value of x has 0.025 probability to the left of it?
qnorm(p = 0.025, mean = 0, sd = 1) 

## ------------------------------------------------------------------------
summary(ecdf(actual.accidents))

## ----ecdf,fig.width=4,fig.height=2.5,out.width='.75\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
plot(ecdf(actual.accidents))

## ------------------------------------------------------------------------
#Find the 50th and 90th and 99th percentiles
quantile(x = actual.accidents, probs= c(0.5,0.9,0.99))

## ----normquant,fig.width=4,fig.height=2.5,out.width='.65\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction

x <- rnorm(n=1000,mean = 3,sd = 2) # Create 1000 normals and plot them
qqnorm(x) # The normal quantile plot
qqline(x) # Add the reference line

## ----tquant,fig.width=4,fig.height=2.5,out.width='.65\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction

x <- rt(n=1000,df = 3) # Create 1000 t-3s
qqnorm(x) # The normal quantile plot
qqline(x) # Add the reference line

## ----qqplot,fig.width=4,fig.height=2.5,out.width='.65\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction

x1 <- rt(n=1000,df = 3) # Create 1000 t-3s
y1 <- rt(n=1000,df = 10) # Create 1000 t-10s
qqplot(x1,y1) # The qq plot

