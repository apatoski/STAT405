# some setup
options(width=60)  # make the printing fit on the page
set.seed(1121)   # make the results repeatable

## ------------------------------------------------------------------------
# Get the two datasets from the web
x.data <- read.csv(file = "http://mathmba.com/richardw/x_var_join.csv")
y.data <- read.csv(file = "http://mathmba.com/richardw/y_var_join.csv")

## ------------------------------------------------------------------------
# Have a look at the two data sets
head(x.data,3)
head(y.data,3)

## ------------------------------------------------------------------------
# A first attempt (it does not work)!
merge(x = x.data, y = y.data, by = "AccountID")
#The merge argument is case sensitive and accountID 
#doesn't exactly match across the two data frames.

## ------------------------------------------------------------------------
# Carefully specifying the matching column names
my.merge <- merge(x = x.data, y=y.data, 
	by.x = "ACCOUNTID", by.y = "AccountID")
print(my.merge)

## ------------------------------------------------------------------------
# Merging by column index
my.merge <- merge(x = x.data, y=y.data, 
	by.x = 3, by.y = 1)
print(my.merge)

## ------------------------------------------------------------------------
# Keeping all the rows in the y data frame
my.merge <- merge(x = x.data, y=y.data, 
	by.x = "ACCOUNTID", by.y = "AccountID",
	all.y = TRUE)
print(my.merge)

## ------------------------------------------------------------------------
# Keeping all the rows in the x and y data frames
my.merge <- merge(x = x.data, y=y.data, 
	by.x = "ACCOUNTID", by.y = "AccountID",
	all.x = TRUE, all.y = TRUE)
print(my.merge)


## ------------------------------------------------------------------------
prodtime <- read.csv(file = "http://mathmba.com/richardw/ProdTime.csv")
summary(prodtime)

## ------------------------------------------------------------------------
lm.out <- lm(Time.for.Run ~ Run.Size, data = prodtime)

## ------------------------------------------------------------------------
summary(lm.out)

## ----lm-plots,fig.width=4,fig.height=4,out.width='.25\\linewidth',echo=-1----
par(las=1,mar=c(4,4,1,.3))  # tick labels direction
#There are multiple diagnostic plots and you 
#can specify which ones you want with the "which" argument

plot(lm.out,which=c(1:5))

## ------------------------------------------------------------------------
#You can pull individual pieces from the regression summary
reg.summary <- summary(lm.out) #Save the whole summary
names(reg.summary) # What's in the summary?
reg.summary$coefficients # The coefficients table
reg.summary$coefficients[,4] # Just the p-values

## ------------------------------------------------------------------------
lm.out.no.c <- lm(Time.for.Run ~ Run.Size, data = prodtime, 
	subset = (Manager != "c"))

## ------------------------------------------------------------------------
summary(lm.out.no.c)

## ------------------------------------------------------------------------
lm.out.manager <- lm(Time.for.Run ~ Run.Size + Manager, data = prodtime)

## ------------------------------------------------------------------------
summary(lm.out.manager)

## ------------------------------------------------------------------------
anova(lm.out.manager)

## ------------------------------------------------------------------------
predict(lm.out.manager) #The predicted values -- y^hats

## ------------------------------------------------------------------------
# Predict for a manager "b" job at 132 items
# and a manager "c" job at 190 items
x.predict <- data.frame(Manager = c("b","c"), Run.Size = c(132, 190))
print(x.predict)

## ------------------------------------------------------------------------
# Ask for the predictions using the "newdata" argument
my.predictions <- predict(lm.out.manager,newdata=x.predict)
print(my.predictions)
#We can get 95% prediction intervals with the "interval" argument
predict(lm.out.manager,newdata=x.predict,interval="prediction")

## ------------------------------------------------------------------------
hr.data <- read.csv(file = "http://mathmba.com/richardw/HR.csv")
summary(hr.data)

## ------------------------------------------------------------------------
# glm syntax is very similar to lm
glm.out <- glm(volturn ~ age + Gender, # The model specification
	data =hr.data, # The data frame in which to find the data
	family="binomial") # telling R that the outcome 
	                   # is a binomial random variable 

## ------------------------------------------------------------------------
summary(glm.out) # Summarize the output

