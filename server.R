library(forecast)
library(plyr)

GLT2 <- read.csv(file = "GLT2.csv", stringsAsFactors = F)
countrynames <- read.csv(file = "country_names.csv", stringsAsFactors = F)

shinyServer(function(input, output) {
        
        output$Country_names <- renderUI({
                selectizeInput("ccountry","Select Country", countrynames[,2], multiple = FALSE, select = 1)
        })
        
        output$City_names <- renderUI ({
                selectizeInput("ccity", "Select City", citynames(), multiple = FALSE, select = 1)
        })
        
     
        citynames <- reactive({
                current_country <- input$ccountry
                count(GLT2[GLT2$Country==current_country,],'City')[,1]
                                                          })
        
        
        cityyvar <- reactive({
                city2 <- input$ccity
                city2
        })
        
        
            temperaturex <- reactive({
                selectedcity <- cityyvar()
                current_city <- GLT2[GLT2$City==selectedcity,]
                combo <- ts(current_city$AverageTemperature, start=c(2003,9), end=c(2013,8), frequency = 12)
                lastdate <- as.Date("2013-08-01")
                mydate <- input$date
                m32 <- stl(combo, s.window = "periodic") #model data with STL
                d4 <- length(seq(lastdate, mydate, "month"))-1   # Calculate month difference from 2013 August
                f32 <- forecast(m32, h = d4)
                round(f32$upper[length(f32$upper)],2)
        })
        
       output$temperature2 <- reactive({
              t2<- temperaturex()
                          return(t2)
       })
        
        output$temperature3 <- reactive({
                t3 <- temperaturex()
                round(t3*1.8+32,2)
        })
        
        
})      