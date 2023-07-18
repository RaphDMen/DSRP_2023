## Install Required Packages ####
install.packages("janitor")
install.packages("tidyr")

## Load Required Packages ####
library(tidyr)
library(janitor)
library(dplyr)

starwars
clean_names(starwars, case = "small_camel")
new_starwars <- clean_names(starwars, case = "screaming_snake")
clean_names(starwars, case = "upper_lower")
## news_starwars <- 
news_starwars

clean_names(new_starwars)

new_starwars <- rename(new_starwars, `hair*color` = HAIR_color)
clean_names(new_starwars)


## How would we create a new table called StarWarsWomen of just the name and species of all female Star Wars characters in order of their birth year?
## Make a Table of Names and Species of all Female Star Wars characters by age
StarWarsWomen <- select(arrange(filter(starwars, sex == "female"), birth_year), name, species)
StarWarsWomen

## StarWarsWomen <- filter(starwars, sex == "female")
## StarWarsWomen <- arrange (StarWarsWomen, birth_year)
## StarWarsWomen <- select(StarWarsWomen, name, species)

## sww <- filter(starwars, sex == "female")
## sww <- arrange (sww, birth_year)
## sww <- select(sww, name, species)


## Using Pipes
StarWarsWomen <- starwars |> 
  filter(sex =="female") |> 
  arrange(birth_year) |> 
  select(name, species)

StarWarsWomen


## Using Slice
# 10 Tallest Star Wars Characters
slice_max(starwars, height, n = 10)
slice_min(starwars, height, n = 10)
slice_max(starwars, height, n = 1, by = species)
slice_max(starwars, height, n = 2, by = species)
slice_max(starwars, height, n = 2, by = species, with_ties = F)


## Tidy Data ####

# Pivot Longer
table4a
tidy_table4a <- pivot_longer(table4a,
             cols = c(`1999`, `2000`),
             names_to = "year",
             values_to = "cases")

table4b
## How would we pivot table4b to be in "tidy" format?
tidy_table4b <-pivot_longer(table4b,
             cols = c(`1999`, `2000`),
             names_to = "year",
             values_to = "population")


# Pivot Wider
table2
pivot_wider(table2,
            names_from = type,
            values_from = count)


## Separate
table3
separate(table3,
         rate,
         into = c("cases", "population"),
         sep = "/")


## Unite
table5
tidy_table5 <- table5 |>
                  unite("year",
                        c("century", "year"),
                        sep = "") |>
                  separate(rate,
                           into = c("cases", "pipulation"),
                           sep = "/")


## Bind rows
new_data <- data.frame(country = "USA", year = "1999", cases = 1043, population = 2000000)
 
bind_rows(tidy_table5, new_data)




























