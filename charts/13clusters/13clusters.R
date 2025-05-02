library(tidyverse)
library(palmtrees)

palmtrees |>  filter(palm_subfamily %in% c("Coryphoideae", "Arecoideae", "Ceroxyloideae", "Calamoideae")) |>
  ggplot(aes(x=average_fruit_width_cm, y=average_fruit_length_cm)) +
  geom_point(aes(color=palm_subfamily, shape = palm_subfamily)) +
  scale_color_brewer(palette = "Set1") +
  coord_cartesian(
    xlim = c(0, 10),
    ylim = c(0, 10)
  ) +
  facet_wrap(~palm_subfamily, nrow = 1) +
  theme(legend.position = "none") +
  labs(
    title = "Palmtrees in the Royal Botanic Gardens",
    subtitle = "Fruit size by subfamily"
  )
