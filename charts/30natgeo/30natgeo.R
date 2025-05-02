library(tidyverse)

nat_geo_yellow <- "#ffc900"

Orange |> ggplot(aes(x=age, y=circumference, group=Tree)) +
  geom_point(size=5, color=nat_geo_yellow) +
  geom_line(color=nat_geo_yellow, size=2) +
  labs(
    title = "Orange tree growth",
    x = "Age (days)",
    y = "Circumference (mm)",
    caption = "Data: Orange trees"
  ) +
  theme_minimal() +
  theme(
   # black background 
    panel.background = element_rect(fill = "black", color = "black"),
    plot.background = element_rect(fill = "black", color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(color = nat_geo_yellow),
    axis.title = element_text(color = nat_geo_yellow),
    plot.title = element_text(color = nat_geo_yellow),
    plot.subtitle = element_text(color = nat_geo_yellow),
    plot.caption = element_text(color = nat_geo_yellow)
  )
