library(tidyverse)
library(ggrepel)

mean_cty <-  mpg|> 
  group_by(manufacturer, year) |>
  summarise(cty = mean(cty, na.rm=TRUE), .groups = "drop")

cty_difs <- mean_cty |> pivot_wider(names_from = year, values_from = cty) |> mutate(dif = `2008` - `1999`) |> arrange(dif) 

df <-  mean_cty |> left_join(cty_difs |> select(manufacturer, dif)) |> arrange(desc(dif))

df |> 
  mutate(manufacturer = fct_reorder(manufacturer, dif)) |> 
  mutate(dif = round(dif, 2)) |> 
  mutate(dif = ifelse(dif > 0, str_glue("+{dif}"), dif)) |> 
  mutate(dif = str_c(" ", dif)) |>
  ggplot(aes(x=year, y=cty, group=manufacturer)) +
  geom_line(aes(color=manufacturer)) +
  geom_point(aes(color=manufacturer)) +
  geom_label_repel(data = . %>% filter(year == 1999),  aes(label=manufacturer, color=manufacturer), nudge_x = -.3, ) +
  geom_label_repel(data = . %>% filter(year == 2008),  aes(label=dif, color=manufacturer), nudge_x = .3, ) +
  theme(legend.position = "none") +
  scale_x_continuous(breaks= c(1999, 2008)) +
  labs(
    title = "Average city mileage of car manufacturers",
    subtitle = "Most manufactureres have improved gas mileage over the years",
    x = "Year",
    y = "Average city mileage (mpg)",
    caption = "Data: mpg dataset from ggplot2"
  ) 

