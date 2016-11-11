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
    dashboardHeader(title = "Growth analysis of Tobacco in the LAB"),
    dashboardSidebar(
      textInput("PW",　"OneDriveファイルのID",　value = " input "),
      fileInput("localFile", "ファイルをアップロード (csv/xlsx)", accept = c(".xlsx", ".csv")),
      sliderInput("IndivAlpha", label = "個別データの表示濃度", min = 0, max = 100, value = 0, step = 20),
      checkboxInput("Regression", label = 'カーブ (個別データで回帰) \n 折線 (実測)', value = F),
      checkboxGroupInput("VarSelect", label = '表示するカラム',
                         choices = set_names(as.list(1:15), paste0("col.", 1:15)),
                         selected = 1:2)
      ),
    dashboardBody(
      # print(set_names(as.list(textOutput("test")), textOutput("test")))),
      htmlOutput("URLlink"),
      plotlyOutput("Plotly", height = "800px", width = "100%")
    )
  )
)