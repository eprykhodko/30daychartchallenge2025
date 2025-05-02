library(tidyverse)
library(tidyplots)
df <- read_csv("WHO-COVID-19-global-data.csv")

df <- read_csv("charts/24who/WHO-COVID-19-global-data.csv")

countries <- c("Ukraine", "Poland", "Italy", "Czechia", "Hungary") 

df |> filter(Country %in% countries ) |> tidyplot(x=Date_reported, y=Cumulative_deaths, color=Country) |>
  add_areastack_absolute() |> 
  # theme_minimal_y() |> 
  adjust_legend_position("top") |> 
  adjust_size(200, 100) |> 
  add_title("Cumulative deaths in selected countries") |>
  add_caption("Data: WHO")
