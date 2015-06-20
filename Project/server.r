library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
    
    output$text1 <- renderText({ 
        t_value <- (input$x_bar-input$u0)/(input$s/sqrt(input$n))
        df <- input$n-1
        paste("The T statistic for your data is", round(t_value,2), "with", df, "degrees of freedom")
        
        
    })
    output$text2 <- renderText({ 
        t_value <- (input$x_bar-input$u0)/(input$s/sqrt(input$n))
        df <- input$n-1
        if(input$Test_type == 1) {
            paste("P Value for a right hand test is : ", round(pt(t_value, df, lower.tail = FALSE),5))
        } else
        if(input$Test_type == 2) {
            paste("P Value for a left hand test is : ", round(pt(t_value, df, lower.tail = TRUE),5))
        } else
        if(input$Test_type == 3) {
            paste("P Value for a two sided test is : ", 2*round(pt(t_value, df, lower.tail = FALSE),5))
        }
    })  
    
    output$plot1 <- renderPlot({
        t_value <- (input$x_bar-input$u0)/(input$s/sqrt(input$n))
        df <- input$n-1
        q <- abs(t_value)+2
        x <- seq(-q, q, length = 100)
        y_val <- dt(x, df)
        t_plot <- as.data.frame(cbind(x, y_val))
        g <- ggplot(t_plot, aes(x,y_val)) + geom_line() + labs(x="t", y="Probability")
        if(input$Test_type == 1) {
            g + geom_ribbon(data=subset(t_plot,x>=t_value),aes(ymax=y_val),ymin=0,fill="red",colour=NA,alpha=0.5)
        } else
            if(input$Test_type == 2) {
               g + geom_ribbon(data=subset(t_plot,x<=t_value),aes(ymax=y_val),ymin=0,fill="red",colour=NA,alpha=0.5)
            } else
                if(input$Test_type == 3) {
                    g+ geom_ribbon(data=subset(t_plot,x>=(abs(t_value))),aes(ymax=y_val),ymin=0,fill="red",colour=NA,alpha=0.5) + geom_ribbon(data=subset(t_plot,x<=(-abs(t_value))),aes(ymax=y_val),ymin=0,fill="red",colour=NA,alpha=0.5)
                }
        
    })
}
)