2 + 2
4 + 4
number <- 4
number + 2
number <- number + 2


2 + 2

number <- 5
number
number + 1
number <- number + 1

#this is a comment
number <- 10 # set number to 10

# R Objects ####
ls() #Print the names of all objects in our environments
rm("numbers") #

number <- 5
decimal <- 1.5

letter <- "a"
word <- "hello"

logic <- TRUE
logic2 <- F

## types of variables
## there are 3 main class: numeric, character, and logical
class(number)
class(decimal) #numerical

class(letter)
class(word) #character

class(logic) #logical


## there is more variation in types
typeof(number)
typeof(decimal)

## we can change the type of an object
as.character(number)
as.integer(number)
as.integer(decimal)


## how to round numbers
round(decimal) # less than 0.5, round down. Greater/Equal to 0.5, round up.
round(22/7)
round(22/7, 3) # 3 values after the decimals
?round

22/7
ceiling(22/7) # ceiling always rounds up
floor(22/7) # floor always rounds down
floor(3.9)

?as.integer
word_as_int <- as.integer("hello")

# NA Values
NA + 5

## Naming
name <- "Sarah"
NAME <- "Joe"
n.a.m.e <- "Sam"
n_a_m_e <- "Lisa"
name2 <- "Paul"

## Illegal Naming Characters
# Starting with a number
# Starting with an underscore
# operators: + - / *
# conditionals: & ! < > !
# others: \ , space $

n <- ame <- "test"
n = "test"
n=ame <- "test"

## good naming convection
camelCase <- "start with a capital letter"
snake_Case <- "underscore between words"

## Object manipulation ####
number
number + 7

decimal
number + decimal

name
paste(name,"Parker") # concatenates vectors
paste(name, "Parker is awesome")
paste0(name,"Parker")

paste(name,number) # we can join together characters and numbers
logic <- T
paste0(name,logic)

letter # STUDENTS EXAMPLES
name6 <- "Miles"
paste("I'm", name6, "Morales", "But you, you could call me the Prowler")

?grep
food <- "watermelon"
grepl("me",food) # T or F, is the pattern in the character object?

## substituting characters in words
sub("me","you",food)
sub("me","_",food)
sub("me","",food)


# Vectors ####
# make a vector of numerics
number <- c(2,4,6,8,10)
range_of_vals <- 1:5 # all integers from 1 to 5
5:10 # all integers from 5 to 10
seq(2,10,2) # from 2 to 10, by 2's
seq(from = 2, to = 10, by = 2)
seq(by =2, from = 2, to = 10) # can put parameters out of order if they are anmed
seq(from = 2, to = 9, by = 2)
seq(1,10,2) # odd numbers between 1 and 10



rep(3,5) # repeat 3, 5 times
rep(c(1,2),5) # repeats 1,2 5 times


# how can we get all the values between 1 and 5 by 0.5?
seq(from = 1, to = 5, by = 0,5)

# how can we get 1 1 1 2 2 2?
c(rep(1,3),rep(2,3))
rep(c(1,2), each = 3)

# make a vector of characters
letters <- c("a","b","c")
paste("a","b","c") # paste() is different from c()

letters <- c(letters,"d")
letter
letters <- c(letters, letter)
letters <- c("x",letters, "w")

# make a vector of random numbers between 1 and 20
numbers <- 1:20
five_nums <- sample(numbers, 5) # choose 5 values from the vector numbers

five_nums <- sort(five_nums)
rev(five_nums)

fifteen_nums <- sample(numbers, 15, replace = T)
fifteen_nums <- sort(fifteen_nums)
length(fifteen_nums) # length of a vector
unique(fifteen_nums) # what are the unique values in the vector

# how to we get the number of unique values?
length(unique(fifteen_nums))

table(fifteen_nums) # get the count of values in the vector

fifteen_nums + 5
fifteen_nums/2

nums1 <- c(1,2,3)
nums2 <- c(4,5,6)
nums1 + nums2

nums3 <- c(nums1,nums2)
nums3 + nums1 # values are recycled to add together
nums3 + nums1 + 1

# what is the difference between these?
sum(nums3 + 1)
sum(nums3) + 1

# Vector indexing
numbers <- rev(numbers)
numbers
numbers[1]
numbers[5]

numbers[c(1,2,3,4,5)]
numbers[1:5]
numbers[c(1,5,2,12)]
i <- 5
numbers[i]

# Data sets ####
?mtcars
mtcars # print entire dataset to console

View(mtcars) # View entire data set in a new tab

summary(mtcars) # gives us info about the spread of each variable
str(mtcars) # preview the structure of the dataset

name(mtcars) # names of variables
head(mtcars, 5) # preview the first number of rows

## Pull out individual variables as vectors
mpg <- mtcars[,1] # blank means "all". All rows, first column
mtcars[2,2] # value at second row, second column
mtcars[3,] # third rows, all columns

# first 3 columns
mtcars[,1:3]

# use the names to pull out columns
mtcars$gear #pull out the "gear" column
mtcars[,c("gear","mpg")] # pull out the gear and mpg columns

sum(mtcars$gear)


# Statistics ####
View(iris)
iris

first5 <- iris$Sepal.Length[1:5]

mean(first5)
median(first5)
max(first5)-min(first5)

mean(iris$Sepal.Length) # find the to all Iris
mean(iris$Sepal.Length)
max(iris$Sepal.Length)-min(iris$Sepal.Length)

var(first5)
sd(first5)
sqr(var(first5))

var(iris$Sepal.Length)

## IQR
IQR(first5) #range of the middle of the 50% of data
quantile(first5, 0.25) # Q1
quantile(first5, 0.75) # Q3

## Outliers
sl <- iris$Sepal.Length

lower <- mean(sl) - 3*sd(sl)
upper <- mean(sl) + 3*sd(sl)

as.numeric(quantile(sl,0.25) - 1.5*IQR(sl))
quantile(sl,0.75) + 1.5*IQR(sl)


## subletting vectors
first5
first5 < 4.75 | first5 > 5
first5[first5 < 4.75]

values <- c(first5,3,9)
upper
lower

#removes outliers
values[values > lower & values < upper] # keep values loweer than upper and higher than loweer
values
values_no_outliers <- values[values > lower & values < upper]

## read in Data
getwd() # get working directory
super_data <- read.csv("data/super_hero_powers.csv")


## Condionals ####
x <- 5 # set x to 5

x < 3
x > 5
x == 3 # == means it's not
x == 5
x != 3

# We can test all valyes of a vector at once
numbers <- 1:5

numbers < 3
numbers == 3

numbers[1]
numbers[c(1,2)]
numbers[1:2]

numbers[numbers < 3] # numbers "where" numbers < 3

# outliers thresholds
lower <- 2
upper <- 4

# pull out only outliers
numbers[numbers < lower]
numbers[numbers > upper]

# combite with | (or)
numbers[numbers < lower | numbers > upper]

# use & to get all values in between outlier thresholds
numbers[numbers >= lower & numbers <= upper]

# using & with outlier threshold doesn't work
numbers[numbers < lower & numbers > upper]

# NA values
NA #Unknown
NA + 5

sum(1,2,3,NA) #returns NA if any value is NA
sum(1,2,3,NA,na.rm=T)

mean(c(1,2,3,NA), na.rm =T)
