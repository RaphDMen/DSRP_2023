## read in Data
getwd() # get working directory
data <- read.csv("Labs/pokemon.csv")
View(data)

ggplot()


## Plot 1 - Histogram ####
Weight <- data$weight_kg

ggplot(data = data, aes(x = Weight)) +
  geom_histogram(bins = 25)




## Plot 2 - Barplot ####
Height <- data$height_m
Pkdx <- data$pokedex_number

ggplot(data = data, aes(x = Height, y = Pkdx, fill = Height)) +
  geom_bar(stat = "summary" ,
           fun = "mean")



## Plot 3 - Lineplot ####
SpAtk <- data$sp_attack
Speed <- data$speed

ggplot(data = data, aes(x = SpAtk, y = Speed)) +
  geom_line(stat = "summary", fun = "mean")



