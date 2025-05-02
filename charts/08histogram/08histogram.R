library(tidyverse)
library(janitor)

df <- read_csv('charts/08histogram/pups.csv')

df <- janitor::clean_names(df)

df$weight <- parse_double(str_match(df$vaga_kg, "[\\d\\.]+"))

df |> ggplot(x=weight) +
  geom_histogram(aes(x=weight),binwidth=3, width=0.5) +
  labs(title="Weight distributin of stray puppies", x="Weight (kg)", y="Count") +
  theme_minimal() +
  theme(
      panel.grid = element_blank(),
  )
