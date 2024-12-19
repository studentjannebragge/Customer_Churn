# Customer Churn Analysis Project

## Overview
This project aims to analyze customer churn using a dataset of customer demographics, service details, and churn status. The goal is to uncover key factors driving churn, predict customers likely to churn, and provide actionable insights for improving customer retention.

---

## Features
- **Data Preprocessing**: Cleans and prepares the dataset for analysis by removing unnecessary columns and handling categorical variables.
- **Exploratory Data Analysis (EDA)**: Visualizes churn distribution and identifies correlations between churn and other variables.
- **Predictive Modeling**: Uses logistic regression to predict customer churn.
- **Evaluation Metrics**: Includes a confusion matrix and ROC curve for performance evaluation.
- **File Outputs**: Saves visualizations, evaluation metrics, and processed data as files.

---

## Steps to Run the Script

1. **Clone or download the repository**.
2. **Place the dataset** (e.g., `Customer_Churn_Dataset.csv`) in the same directory as the script.
3. **Install necessary R packages**:
   ```R
   install.packages(c("dplyr", "ggplot2", "caret", "pROC"))
   ```
4. **Run the script in R or RStudio**.
5. **Access the generated outputs** in the working directory.

---

## Generated Files
1. **`processed_churn_data.csv`**: Cleaned and preprocessed dataset.
2. **`churn_distribution.png`**: Visualization of churn distribution.
3. **`roc_curve.png`**: ROC curve for model performance.
4. **`confusion_matrix.txt`**: Confusion matrix showing model performance.
5. **`model_summary.txt`**: Logistic regression model summary.

---

## Code Workflow

### Step 1: Load the Dataset
The script loads the customer churn dataset and previews the data.
```R
churn_data <- read.csv("Customer_Churn_Dataset.csv")
```

### Step 2: Data Preprocessing
- Removes the `CustomerID` column as it is not predictive.
- Converts categorical variables to factors.
```R
churn_data <- churn_data %>% select(-CustomerID)
churn_data$Churn <- as.factor(churn_data$Churn)
```

### Step 3: Train-Test Split
Splits the data into training (80%) and testing (20%) sets for model validation.
```R
train_index <- createDataPartition(churn_data$Churn, p = 0.8, list = FALSE)
```

### Step 4: Logistic Regression Model
Fits a logistic regression model to predict churn.
```R
churn_model <- glm(Churn ~ ., data = train_data, family = binomial)
```

### Step 5: Predictions and Evaluation
Generates predictions on the test data and evaluates performance using a confusion matrix and ROC curve.
```R
conf_matrix <- confusionMatrix(factor(predicted_class), test_data$Churn)
roc_curve <- roc(test_data$Churn, predictions)
```

### Step 6: Visualizations
Creates plots for churn distribution and the ROC curve.
```R
ggsave("churn_distribution.png", plot = churn_plot)
ggsave("roc_curve.png", plot = roc_plot)
```

### Step 7: Save Results
Saves key outputs as files for further analysis.
```R
write.table(conf_matrix$table, file = "confusion_matrix.txt", sep = "\t")
writeLines(capture.output(summary(churn_model)), con = "model_summary.txt")
```

---

## Expected Outputs
- Visualize churn trends.
- Evaluate model accuracy and identify key predictors.
- Provide insights for reducing churn rates.

---


