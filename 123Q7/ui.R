library(shiny) 

shinyUI(fluidPage(
    titlePanel("Predict Ozone level, given the Temp From airquality dataset"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderTemp", "What is the Ozone level?", 12, 150, value = 75),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            submitButton("Submit")
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predicted Ozone level from Model 1:"), 
            textOutput("pred1"),
            h3("Predicted Ozone level from Model 2:"),
            textOutput("pred2")
        )
    )
))