library(leaflet)
# install.packages("leaflet")

leaflet() %>%
  addTiles() %>%
  addMarkers(
    lng = nasa_fireball$lon, 
    lat = nasa_fireball$lat
  )
