library(shiny)
library(ggplot2)
library(ElemStatLearn)
data("ozone")

shinyServer(function(input, output) {
    brushed_data = reactive({
        bd = brushedPoints(ozone, input$brush1, xvar = "temperature", yvar = "ozone")
        if(nrow(bd)<2){
            return(NULL)
        }
        bd
    })
    modelPred = reactive({
        bd = brushed_data()
        if(is.null(bd))
            return(NULL)
        else {
            mpgInput = input$temp
            pr = predict(loess(ozone~temperature, data = bd), newdata = data.frame(temperature = mpgInput))
        }
    })
    output$ozonePlot <- renderPlot({
        gg = ggplot(data = ozone, aes(x = temperature, y = ozone))
        gg = gg + geom_point()
        if(!is.null(brushed_data())){
            gg = gg + geom_smooth(data = brushed_data())}
        if(!is.null(modelPred())){
            gg = gg + geom_point(data = data.frame(temperature = input$temp, ozone = modelPred()),
                                 col = "red")}
        gg
    })
    output$pointPr = renderText({
        pr = modelPred()
        if(is.null(pr))
            "No model found. Choose points on the plot to fit a model"
        else if (is.na(pr))
            return("Chosen points are too far from the prediction point. Can not predict")
        else 
            pr
    })
    url <- a("gh-pages",
             href="https://olarina.github.io/DevelopingDataProductsPrj3/projectDescr.html")
    output$dlink <- renderUI({
        tagList("More information about realization is available in presentation on", url)
    })
})
