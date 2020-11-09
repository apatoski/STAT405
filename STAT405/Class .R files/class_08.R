## ------------------------------------------------------------------------
#Read in the datafile (also in the "outpatient.Rdata" file)
outpatient <- read.csv(
"C:\\Users\\richardw\\Dropbox (Penn)\\Teaching\\705s2019\\Data\\Outpatient.csv"
)
#Have a quick look at it
head(outpatient,5)

## ------------------------------------------------------------------------
summary(outpatient)

## ------------------------------------------------------------------------
# The dates are not correctly represented
print(class(outpatient$SchedDate))

## ------------------------------------------------------------------------
outpatient[outpatient$PID == "P10141",] #Patient P10141's history

## ------------------------------------------------------------------------
my.data <- data.frame( #Some example data
	X = c(3,6,2,2,5,6,1,2,6,6,2,3),
	Y = c("B","A","B","D","A","C","A","B","D","A","C","A")
)
order(my.data$X) # Take a look at the "order" command applied to X
# Make number 7 in the original vector the first element
# Make number 3 in the original vector the second element 
# Make number 10 in the original vector the last element

## ------------------------------------------------------------------------
# You sort by applying the "order" 
# permutation to the rows of the original object:
my.data[order(my.data$X),]

## ------------------------------------------------------------------------
my.data[order(my.data$X,my.data$Y),] # Sort on X, then Y

## ------------------------------------------------------------------------
as.POSIXlt(outpatient$ApptDate)

## ------------------------------------------------------------------------
# This can read the dates because we are specifying 
# the format of the date string 
strptime(outpatient$SchedDate, format="%m/%d/%Y") 

## ------------------------------------------------------------------------
outpatient$SchedDate <- strptime(outpatient$SchedDate, format="%m/%d/%Y")
outpatient$ApptDate <- strptime(outpatient$ApptDate, format="%m/%d/%Y")

# The difference between the two dates (measured in seconds)
# This will be a new column in the data frame
outpatient$SchedLag <- (outpatient$ApptDate - outpatient$SchedDate)
# Turn it into days
outpatient$SchedLag <- as.numeric(outpatient$SchedLag)/(60 * 60 * 24) 

## ------------------------------------------------------------------------
# A new sorted data frame
new.outpatient <- outpatient[order(outpatient$PID, 
                                   outpatient$ApptDate),]

#Now subset by the outcomes we care about
new.outpatient <- new.outpatient[
 (new.outpatient$Status == "Arrived" | # Note the logical OR
  new.outpatient$Status == "No Show"),
                              ]

## ------------------------------------------------------------------------
summary(glm(Status  ~ SchedLag, data = new.outpatient, family="binomial"))

## ------------------------------------------------------------------------
#The number of unique patient IDs
num.pats <- length(unique(new.outpatient$PID))
num.pats

## ------------------------------------------------------------------------
behavior.df <- data.frame(
  PID = as.character(rep(NA,num.pats)),
  Sex = rep(NA,num.pats),
  Age = rep(NA,num.pats),
  Prior.Visits = rep(NA,num.pats),
  No.Show.Rate = rep(NA,num.pats),
  Current.Visit.Lag = rep(NA,num.pats),
  Current.Visit.Status = as.character(rep(NA,num.pats)),
  stringsAsFactors = FALSE #Stop the use of factors, keep as characters
)

## ------------------------------------------------------------------------
#An example patient
test.patient <- new.outpatient[new.outpatient$PID =="P11000",]
print(test.patient)

## ------------------------------------------------------------------------
# nrow is a function to count the number of rows
prior.visits <- nrow(test.patient) - 1 

#Find the status of the prior visits, ignoring the current one
prop.no.show <- (# The proportion of no shows
sum( #This counts the number of No Shows
 test.patient[-nrow(test.patient),"Status"] #This pulls out the status 
                                            #of prior visits  
               == "No Show")  #This finds the "No Shows"
			   / prior.visits #Normalize by the number of prior visits
			   )

## ------------------------------------------------------------------------
# The extraction function takes a patient history data frame
extract.hist <- function(df){ 
# Special case: there is a single record, no history
if(nrow(df) == 1){
return(data.frame(
  PID = as.character(df[1,"PID"]),
  Sex = df[1,"Sex"],
  Age = df[1,"Age"],
  Prior.Visits = 0, #No prior visits
  No.Show.Rate = NA, #Undefined prior no show rate
  Current.Visit.Lag = df[1,"SchedLag"],
  Current.Visit.Status = as.character(df[1,"Status"]),
  stringsAsFactors = FALSE #Stop the use of factors
  )
 )
}
# The rest of the code will only be executed if the if failed
prior.visits <- nrow(df) - 1 
prop.no.show <- (# The proportion of no shows
sum( #This counts the number of No Shows
     df[-nrow(df),"Status"] #This pulls out the status 
                                            #of prior visits  
               == "No Show")  #This finds the "No Shows"
			   / prior.visits #Normalize by the number of prior visits
			   )
last.row.num <- nrow(df) #We will pull values from the last row			   
return(data.frame(
  PID = as.character(df[last.row.num,"PID"]),
  Sex = df[last.row.num,"Sex"],
  Age = df[last.row.num,"Age"],
  Prior.Visits = prior.visits, #We just calculated this 
  No.Show.Rate = prop.no.show, #We just calculated this 
  Current.Visit.Lag = df[last.row.num,"SchedLag"],
  Current.Visit.Status = as.character(df[last.row.num,"Status"]),
  stringsAsFactors = FALSE #Stop the use of factors
 )
 )
}

## ------------------------------------------------------------------------
#Someone with 1 visit
new.outpatient[new.outpatient$PID == "P10001",]
extract.hist(new.outpatient[new.outpatient$PID == "P10001",])

## ------------------------------------------------------------------------
#Someone with multiple visits
new.outpatient[new.outpatient$PID == "P10127",]
extract.hist(new.outpatient[new.outpatient$PID == "P10127",])

## ------------------------------------------------------------------------
row.counter <- 1 #start by filling the first row
for(pid in unique(new.outpatient$PID)){ #iterate over id's
 behavior.df[row.counter, ] <- extract.hist(df = # Pull out history
                     new.outpatient[new.outpatient$PID == pid,])
row.counter <- row.counter + 1 # Increment the row counter by 1
 }

## ------------------------------------------------------------------------
# Have a look at the new behavioural data frame
head(behavior.df,5)

