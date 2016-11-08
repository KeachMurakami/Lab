library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)
library(magrittr)
library(plotly)
library(xlsx)
library(shiny)
library(shinydashboard)

shinyServer(function(input, output) {
  
  output$URLlink <- renderText({'<a href = "https://github.com/KeachMurakami/Lab/tree/master/GrowthPlot">コードなど@GitHub</a>'})
  
  output$Plotly <- renderPlotly({
    
    GrowthLog <-
      paste0("https://onedrive.live.com/download?", input$PW) %>%
      read.csv %>%
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
    
    GrowthLog_initial <-
      GrowthLogRaw %>%
      dplyr::distinct(Name, Date_measured, Date_sowing, Experiment, PlantNo, variable, .keep_all = T) %>%
      mutate(Date_measured = Date_sowing,
             DayAfterSowing = Date_measured - Date_sowing,
             value = .0001)
    
    GrowthLog_all <-
      dplyr::bind_rows(GrowthLogRaw, GrowthLog_initial) %>%
      filter(variable %in% ShownVariables)
    
    GrowthLog_mean <-
      GrowthLogRaw %>%
      group_by(Name, Date_measured, Date_sowing, Experiment, variable) %>%
      summarise(SD = sd(value, na.rm = T),
                value = mean(value, na.rm = T)) %>%
      mutate(DayAfterSowing = Date_measured - Date_sowing,
             PlantNo = 0) %>%
      filter(variable %in% ShownVariables)
    
    GrowthPlot <-
      GrowthLog_all %>%
      ggplot2::ggplot(aes(x = DayAfterSowing, y = value, col = Experiment, group = paste(Experiment, PlantNo))) +
      geom_errorbar(data = GrowthLog_mean, aes(ymin = value - SD, ymax = value + SD), width = rel(.1)) +
      geom_point(data = GrowthLog_mean) +
      geom_point(alpha = .25) +
      geom_line(alpha = .25) + 
      geom_smooth(aes(group = Experiment), alpha = .3) +
      facet_grid(variable ~ Name)
    
    ggplotly(GrowthPlot)
  })
})