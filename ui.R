library(shiny)
library(highcharter)

shinyUI(fluidPage(

    titlePanel("Stock Chart"),

    sidebarLayout(
        sidebarPanel(
            textInput("symbol", "Symbol", value = "AAPL"),
            selectInput("daterange", "Source data date range:",
                        c("5d" = 5,
                          "1m" = 30,
                          "3m" = 90,
                          "6m" = 180,
                          "1y" = 365,
                          "3y" = 365 * 3),
                        selected = 30),
            # https://shiny.rstudio.com/reference/shiny/1.6.0/checkboxGroupInput.html
            checkboxGroupInput("indicators", "Indicators",
                               c("5MA" = "5MA",
                                 "20MA" = "20MA",
                                 "60MA" = "60MA",
                                 "EMA" = "EMA",
                                 "RSI" = "RSI",
                                 "MACD" = "MACD")),
            uiOutput("link"),
            textOutput("text")
        ),

        mainPanel(
            # https://jkunst.com/highcharter/ See: Highstock
            highchartOutput("distPlot", height = "540px")
        )
    )
))
