shinyUI(pageWithSidebar(
  headerPanel('Iris k-means clustering'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(scaled_features_frame)),
    selectInput('ycol', 'Y Variable', names(scaled_features_frame),
                selected=names(scaled_features)[[2]]),
    numericInput('clusters', 'Cluster count', 5,
                 min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
))
