# 01 Importing the Dataset
# Load the Titanic Dataset downloaded from Kaggle
titanic_train <- read.csv("/home/saky/Desktop/tested.csv")

# Preview the first few rows
head(titanic_train)

# Select relevant columns
titanic_data <- titanic_train[, c("Survived", "Pclass", "Sex", "Age", "Fare", "SibSp")]
# Choosing first 500 rows
titanic_data <- titanic_data[1:500, ]
head(titanic_data)
dim(titanic_data)

# 02 Data Validation

# Check data types of each variable
str(titanic_data)
#Summary of the dataset
summary(titanic_data)

# Check unique values for categorical variables
unique(titanic_data$Survived)   # Should be "Died" or "Survived"
unique(titanic_data$Sex)        # Should be "male" or "female"
unique(titanic_data$SibSp)   

# Check for any invalid values in numeric variables (e.g., negative numbers for Age or Fare)
summary(titanic_data$Age)       # Check for unreasonable values like negative or very high numbers
summary(titanic_data$Fare)      # Fare should not be negative

# Check for duplicate rows
duplicates <- titanic_data[duplicated(titanic_data), ]
nrow(duplicates)  # Number of duplicate rows
duplicates        # Display the duplicate rows

# Check for remaining missing values in the dataset
colSums(is.na(titanic_data))

# Check for missing values in the dataset
missing_values <- colSums(is.na(titanic_data))
missing_values

#03 Data Preprocessing
# a. Removing Duplicate Rows
# Check for duplicate rows in the dataset
num_duplicates <- sum(duplicated(titanic_data))  # Returns the number of duplicate rows
cat("Number of duplicate rows:", num_duplicates, "\n")

# If duplicates exist, remove them
titanic_data <- titanic_data[!duplicated(titanic_data), ]
cat("Duplicates removed. Remaining rows:", nrow(titanic_data), "\n")

# b. Handling Missing Values
# Check for missing values in the dataset
cat("Missing values in each column:\n")
colSums(is.na(titanic_data))

# Replace missing values in numerical variables with the mean
titanic_data$Age[is.na(titanic_data$Age)] <- mean(titanic_data$Age, na.rm = TRUE)
titanic_data$Fare[is.na(titanic_data$Fare)] <- mean(titanic_data$Fare, na.rm = TRUE)
titanic_data$SibSp[is.na(titanic_data$SibSp)] <- mean(titanic_data$SibSp, na.rm = TRUE)

# Replace missing values in categorical variables with the most frequent category
# For 'Sex' variable (assuming the most frequent category is "male")
titanic_data$Sex[is.na(titanic_data$Sex)] <- "male" 
# For 'Pclass' variable (assuming the most frequent category is 3rd class)
titanic_data$Pclass[is.na(titanic_data$Pclass)] <- 3

# Check if missing values have been successfully replaced
cat("Missing values replaced.\n")
colSums(is.na(titanic_data))

# C Encoding Categorical Variables
# Check whether Data Encoding needed or not.
head(titanic_data) # Since already encoded, no need.

# D Outlier Detection and Removal
# Generate boxplots for numerical variables to check for outliers
par(mfrow = c(1, 3))  # Set up a plot with 2 graphs side by side

# Boxplot for Age
boxplot(titanic_data$Age, main = "Boxplot for Age", col = "lightblue", ylab = "Age")

# Boxplot for Fare
boxplot(titanic_data$Fare, main = "Boxplot for Fare", col = "lightgreen", ylab = "Fare")

# Boxplot for SibSp
boxplot(titanic_data$SibSp, main = "Boxplot for SibSp", col = "lightgreen", ylab = "Sibling/Spouse Count")

# Identify outliers in Age
Q1_age <- quantile(titanic_data$Age, 0.25)
Q3_age <- quantile(titanic_data$Age, 0.75)
IQR_age <- Q3_age - Q1_age
age_outliers <- titanic_data$Age[titanic_data$Age < (Q1_age - 1.5 * IQR_age) | titanic_data$Age > (Q3_age + 1.5 * IQR_age)]
cat("Outliers in Age:", age_outliers, "\n")

# Identify outliers in Fare
Q1_fare <- quantile(titanic_data$Fare, 0.25)
Q3_fare <- quantile(titanic_data$Fare, 0.75)
IQR_fare <- Q3_fare - Q1_fare
fare_outliers <- titanic_data$Fare[titanic_data$Fare < (Q1_fare - 1.5 * IQR_fare) | titanic_data$Fare > (Q3_fare + 1.5 * IQR_fare)]
cat("Outliers in Fare:", fare_outliers, "\n")

# Identify outliers in Fare
Q1_SibSp <- quantile(titanic_data$SibSp, 0.25)
Q3_SibSp <- quantile(titanic_data$SibSp, 0.75)
IQR_SibSp <- Q3_SibSp - Q1_SibSp
SibSp_outliers <- titanic_data$SibSp[titanic_data$SibSp < (Q1_SibSp - 1.5 * IQR_SibSp) | titanic_data$SibSp > (Q3_SibSp + 1.5 * IQR_SibSp)]
cat("Outliers in SibSp:", SibSp_outliers, "\n")

# Removing the Outliers in Age, Fare and SibSp
# Remove outliers in Age
titanic_data <- titanic_data[!(titanic_data$Age < (Q1_age - 1.5 * IQR_age) | titanic_data$Age > (Q3_age + 1.5 * IQR_age)), ]

# Remove outliers in Fare
titanic_data <- titanic_data[!(titanic_data$Fare < (Q1_fare - 1.5 * IQR_fare) | titanic_data$Fare > (Q3_fare + 1.5 * IQR_fare)), ]

# Remove outliers in SibSp
titanic_data <- titanic_data[!(titanic_data$SibSp < (Q1_SibSp - 1.5 * IQR_SibSp) | titanic_data$SibSp > (Q3_SibSp + 1.5 * IQR_SibSp)), ]

# Generate new boxplots after removing outliers
par(mfrow = c(1, 3))

# New Boxplot for Age
boxplot(titanic_data$Age, main = "Boxplot for Age (After Removing Outliers)", col = "lightblue", ylab = "Age")

# New Boxplot for Fare
boxplot(titanic_data$Fare, main = "Boxplot for Fare (After Removing Outliers)", col = "lightgreen", ylab = "Fare")

# New Boxplot for SibSp
boxplot(titanic_data$SibSp, main = "Boxplot for SibSp (After Removing Outliers)", col = "lightgreen", ylab = "Sibling/Spouse Count")

# 04 Measures of Central Tendency and Dispersion
# Load necessary libraries
library(dplyr)

# Ensure the dataset is clean (replace missing values)
titanic_data$Age[is.na(titanic_data$Age)] <- mean(titanic_data$Age, na.rm = TRUE)
titanic_data$Fare[is.na(titanic_data$Fare)] <- mean(titanic_data$Fare, na.rm = TRUE)
titanic_data$SibSp[is.na(titanic_data$SibSp)] <- mean(titanic_data$SibSp, na.rm = TRUE)

# Function to calculate the mode
get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# Group the data by the 'Survived' variable and calculate the measures of central tendency and dispersion
grouped_data <- titanic_data %>%
  group_by(Survived) %>%
  summarise(
    # Statistics for Age
    Mean_Age = mean(Age, na.rm = TRUE),
    Median_Age = median(Age, na.rm = TRUE),
    Mode_Age = get_mode(Age),
    Variance_Age = var(Age, na.rm = TRUE),
    SD_Age = sd(Age, na.rm = TRUE),
    
    # Statistics for Fare
    Mean_Fare = mean(Fare, na.rm = TRUE),
    Median_Fare = median(Fare, na.rm = TRUE),
    Mode_Fare = get_mode(Fare),
    Variance_Fare = var(Fare, na.rm = TRUE),
    SD_Fare = sd(Fare, na.rm = TRUE),
    
    # Statistics for SibSp (Sibling/Spouse Count)
    Mean_SibSp = mean(SibSp, na.rm = TRUE),
    Median_SibSp = median(SibSp, na.rm = TRUE),
    Mode_SibSp = get_mode(SibSp),
    Variance_SibSp = var(SibSp, na.rm = TRUE),
    SD_SibSp = sd(SibSp, na.rm = TRUE)
  )

# Display the calculated summary statistics
print(grouped_data)


# 05 Data Visualization
# Load necessary libraries
install.packages("ggplot2")

library(ggplot2)
# Boxplot for Survival Rate by Age
ggplot(titanic_data, aes(x = as.factor(Survived), y = Age, fill = as.factor(Survived))) +
  geom_boxplot() +
  labs(title = "Survival Rate by Age",
       x = "Survived (0 = No, 1 = Yes)",
       y = "Age") +
  theme_minimal() +
  scale_fill_manual(values = c("red", "green"), name = "Survival Status",
                    labels = c("Did not Survive", "Survived"))


# Load necessary libraries
library(ggplot2)
library(gridExtra)

# Remove rows with NA values in Age, Fare, or SibSp
clean_titanic_data <- na.omit(titanic_data[, c("Age", "Fare", "SibSp", "Survived")])

# Boxplot for Survival Rate by Age
boxplot_age <- ggplot(clean_titanic_data, aes(x = as.factor(Survived), y = Age, fill = as.factor(Survived))) +
  geom_boxplot() +
  labs(title = "Survival Rate by Age",
       x = "Survived (0 = No, 1 = Yes)",
       y = "Age") +
  theme_minimal() +
  scale_fill_manual(values = c("red", "green"), name = "Survival Status",
                    labels = c("Did not Survive", "Survived")) +
  theme(legend.title = element_blank(),
        legend.text = element_text(family = "Times New Roman"))

# Boxplot for Survival Rate by Fare
boxplot_fare <- ggplot(clean_titanic_data, aes(x = as.factor(Survived), y = Fare, fill = as.factor(Survived))) +
  geom_boxplot() +
  labs(title = "Survival Rate by Fare",
       x = "Survived (0 = No, 1 = Yes)",
       y = "Fare") +
  theme_minimal() +
  scale_fill_manual(values = c("red", "green"), name = "Survival Status",
                    labels = c("Did not Survive", "Survived")) +
  theme(legend.title = element_blank(),
        legend.text = element_text(family = "Times New Roman"))

# Boxplot for Survival Rate by SibSp (Siblings/Spouses Aboard)
boxplot_sibsp <- ggplot(clean_titanic_data, aes(x = as.factor(Survived), y = SibSp, fill = as.factor(Survived))) +
  geom_boxplot() +
  labs(title = "Survival Rate by SibSp",
       x = "Survived (0 = No, 1 = Yes)",
       y = "Siblings/Spouses Aboard") +
  theme_minimal() +
  scale_fill_manual(values = c("red", "green"), name = "Survival Status",
                    labels = c("Did not Survive", "Survived")) +
  theme(legend.title = element_blank(),
        legend.text = element_text(family = "Times New Roman"))

# Visualize the three boxplots together in a 1x3 grid
grid.arrange(boxplot_age, boxplot_fare, boxplot_sibsp, ncol = 3)