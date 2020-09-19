library(shiny)

shinyServer(function(input, output) {
    airquality$Tempsp <- ifelse(airquality$Temp - 75 > 0, airquality$Temp - 75, 0)
    model1 <- lm(Ozone ~ Temp, data = airquality)
    model2 <- lm(Ozone ~ Tempsp + Temp, data = airquality)
    
    model1pred <- reactive({
        TempInput <- input$sliderTemp
        predict(model1, newdata = data.frame(Temp = TempInput))
    })
    
    model2pred <- reactive({ 
        TempInput <- input$sliderTemp
        predict(model2, newdata =
                    data.frame(Temp = TempInput,Tempsp = ifelse(TempInput - 75 > 0,
                                                                TempInput - 75, 0)))
                               
    })
    output$plot1 <- renderPlot({
        TempInput <- input$sliderTemp
        
        plot(airquality$Temp, airquality$Ozone, xlab = "Ozone Level",
             ylab = "Temperature", bty = "n", pch = 16, 
             xlim = c(12, 150), ylim = c(12, 360))
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        if(input$showModel2){ 
            model2lines <- predict(model2, newdata = data.frame(
                Temp = 12:150,  Tempsp = ifelse(12:150 - 75 > 0, 12:150 - 75, 0)
            ))
            lines(12:150, model2lines, col = "blue", lwd = 2) 
        }
        legend(70, 350, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
               col = c("red", "blue"), bty = "n", cex = 1.2)
        points(TempInput, model1pred(), col = "red", pch = 16, cex = 2)
        points(TempInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })
    output$pred1 <- renderText({ 
        model1pred()
    })
    output$pred2 <- renderText({
        model2pred()
    })
})
