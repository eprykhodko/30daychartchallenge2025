library(tidyverse)

df <- read_csv('charts/02slope/bookings.csv', col_names = c("date", "count"), skip=1)


df  |> 
 ggplot(aes(x=date, y=count)) +
  geom_area(alpha=0.4) + 
  geom_smooth(se=FALSE) + 
  theme_minimal() +
  labs(x=NULL, y=NULL, title="Cocnur T2 bookings in March 2025")

