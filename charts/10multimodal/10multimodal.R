library(tidyverse)
library(showtext)
library(ggimage)
library(ggtext)

temps <- read_csv('charts/mono/temps.csv') |> 
  pivot_longer(cols=!matches("^year$"), names_to="month", values_to = "temp") |> 
  mutate(
    month=as.integer(month),
    temp=parse_double(str_trim(temp), locale = locale(decimal_mark = ","), na=c("", " "), trim=TRUE)
  )

temps <- temps |> mutate(
  img = case_when(
    temp > 23 ~ 'charts/10multimodal/sun.png',
    temp < -4.5 ~ 'charts/10multimodal/snow.png',
    )
  )

temps |>   ggplot(aes(x=month, y=year, fill=temp)) + 
  geom_tile(color="white") + 
  geom_image(data=temps, mapping = aes(image=img), size=0.08) + 
  scale_fill_fermenter(palette="RdBu",  na.value=NA, direction=-1) +
  scale_x_discrete(expand = c(0, 0),) +
  scale_y_discrete(expand = c(0, 0), limits = c(temps$year))+
  labs(
    title = "Average monthly temperature in Ukraine",
    subtitle = "Hottest (>23°C) and coldest (<-4.5°C) months are higligted",
  ) 

