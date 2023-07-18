## install required packages
# NEVER RUN AGAIN [VERY IMPORTANT] [RTOOLS] {ERROR IF MESSES} ####
# install.packages("Rtools")
# install.packages("ggplot2", dependencies = TRUE)
# install.packages("ggplot2",INSTALL_opts = '--no-lock')
# unlink("/home/me/src/Rlibs/00LOCK-Rcpp", recursive = TRUE)
# unlink("C:/Users/littl/AppData/Local/R/win-library/4.3/00LOCK", recursive = TRUE)
# install.packages("lifecycle")

install.packages(c("usethis","credentials"))



### ABLE TO CLEAN THE CONSOLE BUT NOT TOUCED TOP ###
# Plot ####

## ALWAYS LOAD WHEN STARTING
## load required packages
library(ggplot2)

ggplot()


## mpg dataset
str(mpg)
?mpg

ggplot(data = mpg, aes(x = hwy, y = cty)) +
geom_point() +
labs(x = "highway mpg",
     y = "city.mpg",
     title = "car city vs highway milage")

## histogram ####
# We cam set the numbers of bar with bins
ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 25)

# We cam set the numbers of bar with bins
ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 0.25)



## Boxplots ####
ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_boxplot()

ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_boxplot()

ggplot(data = iris, aes(x = Sepal.Length, y = Species)) +
  geom_boxplot()



## Violin and boxplot ####
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin(color = "violet", fill = "grey95") +
  geom_boxplot(width = 0.2, fill = NA)

ggplot(data = iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_violin(color = "violet", fill = "grey95") +
  geom_boxplot(width = 0.2, fill = "white")

ggplot(data = iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_violin(aes(fill = Species )) +
  geom_boxplot(width = 0.2)



# Barplot ####
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_bar(stat = "summary" ,
           fun = "mean")

ggplot(data = iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_bar(stat = "summary" ,
           fun = "mean")



## Scatterplot ####
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_point()

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_jitter(width = 0.2)



## Lineplots ####
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_line(stat = "summary", fun = "mean")

# ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
#   geom_point() +
#   geom_line()


## Best-Fit Line
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_smooth()

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_smooth(se = F)

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_smooth(se = F) +
  theme_void()



## Color Scales ####
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(aes(color = Species)) + 
  scale_color_manual(values = c("violet", "lightpink", "red"))

ggplot(data = iris, aes(x = as.factor(Sepal.Length), y = Sepal.Width)) +
  geom_point(aes(color = Species)) + 
  scale_color_manual(values = c("violet", "lightpink", "red"))


## Factors ####
mpg$year <- as.factor(mpg$year)

iris$Species <- factor(iris$Species, levels = c("versicolor", "setosa", "virginica"))































