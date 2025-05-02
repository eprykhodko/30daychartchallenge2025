library(tidyverse)
library(ggtext)

meteorites <- readr::read_csv(
  "https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2019/2019-06-11/meteorites.csv"
)

skimr::skim(meteorites)

meteorites |> group_by(year) |>
  summarise(count = n(), total_mass = sum(mass)) |>
  ggplot(aes(x = year, y = count)) +
  geom_col(alpha=0.75) +
  geom_smooth(se=FALSE, na.rm=TRUE) +
  labs(title = "Exponential growth in documented metheorites", x = "Year", y = "Meteorite recorded by year (log)") +
  scale_y_log10() +
  scale_x_continuous(limits = c(1700, 2025))


meteorites |>
  ggplot(aes(x= mass)) + geom_histogram()
  

meteorites |> group_by(year) |>
  summarise(count = n(), total_mass = sum(mass)) |>
  ggplot(aes(x = year, y = total_mass)) +
  geom_col() +
  labs(title = "Meteorite falls by year", x = "Year", y = "Number of meteorites") +
  coord_cartesian(xlim = c(1900, 2025))

#multiline string
tag_text <- " In 1920 the Hoba metorite was excavated in Namibia.
       It remains the largest known intact metorite as well the larges known solid piece of Iron.
       It weighs 60 tons and is estimated to be 80,000 years old. "

meteorites |> group_by(year) |>
  summarise(count = n(), total_mass = sum(mass)) |>
  ggplot(aes(x = year, y = total_mass)) +
  geom_col() +
  labs(
    title = "Meteorites",
    subtitle = "Combined mass(kg) of metheorites discovered each year",
    x = "Year",
    y = "Total weight of meteorites",
    tag = tag_text
  ) +
  coord_cartesian(xlim = c(1900, 2025)) +
  scale_y_continuous(labels = scales::number_format(suffix = "kg"))  +
theme(
    plot.tag.location = "plot",
    plot.tag.position = c(0.78, 0.75),
    plot.tag = element_textbox_simple(
      hjust = 1,
      halign = 0,
      margin = margin(b = 10, t = 10),
      lineheight = 0.5,
      size = rel(1.3),
      maxwidth = 0.7,
    ),
  )


# Stacked bar chart variation
meteorites |>
  ggplot(aes(x = year, y=mass)) +
  geom_col(aes(fill=id),  position = "stack") +
  labs(
    title = "Meteorites",
    subtitle = "Combined mass(kg) of metheorites discovered each year",
    x = "Year",
    y = "Total weight of meteorites",
    tag = tag_text
  ) +
  coord_cartesian(xlim = c(1900, 2025)) +
  scale_y_continuous(labels = scales::number_format(suffix = "kg"))  +
  scale_fill_distiller(palette = "Set1") + 
  theme(
    plot.tag.location = "plot",
    plot.tag.position = c(0.78, 0.75),
    plot.tag = element_textbox_simple(
      hjust = 1,
      halign = 0,
      margin = margin(b = 10, t = 10),
      lineheight = 0.5,
      size = rel(1.3),
      maxwidth = 0.7,
    ),
  )

# Stacked bar chart variation
meteorites |>
  ggplot(aes(x = year, y=mass)) +
  geom_col(aes(fill=id),  position = "stack") +
  labs(
    title = "Meteorites",
    subtitle = "Combined mass(kg) of metheorites discovered each year",
    x = "Year",
    y = "Total weight of meteorites") +
  scale_x_continuous(limits = c(1981, 1989), labels = c("1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989" ),
                     breaks = parse_integer( c("1981", "1982", "1983", "1984", "1985", "1986", "1987",   "1988", "1989" )))+
  scale_y_continuous(labels = scales::number_format(suffix = "kg"))  +
  scale_fill_distiller(palette = "Set3")



meteorites |>
  ggplot(aes(x = year, y=mass)) +
  geom_col(aes(fill=id),  position = "stack") +
  scale_x_continuous(limits = c(1981, 1989), breaks = scales::breaks_width(1)) +
  scale_y_continuous(labels = scales::number_format(suffix = "kg"))  +
  scale_fill_distiller(palette = "Set3")


