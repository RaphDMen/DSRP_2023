## read in Data
getwd() # get working directory
pokedata <- read.csv("Labs/pokemon.csv")
pokedata
View(data)

## Filter Section ####
filter(pokedata, weight_kg < 100)
filter(pokedata, type1 == "grass")



## Select Section ####
select(pokedata, -c(against_bug:against_water))
select(pokedata, classfication, experience_growth, height_m, japanese_name:pokedex_number)



## Mutate Section ####
mutate(pokedata,
       lbs = weight_kg*2.2)
mutate(pokedata,
       sum = sum(weight_kg, na.rm = T))



## Summarize Section ####
summarize(pokedata,
          mean_weight = mean(weight_kg, na.rm = T),
          count = n(),
          .by = name)
summarize(pokedata,
          mean_speed = mean(speed, na.rm = T),
          count = n(),
          .by = name)



## Arrange Section ####
arrange(pokedata, name)
arrange(pokedata, desc(sp_attack))



