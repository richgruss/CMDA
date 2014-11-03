library(shiny)

# Define UI for application that calculates performance measures for logistic regression classifier
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Validation of Classification with Logistic Regression"),
  
  # Sidebar with a slider input for the threshold
  sidebarLayout(
    sidebarPanel(
      # Decimal interval with step value
      sliderInput("threshold", "Threshold:", 
                  min = 0, max = 1, value = 0.5, step= 0.1)
    ),
    # Show a table summarizing the values entered
    mainPanel(
      h4("Threshold Probability"),
      tableOutput("values"),
      
      h4("Predicted vs. Actual in Test Set"),
      tableOutput("view"),
            
      h4("Confusion Matrix for the Selected Threshold with Column the Actual"),
      tableOutput("confusion"),
      
      h4("Performance Measures Based on Confusion Matrix"),
      tableOutput("measures")
      
      
    )
  )
))
