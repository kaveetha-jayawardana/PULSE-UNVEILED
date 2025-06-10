<h1 align="center"><b>PULSE-UNVEILED DASHBOARD</b></h1> 
<h3 align="center"><i>A Plotly-powered R Dashboard using Logistic Regression to visualize and analyze Heart Failure clinical records for predictions and insights</i></h3> 
<div align="center"> 
  <img height="180" src="https://media.giphy.com/media/v1.Y2lkPWVjZjA1ZTQ3ejE3ODVlNmRyZnc2M3loaHRvdTJqeXZubGo3Z2U0Z2ptajBibGdhaSZlcD12MV9zdGlja2Vyc19yZWxhdGVkJmN0PXM/irOvD4JoFVGdmgHXUB/giphy.gif" />
  <img height="180" src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExMWlmM2NhejJtejRpc3I3dzk0emQ1bXQ3NWd6bWMxNGJqYzZqMzQwdiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/qfta6FfdnpYTNSWxa2/giphy.gif" /> 
  <img height="180" src="https://media.giphy.com/media/v1.Y2lkPWVjZjA1ZTQ3M3V1N3hxa2QyaGdjZXd3MnRvYjVpNGpiajB5MXF3NmJoMXd4OXVycSZlcD12MV9zdGlja2Vyc19yZWxhdGVkJmN0PXM/UZkTfqda3N4BQnqAML/giphy.gif" /> 
  <img height="180" src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExZXJzMTAydnJwMmwyenJlM212aDBzOWphcHZsaGZ3cDNncDNpbHJ6aCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/DGTLeokrJoM50usQgs/giphy.gif" />
  <img height="180" src="https://media.giphy.com/media/v1.Y2lkPWVjZjA1ZTQ3ejE3ODVlNmRyZnc2M3loaHRvdTJqeXZubGo3Z2U0Z2ptajBibGdhaSZlcD12MV9zdGlja2Vyc19yZWxhdGVkJmN0PXM/A5gF0x2CYbesC9iHUN/giphy.gif" />
</div> <hr>

### 1. Introduction
Pulse Unveiled is an interactive Plotly dashboard built in R that visualizes and explores key insights from the UCI Heart Failure Clinical Records dataset. Using logistic regression and R Shiny, the dashboard helps predict survival outcomes in heart failure patients by examining attributes like age, serum creatinine levels, ejection fraction, and more. This project aims to provide data-driven guidance for healthcare professionals by identifying crucial risk factors influencing mortality among heart failure patients.

🤝 This project was developed by a group of second year undergraduates (4 members), as part of a university assignment for the BSc in Applied Data Science Communication degree program.

⚠️ Note: This project is open-source. Contributions and suggestions are welcome. Feel free to fork and adapt it for your own use.

<br>

### 2. Dataset Information
- Source: <a href="https://archive.ics.uci.edu/dataset/519/heart+failure+clinical+records"> UCI Heart Failure Clinical Records Dataset</a>
- Characteristics 
   - Records: 299 patient records
   - Attributes (13): Age, Gender, Anaemia, Diabetes, Ejection Fraction, Serum Creatinine, Smoking, Time (Follow-up), and more

<br>

### 3. Data Preparation & Methodology
- <b> Data Cleaning & Preprocessing :</b> The Heart Failure Clinical Records dataset was first loaded into R and preprocessed to ensure suitability for analysis.
    - Verified the absence of missing values
    - Converted target variable (DEATH_EVENT) into a factor for classification
    - Conducted exploratory data analysis (EDA) using `summary()`, `str()`, and `dim()` functions
    - Utilized correlation matrix and visualization techniques to understand feature relationships

- <b> Model Used :</b> Logistic regression was selected as the core data mining technique due to its ability to handle **binary classification** problems.
    - Built two logistic regression models to predict the probability of patient survival (DEATH_EVENT)
    - Evaluated key predictors like age, ejection fraction, and serum creatinine
    - Training and testing datasets were split in a 70:30 ratio
      
- <b> Evaluation Metrics :</b> Accuracy, Confusion Matrix, ROC curves

- <b>Visualization Techniques Used :</b> Interactive and static visualizations were created using various R packages to enhance interpretability.
  - `Corrplot` to assess feature correlations
  - `GGplot2`, `GGally::ggpairs` for pairwise scatter + density plots
  - `Plotly` interactive charts:
    * **Scatter:** Analyze gender distribution, platelet levels, symptom presence
    * **Boxplot:** Age distribution by Gender
    * **Bar / Pie:** Visualize death events, gender proportions, smoking impact
    * **3D Scatter:** Show interaction between ejection fraction, serum creatinine, and survival probability (Age × Ejection Fraction × Serum Creatinine → Death Risk)
    * **Multiple-bar:** Symptom presence (Anaemia, Diabetes, Hypertension)
    *  **Logistic Regression Curve :** Depict survival prediction trend using serum creatinine

- <b>Dashboard Implementation in R :</b> A dynamic dashboard was built using the `shiny` and `plotly` packages
  - Four tabs: Overview, Visualizations, Logistic Regression, and Summary
  - UI design implemented with `dashboardHeader()`, `sidebarMenu()` and custom backgrounds
  - All plots rendered using R code for enhanced interactivity and real-time data exploration

<br>

### 4. Dashboard Overview
The dashboard includes 4 interactive tabs:

 #### 📌 **Overview :** Dataset description and project summary.
<div align="center">
  <img src = "Dashboard - Page 1.png" />
</div>
<br>
<div align="center">
  <img src = "Dashboard - Page 2.png" />
</div>
<br>

 #### 📌 **Visualizations :** Scatter plots, boxplots, bar charts, pie charts, and 3D plots visualizing the data is depicted.
<div align="center">
  <img src = "Dashboard - Page 3.png" />
</div>
<br>
<div align="center">
  <img src = "Dashboard - Page 4.png" />
</div>
<br>

 #### 📌 **Logistic Regression :** Logistic regression curve with predictions
<div align="center">
  <img src = "Dashboard - Page 5.png" />
</div>
<br>
<div align="center">
  <img src = "Dashboard - Page 6.png" />
</div>
<br>

 #### 📌 **Summary :** Highlighted insights and conclusions
<div align="center">
  <img src = "Dashboard - Page 7.png" />
</div>
<br>

### 5. Key Insights
- **Survival Risk Factors:**
  - High serum creatinine and low ejection fraction strongly correlate with mortality.
  - Smokers showed a higher death rate than non-smokers.
  - Males had a higher representation in the dataset (64.9%).

- **Model Accuracy:**
  - Training Accuracy: 85.65%
  - Testing Accuracy: 77.78%

- **Visual Trends:**
  - Males tend to have higher platelet counts.
  - Most deaths occurred among patients with high serum creatinine.

<br>

## 📄 Documentation 
dashboard.R — Full R Shiny code for the interactive dashboard

heart_failure.csv — Cleaned dataset

screenshots/ — Dashboard preview images

report.pdf — Technical documentation and result analysis

<br>

## 📚 References
Chicco, D., & Jurman, G. (2020). Machine learning can predict survival of patients with heart failure

UCI Machine Learning Repository:

Heart Failure Dataset

Dashboard inspiration and tutorials:

https://youtu.be/-lN_JNvFSyE

https://youtu.be/_a4S4tq62OE

https://youtu.be/WmofiOklux8

💬 Contact
Feel free to raise issues, fork, or contribute to this project. For questions, reach out via GitHub or email.
