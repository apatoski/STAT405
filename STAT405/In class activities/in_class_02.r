#### Answer for In-class activity 2.

#### Get the data

gala.data <- read.csv(file="http://mathmba.com/richardw/gala.csv")

#### Review the data and column names
head(gala.data,3)

#### The responses are in column 4
#### Numbers in parentheses refer to slide numbers in the class 3 slides.

insights <-   # save the word frequencies into "insights" variable  (15)
  sort(         # sort the table (16)
    table(        # Tabulate word frequencies 
      toupper(      # make everything upper case (21)
        unlist(       # Smash the list to a vector (19)
          strsplit(     # Split by blank space (17)
            as.character( # Coerce to character (7)
              gala.data[,4]), # Pull the column of interest
            " ")
        )
      )
    ), decreasing = TRUE #Get the most frequent words at the top of the table 
  )


