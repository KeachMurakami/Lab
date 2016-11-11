library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(magrittr)
library(plotly)
library(xlsx)
library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram

shinyUI(
  dashboardPage(
    dashboardHeader(title = "Growth Visualize"),
    dashboardSidebar(
      textInput("PW", label = "OneDrive link:",　value = " input "),
      fileInput("LocalFile", label = "file upload (csv/xlsx):", accept = c(".xlsx", ".csv")),
      sliderInput("IndivAlpha", label = "show individual data point", min = 0, max = 100, value = 0, step = 20),
      radioButtons("LinePlot", "style:", c("line" = T, "smoothing" = F)),
      checkboxGroupInput("VarSelect", label = 'select columns:',
                         choices = set_names(as.list(1:15), paste0("col.", 1:15)),
                         selected = 1:2)
      ),
    dashboardBody(
      htmlOutput("URLlink"),
      plotlyOutput("Plotly", height = "1500px", width = "100%")
    )
  )
)