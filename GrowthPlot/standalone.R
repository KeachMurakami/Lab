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
    ShownVariables <- colnames(GrowthLog)[-(1:6)][1:2]
    
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
    GrowthLog_initial <-
      GrowthLogRaw %>%
      dplyr::distinct(Name, Date_measured, Date_sowing, Experiment, PlantNo, variable, .keep_all = T) %>%
      dplyr::mutate(Date_measured = Date_sowing,
                    DayAfterSowing = Date_measured - Date_sowing,
                    value = .0001)
    
  # calculate mean & sd
    GrowthLog_mean <-
      GrowthLogRaw %>%
      dplyr::group_by(Name, Date_measured, Date_sowing, Experiment, variable) %>%
      dplyr::summarise(SD = sd(value, na.rm = T),
                value = mean(value, na.rm = T)) %>%
      dplyr::mutate(DayAfterSowing = Date_measured - Date_sowing,
                    PlantNo = 0) %>%
      dplyr::filter(variable %in% ShownVariables)

  # non-interactive plot
    GrowthPlot <-
      dplyr::bind_rows(GrowthLogRaw, GrowthLog_initial) %>%
      dplyr::filter(variable %in% ShownVariables) %>%
      ggplot2::ggplot(aes(x = DayAfterSowing, y = value, col = Experiment, group = paste(Experiment, PlantNo))) +
      geom_errorbar(data = GrowthLog_mean, aes(ymin = value - SD, ymax = value + SD), width = rel(.1)) +
      geom_point(data = GrowthLog_mean) +
      geom_point(alpha = .25) +
      geom_line(alpha = .25) + 
      geom_smooth(aes(group = Experiment), alpha = .3) +
      facet_grid(variable ~ Name)

  # interactive plot    
    plotly::ggplotly(GrowthPlot)
