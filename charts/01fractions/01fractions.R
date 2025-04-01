library(tidyverse)

df <- read_csv(
  'charts/01fractions/female.csv',
 ) |>  rename(percent_female = data, year = period)

df$percent_male = 100 - df$percent_female

# pivot longer extract percent from percent_male and percent_female
df <- df |> pivot_longer(
  cols = starts_with("percent"),
  names_to = "gender",
  values_to = "percent",
  names_prefix = "percent_",
)

only_female <- df |> filter(gender == "female")


df |> ggplot(aes(year, percent, group = fct_relevel(gender, c("male","female") ) )) + 
  geom_area(aes(fill=gender),  position = "stack", alpha = 0.5) +
  geom_line(data=only_female)+
  scale_fill_brewer(palette = "Set1") +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  labs(title="Percentage of women in Ukrainian parliament", subtitle="1990-2020", y=NULL)
  
  

