#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#




# Define UI for application that draws a histogram
shinyUI(fluidPage(
    titlePanel("Carbon Sequestration Analysis Tool"),
    sidebarLayout(
        sidebarPanel(
            selectInput("lcg", label = h3("Land Cover - General"),
                        choices = unique(carbondatabase$`LC General`), selected = "Forests"),
            selectInput("lct", label = h3("Land Cover - Type"),
                        choices = unique(carbondatabase$`LC Type`), selected = "Evergreen"),
            selectInput("lcss", label = h3("Land Cover - Sub-specific"),
                        choices = unique(carbondatabase$`LC Sub-specific`), selected = "Douglas-fir"),
            selectInput("man", label = h3("Management"),
                        choices = unique(carbondatabase$Management), selected = "Evergreen"),
            textInput("age", "Age", "1", placeholder = 1),
            textInput("cardol", "Carbon Value", "1", placeholder = 1),
            textInput("acr", "Acreage", "1", placeholder = 1)
            
            
            
        ),
        
        mainPanel(strong("Example only, all data has been randomized"),
            
            tabsetPanel(type = "tabs",
                        tabPanel("Model Summary", verbatimTextOutput("summary"), actionButton("go", "Save"), actionButton("go", "Download")),
                        tabPanel("Prediction", verbatimTextOutput("prediction"), actionButton("go", "Save"), actionButton("go", "Download")), # Regression output
                        
                        tabPanel("Distribution", # Plots of distributions
                                 fluidRow(
                                     column(6, plotOutput("distribution1")),
                                     column(6, plotOutput("distribution2")))
                        ),
                        tabPanel("Data", DT::dataTableOutput('tbl')),# Data as datatable
                        tabPanel("Scatterplot", plotOutput("scatterplot")) # Plot
                        
                        
            )
        )
    )))
