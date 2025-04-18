library(tidyverse)
library(pixarfilms)
library(ggrepel)

all_data <- pixar_films |> left_join(public_response) |> left_join(box_office)

interesting <- all_data |> filter(box_office_worldwide >= 1000000000 | film == "Soul")


all_data |> 
  ggplot(aes(budget, box_office_worldwide)) + geom_point(alpha=0.5) + geom_smooth(method = "lm") +
  geom_point(data=interesting) +
  geom_label_repel(data = interesting, aes(label=film, group=box_office_worldwide)) +
  scale_x_continuous(labels = scales::dollar_format()) +
  scale_y_continuous(labels = scales::dollar_format()) +
  coord_cartesian(
    xlim = c(0, 22e7),
  ) +
  labs(
    title = "Why is everything a sequel?",
    subtitle = "Sequels tend to be better return on investment compared to original ideas",
    x = "Budget",
    y = "Box Office Worldwide"
  )

