library(shiny)

shinyUI(fluidPage(
  
  
  sidebarLayout(
    sidebarPanel(
      h1("Finding Death rate "),
      
      
      sliderInput("bin1","change the value",min=-1000,max=1000,value=10,step=10),
      sliderInput("bin2","change the value",min=-1000,max=1000,value=10,step =10),
      sliderInput("bin3","change the value",min=-1000,max=1000,value=10,step=10)
      
    ),
    mainPanel(
      
      plotOutput("my_plot"),
      h3("predicted value"),
      textOutput("Predicted")
      
      
    )
  )
  
))