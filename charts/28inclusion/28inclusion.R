library(leaflet)
library(tidyverse)
library(sf)

geo <-  read_sf("charts/28inclusion/inclusive_buildings.json")
geo |> 
  ggplot() +
  geom_sf()

leaflet(geo) |> 
  addTiles() |> 
  setView(lng = 25.34, lat = 50.75, zoom = 14) |> 
  addGeoJSON(geo$geometry)
