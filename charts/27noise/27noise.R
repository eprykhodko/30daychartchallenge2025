library(tidyverse)
library(ggimage)
library(magick)

imdb <- read_csv("charts/27noise/brooklyn99_imdb.csv")
episodes <- read_csv("charts/27noise/brooklyn99_episodes.csv")
imdb |> 
  filter(!is.na(rating)) |> 
  mutate(
    season = as.integer(str_extract(season, "\\d+")),
    episode = as.integer(str_extract(episode, "\\d+")),
    episode = ifelse(is.na(episode), 0, episode)
  ) |> 
  left_join(episdoes |> select(season, episode, title)) |> 
  ggplot(aes(x=episode, y=rating)) +
  geom_point() +
  geom_line() +
  facet_wrap(~season) +
  labs(
    title = "Brooklyn Nine-Nine IMDB ratings",
    x = "Episode",
    y = "IMDB rating",
    caption = "Data: IMDB"
  ) +
  theme_minimal()
 

df <- episodes |> left_join(imdb, by = join_by(season == season, episode_num_in_season ==episode_num ))

df$us_viewers_scaled <- 10 * (df$us_viewers - min(df$us_viewers)) /( max(df$us_viewers)  - min(df$us_viewers))

df_long <- df |> 
  mutate(
    imdb_rating = - imdb_rating
  ) |> 
  pivot_longer(cols = c("us_viewers_scaled", "imdb_rating"), names_to = "metric", values_to = "value") |> 
  mutate(
    metric = factor(metric, levels = c("us_viewers", "rating")),
  )


thebox <- df |> filter(episode_num_overall == 104)
thebox_text <-  "Highest rated episode, \nThe Box at 9.6 on IMDB"

brokenfeather <- df |>  filter(episode_num_overall == 15)
brokenfeather_text <- "Airinig right after Super Bowl 2014, \nOperation: Broken Feather  premiers to est. 15 million viewers."



df |> 
  ggplot(aes(y = us_viewers, x=-episode_num_overall)) +
  geom_image(data = df |> head(1) , aes(image ="charts/27noise/noice.png", x=-75, y=9.5e6), size=.35) +
  geom_col(aes(fill = fct(as.character(season)))) +
  guides(fill = "none") +
  annotate(
    "curve",  
    xend = -thebox$episode_num_overall[1], yend = thebox$us_viewers[1], 
    x = - 100,  y = 8e6,  
    color = "black", size = 1, curvature= -0.4, 
    arrow=arrow(type="closed", length = unit(3, "mm") )
  ) +
  annotate("label", label = thebox_text,  x = - 93,  y = 8e6) +
  guides(fill = "none") +
  scale_x_continuous(expand=c(0,0), labels = NULL) +
  scale_y_continuous(expand=c(0,0), labels = NULL) +
  annotate(
    "curve",  
    xend = -16, yend = 1.1e7,
    x = - 25,  y = 1.1e7,  
    color = "black", size = 1, curvature= 0.1,
    arrow=arrow(type="closed", length = unit(3, "mm") )
  ) +
  annotate("label", label = brokenfeather_text,  x = - 25,  y = 1.1e7) +
  geom_hline(yintercept = 0, color = "black", size = 1) +
  coord_flip() +
  scale_fill_manual(values = c("#ec979a", "#f3c69c", "#fbe89b", "#b6d5ac", "#a8c6c8", "#a9cbe7", "#aea6cd", "#d6a5ba")) +
  theme_minimal()  +
  labs(
    title = "Brooklyn Nine-Nine IMDB ratings",
    x = "Episode",
    y = "US viewers (millions)",
    caption = "Data: Kaggle"
  )




  

