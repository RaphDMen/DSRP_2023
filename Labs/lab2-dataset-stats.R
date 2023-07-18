## read in Data
getwd() # get working directory
data <- read.csv("Labs/pokemon.csv")
View(data)

pokedata <- data$weight_kg

meanwe <- mean(pokedata,na.rm=T)
medwe <- median(pokedata,na.rm=T)
ranwe <- range(pokedata,na.rm=T)
varwe<- var(pokedata,na.rm=T)
