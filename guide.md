# Introduction

[StockChart](https://chiahsun.shinyapps.io/ShinyDemo/) is a [Shiny](https://shiny.rstudio.com/) application built on [quantmod](https://www.quantmod.com/) for financial modeling and [highcharter](https://jkunst.com/highcharter/) for visualization.

You can view the presentation [here](https://chiahsun.github.io/coursera-data-products-shiny/).

# Symbol Selection

Enter your stock symbol under `Symbol` for visualization, e.g. AAPL, FB, etc.

[Stock symbol](https://en.wikipedia.org/wiki/Ticker_symbol)

Mouse over on the chart to get open, high, low, close values on specific days.

# Date Range

Choose different date range for visualization under `Source data date range:`.

* 5d, 1m, 3m, 6m, 1y, 3y.

# Indicators

Toggle your favorite indicators under `Indicators
`.

* 5MA, 20MA, 60MA, EMA, RSI, MACD

* For MA, it will show on the same y-axis.
* For RSI, MACD, it will show on the new y-axis.

Mouse over on the chart to get indicator values.

The indicator is computed at server side using the R quantmod package.

Note: 

* If you choose `5d`, then `20MA` won't work.
* If you choose `5d`, `1m`, then `60MA` won't work.
