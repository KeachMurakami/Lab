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
      actionButton("pre", "サンプルサイズを決める"),
      actionButton("post", "効果の強さを見る"),
      actionButton("reset", "Clear"), 
      textInput("PW",　"input following key after 'https://onedrive.live.com/download?'",　value = "")    ),
    dashboardBody(
      htmlOutput("URLlink"),
      plotlyOutput("Plotly")
    )
  )
)