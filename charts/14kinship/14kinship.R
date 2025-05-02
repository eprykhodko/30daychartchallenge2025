library(kinship2)
library(tidyverse)


df <- tribble(
  ~id,     ~sex, ~dadid, ~momid, ~famid,
  "кісюка", "f", NA, NA, 1,
  "котя",    "m", "aнонім1",  "кісюка", 1,
  "пінгвін", "m",  "aнонім1",  "кісюка", 1,
  "боніта", "f", NA, NA, 2,
  "кісточка", "m",  "aнонім2", "боніта", 2,
  "магелан", "m",  "aнонім2", "боніта", 2,
  "мауглі", "f", NA, NA, 2,
  "костя", "m", NA, "мауглі", 2,
  "фелікс", "m", NA, "мауглі", 2,
)

ndf <- with(df, fixParents(id, dadid, momid,  sex, missid="0"))
ped <- with(ndf, pedigree(id,  dadid, momid, sex, missid="0"))


plot(ped)

