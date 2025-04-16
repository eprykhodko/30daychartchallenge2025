library(tidyverse)
library(tidyplots)

df <- read_csv('charts/16negative/t8.csv')
online  <- read_csv('charts/16negative/t8_online.csv')


df  |> 
  mutate(
    date=as.Date(DateTime),
    ) |> 
  pivot_longer(
    cols = c(`Positive reviews`, `Negative reviews`),
    names_to = "type",
    values_to = "count",
  ) |>
  ggplot(aes(x=date,y=count, group=type, fill=type)) +
  geom_col(position = "stack") +
  annotate(
    "text",
    x = ymd("2025-02-01"),
    y = -850,
    label = "Season 2\nReleased",
    size = 4,
    family = "Roboto",
  ) +
  geom_curve(
    arrow=arrow(),
    aes(
      x = ymd("2025-02-01"),
      y = -750,
      xend = ymd("2025-03-29"),
      yend = -100,
    ),
    curvature = -0.2,
  ) +
  annotate(
    "text",
    x = ymd("2024-07-29"),
    y = -550,
    label = "Clive Rosfied\nDLC Released ",
    size = 4,
    family = "Roboto",
  ) +
  geom_curve(
    arrow=arrow(),
    aes(
      x = ymd("2024-07-29"),
      y = -450,
      xend = ymd("2024-10-01"),
      yend = -70,
    ),
    curvature = -0.2,
  ) +
  coord_cartesian(
    ylim = c(-3000, 1200),
    xlim = c(ymd("2024-06-01"), ymd("2025-04-17")),
  ) + 
  guides(fill=FALSE) +
  labs(
    title="Tekken 8 Steam reviews",
    subtitle="Spikes of negativity are related to new content releases",
    caption="data: steamdb.info",
  )

library(tidyplots)

online  |> tidyplot(x=DateTime, y=`Average Players`) |> add_line()


