#### Create a simulation model of the infringement process.
#### Verbosity parameter
set.seed("09091937")

verbose <- TRUE       # Status updates
graphics <- FALSE     #  Write out graphs
results.tab <- FALSE  #  Write out tables behind graphs
isp.mode <- FALSE     #  If TRUE, we model n notices sent from the ISP to infringer.
                      #  If FALSE, we model n notices sent to the ISP.



#### Input paramters
#### Telstra (From PTGBS report)
#pop.size <- 3987400
#### Iinet (From 2011 annual report)
pop.size <- 640000
#### TPG (From 2011 annual report)
pop.size <- 548000
#### Primus (from online source: http://thebernoullitrial.wordpress.com/2010/08/07/australian-isp-market-share-2009-2010/)
pop.size <- 114600


isp.strings <- c("Telstra","Iinet","TPG","Primus")
isp.pop.sizes <- c( 3987400, 640000,  548000,  114600)


for (isp in 1:4){

isp.name <- isp.strings[isp]
pop.size <- isp.pop.sizes[isp]

#### Scale factor
scale.fac <- 10
##### Total subscribers
t.sub <- pop.size/scale.fac
##### Proportion initially infringing
p.inf <- 0.1
##### Infringing subscribers
i.sub <- floor(t.sub * p.inf)

##### The number of periods for the simulation
#### One week grace period.
#n.periods <- 104 + 1
#### Two week grace period.
#n.periods <- 52 + 1
#### Three weeks grace period
#n.periods <- 35 +1
#### Monthly (4 weeks) weeks grace period
n.periods <- 26 + 1


notices.per.month <- c(75,100,200,500,1000,2000) 
notices.per.three.weeks <- floor(notices.per.month *3/4)
notices.per.two.weeks <- floor(notices.per.month *2/4)
notices.per.one.week  <- floor(notices.per.month *1/4)

graph.x.factor <- c(4,3,2,1)


notices.per.period <- notices.per.month


##### How many infringers are identified each week 
#effort <- seq(0.051,0.1,0.001)
#effort <- c(0.044,0.074)
#effort <- c(0.05)
#effort <- c(0.01)

effort <- notices.per.period/(i.sub * scale.fac)


#### Assumptions.
#### How receiving notices impacts infringement. theta contains the probability of stopping on the given notice and
#### receiving the notice.
#### The first zero is for the fact that if you haven't seen any notices you won't stop infringing
#theta <-  c(0.0,0.15,0.1,0.67,0,0,0,0,0,0,0)
#theta <-  c(0.0,0.061,0.123,0.058,0.3,0.3,0.342,0,0,0,1) # Gives 100% chance of capture at period 10.
#theta <-  c(0.0,0.061,0.123,0.058,0.3,0.3,0.342,0,0,0,0) # Gives 75% chance of capture at period 6.
#theta <-  c(0.0,0.061,0.123,0.058,0.1,0.1,0.204,0,0,0,0,0) # Gives 50% chance of capture
#theta <-  c(0.0,0.061,0.123,0.058,0.065,0.0,0.0,0,0,0,0,0)  # Uses the Cox observed numbers, 27.5% chance.
#theta <-   c(0.0,0.124,0.145,0.080,0.083,0.371,0.371,0,0,0,0,0)  # Uses Cox + TimeWarner blend, 75% of stopping by notice 6.
#theta <-   c(0.0,0.124,0.145,0.080,0.083,0.204,0.204,0,0,0,0,0)  # Uses Cox + TimeWarner blend, 60% of stopping by notice 6.
#theta <-    c(0.0,0.124,0.145,0.080,0.083,0.11,0.11,0,0,0,0,0)  # Uses Cox + TimeWarner blend, 50% of stopping by notice 6.
#theta <-    c(0.0,0.124,0.145,0.080,0.083,0.371066,0.371066,0,0,0,0,0)  # Uses Cox + TimeWarner blend, 70% of stopping by notice 6.

#### Australian theta
theta <-    c(0.0,0.3,0.12,0.05)  # NERA/ SWEET base


theta <- c(theta,rep(0.0,(n.periods + 1) - length(theta)))
#### Allow for people to disappear (stop infringing even when not receiving a notice)
theta.zero <- 0.0

#### The maximum number of notices before sending no more.
max.notice <- n.periods
max.notice <- 4

#### Pass through. Not everyone sees the notice. What proportion sees each notice?
#### The first zero is for being sent zero notices, so no chance of getting one
pass.through <- c(0.0)
pass.through <- c(pass.through, rep(1.0,(n.periods) +1 - length(pass.through)))

#### Records the number with 5 or more notices and are still infringing at 1 and 2 years
results.mat.5.notices <- matrix(rep(0, 3 * 2 * length(effort)),ncol=3)

#### Record the frequency distribution of notices received at one and two years.
#### Three heterogeneity scenarios, x effort scenarios x 2 interim  calculation points x 5 points for the frequency distribution.
results.mat.freq.dist <- array(rep(0, 3 * length(effort) * 2 * 5),dim=c(3,length(effort),2,5),
                               dimnames =list( c("H1","H2","H3"),paste("Effort",ceiling(effort * i.sub) * scale.fac,sep=""),
                                               c("One_year","Two_years"),paste("F",c(0:4),sep="")))
 

#### Record the number of infringers at zero, one and two years.
#### Three heterogeneity scenarios, x effort scenarios x 3 interim  calculation points. 
results.mat.num.infr <- array(rep(0, 3 * length(effort) * 3),dim=c(3,length(effort),3),
                               dimnames =list( c("H1","H2","H3"),paste("N=",ceiling(effort * i.sub) * scale.fac,sep=""),
                                               c("Initial", "One_year","Two_years")))




counter <- 0
for(eff in effort)
{
counter <- (counter + 1)

print(paste("Effort is ",eff))
n.draw <- ceiling(i.sub * eff)

print(paste("Notices per period:", n.draw*scale.fac))

##### How many get sent a notice.
n.notice <- n.draw * 1.0

#### Assumption on selection probabilities.
#### Equal selection probabilities
#### Outlier removal appears here via their inclusion or exclusion in the heterogeneity modeling.
het.1 <- rep(n.draw/i.sub,i.sub)
#### Beta model, comcast-esqe
alpha <- 2
het.2 <- rbeta(i.sub,alpha,(alpha-0.002)/0.002)
alpha <- .1
het.3 <- rbeta(i.sub,alpha,(alpha-0.002)/0.002)
#### Empirical Comcast
#comcast.probs <-  read.table("Comcast.het.txt")
#het <- sample(c(1:length(unlist(comcast.probs)))/length(unlist(comcast.probs)),
#              i.sub,replace=TRUE,prob=unlist(comcast.probs))

het.mat <- cbind(het.1,het.2,het.3)

#### results.mat, records the number of infringers
results.mat <- matrix(rep(0, 3 * n.periods),ncol=3) 

for(k in 1:3){
print(paste("Heterogeneity scenario  is",k))
het <- het.mat[,k]
#### The three state matrices

#### Infringing
z <- matrix(rep(0,i.sub * n.periods),ncol=n.periods)
#### Observed infringing and received & viewed a notice
y <- matrix(rep(0,i.sub * n.periods),ncol=n.periods)
#### Observed infringing and sent a notice
x <- matrix(rep(0,i.sub * n.periods),ncol=n.periods)

#### Assumption 3.
#### At time period 1, everyone is infringing
z[,1] <- rep(1,i.sub)


cat("Number of infringers on iteration",1, "is",sum(z[,1]),"\n")
for( i in 1:(n.periods -1 )){

#### Prepare to draw a sample of infringers.
#### Only those infringing (z ==1) can be seen.
#### Sort users by infringement status

sort.vec <- order(z[,i],decreasing=TRUE)
x <- x[sort.vec,]
y <- y[sort.vec,]
z <- z[sort.vec,]
het <- het[sort.vec]


#num.inf <- sum(z[,i] == 1)

if(i == 1){
sent.so.far <- rep(0,dim(x)[1])
} else {
if(i == 2){
sent.so.far <- apply(x[,c(1:(i-1)),drop=FALSE],1,cumsum)
} else {
sent.so.far <- t(apply(x[,c(1:(i-1)),drop=FALSE],1,cumsum))[,i-1]
}
}

if(isp.mode){
notice.elig <- (z[,i] == 1) & (sent.so.far < max.notice)
}
else{
notice.elig <- (z[,i] == 1)
}

#### How many infringers do we have to choose from?
num.inf <- sum(notice.elig)


if(num.inf == 0){chosen <- c()}
if(num.inf == 1){chosen <- c(1:i.sub)[notice.elig]}
if(num.inf > 1){
if(isp.mode){
chosen <- sample(c(1:i.sub)[notice.elig], min(n.draw,num.inf), replace = FALSE, prob = het[notice.elig])
}
else{
#### Sample with replacement as the same user may be identified more than once by the vendor doing the scanning.
chosen <- sample(c(1:i.sub)[notice.elig], min(n.draw,num.inf), replace = TRUE, prob = het[notice.elig])
#### But then, a dupliacte user can receive at most a single notice within the grace period.
chosen <- unique(chosen)
}

} 


#### Update the infringers who get sent a notice
x[chosen,i] <- 1

#### Update the infringers receiving a notice
#### It depends on how many you have been sent (not received) before.
#### The cumsum function is sensitive to the dimensions of the x matrix.
if(i == 1){
sent.so.far <- apply(x[,c(1:(i)),drop=FALSE],1,cumsum)
} else {
sent.so.far <- t(apply(x[,c(1:(i)),drop=FALSE],1,cumsum))[,i]
}
#### Your chances of getting the notice depend on the pass through rate
y[,i] <- rbinom(dim(x)[1],1,pass.through[sent.so.far + 1]) * x[,i]


#### Now define z in the next time period
#### If you were not infringing, then you continue to not infringe
z[z[,i] == 0,(i+1)] <- 0

#### If you were infringing and did not receive a notice, 
#### then you continue to infringe with probability 1- theta.zero
still.inf.no.notice <- sum((z[,i] == 1) & (y[,i] == 0))
z[(z[,i] == 1) & (y[,i] == 0),(i+1)] <- rbinom(still.inf.no.notice,1,(1-theta.zero))
  
#### If you were infringing and were sent a notice,
#### then you continue to infringe with probability 
#### depending on the number of notices you have seen (not been sent) 

#### Update the number of infringers who have seen notices
if(i == 1){
seen.so.far <- apply(y[,c(1:(i)),drop=FALSE],1,cumsum)
} else {
seen.so.far <- t(apply(y[,c(1:(i)),drop=FALSE],1,cumsum))[,i]
}
still.inf.notice <- sum((z[,i] == 1) & (y[,i] == 1))

z[(z[,i] == 1) & (y[,i] == 1),(i+1)] <- 
rbinom(dim(y[(z[,i] == 1) & (y[,i] == 1),,drop=FALSE])[1],
1,
(1 - theta[seen.so.far + 1][(z[,i] == 1) & (y[,i] == 1)])) 

if(i%%10 == 0){
cat("Number of infringers on iteration",i+1, "is",sum(z[,i+1]),"\n")
}
}

results.mat[,k] <- apply(z,2,sum) /(1000000/scale.fac)

#### 5/8/2010
#### Find how many have been sent 5 or more notices and are still infringing.
#### At week 53 and 105 for the full year.
#interim.dates <- c(53,105)

#### For the 4 week grace period.
interim.dates <- c(14,27)


print(paste("calculating 5 infringers when counter is",counter))
bad.at.one.year  <- sum((t(apply(x[,c(1:(interim.dates[1])),drop=FALSE],1,cumsum))[,interim.dates[1]] >=5) & (z[,(interim.dates[1])] == 1))
bad.at.two.years <- sum((t(apply(x[,c(1:(interim.dates[2])),drop=FALSE],1,cumsum))[,interim.dates[2]] >=5) & (z[,(interim.dates[2])] == 1))

results.mat.5.notices[counter * 2 - 1 ,k]  <- bad.at.one.year  * scale.fac
results.mat.5.notices[counter * 2     ,k]  <- bad.at.two.years * scale.fac

print(paste("calculating notice distributions when counter is",counter))

res.tmp <- table(apply(x[,c(1:(interim.dates[1])),drop=FALSE],1,sum))
if(length(res.tmp) > 5){res.tmp <- res.tmp[1:5]
names(res.tmp) <- c(0:4)
}
results.mat.freq.dist[k,counter,1,(as.integer(names(res.tmp)) + 1 )] <- res.tmp/sum(res.tmp)

res.tmp <- table(apply(x[,c(1:(interim.dates[2])),drop=FALSE],1,sum))
if(length(res.tmp) > 5){res.tmp <- res.tmp[1:5]
names(res.tmp) <- c(0:4)
}
results.mat.freq.dist[k,counter,2,(as.integer(names(res.tmp)) + 1 )] <- res.tmp/sum(res.tmp)

print(paste("calculating number of infringers when counter is",counter))
results.mat.num.infr[k,counter,1] <- results.mat[1,k] * 1000000
results.mat.num.infr[k,counter,2] <- results.mat[interim.dates[1],k] * 1000000
results.mat.num.infr[k,counter,3] <- results.mat[interim.dates[2],k] * 1000000

}

#### Graph the results table

if(graphics){
file=paste("images/img","_9_", n.draw*scale.fac,".png",sep="")
      png(file=file,width=720,height=540,bg="white")
      par(cex.lab=1.3)

max.y <- ceiling(pop.size * p.inf / 1000000)

ts.plot(results.mat,ylim=c(0,max.y),xlab="Period",ylab="Remaining infringers (M)",
col=c(2,3,4),lwd=2,
main=paste("Infringer survival, effort at", n.draw * scale.fac,"notices per period"))


percs <- seq(0,max.y,.5)

for (k in 1:length(percs)){
lines(x=c(1,n.periods),y=rep(percs[k],2),lty=2,col="grey")
}

percs <- seq(1,n.periods,4.333333)
for (k in 1:length(percs)){
lines(x=rep(percs[k],2),y=c(0,max.y),lty=2,col="grey")
}

desc.list <- list("Scenario 1" = NULL,"Scenario 2" = NULL,"Scenario 3" = NULL)
legend("topright",names(desc.list),fill=c(2:(length(desc.list)+1)) ,inset=0.02,ncol=3)

junk <- dev.off()
}

#### Write out the results table
if(results.tab){
results.mat <- cbind(c(1:n.periods),results.mat)
colnames(results.mat) <- c("Week","S1","S2","S3")
write.table(results.mat,
  file=paste("/home/richardw/Consulting/MPAA/Simulation/data/survival_",isp.name, ".1_month_grace_",n.draw*scale.fac,".txt",sep=""),
row.names=FALSE)
}
}

sink(  file=paste("/home/richardw/Consulting/MPAA/Simulation/data/notice.freq.dist.",isp.name, ".1_month_grace",".txt",sep=""))
print(aperm(results.mat.freq.dist,c(3,4,2,1)))
sink()
#### Write out the distributions of notices received.
#write.table(aperm(results.mat.freq.dist,c(3,4,2,1)),
#  file=paste("/home/richardw/Consulting/MPAA/Simulation/data/notice.freq.dist.",isp.name, ".1_month_grace",".txt",sep=""),
#row.names=FALSE)

sink(file=paste("/home/richardw/Consulting/MPAA/Simulation/data/num.inf.remain.",isp.name, ".1_month_grace",".txt",sep=""))
print(aperm(results.mat.num.infr,c(2,3,1)))
sink()
#### Write out the number of infringers remaining
#write.table(aperm(results.mat.num.infr,c(2,3,1)),
#  file=paste("/home/richardw/Consulting/MPAA/Simulation/data/num.inf.remain.",isp.name, ".1_month_grace",".txt",sep=""),
#row.names=FALSE)





#### Write out the still infringing after 5 notices table.
#colnames(results.mat.5.notices) <- c("S1","S2","S3")
#write.table(results.mat.5.notices,
#  file=paste("/home/richardw/Consulting/MPAA/Simulation/data/still_inf_5_75",".txt",sep=""),
#row.names=FALSE)


}



