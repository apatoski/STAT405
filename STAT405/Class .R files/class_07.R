## ----echo=FALSE,results='hide'-------------------------------------------
# some setup
options(width=60)  # make the printing fit on the page
set.seed(1121)   # make the results repeatable

## ------------------------------------------------------------------------
if(TRUE){
	print("This will be executed")
}

if(FALSE){
	print("This will not be executed")
}

## ------------------------------------------------------------------------
# The is.dichotomous function made use of the "if" statement
is.dichotomous <- function(x){ # x is the input column
tmp <- table(x) # Make a table of the frequencies of the values in x
if(length(tmp) == 2){
  return(TRUE) # If there are two elements then it is dichotomous
  }            # and we immediately quit and return the result 
return(FALSE)  # Otherwise, it is not dichotomous and we return FALSE
}

## ------------------------------------------------------------------------
# Make a pack of playing cards
CARDS <- paste(
rep(c("ACE","2","3","4","5","6","7","8","9","10","J","Q","K"),rep(4,13)),
rep(c("H","C","D","S"),13),
sep="_")

#The is.ace function. It will accept a vector (hand) of cards:
is.ace <- function(cards){ 
result <- rep(FALSE,length(cards)) #Fill the result with FALSE
#grep looks for its first argument in its second, 
#and returns the location of the matches 
result[grep("ACE",cards)] <- TRUE  # Overwrite FALSE with "TRUE" 
                                   # if the card is an ace
return(result)
}

## ------------------------------------------------------------------------
set.seed(20170406)
#Draw 2 cards from the pack of cards, without replacement
my.hand <- sample(x=CARDS,size=2,replace=FALSE)# "sample" is very useful!

if(any(is.ace(my.hand))){ # any looks to see whether in a logical vector,
                          # any elements are TRUE. If so, it returns TRUE.
print(paste("Yes! I got an ace. 
             Here's my hand:", my.hand[1], my.hand[2])) 
} else{
print(paste("I didn't get an ace and here's my hand:", 
             my.hand[1], my.hand[2]))
}

## ------------------------------------------------------------------------
### This fails. R views the first "if" statement as complete
### and is confused by the else starting its own a line.
#if(any(is.ace(my.hand))){ # any looks to see if in a logical vector, any are TRUE
#print(paste("Yes! I got an ace. Here's my hand:", 
#             my.hand[1], my.hand[2])) 
#} 
#else{
#print(paste("I didn't get an ace and here's my hand:", 
#             my.hand[1], my.hand[2]))
#}
# Make sure that the "else" comes on the same line as the closing 
# curly bracket to the "if" command. 

## ------------------------------------------------------------------------
x <- c(TRUE,TRUE,FALSE,FALSE)
y <- c(TRUE,FALSE,TRUE,FALSE)

x & y  # Truth table for "&" (AND)
x | y  # Truth table for "|" (OR)
# The 'any" function is handy to check an entire vector 
# to see if "any" elements are TRUE
any(x)

## ------------------------------------------------------------------------
# Make a character vector 
my.words <- c("This", "sentence", "contains", "many", "words",
              "but", "some", "have", "few","letters") 

# For those words with less than 5 characters return "Small word"
# For those words with 5 or more characters return "Big word"
# The return vector will have as many elements as the test condition

ifelse(nchar(my.words) < 5,"Small word","Big word")			  

## ------------------------------------------------------------------------
for(i in 1:5){ # "i" will take on the values 1 through 5 within the loop.
print(paste("This is iteration: ",i))
}

## ------------------------------------------------------------------------
my.words <- c("Here", "are", "some", "text", "strings")
# "word" is a variable in the loop that takes on the values in "my.words" 
for (word in my.words){ 
	print(paste("The word is: [",word, "]",sep="")) 
}

## ------------------------------------------------------------------------
set.seed(20160405) # set the seed for reproducibility
num.its <- 10000 # set the number of iterations
counter <- 0 # A counter that will count how often we get at least one ace
# Note the indentation to improve readability
for (i in 1:num.its) {
  my.hand <- sample(x = CARDS,size = 2,replace = FALSE)# draw 2 cards
  if (any(is.ace(my.hand))) { #Is there at least one ace?
    counter <- counter + 1 # Add 1 to the counter if there is an ace.
  }
}
print(paste("I saw", counter, "hands with an ace, in",
             num.its,"iterations"))
#Aside: the exact answer from probability theory is 0.1493213

## ------------------------------------------------------------------------
num.its <- 10000 # set the number of iterations
results.container <-
  rep(NA,num.its)# A container to store the results of each iteration
for (i in 1:num.its) { #Start the simulation
  shuffled.deck <-
    sample(x = CARDS) # With no extra arguments sample 
	                  # will randomly permute its input
  for (j in 1:49) {
    #We must find an ace before the 50th card.
    if (is.ace(shuffled.deck[j])) {
      break #We break out of the inner "j" loop as soon as we see an ace
    }
  }
  results.container[i] <- j # We jumped out of the loop, with the value "j"
 }
print(paste("The expected waiting time for an ace is", 
             mean(results.container), "cards"))

## ------------------------------------------------------------------------

for(i in 1:8){
  if(i %% 2 ==0){
    print("Jumping straight to the next iteration")
    next  # Jump out on even numbers
  }
  print(paste("Iteration", i)) # Not executed for even numbers
}

## ------------------------------------------------------------------------
my.hand <- sample(x = CARDS,size = 2,replace = FALSE)# draw 2 cards
while( ! any(is.ace(my.hand))){ #Keep playing until we see an ace
  print ("No ace yet!")
  my.hand <- sample(x = CARDS,size = 2,replace = FALSE)# draw 2 cards
}
print(my.hand)

