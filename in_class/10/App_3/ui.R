shinyUI(pageWithSidebar(
  headerPanel('Protein k-means clustering'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(protein1)),
    selectInput('ycol', 'Y Variable', names(protein1),
                selected=names(protein1)[[2]]),
    numericInput('clusters', 'Cluster count', 5,
                 min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
))
