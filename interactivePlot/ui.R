#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Old Faithful Geyser Data"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Interactive plot", br(), plotOutput("distPlot")),
                        tabPanel("Documentation", br(),"Write a shiny application with associated supporting documentation. The documentation should be thought of as whatever a user will need to get started using your application.Write a shiny application with associated supporting documentation. The documentation should be thought of as whatever a user will need to get started using your application.", br(), uiOutput("dlink")))
        )
    )
))
