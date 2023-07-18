## Unsupervised Learning ####
## Principal Components Analysis
head(iris)

## Remove any Non-Numeric Variables
iris_num <- select(iris, -Species)
iris_num

## Do PCA
pcas <- prcomp(iris_num, scale = T)
pcas
summary(pcas)
pcas$rotation

pcas$rotation^2
variancePercentages <- as.data.frame(pcas$rotation^2)
arrange(variancePercentages, desc(PC1))

## Get the x Values of PCAs and Make it a Data Form
pca_vals <- as.data.frame(pcas$x)
pca_vals$Species <- iris$Species

ggplot(pca_vals, aes(PC1, PC2, color = Species)) +
  geom_point() +
  theme_minimal()



### Supervised Machine Learning Models ####

## load required Packages
#install.packages("ranger")
#install.packages("xgboost")
#install.packages("tidymodels")
# install.packages("reshape2")
#install.packages("MLmetrics")
#install.packages("Metrics")
library(parsnip)
library(rsample)
library(yardstick)
library(reshape2)
library(ggplot2)
library(dplyr)
library(MLmetrics)
library(Metrics)

## Step 1: Collect Data
head(iris)
View(iris)



## Step 2: Clean and Process Data
## Get rid of NAs in any Rows
# Remove Rows that contains Nas
# Only use na.omit when you have specifically selected for the # Variables you want to include into this Model
noNas <- na.omit(starwars) #example b/c iris Data has no Nas

noNas <- filter(starwars, !is.na(mass), !is.na(height))
View(noNas)

# Replace with Means
# If it's not NA, set mass = mass
replaceWithMeans <- mutate(starwars, 
                           mass = ifelse(is.na(mass),
                                         mean(mass),
                                         mass))


## Encoding Categories as Factors or Integers
# If categorical variable is a character, make it a factor
str(starwars)
View(starwars)
intSpecies <- mutate(starwars, 
                     species = as.factor(species))


intSpecies <- mutate(starwars, 
                     species = as.integer(as.factors(species)))
intSpecies
str(intSpecies)

# If Categorical Variable is already a factor, make it an integer
str(iris)
View(iris)
irisAllNumeric <- mutate(iris,
                        Species = as.integer(Species))
irisAllNumeric
str(irisAllNumeric)


## Step 3: Visualize Data
# Make a PCA
# Calculate Correlations

irisCors <- irisAllNumeric |>
  cor() |>
  melt() |>
  as.data.frame()

irisCors
View(irisCors)

ggplot(irisCors, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "red", high = "blue", mid = "white",
                      midpoint = 0)
View(irisAllNumeric)

# High Correlation?
ggplot(irisAllNumeric, aes(x = Petal.Length, y = Sepal.Length)) +
  geom_point() +
  theme_minimal()

# Low Correlation?
ggplot(irisAllNumeric, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_point() +
  theme_minimal()


## Step 4: Perform Feature Selection
# Choose which Variables you want to Classify or Predict
# Choose which Variables you want to use as a Features in your Model
# For iris Data...
# Classify on Species (Classification) & Predict on Sepal.Length Regression)

View(irisAllNumeric)
str(irisAllNumeric)

## Step 5: Separate Data into Testing and Training Sets
# Choose 70-85% of Data to train on
library(rsample)

## Set a seed for Reproducability
set.seed(71723)

## Regression Datasets Splits
# Create a Split
reg_split <- initial_split(irisAllNumeric, prop = .75) # Use 75% of data for Training

# Use the Split to form Testing and Training Sets
reg_train <- training(reg_split)
reg_test <- testing(reg_split)



## Classification Datasets splits (use iris instead or irisAllNumeric)
class_split <- initial_split(iris, prop = .75)

class_train <- training(class_split)
class_test <-  testing(class_split)



## Step 6 and 7: Choose a ML model and train it

## Linear Regression
lm_fit <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ Petal.Length + Petal.Width + Species + Sepal.Width,
      data = reg_train)

## Sepal.Length = 2.3 + Petal.Length*0.7967 + Petal.Width*-0.4067 + Species*-0.3312 + Sepal.Width*0.5501

lm_fit$fit
summary(lm_fit$fit) #Closer for R-Squared to 1, closer to is perfect squared?



## Logistic Regression
# For Logistic Regression 
# 1. Filter Data to only 2 groups in Categorical Variable of Interest
# 2. Make the Categorical Variable a Factor
# 3. Make your Training and Testing Splits

# For our purpose, we are just going to filter test and training (don't do this)
binary_test_data <- filter(class_test, Species %in% c("setosa", "versicolor"))
binary_train_data <- filter(class_train, Species %in% c("setosa", "versicolor"))

# Build the Model
log_fit <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification") |>
  fit(Species ~ Petal.Width + Petal.Length + ., data = binary_train_data)


log_fit$fit
summary(log_fit$fit)



## Boosted Decision Tree
# Regression
boost_reg_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ ., data = reg_train)

boost_fit$fit$evaluation_log
boost_reg_fit$fit$evaluation_log


# Classification
# Use "classification" as the mode, and use Species as the predictor (Independent) Variable
# Use class_train as the Data

boost_class_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("classification") |>
  fit(Species ~ ., data = class_train)

boost_class_fit$fit$evaluation_log




## Random Forest
# Regression
forest_reg_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ ., data = reg_train)

forest_reg_fit$fit$evaluation_log


## Classification
forest_class_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("classification") |>
  fit(Species ~ ., data = class_train)

forest_class_fit$fit



## Step 8: Evaluate Model Performance on Text Set
# Calculate Errors for Regressions
library(yardstick)
#lm_fit, boost_reg_fit, forest_reg_fit
reg_results <- reg_test

reg_results$lm_pred <- predict(lm_fit, reg_test)$.pred
reg_results$boost_pred <- predict(boost_reg_fit, reg_test)$.pred
reg_results$forest_pred <- predict(forest_reg_fit, reg_test)$.pred

yardstick::mae(reg_results, Sepal.Length, lm_pred)
yardstick::mae(reg_results, Sepal.Length, boost_pred)
yardstick::mae(reg_results, Sepal.Length, forest_pred)

yardstick::rmse(reg_results, Sepal.Length, lm_pred)
yardstick::rmse(reg_results, Sepal.Length, boost_pred)
yardstick::rmse(reg_results, Sepal.Length, forest_pred)


# Calculate Accuracy for Classification Models
library(MLmetrics)
library(Metrics)
class_results <- class_test

class_results$lm_pred <- predict(log_fit, class_test)$.pred_class
class_results$boost_pred <- predict(boost_class_fit, class_test)$.pred_class
class_results$forest_pred <- predict(forest_class_fit, class_test)$.pred_class


#f1(class_results$Species, class_results$log_pred)
#f1(class_results$Species, class_results$boost_pred)
#f1(class_results$Species, class_results$forest_pred)



class_results$Species == "setosa"
class_results$log.pred == "setosa"

f1(class_results$Species == "setosa", class_results$log.pred == "setosa")
f1(class_results$Species == "virginica", class_results$log.pred == "virginica")




















