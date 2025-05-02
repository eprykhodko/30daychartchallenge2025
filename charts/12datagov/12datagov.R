library(tidyverse)
library(patchwork)

df <-  read_csv('charts/12datagov/Air_Quality.csv')

fp <-  "Fine particles (PM 2.5)"


upper <- df |>  
  filter(Name == fp, `Geo Place Name` == "New York City") |> 
  filter(str_detect(`Time Period`, "Annual")) |>  
  mutate(
    year = parse_integer(str_extract(`Time Period`, "\\d{4}"))
  ) |> 
  select(
    Name, year, `Data Value`
  ) |> 
  ggplot(aes(x = year, y = `Data Value`)) +
  geom_point() + geom_line(aes(group=1) ) +
  labs(title=fp, x="Year", y="µg/m³") +
  scale_x_continuous(breaks = seq(2005, 2024, 2), limits = c(2005, 2020)) +
  theme_minimal() 



lower <- df |>  
  filter(Name == "Respiratory hospitalizations due to PM2.5 (age 20+)", `Geo Place Name` == "New York City") |> 
  ggplot(aes(x = `Time Period`, y = `Data Value`)) +
  geom_point() + geom_line(aes(group=1), ) +
  labs(title="Respiratory hospitalizations due to PM2.5 (age 20+)", x="Year", y="rate per 100k residents") +
  theme_minimal()


upper / lower
