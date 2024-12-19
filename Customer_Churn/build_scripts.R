# lataa asiakasdata R-ympäristöön

churn_data <- read.csv("Customer_Churn_Dataset.csv")
head(churn_data)

# Esikäsitellään data
sum(is.na(churn_data))

# korjataan tai poistetaan puuttuvat arvot
churn_data <- na.omit(churn_data)

# muutetaan kategoriset muuttujat faktoreiksi
churn_data$Churn <- as.factor(churn_data$Churn)
churn_data$Contract <- as.factor(churn_data$Contract)


# Datan visualisointi

#Visualisoi churnin jakauma
library(ggplot2)
ggplot(churn_data, aes(x = Churn)) +
  geom_bar(fill = "steelblue") +
  ggtitle("Churn Distribution") +
  theme_minimal()
  ggsave("churn_distribution1.png", plot = plot, width = 8, height = 6)

# tarkastele churnin riippuvuutta muista muuttujista

ggplot(churn_data, aes(x = Contract, fill = Churn)) +
  geom_bar(position = "fill") +
  ggtitle("Churn by Contract Type") +
  theme_minimal()
  ggsave("churn_distribution.png", plot = plot, width = 8, height = 6)


#Ennustemallin luominen
set.seed(123)
library(caret)
train_index <- createDataPartition(churn_data$Churn, p = 0.8, list = FALSE)
train_data <- churn_data[train_index, ]
test_data <- churn_data[-train_index, ]

#luo logistinen regressiomalli
churn_model <- glm(Churn ~ ., data = train_data, family = binomial)
summary(churn_model)

#testaa mallia
predictions <- predict(churn_model, newdata = test_data, type = "response")
predicted_class <- ifelse(predictions > 0.5, "Yes", "No")
confusionMatrix(factor(predicted_class), test_data$Churn)

#visualisoi tulokset
library(pROC)
roc_curve <- roc(test_data$Churn, predictions)
plot(roc_curve, main = "ROC Curve")
