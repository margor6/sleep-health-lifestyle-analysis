# Sleep Health & Lifestyle Analysis 💤

![R](https://img.shields.io/badge/R-4.0%2B-blue)
![RMarkdown](https://img.shields.io/badge/Document-RMarkdown-orange)
![Status](https://img.shields.io/badge/Status-Completed-success)

## Overview

This project analyzes the impact of lifestyle factors (such as physical activity, BMI, and age) on sleep quality and stress levels. Based on the "Sleep Health and Lifestyle Dataset", the analysis identifies key correlations and statistical significance between daily habits and health metrics.

The repository contains the full analysis in Polish (`report.pdf`), including detailed interpretations.

## Key Findings

* **Gender vs. Sleep:** A T-test confirmed statistically significant differences in sleep duration between men and women.
* **BMI vs. Stress:** ANOVA and Tukey's HSD test revealed significant differences in stress levels between overweight individuals and those with normal weight.
* **Activity vs. Sleep Quality:** Linear regression analysis showed that physical activity has a significant positive impact on sleep quality (Model $R^2 \approx 0.19$).

## Methodology

* **Data Cleaning:** `tidyverse`, `dplyr` (recoding BMI categories, factor handling).
* **Visualization:** `ggplot2` (boxplots, scatter plots), `corrplot` (correlation matrix).
* **Statistical Tests:**
    * **T-Student Test** (Independent samples)
    * **ANOVA** (Analysis of Variance)
    * **Tukey HSD** (Post-hoc analysis)
    * **Linear Regression** (Modeling relationships)
* **Reporting:** RMarkdown (exported to PDF via XeLaTeX).

## Repository Structure

* `report.Rmd` - Source code of the analysis in RMarkdown.
* `report.pdf` - Generated report with all charts and interpretations (in Polish).
* `Sleep_health_and_lifestyle_dataset.csv` - Raw dataset used for the analysis.

## Installation and Usage

1.  Clone the repository.
2.  Open `analysis.Rmd` in RStudio.
3.  Ensure the following packages are installed:
    ```r
    install.packages(c("tidyverse", "knitr", "corrplot"))
    ```
4.  Knit the document to PDF or HTML.
