#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# SERVER
shinyServer(function(input, output, session) {
    
    updateSelectizeInput(session, "lcg",
                choices = c("All"), selected = "All", server =TRUE)
    
    updateSelectizeInput(session, "lct",
                choices = c("All", unique(carbondatabase$`LC Type`)), selected = "All", server =TRUE)
    
    updateSelectizeInput(session, "lcss",
                choices = c("All",unique(carbondatabase$`LC Sub-specific`)), selected = "All", server =TRUE)
    
    updateSelectizeInput(session, "man", 
                choices = c("All",unique(carbondatabase$Management)), selected = "All", server =TRUE)
    
    
    newcarbondb <- reactive({dataframe(carbondatabase %>% filter(`LC General` == input$lcg))})
    # Regression output
    output$summary <- renderPrint({
        carbondatabase$`LC General` <- as.character(carbondatabase$`LC General`)
        data <- carbondatabase
        data$`LC General` <- as.numeric(data$`LC General`)
        if (input$lcg != "All") {
            data <- data[data$`LC General` == input$lcg,]
        }
        if (input$lct != "All") {
            data <- data[data$`LC Type` == input$lct,]
        }
        if (input$lcss != "All") {
            data <- data[data$`LC Sub-specific` == input$lcss,]
        }
        if (input$man != "All") {
            data <- data[data$Management == input$man,]
        }
        data
        fit <- lm(data$value ~ data$Age + I(data$Age^2) + I(data$Age^3))
        summary(fit)

    })
    
    # Data output
    output$tbl = DT::renderDataTable(DT::datatable({
        carbondatabase$`LC General` <- as.character(carbondatabase$`LC General`)
        data <- carbondatabase
        data$`LC General` <- as.numeric(data$`LC General`)
        if (input$lcg != "All") {
            data <- data[data$`LC General` == input$lcg,]
        }
        if (input$lct != "All") {
            data <- data[data$`LC Type` == input$lct,]
        }
        if (input$lcss != "All") {
            data <- data[data$`LC Sub-specific` == input$lcss,]
        }
        if (input$man != "All") {
            data <- data[data$Management == input$man,]
        
        }
        data
    }, extensions = 'Buttons',
    
    options = list(
        paging = TRUE,
        searching = TRUE,
        fixedColumns = TRUE,
        autoWidth = TRUE,
        ordering = TRUE,
        dom = 'tB',
        buttons = c('copy', 'csv', 'excel')
    ),
    
    class = "display"
    ))
    
    #prediction
    

    output$prediction = renderText({
        
            carbondatabase$`LC General` <- as.character(carbondatabase$`LC General`)
            data <- carbondatabase
            data$`LC General` <- as.numeric(data$`LC General`)
            if (input$lcg != "All") {
                data <- data[data$`LC General` == input$lcg,]
            }
            if (input$lct != "All") {
                data <- data[data$`LC Type` == input$lct,]
            }
            if (input$lcss != "All") {
                data <- data[data$`LC Sub-specific` == input$lcss,]
            }
            if (input$man != "All") {
                data <- data[data$Management == input$man,]
            }
            data
        
        age <- input$age
        newdata <- data.frame(Age=as.numeric(age))
        fit <- lm(value ~ Age, data = data)
        pred <- predict(fit, newdata)
         pred * as.numeric(input$cardol) * as.numeric(input$acr)



    })
    
    
    # Scatterplot output
    output$scatterplot <- renderPlot({
        carbondatabase$`LC General` <- as.character(carbondatabase$`LC General`)
        data <- carbondatabase
        data$`LC General` <- as.numeric(data$`LC General`)
        if (input$lcg != "All") {
            data <- data[data$`LC General` == input$lcg,]
        }
        if (input$lct != "All") {
            data <- data[data$`LC Type` == input$lct,]
        }
        if (input$lcss != "All") {
            data <- data[data$`LC Sub-specific` == input$lcss,]
        }
        if (input$man != "All") {
            data <- data[data$Management == input$man,]
        }
        data
        plot(data$Age, data$value, main="Scatterplot")
        abline(lm(data$value ~ data$Age), col="red")
    }, height=400)
    
    
    # Histogram output var 1
    output$distribution1 <- renderPlot({
        carbondatabase$`LC General` <- as.character(carbondatabase$`LC General`)
        data <- carbondatabase
        data$`LC General` <- as.numeric(data$`LC General`)
        if (input$lcg != "All") {
            data <- data[data$`LC General` == input$lcg,]
        }
        if (input$lct != "All") {
            data <- data[data$`LC Type` == input$lct,]
        }
        if (input$lcss != "All") {
            data <- data[data$`LC Sub-specific` == input$lcss,]
        }
        if (input$man != "All") {
            data <- data[data$Management == input$man,]
        }
        data
        hist(data$value, main="", xlab="Value")
    }, height=300, width=300)
    
    # Histogram output var 2
    output$distribution2 <- renderPlot({
        carbondatabase$`LC General` <- as.character(carbondatabase$`LC General`)
        data <- carbondatabase
        data$`LC General` <- as.numeric(data$`LC General`)
        if (input$lcg != "All") {
            data <- data[data$`LC General` == input$lcg,]
        }
        if (input$lct != "All") {
            data <- data[data$`LC Type` == input$lct,]
        }
        if (input$lcss != "All") {
            data <- data[data$`LC Sub-specific` == input$lcss,]
        }
        if (input$man != "All") {
            data <- data[data$Management == input$man,]
        }
        data
        hist(data$Age, main="", xlab="Age")
    }, height=300, width=300)
})

