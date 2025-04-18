library(tidyverse)
library(pixarfilms)

skimr::skim(pixarfilms::academy)
pixarfilms::academy |> count(status)


skimr::skim(pixarfilms::pixar_films)
pixarfilms::pixar_films |> count(film_rating)


skimr::skim(pixarfilms::pixar_people)
pixarfilms::pixar_people |> head()
pixarfilms::pixar_people |> count(role_type)

skimr::skim(pixarfilms::genres)
pixarfilms::genres |> count(genre)


skimr::skim(pixarfilms::box_office)
pixarfilms::box_office |> sample_n(15)

skimr::skim(pixarfilms::public_response )



ppl <-  pixar_people
acad <-  academy

ppl |> count(name, sort=TRUE)


ppl_worked_on_films <- ppl |>  group_by(name, film) |> summarise(n=n()) 

# sum of wins and noms per film
noms = academy |>  filter(status %in% c("Nominated", "Won Special Achievement", "Won")) |> group_by(film) |>  summarise(nominations=n()) |> arrange(desc(nominations))

ppl_worked_on_films |>  left_join(noms) |> group_by(name) |> summarise(n_films=n(), n_noms=sum(nominations)) |> arrange(desc(n_noms))


all_data <- pixar_films |> left_join(public_response) |> left_join(box_office) |> left_join(noms)

cars2 <- all_data |> filter(film == "Cars 2") 
good_films <- all_data |> filter(!is.na(film) & !is.na(metacritic)) |>  arrange(desc(metacritic)) |> head(10)
df <-  bind_rows(good_films, cars2)

df |> 
  ggplot(aes(metacritic, fct_reorder(film, metacritic))) + 
  geom_point(size = 4, color= "#FF9149") +
  geom_segment(aes(yend=film), xend=0, color="#FF9149", linewidth = 3) +
  geom_label(aes(label=metacritic), hjust=0, nudge_x=0.4, fill = "#AFDDFF", color = "#FF9149") +
  labs(
    title = "Pixar films with the highest Metacritic scores",
    subtitle = "And then there's Cars 2...",
    x = "Metacritic score",
    y = NULL
  ) +

  scale_x_continuous(breaks = NULL) +
  theme_void() +
  theme(
    axis.ticks.x = element_blank(),
    axis.text.x = element_blank(),
    plot.background = element_rect(fill = "#60B5FF", color = "#60B5FF"),
    panel.background = element_rect(fill = "#60B5FF", color = "#60B5FF"),
    axis.text.y = element_text(family = "Ubuntu", color = "#FFECDB", size = 18),
    plot.title = element_textbox(family = "Ubuntu", color = "#FFECDB", size = 20, hjust = 0.5),
    plot.subtitle = element_textbox(family = "Ubuntu", color = "#FFECDB", size = 14, hjust = 0.5),
  )


    

