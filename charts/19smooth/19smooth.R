library(tidyverse)
library(ggbump)


df <- read_csv('charts/18elpais/prices.csv')

df |> 
  filter(`Територіальний розріз` == "Україна") |> 
  pivot_longer(
    cols = starts_with("202"),
    names_to = "yrmonth",
    values_to = "price",
  ) |> 
  filter(str_detect(yrmonth, "M01")) |> 
  ggplot(aes(x=yrmonth, y=price, color=`Тип товарів і послуг`, group = `Тип товарів і послуг`)) +
  geom_bump(size=2, smooth=10) +
  geom_point(size=5) +
  geom_point(size=2, color="darkgrey") +
  theme_dark() +
  paletteer::scale_color_paletteer_d("nbapalettes::lakers_alt")


