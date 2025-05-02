library(tidyverse)
library(forcats)
library(patchwork)

df <- read_delim("charts/03circular/tz_opendata_z01012025_po01022025.csv", delim=';')

# how many rows in df
common_color <- c("БІЛИЙ", "ЧОРНИЙ", "СІРИЙ")


df |> filter(!COLOR %in% common_color) |>  count(COLOR) |> mutate(total = sum(n),  pct=(n / total), total_pct=sum(pct))

colors <-  c(
  'БІЛИЙ' = "ivory",
  'ЧОРНИЙ' = "black",
  'СІРИЙ' = "gray",
  'ЧЕРВОНИЙ' = "red",
  'ЖОВТИЙ' = "yellow",
  'ЗЕЛЕНИЙ' = "green",
  'СИНІЙ' = "blue",
  'ФІОЛЕТОВИЙ' = "purple",
  'БЕЖЕВИЙ' = "beige",
  'КОРИЧНЕВИЙ' = "brown",
  'ОРАНЖЕВИЙ' = "orange",
  'РОЗОВИЙ' = "pink"
)


color_pie_chart <-function(data){
  data |> ggplot(aes(x= 1, y = n, fill = fct_relevel(COLOR, colors))) +
    geom_bar(stat = "identity", position="stack", color='white', alpha=0.9)  + 
    scale_fill_manual(values = colors) +
    scale_y_continuous(breaks = NULL, expand = c(0, 0))+
    scale_x_continuous(breaks = NULL, expand = c(0, 0)) +
    xlab(NULL) + ylab(NULL) +
    coord_polar('y', start=0) +
    theme_minimal(legend.position = "none", axis.ticks=element_blank(), axis.text.y = element_blank(), axis.text.x = element_blank())
  
}

  
rare <- df |> filter(!COLOR %in% common_color) |>  count(COLOR, sort = TRUE) |> 
  mutate(COLOR = fct_reorder(COLOR, n)) |> color_pie_chart() + 
  labs(subtitle="Rare colors only")



full <-df |>  count(COLOR,  sort = TRUE) |> mutate(pct = round(n*100/nrow(df))) |> 
  mutate(COLOR = fct_reorder(COLOR, n)) |>color_pie_chart() + labs(subtitle="All colors") +
  geom_label(
    data = df  |>  count(COLOR,  sort = TRUE) |> mutate(pct = round(n*100/nrow(df))) |>  filter(COLOR == "СІРИЙ"),
    aes(label = glue::glue("{pct}%")),
    position = position_stack(vjust = 0.5),
    show.legend = FALSE
  )

full + rare + plot_annotation(
  title = "Colors of vehicles registered since the beginning of 2025",
  subtitle = "One in three registered vehicles is grey. 391 violet cars were registerd.",
  caption = "Data: https://data.gov.ua/dataset/06779371-308f-42d7-895e-5a39833375f0/resource/3f13166f-090b-499e-8e23-e9851c5a5f67"
)



