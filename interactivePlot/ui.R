library(shiny)
doc = "This interactive plot shows that observations chosen to fit a model are
very important for a final prediction. To get the prediction select a temperature
on slider and then choose observations for model and prediction on plot. Get your prediction."

shinyUI(fluidPage(
    titlePanel("Dependency between ozone and temperarure"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("temp",
                        "Choose temperature:",
                        min = 57,
                        max = 97,
                        value = 79),
            h5("Ozone prediction for chosen temperature:"),
            textOutput("pointPr")
        ),
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Interactive plot", br(), plotOutput("ozonePlot", brush = brushOpts(id = "brush1"))),
                        tabPanel("Documentation", br(), doc, br(), uiOutput("dlink")))
        )
    )
))
