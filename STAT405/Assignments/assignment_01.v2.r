#### STAT 405/705 Spring 2019 ASSIGNMENT 1
#### NAME:

#### If in a question I refer to a function that we have not seen in class, 
#### then use the help facility in R to find out about it.
#### Insert your answers and the R code you used to generate it, beneath each question.
#### Even though for some questions you could find the answer "by inspection", for this  homework you need
#### to write code to explicitly get the answers.

# My birthday is September 2nd, 1994 (I wish).
# Using the convention MMDDYYYY, then my birthday number is
# 09021994


#### Q1. 

#a Store your birthday number into a numeric variable called "bday".
#  (It doesn't matter if your birthday number starts with a leading 0 - just include it.)

# Now write code to find and print the answer for all parts:
#b The fifth root of your birthday number.

#c The log base 2 of your birthday number.

#d The modulus of your birthday number, base 9.

#e Write code to create and store in a variable (vector) the first 1000 terms in the sequence:
# (Hint: create two simpler sequence vectors that you then multiply elementwise). 
# {1, -1/3, 1/5, -1/7, 1/9, -1/11 ... } 

#f Take the sequence in part e, sum it and multiply by 4.  Print the answer.


#### Q2. 

#a  Create the two vectors of numbers alpha = (1000, 980, 960,...,200)
#                                     beta  = (150, 165, 180, ..., 750)  

#b What is the sum of the elementwise product of the two vectors?

#c What is the maximum value in the vector containing the elementwise products?

#d What is/are the indices (position in the vector) of the maximum value found in part c?

#e How many of the elements of the elementwise product vector are strictly greater than 220000?

#f How many of the elements of the elementwise product vector are strictly between 180000 and 240000?


#### Q3.
#a Set the random number seed as your birthday number

#b Create two vectors, named x and y of standard normal random variables, each of length 1000000.

#c Create a third vector, called z, containing the elementwise square root of the sum
#  of the squares of the elements.
#  That is, if you call the first elements x1 and y1, etc., you need to calculate
#  
#   x1,y1   --->>>> sqrt(x1^2 + y1^2)
#   x2,y2   --->>>> sqrt(x2^2 + y2^2)
#   x3,y3   --->>>> sqrt(x3^2 + y3^2)
#   and so on.

#d  Find the average of the elements in the z vector.

#e  Square the average and double it. Print the result.  


#### Q4. 
#a  Enter the following 5 x 5 matrix into R and call it "mat.q4"
####     (0 0 0 0 1 
####      0 0 0 1 4
####      0 0 1 3 6
####      0 1 2 3 4
####      1 1 1 1 1)
####     Label  the columns as A, B, C, D and E and the rows as Alpha, Beta, Gamma, Delta and Epsilon.

#b  Print the matrix and paste the printed output below.

#c  Extract and print the submatrix corresponding to the third row,
#   and the fourth and fifth columns. Make sure that what you extract is indeed a matrix
#   and not a vector.

#d  Find the transpose of the matrix entered in part a (the transpose swaps the rows and columns).  

#e  Multiple the original matrix (on the left) by its transpose (on the right) 
#  (use, matrix multiplication, "%*%", not element-wise) and store the result.

#f  Find and print the inverse of the matrix created in part e.  

#g  Find and print the sum of the elements of the leading (top left to bottom right)
#   diagonal of the inverse matrix.


#### Q5. A market research company asked respondents the question:
#### "Would you recommend this product to a friend?" 
#### People answered on a 1 through 5 numeric scale, where: 
#### 1 was "definitely no"
#### 2 was "probably no"
#### 3 was "maybe" 
#### 4 was "probably yes" 
#### 5 was "definitely yes" 
####
#### Analysts needed to recode this numeric variable into a
#### three-level ordered factor, with levels:
#### "definitely no" if they had answered with a 1.
#### "unsure" if they had answered with 2, 3 or 4.
#### "definitely yes" if they had answered with a 5.

#### Here's the raw data:
raw.scores <- c(1, 2, 1, 4, 4, 5, 2, 1, 1, 5,
                5, 1, 3, 3, 3, 1, 4, 2, 2, 2, 
                3, 1, 1, 1, 3, 2, 3, 1, 4, 5)
				
#a Write code to create and store a logical vector that takes on the value TRUE if
#  the raw score was either a 2 or a 3 or a 4 and FALSE otherwise.				

#b Using the logical vector from part a, replace the values 2, 3 and 4 with the
#  value 3. Call this new numeric vector "mod.scores". At this point
#  mod.scores should only contain the values 1, 3 and 5.

#c Create and store from "mod.scores" an ordered factor variable from the modified data with the 
#  labels "definitely no", "unsure", and "definitely yes".
#  "definitely no" should be the lowest value and "definitely yes" the highest value of the factor. 

#d  Summarize the data with the "table" command and paste the output below.

#e  Write code to identify and print which of the three new levels occurred most frequently and how often it occurred.

#aside: you can use the table output as input to the "pie" function which makes a pie chart.


#### Q6. 

#a What is a key difference between the list extraction operators [ and $?

#b Reset the random number seed to your birthday seed.

# Paste the following code into R

my.list <- list(A = c(sample(10,10,replace=TRUE)), B = matrix(rnorm(49),ncol=7), 
                ALPHA = list(MU = matrix(sample(10,81,replace=TRUE),ncol=9), NU = matrix(rnorm(81),ncol=9)))

#c Write code to extract and print the value of the (6,2) element in the B matrix.
 
#d Write code to extract and find the sum of all of the elements in the 
#  matrix product (%*%) of the two matrices MU and NU.

#e Rename the element called "B", as "D", and paste both the command you used 
#  and the output from the names() command to prove that you did it successfully.   


#### Q7. 

#a Set the random number seed to your birthday number again.

#b Create a 400 x 10000 matrix of standard normals (mean = 0, sd = 1).

#c Using the apply function, find the mean of each column of the matrix.

#d Find and report the standard deviation (R command "sd") of these 10000 column means.
#  What you have just done is empirically estimate the standard error of the sample mean,
#  when the sample mean is based on a sample of size n = 400. 




