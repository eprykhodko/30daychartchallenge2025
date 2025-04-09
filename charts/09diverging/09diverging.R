library(tidyverse)

df <- read_csv(
  'charts/09diverging/salary_over_age.csv',
)

df <- df |> filter(Стать != "Усього") |> filter(Розріз != "Загалом")

df |> 
  ggplot(aes(x= fct_relevel(Розріз, "До 25 років"), y=`2020`, group = Стать)) + 
  geom_line(aes(color=Стать)) +
  scale_color_brewer(palette = "Set2") +
  xlab("Вік") +
  ylab("Середня зарплата. 2020р") +
  labs(title = "Pay Gap в Україні")

# data https://stat.gov.ua/uk/explorer?urn=SSSU%3ADF_ENTERPRISE_LABOR_STATISTICS%2820.0.0%29&filter=RAT_AVG_SALARY_MEN_WOMEN.%2A.%2A.%2A.%2A.%2A