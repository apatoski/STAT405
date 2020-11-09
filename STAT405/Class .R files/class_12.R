
## ----echo=FALSE,results='hide'-------------------------------------------
# some setup
options(width=60)  # make the printing fit on the page
set.seed(1121)   # make the results repeatable


## ----basic-plots-03,fig.width=4,fig.height=3,out.width='0.85\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,.3))   # tick labels direction
plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "My plot title", # add a title 
     xlab = "X-axis title",  # add an x-axis label
     ylab = "Y-axis title",  # add a y-axis label
     type = "n")             # don't actually plot anything yet	 

points(x = c(0.25,0.75), y = c(0.5,0.75)) # Add a couple of points to the graph
lines(x=c(0.25,0.75), y = c(0.5,0.75))    # Join them up with a line
polygon(x = c(0.25,0.6,0.35), y = c(0.25, 0.45, 0.4)) # A polygon
text(x = c(0.7),y = c(0.8), labels = c("Here is some text")) # Add text


## ----basic-plots-05,fig.width=4,fig.height=3,out.width='0.85\\linewidth',eval=TRUE,echo=FALSE----
par(las=1,mar=c(4,4,1,.3))   # tick labels direction
par(bg = "lightgray", # Set the background color
    cex = 1.4,        # Larger sized symbols
    cex.axis = 1.4,   # Change the axis annotation magnification
    fg = "blue")      # Set the foreground color
   	
plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "My plot title", # add a title 
     xlab = "X-axis title",  # add an x-axis label
     ylab = "Y-axis title",  # add a y-axis label
     type = "n")             # don't actually plot anything yet	 


## ----basic-plots-07,fig.width=4,fig.height=3,out.width='0.75\\linewidth',echo=FALSE----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction

plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "My plot title", # add a title 
     xlab = "X-axis title",  # add an x-axis label
     ylab = "Y-axis title",  # add a y-axis label
     type = "n")             # don't actually plot anything yet	 
	 
points(x = c(0.25,0.75), y = c(0.5,0.75),
       pch=17,col="red") # use red triangles for points
lines(x=c(0.25,0.75), y = c(0.5,0.75),
       lwd=2,lty=4,col="blue") # Change the line type
polygon(x = c(0.25,0.6,0.35), y = c(0.25, 0.45, 0.4),
        col="green") # Fill the polygon in green
text(x = c(0.7),y = c(0.8), labels = c("Here is some text"),
     col="orange",cex=2,pos=2) # Position to the left of the coordinates 	 


## ----basic-plots-09,fig.width=4,fig.height=3,out.width='0.85\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
par(mfrow=c(2,2)) # Set up a two-by-two grid of plots

# Now make  a series of plots:
plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "Plot 1")
plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "Plot 2")
plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "Plot 3")
plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "Plot 4")	 

## ----basic-plots-11,fig.width=4,fig.height=3,out.width='0.85\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     xlab="",ylab="",main = "Colors",type="n")
for(i in 1 :20){
  lines(x = c(0.05,0.95),
        y = c(i/20,i/20),
		col=i, # The numbered colors
		lwd=7) # line width 
}
	 

## ------------------------------------------------------------------------
length(colors())  # There are plenty of colors 
colors()[1:30] #Here are the names of the first 30


## ----basic-plots-13,fig.width=4,fig.height=3,out.width='0.85\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
#### View all the colors available by name:
plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     xlab="",ylab="",main = "Colors by name",type="n")
counter <- 1 # Keep track of the latest color
for(i in 0:25){ # Loop over the x-axis
  for(j in 0:25){ # Loop over the y-axis
    polygon(  # We will fill a square with each color in turn
	        x = c(i/26,(i+1)/26, (i+1)/26, i/26),
            y = c(j/26, j/26,(j+1)/26, (j+1)/26),
            col=colors()[counter] #S pecificy the color by name
            )
    counter <- counter + 1         			
  }
}

## ----basic-plots-15,fig.width=4,fig.height=3,out.width='1.0\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
wb1 <- rgb(red=    0/255, green = 71/255, blue = 133/255, 
names="wharton-blue-one")
wb2 <- rgb(red =  38/255, green = 36/255, blue =  96/255, 
names="wharton-blue-two")
wr1 <- rgb(red = 169/255, green =  5/255, blue =  51/255, 
names="wharton-red-one")
wr2 <- rgb(red = 168/255, green = 32/255, blue =  78/255, 
names="wharton-red-two")
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     xlab="",ylab="", main = "Custom colors",type="n")
polygon(x = c(0,0.25,0.25,0), y = c(0.1,0.1,0.9,0.9), col=wb1)     
polygon(x = c(0.26,0.5,0.5,0.26), y = c(0.1,0.1,0.9,0.9), col=wb2)     
polygon(x = c(0.51,0.75,0.75,0.51), y = c(0.1,0.1,0.9,0.9), col=wr1)     
polygon(x = c(0.76,1.0,1.0,0.76), y = c(0.1,0.1,0.9,0.9), col=wr2)     
text(x=0.5,0.95,"Wharton colors",col=wb1,cex=1.1) 

## ----basic-plots-16,fig.width=4,fig.height=3,out.width='0.75\\linewidth',echo=-1,eval=TRUE----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
library(RColorBrewer) # Load the color brewer library
display.brewer.pal(n=7, name="Pastel1") # Display a palette with 7 colors
my.palette <- brewer.pal(7,name="Pastel1") # Save it for future use

## ------------------------------------------------------------------------
outpatient <- read.csv( # Read in the outpatient data
"C:\\Users\\richardw\\Dropbox (Penn)\\Teaching\\705s2019\\Data\\Outpatient.csv")

outpatient$SchedDate <- strptime(outpatient$SchedDate, format="%m/%d/%Y")
outpatient$ApptDate <- strptime(outpatient$ApptDate, format="%m/%d/%Y")

# The difference between the two dates (measured in seconds)
# This will be a new column in the data frame
outpatient$SchedLag <- (outpatient$ApptDate - outpatient$SchedDate)
# Turn it into days
outpatient$SchedLag <- as.numeric(outpatient$SchedLag)/(60 * 60 * 24) 


## ----basic-plots-18,fig.width=4,fig.height=3,out.width='0.45\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,.3))    # tick labels direction
hist(x = outpatient$SchedLag) # A more custom histogram
hist(x = outpatient$SchedLag, 
     breaks=seq(-20,400,40),  
     freq=FALSE,
	 density=24,
	 col=wb1,
	 border=wr2,
	 xlab="Schedule Lag",
     main = "Histogram of schedule lag"	 
) 

## ----basic-plots-19,fig.width=4,fig.height=3,out.width='0.75\\linewidth',echo=TRUE,eval=TRUE----
plot(x = outpatient$SchedDate, y = outpatient$ApptDate,
     main="Schedule date v. appointment date",
	 xlab="Schedule date",
	 ylab = "Appt. date",
     col=wr2)

## ----basic-plots-20,fig.width=4,fig.height=3,out.width='0.90\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(5,5,1,.3))    # tick labels direction
diamonds <- read.csv( # Read in the diamonds data
"C:\\Users\\richardw\\Dropbox (Penn)\\Teaching\\705s2019\\Data\\Diamonds2008.csv")

plot(diamonds$Carat,diamonds$Price,main="Price v. Carat",xlab="Carat") #Plot the data

abline(lm(Price ~ Carat, data = diamonds),col=wr2,lwd=2) # Add the LS line

lines(lowess(diamonds$Carat,diamonds$Price), # A scatterplot smoother
      col="green",
      lwd=3) # Add the smooth to the plot

## ----basic-plots-21,fig.width=4,fig.height=3,out.width='0.65\\linewidth',echo=-1,eval=TRUE----
par(las=1,mar=c(5,5,1,.3))    # tick labels direction
barplot(sort(table(outpatient$Dept),decreasing=TRUE)[1:7], # The top 7 specialties
        cex.names=0.5,  # Make the names smaller so they fit
        col=my.palette, # Specify the color palette
        main="Specialty frequency") # Add a title

## ----basic-plots-22,fig.width=5.1,fig.height=4,out.width='0.65\\linewidth',echo=-1,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction
pie(sort(table(outpatient$Dept),decreasing=TRUE)[1:7], # The top 7 specialties
        col=my.palette, # Specify the color palette
        main="Specialty") # Add a title

## ------------------------------------------------------------------------
# Read in the library
library(ggplot2)

## ----basic-plots-23,fig.width=5,fig.height=3,out.width='0.95\\linewidth',echo=-1,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction
qplot(x = Carat, y = Price, data = diamonds,  geom="point")

## ----basic-plots-24,fig.width=5,fig.height=3,out.width='0.95\\linewidth',echo=-1,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction
qplot(x = Carat, y = Price, color = Color, data = diamonds,  geom="point")

## ----basic-plots-25,fig.width=5,fig.height=3,out.width='0.95\\linewidth',echo=-1,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction
qplot(x = Carat, y = Price, color = Color, 
      facets = ~ Clarity, data = diamonds,  geom="point")

## ----basic-plots-26,fig.width=5,fig.height=3,out.width='0.85\\linewidth',echo=-1,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction
# This defines the features in the plot (but shows nothing)
my.plot <- ggplot(data = diamonds, 
                  aes(x = Color, y = log(Price), fill = Color)) 
my.plot + geom_boxplot() # Now add a layer

## ----basic-plots-28,fig.width=5,fig.height=3.5,out.width='0.95\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction
# This defines the features in the plot (but shows nothing)
my.plot + 
  geom_boxplot() + # Now add a layer and some thematic elements
  ggtitle("A new title") +
  theme(plot.title=element_text(face="bold.italic", size="24", color="black")) + 
  theme(axis.title=element_text(size="18", color="black")) + 
  theme(axis.text=element_text(size="14", color="black")) + 
  theme(panel.background = element_rect(fill = "#BFD0DF"))

## ----basic-plots-29,fig.width=5,fig.height=3.5,out.width='0.95\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction
 # A basic histogram  
ggplot(data = diamonds, aes(x = log(Price))) + 
       geom_histogram(binwidth=0.5,col=wr1,fill=wb1)

## ----basic-plots-30,fig.width=5,fig.height=3.5,out.width='0.95\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction
#Overlaying a transparent density	   
ggplot(data = diamonds, aes(x = log(Price))) + 
      geom_histogram(binwidth=0.5,col=wr1,fill=wb1,aes(y=..density..)) +
      geom_density(alpha=.2, fill=wb2) 		  

## ----basic-plots-31,fig.width=5,fig.height=3.5,out.width='0.95\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction
# Stacked histogram
ggplot(data = diamonds, aes(x = log(Price),fill=Color)) + 
      geom_histogram(binwidth=0.5) 	   

## ----basic-plots-32,fig.width=5,fig.height=3.5,out.width='0.95\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction
# Price densities for each color
ggplot(data = diamonds, aes(x = log(Price),fill=Color)) + 
       geom_density(alpha=.3)
   

## ----basic-plots-33,fig.width=5,fig.height=3.5,out.width='0.95\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction

# Add Cut as a facet
 ggplot(data = diamonds, aes(x = log(Price),fill=Color)) + 
       geom_density(alpha=.3) + 
	   facet_grid(~ Cut)


## ----basic-plots-34,fig.width=5,fig.height=3.5,out.width='0.95\\linewidth',echo=FALSE,eval=TRUE----
par(las=1,mar=c(4,4,1,4))    # tick labels direction

# Add Cut and Polish as a facet
# Turn off warnings
options(warn = -1)
 ggplot(data = diamonds, aes(x = log(Price),fill=Color)) + 
       geom_density(alpha=.3) + 
	   facet_grid(Polish ~ Cut)

## ------------------------------------------------------------------------
my.graph <- ggplot(data = diamonds, aes(x = log(Price),fill=Color)) + 
       geom_density(alpha=.3) + 
	   facet_grid(~ Cut)
	   
# Open a graphics device to write to	   
png(filename="C:\\Users\\richardw\\Dropbox (Penn)\\Teaching\\705s2019\\Notes\\graph01.png",
             width=720,
             height=480)
my.graph 
dev.off()	# Turn the graphics device off		 

