?ifelse()
case_when() # Is a dplyr function
# Saving Plots

library(dplyr)
library(ggplot2)

x <- 7
x <- c(1,3,5,7,9)
ifelse(x < 5, "small number", "big number")

head(iris)
mean(iris$Sepal.Width)
iris_new <- iris

## Add Categorical Column
iris_new <- mutate(iris_new,
                   petal_size = ifelse(Petal,Width > 1, "big", "small"))

iris_new <- mutate(iris_new,
                   petal_size = case_when(
                     Petal.Width < 1 ~ "small",
                     Petal.Width < 2 ~ "medium",
                     TRUE ~ "big"
                   ))
iris_new

ggplot(iris, aes(x = Sepal.Length, y= Sepal.Width)) +
  geom_point()
ggsave("Plots/scatterPlot.png")

