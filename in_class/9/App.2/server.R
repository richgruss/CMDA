

library(shiny)

# Define server logic for logistic classifier with variable threshold
shinyServer(function(input, output) {
  
  # Reactive expression to compose a data frame containing all of
  # the values
  sliderValues <- reactive({
    
    # Compose data frame
    data.frame(
      Name = c("Threshold") 
               ,
      Value = as.character(c(input$threshold 
                             )), 
      stringsAsFactors=FALSE)
  }) 
  
  # Show the values using an HTML table
  output$values <- renderTable({
    sliderValues()
  })
  
  # Show the first "6" test predicted and actual observations
  #Need to have the test data frame with predicted values already created
  output$view <- renderTable({
    head(test[,c('pred','atRisk')])
  })
  
 
  #Show calculated confusion matrix with input threshold
  output$confusion <- renderTable({
    table(pred=test$pred>input$threshold, target = test$atRisk)
  })
  #Calculate performance measures and make a table
  
  output$measures <- renderTable({
    confusion.test <- table(pred=test$pred>input$threshold, target = test$atRisk)
    accuracy <- (confusion.test[2,2] + confusion.test[1,1])/sum(confusion.test[,])
    precision <- confusion.test[2,2] / sum(confusion.test[2,])
    recall <- confusion.test[2,2] / sum(confusion.test[,2])
    as.table(matrix(data=
                  c("accuracy","precision TP/(TP+FP)","recall TP/(TP+FN)",round(accuracy,3),round(precision,3),round(recall,3)),
                    nrow = 3, ncol = 2,
                    dimnames = list(c("1","2","3"),c("Measure","Value"))))
  })
})
