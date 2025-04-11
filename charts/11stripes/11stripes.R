library(tidyverse)

df <- read_csv('charts/mono/transactions.csv')


df <- df |> 
  mutate(time = as.POSIXct(time, tz="Kyiv/Ukraine")) |> 
  mutate(
    year = year(time),
    month = month(time),
    day = day(time),
    date = as.Date(time),
  )



df |> group_by(date) |> summarise(spend = sum(amount) / 100, cb = sum(cashbackAmount)/100) |> 
  ggplot(aes(y=date, x = 1)) + geom_tile(aes(fill=cb)) +
  scale_fill_distiller(palette="Oranges", direction = 1) +
  scale_y_date( date_breaks= "1 year", date_labels = "'%y", expand = c(0,0)) +
  scale_x_discrete(expand = c(0, 0),) +
  labs(
    title = "Daily amount of Cashback earned",
    x = NULL,
    y = "Cashback",
)
