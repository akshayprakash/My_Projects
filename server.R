
shinyServer(function(input, output) {
    
  output$text1 <- renderText({  
    paste("Description: ", WDIsearch(string = input$ind, 
                                     field = "indicator", short = FALSE)[3])
  })
  
  output$text2 <- renderText({  
    paste("Source Database: ", WDIsearch(string = input$ind, 
                                     field = "indicator", short = FALSE)[4])
  })
  
  output$text3 <- renderText({  
    paste("Source Organization: ", WDIsearch(string = input$ind, 
                                     field = "indicator", short = FALSE)[5])
  })
  
    output$wdi = renderPlot({
      choroplethr_wdi(code=input$ind, year=input$year,,  buckets = input$k)
    })
    
    output$map = renderGvis({
      df = WDI(country = "all", indicator = input$ind,
               start = input$year, end = input$year, extra = FALSE, cache = NULL)
      gvisGeoChart(df, "country", input$ind, 
                        options=list(colors="['#aabbcc','#FF6600']", region = input$r, width=600, height=400))
    })
  })