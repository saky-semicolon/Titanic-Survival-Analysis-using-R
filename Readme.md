# Titanic Survival Analysis using R

## Overview
This repository provides a comprehensive analysis of the Titanic dataset, focusing on survival rates of passengers using the R programming language. The project explores the impact of key variables such as Age, Fare, Sex, Passenger Class, and Siblings/Spouses Aboard (SibSp) on survival. The analysis involves data preprocessing, statistical analysis, and a series of visualizations to gain insights into the survival patterns.

## Dataset
The Titanic dataset used for this analysis is available from [Kaggle's Titanic Dataset](https://www.kaggle.com/c/titanic/data). It contains information about the passengers who were aboard the Titanic, including demographic details and whether they survived the disaster.

### Key Variables:
- **Survived**: Binary indicator (0 = No, 1 = Yes), whether the passenger survived the sinking of the Titanic.
- **Pclass**: Passenger class (1st, 2nd, 3rd).
- **Sex**: Gender of the passenger.
- **Age**: Age of the passenger.
- **Fare**: The ticket fare paid by the passenger.
- **SibSp**: Number of siblings or spouses aboard.
- **Embarked**: Port of embarkation (C = Cherbourg, Q = Queenstown, S = Southampton).

## Project Structure
This repository is organized as follows:

```plaintext
├── data/                      # Folder to store the dataset (Kaggle Titanic dataset)
├── R_scripts/                 # R scripts used for data analysis and visualization
├── plots/                     # Folder containing all generated plots
├── README.md                  # Project description and documentation
└── titanic_analysis.R         # Main R script for Titanic data analysis
```

## Analysis Breakdown

### 1. **Data Preprocessing**
   - Handle missing values in Age, Fare, and SibSp.
   - Convert categorical variables (Sex, Survived, etc.) into factors.
   - Summary statistics for numerical and categorical variables.

### 2. **Exploratory Data Analysis (EDA)**
   - **Measures of Central Tendency**: Calculation of mean, median, and mode for Age, Fare, and SibSp for both survivors and non-survivors.
   - **Measures of Dispersion**: Calculation of variance and standard deviation for the above variables.
   - **Boxplots**: Used to visualize the distribution of Age, Fare, and SibSp across survivors and non-survivors.
   - **Histograms**: Display age distribution by passenger class and sex.

### 3. **Data Visualizations**
   - **Survival Rate by Age**: Boxplot showing how age influences survival rates.
   - **Survival Rate by Fare**: Boxplot analyzing fare differences between survivors and non-survivors.
   - **Survival Rate by SibSp**: Boxplot depicting the relationship between the number of siblings/spouses aboard and survival.
   - **Histograms**: Age distribution across Sex and Passenger Class (Pclass) to show trends in survival rates.

### 4. **Statistical Findings**
   - Younger passengers had higher survival rates.
   - Passengers who paid higher fares had a greater chance of survival, likely due to their presence in higher-class cabins.
   - Passengers with fewer siblings/spouses aboard had a better chance of survival.

## Installation and Setup

### Prerequisites
Make sure you have the following installed:
- [R](https://cran.r-project.org/) (version 4.0+)
- [RStudio](https://rstudio.com/products/rstudio/download/) (optional, but recommended)
- Required R packages:
  ```R
  install.packages(c("dplyr", "ggplot2", "gridExtra"))
  ```

### Instructions to Run the Code
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/your-username/Titanic-Survival-Analysis.git
   ```
2. Open the R script `titanic_analysis.R` in RStudio.
3. Run the script to perform the analysis and generate visualizations.

### Running the Project
To run the analysis, follow these steps:
1. Load the dataset and R packages.
2. Run the preprocessing section to handle missing values.
3. Execute the exploratory data analysis to generate statistics.
4. Generate visualizations using the provided ggplot2 code.

## Project Report
Find the detailed report on the analysis in the <a href="https://github.com/saky-semicolon/Titanic-Survival-Analysis-using-R/blob/master/Project%20Report_Titanic%20Survival%20Analysis%20usinng%20R.pdf"> Project Report </a> file.


## Contributors
1. S M Asiful Islam Saky