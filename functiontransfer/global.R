
library(shiny)
library(ggvis)
library(dplyr)
library(shiny)
library(readxl)


carbondatabase <- read_excel("./Carbon database regressions.xlsx", skip = 2)
carbondatabase$Age <- as.numeric(carbondatabase$Age)
carbondatabase$value <- carbondatabase$`Average of MIN Metric tons CO2/Acre.Year`

carbondatabase$`Average of MIN Metric tons CO2/Acre.Year` <- NULL
carbondatabase$`Average of MAX Metric tons CO2/Acre.Year` <- NULL


