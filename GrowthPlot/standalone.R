library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)
library(magrittr)
library(plotly)

  # load the data
    GrowthLog <-
      "https://raw.githubusercontent.com/KeachMurakami/Lab/master/GrowthPlot/SampleData.csv" %>%
      read.csv %>%
      dplyr::mutate(Experiment = as.character(Experiment))
    
  # select shown variables
    ShownVariables <- colnames(GrowthLog)[-(1:6)]
    
    GrowthLogRaw <-
      GrowthLog %>%
      dplyr::mutate(Date_sowing = lubridate::ymd(Date_sowing),
                    Date_measured = lubridate::ymd(Date_measured),
                    DayAfterSowing = Date_measured- Date_sowing,
                    Experiment = as.factor(Experiment)) %>%
      tidyr::gather(variable, value,
                    -Name, -Experiment, -PlantNo, -Remark,
                    -Date_measured, -Date_sowing, -DayAfterSowing)
    
    # dummy symbols at the origin (day 0)
    GrowthLogInitial <-
      GrowthLogRaw %>%
      dplyr::distinct(Name, Date_measured, Date_sowing, Experiment, PlantNo, variable, .keep_all = T) %>%
      mutate(Date_measured = Date_sowing,
             DayAfterSowing = Date_measured - Date_sowing,
             value = .0001) %>%
      filter(variable %in% ShownVariables)
    
    # Raw dataset
    GrowthLog_all <-
      dplyr::bind_rows(GrowthLogRaw, GrowthLogInitial) %>%
      filter(variable %in% ShownVariables)
    
    # Mean & SD
    GrowthLog_mean <-
      GrowthLog_all %>%
      group_by(Name, Date_measured, Date_sowing, Experiment, variable) %>%
      summarise(SD = sd(value, na.rm = T),
                value = mean(value, na.rm = T)) %>%
      mutate(DayAfterSowing = Date_measured - Date_sowing,
             PlantNo = 0) %>%
      na.omit
    
    # plot
    GrowthPlot <-
      GrowthLog_mean %>%
      ggplot2::ggplot(aes(x = DayAfterSowing, y = value, col = Experiment, group = paste(Experiment, PlantNo))) +
      geom_errorbar(aes(ymin = value - SD, ymax = value + SD), width = rel(.1)) +
      geom_point() + 
      facet_grid(variable ~ Name, scale = "free")
    
    # add individual data points
    GrowthPlot <- 
      GrowthPlot +
      geom_point(data = GrowthLog_all, alpha = .25)
    
    if(TRUE){
    # add smoothing
      GrowthPlot <-
        GrowthPlot +
        geom_smooth(data = GrowthLog_all, aes(group = Experiment), alpha = .25)
    } else {
    # add lines
      GrowthPlot <-
        GrowthPlot +
        geom_line(alpha = .25)
    }
    
  # interactive plot    
    plotly::ggplotly(GrowthPlot)
