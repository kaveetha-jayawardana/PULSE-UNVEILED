# Load required libraries
install.packages("plotly")
install.packages("shiny")
install.packages("shinyWidgets")
install.packages("dplyr")
install.packages("shinydashboard")
install.packages("DT")

library(shinydashboard)
library(DT)
library(plotly)
library(shiny)
library(shinyWidgets)
library(dplyr)

data <- read.csv("C:\\Users\\ATHUKORALA\\OneDrive\\Desktop\\heart_failure.csv")
data
head(data)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Heart failure dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
      menuItem("Visualizations", tabName = "visualizations", icon = icon("line-chart")),
      menuItem("Logistic Regression", tabName = "logistic", icon = icon("cogs")),
      menuItem("Summary", tabName = "summary", icon = icon("file"))
    )
  ),
  dashboardBody(
    tags$style(
      HTML(
        "
        .content-wrapper {
          background-image: url('https://d2jx2rerrg6sh3.cloudfront.net/images/news/ImageForNews_776422_17123165547518811.jpg');
          background-size: cover;
          background-repeat: no-repeat;
          background-attachment: fixed;
        }
        .box-header {
          background-color: #17a2b8; /* Change to desired color */
          color: #fff; /* Change to desired text color */
        }
        "
      )
    ),
    tabItems(
      # Page 1: Overview
      tabItem(tabName = "overview",
              fluidRow(
                box(title = "Embracing data to illuminate paths in heart health journey", status = "primary", solidHeader = TRUE, 
                    "This dashboard outlines a study conducted on a dataset of 299 patients with heart failure, collected in 2015. The study aims to analyze the dataset using both machine learning and traditional biostatistics methods to predict patients' survival and identify the most important risk factors associated with heart failure.",
                    width = 12),
                box(title = "Dataset Preview", status = "info", solidHeader = TRUE, 
                    DTOutput("dataHead"), width = 12)
              )
      ),
      
      # Page 2: Visualizations
      tabItem(tabName = "visualizations",
              fluidRow(
                box(title = "Age of the patients", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("AgePlot"), width =4 ),
                box(title = "Age vs Sex", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("SexPlot"), width = 4),
                box(title = "Platelets by Sex", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("PlateletsPlot"), width = 4),
                box(title = "Death Event vs the times the patient has smoked", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("DeathEventPlot"), width = 4),
                box(title = "Gender Distribution of the patients", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("PieChart"), width = 4),
                box(title = "3D Scatter Plot", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("Scatter3DPlot"), width = 4),
                box(title = "Death Event and the serum creatinine", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("SerumCreatininePlot"), width =4 ),
                box(title = "Prescence of symptoms in patients", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("PrescencePlot"), width =8 )
              )
      ),
      # Page 3: Logistic Regression Analysis
      tabItem(tabName = "logistic",
              fluidRow(
                box(title = "Model 01 Summary", status = "success", solidHeader = TRUE, 
                    verbatimTextOutput("modelSummary"), width = 12),
                box(title = "Predictive Model Plot", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("logisticPlot"), width = 12)
              )
      ),
      # Page 4: Summary and Key Points
      tabItem(tabName = "summary",
              fluidRow(
                box(title = "Significant Findings", status = "success", solidHeader = TRUE, 
                    uiOutput("keyInsights"), width = 12),
                box(title = "Suggestions", status = "success", solidHeader = TRUE, 
                    uiOutput("recommendations"), width = 12)
              )
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  output$dataHead <- renderDT({
    datatable(data)
  })
  
  output$AgePlot <- renderPlotly({
    plot_ly(data, x = ~Patient.ID, y = ~age, type = 'scatter', marker = list(color = 'skyblue'))
  })
  
  output$SexPlot <- renderPlotly({
    plot_ly(data, x = ~sex, y = ~age, type = 'box')
  })
  
  output$PlateletsPlot <- renderPlotly({
    plot_ly(data, x = ~platelets, color = ~sex, type = 'scatter')
  })
  
  output$DeathEventPlot <- renderPlotly({
    plot_ly(data, x = ~DEATH_EVENT, y = ~time, type = 'bar', marker = list(color = 'skyblue'))
  })
  
  output$PieChart <- renderPlotly({
    # Use the filtered dataset
    plot_ly(data = data, labels = ~sex, type = "pie", marker = list(colors = c("yellow", "blue"))) %>%
      layout(title = "Percentage Of Males and Females", height = 350)
  })
  
  output$Scatter3DPlot <- renderPlotly({
    # Your code for generating the 3D scatter plot goes here
    # Example:
    plot_ly(data, x = ~age, y = ~ejection_fraction, z = ~serum_creatinine, color = ~DEATH_EVENT, type = 'scatter3d')
  })
  
  output$SerumCreatininePlot <- renderPlotly({
    plot_ly(data, x = ~serum_creatinine, color = ~DEATH_EVENT, type = 'scatter')
  })
  
  output$PrescencePlot <- renderPlotly({
    plot_ly(data, y = ~ Patient.ID ) %>%
      add_trace(x = ~anaemia, name = "anaemia", type = 'bar') %>%
      add_trace(x = ~diabetes, name = "diabetes", type = 'bar') %>%
      add_trace(x = ~high_blood_pressure, name = "high_blood_pressure", type = 'bar') %>%
      layout(barmode = 'group', 
             xaxis = list(title = 'Symptoms'),  # X-axis label
             yaxis = list(title = 'Patient ID'))  # Y-axis label
  })
  
  output$modelSummary <- renderPrint({
    model <- glm(DEATH_EVENT ~ age + creatinine_phosphokinase + ejection_fraction + platelets + serum_creatinine + serum_sodium + sex + smoking + time, 
                 data = data, family = binomial())
    summary(model)
  })
  
  output$logisticPlot <- renderPlotly({
    model <- glm(DEATH_EVENT ~ serum_creatinine, data = data, family = binomial())
    
    # Predict probabilities using the model
    predictions <- predict(model, type = "response")
    
    # Create a new data frame with serum_creatinine values and their corresponding predictions
    plot_data <- data.frame(serum_creatinine = data$serum_creatinine, predictions = predictions)
    
    # Sort the data frame by serum_creatinine values for smoother lines in the plot
    plot_data <- plot_data[order(plot_data$serum_creatinine), ]
    
    # Create a scatter plot with lines connecting the points
    plot_ly(plot_data, x = ~serum_creatinine, y = ~predictions, type = 'scatter', mode = 'lines+markers')
  })
  
  output$keyInsights <- renderUI({
    tagList(
      h5("1. This discovery has the potential to impact on clinical practice, becoming a new supporting tool for physicians when predicting if a heart failure patient will survive or not. Indeed, medical doctors aiming at understanding if a patient will survive after heart failure may focus mainly on serum creatinine and ejection fraction.",style = "font-size: 16px;"),
      h5("2. his discovery may streamline and improve the accuracy of survival predictions, aiding physicians in making informed decisions about patient care.",style = "font-size: 16px;")
    )
  })
  
  output$recommendations <- renderUI({
    tagList(
      h5("Having a proper understanding about the prevalence, distribution, and burden of heart failure within populations helps in healthcare sector with resource allocation, planning, and policy-making. It plays a major role in making informed decisions related to healthcare infrastructure, workforce training, and allocation of financial resources.", style = "font-size: 16px;"),
      h5("Overall, analyzing the heart failure dataset plays a crucial role in improving our understanding of the disease, optimizing patient care, and guiding public health efforts aimed at reducing the burden of heart failure on individuals and healthcare system.", style = "font-size: 16px;")
    )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
