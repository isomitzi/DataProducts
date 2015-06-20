library(shiny)
shinyUI(fluidPage(
    titlePanel("T test calculator"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("This page will take your sample data and will calculate the P value."),
            
            numericInput("n", 
                        label = "Sample Size", value = 30)
            ,
            
            numericInput("x_bar", 
                         label = "Sample mean", value = 5)
            ,
            numericInput("s", 
                         label = "Sample SD", value = 8)
            ,
            numericInput("u0", 
                         label = "Hypothesized value ", value = 4)
            ,
            radioButtons("Test_type", label = h3("Required Test"),
                         choices = list("Right Hand Test" = 1, "Left Hand Test" = 2,
                                        "Two Sided Test" = 3),selected = 1)
            ,
            submitButton(text = "Run Test!", icon = NULL)
            ),
        
        mainPanel(
            h2("Results"),
            textOutput("text1"),
            textOutput("text2"),
            h2("Visual representation of the test "),
            plotOutput("plot1")
        
        )
    )
))