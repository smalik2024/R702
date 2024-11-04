#####################################################################
#####################################################################
library(tidyverse)
message("Hello there")

# Debuugging
Dates = as.Date(c("2011-04-05", 35))
min(Dates)


#Warning
tmp <- log(-pi)
is.na(tmp)

# Error
lm(x~y) #we do not have x and y in our environment


#### TOOLS
traceback()

mean(x)
traceback()

# browser() and debug()
source('MyFunctions.R')


debug()
