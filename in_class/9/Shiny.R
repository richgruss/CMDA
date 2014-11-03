#Web Interactive Data Science with Shiny
#http://shiny.rstudio.com/gallery/

setwd('/Users/rgruss/git/CMDA/in_class/9')

install.packages("shiny")
library(shiny)

#have your ui.R and server.R files in the "App-1" folder
#in your working directory
#Save this Shiny.R file in the working directory

#Run your app by:

runApp("App.1")

#make new shiny apps by modifying examples and 
#examples in Shiny gallery

system.file("examples", package="shiny")

runExample("01_hello") # a histogram
runExample("02_text") # tables and data frames
runExample("03_reactivity") # a reactive expression
runExample("04_mpg") # global variables
runExample("05_sliders") # slider bars
runExample("06_tabsets") # tabbed panels
runExample("07_widgets") # help text and submit buttons
runExample("08_html") # shiny app built from HTML
runExample("09_upload") # file upload wizard
runExample("10_download") # file download wizard
runExample("11_timer") # an automated timer

