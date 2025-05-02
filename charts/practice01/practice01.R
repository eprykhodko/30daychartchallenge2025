library(tidyverse)

df <- read_delim("charts/practice01/zp.csv")
df <- df |> mutate(
  salary=parse_number(data),
  year=parse_integer(str_sub(period, 1, 4)),
  month=parse_integer(str_sub(period, 6, 7)),
  date=ymd(str_glue("{year}-{month}-01"))
)


df |> ggplot(aes(x=date, y=salary)) +
  geom_line() + 
  geom_smooth() +
  labs(title="Salary by month", x="Date", y="Salary")
