library(tidyverse)

df <- read_csv('charts/06florence-nightingale/deaths.csv')

df <- df |> pivot_longer(cols=starts_with("20"), names_to="year_date", values_to = "count") |> rename(sex="year") |> rename(year = "year_date")



df |> ggplot(aes(x=year, y=count, fill=fct_relevel(sex, c("male", "female")))) +
  geom_col(position = "stack", width = 1, alpha = 0.8, color = grey_lines) +
  labs(fill="Gender",) +
  scale_fill_manual(values = c(grey_blue, just_grey)) +
  scale_x_discrete(expand = c(0,0)) + coord_polar() +
  theme(
    legend.position = c(0.75,0.25),
    legend.title = element_text(color = grey_lines),
  ) +
  xlab(NULL)


grey_blue <- "#C5DBE8"
just_grey <- "#BEC3C6"
grey_lines <-  "#84939C"
background <- "#F9EBC1"

# data stat.gov.ua