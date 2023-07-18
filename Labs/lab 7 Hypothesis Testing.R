## IMPORTANT INFORMATION
data <- read.csv("Labs/pokemon.csv")
View(data)

library(dplyr)
library(tidyr)
library(janitor)

newpkdat <- select(data, -c(base_egg_steps:capture_rate ,against_bug:against_water, generation:is_legendary, abilities, experience_growth, japanese_name))
View(newpkdat)

## Part 1 ####

## Categorical = type1
## Numeric = Weight

## Null Hypothesis = Difference between weight of Poison and Fire (QUESTION)
## p-value = 0.005951 / 0.994
## p value / p adj = Significance
## Significance if # is lower than 0.05
## Not significant if # is higher than 0.05

poison <- filter(newpkdat, type1 == "poison")
fire <- filter(newpkdat, type1 == "fire")

View(poison)
View(fire)

t.test(poison$weight_kg, fire$weight_kg, paired = F, alternative = "less")
t.test(poison$weight_kg, fire$weight_kg, paired = F, alternative = "greater")




## Part 2 ####
# Categorical = type 1: flying, ground, rock
# Numeric = Height
## aov(Num.Var ~ Catg.Var, Data)
pokeanov <- aov(data = newpkdat, height_m ~ type1)
pokeanov
summary(pokeanov)
TukeyHSD(pokeanov)

top3type <- newpkdat |>
  summarize(.by = type1,
            count = sum(!is.na(type1))) |>
  slice_max(count, n = 3)

top3type

pokdatyp <- newpkdat |>
  filter(type1 %in% top3type$type1)

pokdatyp


pokedat2 <- aov(height_m ~ type1, pokdatyp)
pokedat2
summary(pokedat2)
TukeyHSD(pokedat2)



## Part 3 ####
## Categorical = classification, type1
pkedat <- newpkdat |>
  filter(classfication != "-",
         type1 != "-")

ggplot(pkedat, aes(x = type1, y = classification)) +
  geom_count() +
  theme_minimal()


poktable <- table(pkedat$classfication, pkedat$type1)
View(poktable)

## chi squared test
chi <- chisq.test(poktable)
chi$p.valueq
chi$residuals

corrplot(chi$residuals, is,cor = F)







































