library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)
library(magrittr)
library(plotly)
library(xlsx)
library(shiny)
library(shinydashboard)
library(xlsx)

shinyServer(function(input, output) {
  
  output$URLlink <- renderText({'<a href = "https://github.com/KeachMurakami/Lab/tree/master/GrowthPlot">コードなど@GitHub</a>'})
  
  fileInput <- reactive({
    inFile <- input$LocalFile
    if(!is.null(inFile)){
      is_xlsx <-
        inFile$name %>%
        stringr::str_match(., ".csv$") %>%
        .[[1]] %>%
        is.na
      if(is_xlsx){
        inFile$datapath %>%
          read.xlsx(sheetIndex = 1) %>%
          return
      } else {
        inFile$datapath %>%
          read.csv %>%
          return
      }
    } else {
      input$PW %>%
        stringr::str_extract(pattern = "https.+width") %>%
        stringr::str_sub(start = 0, -8) %>%
        paste0("https://onedrive.live.com/download?", .) %>%
        read.csv %>%
        return
    }
  })
  

  output$FigHeight <- renderText(
    input$FigHeight
      )

  output$Plotly <- renderPlotly({
    GrowthLog <-
      fileInput() %>%
      mutate(Experiment = as.character(Experiment))
    
    ShownVariables <- colnames(GrowthLog)[-(1:6)][as.numeric(input$VarSelect)]
    
    GrowthLogRaw <-
      GrowthLog %>%
      dplyr::mutate(Date_sowing = lubridate::ymd(Date_sowing),
                    Date_measured = lubridate::ymd(Date_measured),
                    DayAfterSowing = Date_measured- Date_sowing,
                    Experiment = as.factor(Experiment)) %>%
      tidyr::gather(variable, value,
                    -Name, -Experiment, -PlantNo, -Remark,
                    -Date_measured, -Date_sowing, -DayAfterSowing)
    
    GrowthLog_all <-
      GrowthLogRaw %>%
      dplyr::distinct(Name, Date_measured, Date_sowing, Experiment, PlantNo, variable, .keep_all = T) %>%
      mutate(Date_measured = Date_sowing,
             DayAfterSowing = Date_measured - Date_sowing,
             value = .0001) %>%
      dplyr::bind_rows(GrowthLogRaw, .) %>%
      filter(variable %in% ShownVariables)
    
    GrowthLog_mean <-
      GrowthLog_all %>%
      group_by(Name, Date_measured, Date_sowing, Experiment, variable) %>%
      summarise(SD = sd(value, na.rm = T),
                value = mean(value, na.rm = T)) %>%
      mutate(DayAfterSowing = Date_measured - Date_sowing,
             PlantNo = 0) %>%
      na.omit
    
    GrowthPlot <-
      GrowthLog_mean %>%
      ggplot2::ggplot(aes(x = DayAfterSowing, y = value, col = Experiment, group = paste(Experiment, PlantNo))) +
      geom_errorbar(aes(ymin = value - SD, ymax = value + SD), width = rel(.1)) +
      geom_point() + 
      facet_grid(variable ~ Name, scale = "free")
      
      GrowthPlot <- 
        GrowthPlot +
        geom_point(data = GrowthLog_all, alpha = input$IndivAlpha/100)

      
    if(input$LinePlot){
      GrowthPlot <-
        GrowthPlot +
        geom_line(alpha = .25)
    } else {
      GrowthPlot <-
        GrowthPlot +
        geom_smooth(data = GrowthLog_all, aes(group = Experiment), alpha = .25)
    }
    
    ggplotly(GrowthPlot)
  })
})