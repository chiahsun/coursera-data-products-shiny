library(shiny)
library(quantmod)
library(highcharter)

shinyServer(function(input, output) {
    # This text can be used for debugging
    output$text <- renderText({ "Loaded" })
    
    output$distPlot <- renderHighchart({

        # http://www.quantmod.com/examples/intro/
        stockData <- getSymbols(input$symbol, from = Sys.Date() - as.numeric(input$daterange), 
                                to = Sys.Date(), src="yahoo", auto.assign = FALSE)
        # stockData <- get(stock)
        
        # Rename AAPL.Open to Open, etc
        colnames(stockData) <- c("Open", "High", "Low", "Close", colnames(stockData)[5:length(colnames(stockData))])
        
        hc <- highchart(type = "stock") 
        
        # help(hc_yAxis_multiples)
        # https://rdrr.io/cran/highcharter/man/hc_add_yAxis.html
        # https://www.highcharts.com/demo/combo-multi-axes
        yAxisId <- 0
        hc <- hc %>%
            hc_title(text = input$symbol) %>%
            hc_add_series(stockData, yAxis = yAxisId, showInLegend = FALSE) %>%
            hc_add_yAxis(nid = 1L, title = list(text = "Prices"), relative = 2)
        yAxisId <- yAxisId + 1
        
        indicatorDashType <- "ShortDash"
        indicatorMarker <- c(radius = 2)
        indicatorLineWidth <- 1.5
      
        if ("EMA" %in% input$indicators) {
            closeEMA <- EMA(stockData$Close)
            # https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/plotoptions/series-dashstyle-all/
            # https://api.highcharts.com/highcharts/plotOptions.series.marker.radius
            hc <- hc  %>% hc_add_series(closeEMA, name = "EMA", dashStyle = indicatorDashType, marker = indicatorMarker, lineWidth = indicatorLineWidth)
        }
        
        if ("5MA" %in% input$indicators) {
            ma <- SMA(stockData$Close, n = 5)
            hc <- hc  %>% hc_add_series(ma, name = "5MA", dashStyle = indicatorDashType, marker = indicatorMarker, lineWidth = indicatorLineWidth)
        }
        
        if ("20MA" %in% input$indicators) {
            ma <- SMA(stockData$Close, n = 20)
            hc <- hc  %>% hc_add_series(ma, name = "20MA", dashStyle = indicatorDashType, marker = indicatorMarker, lineWidth = indicatorLineWidth)
        }
        
        if ("60MA" %in% input$indicators) {
            ma <- SMA(stockData$Close, n = 60)
            hc <- hc  %>% hc_add_series(ma, name = "60MA", dashStyle = indicatorDashType, marker = indicatorMarker, lineWidth = indicatorLineWidth)
        }
        
        if ("RSI" %in% input$indicators) {
            rsi <- RSI(stockData$Close)
            hc <- hc %>% 
                hc_add_series(rsi, name = "RSI", dashStyle = indicatorDashType, marker = indicatorMarker, lineWidth = indicatorLineWidth, yAxis = yAxisId) %>%
                hc_add_yAxis(nid = 2L, title = list(text = "RSI"), relative = 1)

            yAxisId <- yAxisId + 1
        }
        
        if ("MACD" %in% input$indicators) {
            macd <- RSI(stockData$Close)
            hc <- hc %>% 
                hc_add_series(macd, name = "MACD", dashStyle = indicatorDashType, marker = indicatorMarker, lineWidth = indicatorLineWidth, yAxis = yAxisId) %>%
                hc_add_yAxis(nid = 2L, title = list(text = "MACD"), relative = 1)
                
            yAxisId <- yAxisId + 1
        }
      
        hc <- hc %>% hc_add_theme(hc_theme_darkunica()) %>%
            hc_xAxis(type = "datetime")
    })

})
