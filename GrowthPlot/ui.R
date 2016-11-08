library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)
library(magrittr)
library(plotly)
library(xlsx)
library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram

shinyUI(
  dashboardPage(
    dashboardHeader(title = "Growth analysis of Tobacco in the LAB"),
    dashboardSidebar(
      textInput("PW",　"input following key after 'https://onedrive.live.com/download?'",　value = "cid=C44EDADBA0053805&resid=C44EDADBA0053805%211471&authkey=AJH-4sGauQYPF-g"),
      checkboxGroupInput("VarSelect", label = 'Columns to show:',
                         choices = set_names(as.list(1:10), paste0("col.", 1:10)),
                         selected = 1:2)
      ),
    dashboardBody(
      htmlOutput("URLlink"),
      plotlyOutput("Plotly", height = "800px")
    )
  )
)
