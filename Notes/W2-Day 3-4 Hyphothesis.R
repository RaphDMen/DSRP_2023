## Load Required Libraries
library(dplyr)
library(ggplot2)

## Compare the mass of Male and Female Human Star Wars Characters? ####
## Null Hypothesis: Ave mass of Male and Female Star Wars Characters is the same
## Alternative Hypothesis: Ave Mass of Male and Female Star Wars Characters is different
swHumans <- starwars |> filter(species == "Human", mass > 0)
males <- swHumans |> filter(sex == "male")
females <- swHumans |> filter(sex == "female")

t.test(males$mass, females$mass, paired = F, alternative = "two.sided")
# p-value is 0.06
# Not Significant, failed to reject NULL Hypothesis because 0.06 is higher than 0.05
## Significance if # is lower than 0.05
## Not significant if # is higher than 0.05


## ANOVA ####
iris

## anova_results <- aov(Num.Var ~ Catg.Var, Data)
anova_results <- aov(Sepal.Length ~ Species, iris)
anova_results <- aov(Sepal.Width ~ Species, iris)

## Are there any groups different from each other?
summary(anova_results)

## Which ones? #Only run if P Value is significance (Lower than 0.5)
TukeyHSD(anova_results)


## Is there a significant difference in the mean petal length or petal widths by species?
## Significant Difference = p value / p adj
View(iris)
petal_results <- aov(Petal.Width ~ Species, iris)
petal_results <- aov(Petal.Length ~ Species, iris)
summary(petal_results)
TukeyHSD(petal_results)


### Star Wars
head(starwars)
unique(starwars$species)

## Which 3 Species is the Most Common?
top3species <- starwars |>
  summarize(.by = species,
            count = sum(!is.na(species))) |>
  slice_max(count, n = 3)

top3species

starwars_top3species <- starwars |>
  filter(species %in% top3species$species)

starwars_top3species

## Is there a significance difference in the mass of each of the top 3 species?
starwarssig <- aov(mass ~ species, starwars_top3species)
summary(starwarssig)
TukeyHSD(starwarssig)

## Is there a significance difference in the height of each of the top 3 species?
heistarsig <- aov(height ~ species, starwars_top3species)
summary(heistarsig)
TukeyHSD(heistarsig)


## Chi-Squared ####
View(table(starwars$species, starwars$homeworld))

starwars_clean <- starwars |>
  filter(!is.na(species),
         !is.na(homeworld))

t <- table(starwars$species, starwars$homeworld)
chisq.test(t) # Not enough Data

View(mpg)
table(mpg$manufacturer, mpg$class)
table(mpg$cyl, mpg$displ)

## How do we get a contingency table of year and drv?
t <- table(mpg$year, mpg$drv)

chisq.result <- chisq.test(t)
chisq.result
chisq.result$p.value
chisq.result$residuals

## install.packages("corrplot")
library(corrplot)

corrplot(chisq.result$residuals)


## Chi-Squared full analysis
heroes <- read.csv("Labs/heroes_information.csv")
head(heroes)

## Clean Data
heroes_clean <- heroes |>
  filter(Alignment != "-",
         Gender != "-")

## Plot that counts of alignment and gender
ggplot(heroes_clean, aes(x = Gender, y = Alignment)) +
  geom_count() +
  theme_minimal()

## make contingency table
t <- table(heroes_clean$Alignment, heroes_clean$Gender)
t

## chi squared test
chi <- chisq.test(t)
chi$p.value
chi$residuals

corrplot(chi$residuals, is,cor = F)














































