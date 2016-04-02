shinyUI(fluidPage (
        
        titlePanel("Monthly Average Temperature Prediction of Selected Cities"),
        h5("yogarjun77 - March 2016", align = "right"),
        h5("Please wait a moment while the data loads"),
        
        sidebarLayout(
                sidebarPanel(
                        uiOutput("Country_names"),
                        
                        uiOutput("City_names"),
                        
                        dateInput('date',
                                  label = 'Select Date:',
                                  value = Sys.Date()
                        )
                ),
                
                mainPanel(
                        h3(' Average Temperature in °C'),
                        hr(),
                        fluidRow(column(4,verbatimTextOutput("temperature2"))),
                        
                        
                        h3('Average Temperature in °F'),
                        hr(),
                        fluidRow(column(4,verbatimTextOutput("temperature3")))
                )
        ),
        h5('Raw data from Berkeley Earth Data Page extracted via Kaggle.com', align = "center" ),
        h5("", a("Berkeley Earth Data", href="http://berkeleyearth.org/data/"),align = "center"),
        h5('Prediction model developed with stl algorithm using 10 years data from 2003 to 2013', align = "center")
))