## libraries
library(parsnip)
library(rsample)
library(yardstick)
library(reshape2)
library(ggplot2)
library(dplyr)
library(MLmetrics)
library(Metrics)

pokdata <- read.csv("Labs/pokemon.csv")
View(pokdata)

newpkdat <- select(pokdata, -c(abilities:against_water, base_egg_steps:capture_rate, experience_growth, japanese_name:pokedex_number, generation:is_legendary))
View(newpkdat)
  
# Step 1: CHECK ####
head(newpkdat)
View(newpkdat)


# Step 2: Clean and Process Data CHECK ####
# Replace chr into Factor
pkndata_noNA <- na.omit(newpkdat)
View(pkndata_noNA)

str(pkndata_noNA)
#pkndat_nochr <- mutate(pkndata_noNA, classfication = as.factor(classfication))
#pkndat_nochr <- mutate(pkndata_noNA, type1 = as.factor(type1))
#pkndat_nochr <- mutate(pkndata_noNA, classfication = as.integer(as.factor(classfication)))
#pkndat_nochr <- mutate(pkndata_noNA, type1 = as.integer(as.factor(type1)))


pkndat_nochr <- mutate(pkndata_noNA, classfication = as.integer(as.factor(classfication)),
                       type1 = as.integer(as.factor(type1)),
                       type2 = as.integer(as.factor(type2)))

View(pkndat_nochr)
str(pkndat_nochr)






# Step 3: Visualize Data ####
PokeCors <- pkndat_nochr |>
  cor() |>
  melt() |>
  as.data.frame()

PokeCors
View(PokeCors)

ggplot(PokeCors, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "darkblue", high = "white", mid = "darkred",
                       midpoint = 0)

View(pkndat_nochr)

# High Correlation?
ggplot(pkndat_nochr, aes(x = attack, y = sp_attack)) +
  geom_point() +
  theme_minimal()


# Low Correlation?
ggplot(pkndat_nochr, aes(x = speed, y = sp_attack)) +
  geom_point() +
  theme_minimal()




# Step 4: ####
## Set a seed for Reproducability
set.seed(71723)


# Step 5: ####
# Regression Data Split
pk_reg_split <- initial_split(pkndat_nochr, prop = .75) # Use 75% of data for Training
pk_reg_train <- training(pk_reg_split)
pk_reg_test <- testing(pk_reg_split)



# Step 6 and 7: ####
# Linear Regression Data Looking for sp_attack
pk_lm_fit <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression") |>
  fit(sp_attack ~ .,
      data = pk_reg_train)

pk_lm_fit
pk_lm_fit$fit
summary(pk_lm_fit$fit)

# Boosted Regression Looking for sp_attack
pk_boost_reg_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("regression") |>
  fit(sp_attack ~ ., data = pk_reg_train)

pk_boost_reg_fit
boost_fit$fit$evaluation_log
pk_boost_reg_fit$fit$evaluation_log




#Step 8: ####
#Linear Regression
pk_reg_results <- pk_reg_test

pk_reg_results$lm_pred <- predict(pk_lm_fit, pk_reg_test)$.pred
pk_reg_results$boost_pred <- predict(pk_boost_reg_fit, pk_reg_test)$.pred

#means
yardstick::mae(pk_reg_results, sp_attack, lm_pred)
yardstick::mae(pk_reg_results, sp_attack, boost_pred)

#RMSE
yardstick::rmse(pk_reg_results, sp_attack, lm_pred)
yardstick::rmse(pk_reg_results, sp_attack, boost_pred)







































































































