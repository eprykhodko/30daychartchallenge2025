library(tidyverse)
library(palmerpenguins)

penguins |> 
  ggplot(aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_hex() +
  facet_wrap(~species) +
  labs(
    title = "Flipper length vs body mass",
    x = "Flipper length (mm)",
    y = "Body mass (g)",
    caption = "Data: Palmer Penguins"
  ) +
  scale_fill_gradient(low = "white", high = "black") 
