library(leaflet)
library(rgdal)
library(shiny)
library(htmltools)

forest <- readOGR("data/forest.shp")
base <- readOGR("data/base.shp")

background_Icons <- icons(
  iconUrl = "img/circle.png",
  iconWidth = ifelse(forest$Type_Desig == 1,
                     47, ifelse(forest$Type_Desig == 2, 30, 20)),
  iconHeight = ifelse(forest$Type_Desig == 1,
                      47, ifelse(forest$Type_Desig == 2, 30, 20)),
  iconAnchorX = ifelse(forest$Type_Desig == 1,
                       25, ifelse(forest$Type_Desig == 2, 15, 10)),
  iconAnchorY = ifelse(forest$Type_Desig == 1,
                       25, ifelse(forest$Type_Desig == 2, 16, 10)),
)

Cate_Icons <- icons(
  iconUrl = ifelse(forest$Type_Desig == 1,
                   "img/trees.png", ifelse(forest$Type_Desig == 2, 
                                           "img/bird.png", "img/house.png")),
  iconWidth = ifelse(forest$Type_Desig == 1,
                     40, ifelse(forest$Type_Desig == 2, 30, 20)),
  iconHeight = ifelse(forest$Type_Desig == 1,
                      50, ifelse(forest$Type_Desig == 2, 40, 30)),
  iconAnchorX = ifelse(forest$Type_Desig == 1,
                       20, ifelse(forest$Type_Desig == 2, 15, 10)),
  iconAnchorY = ifelse(forest$Type_Desig == 1,
                       35, ifelse(forest$Type_Desig == 2, 28, 20)),
)

function(input, output, session) {
  output$map <- renderLeaflet({
                                leaflet() %>%
                                  addProviderTiles(providers$OpenStreetMap) %>%
                                  setView(lng = 108.384, lat = 13.794, zoom = 7)
                              })

  observe({
            leafletProxy("map", data = base) %>%
              clearShapes() %>%
              addPolygons(data = base,
                          color = "pink") %>%
              addMarkers(lng = forest$xcoord,
                         lat = forest$ycoord,
                         icon = background_Icons) %>%
              addMarkers(lng = forest$xcoord,
                         lat = forest$ycoord,
                         icon = Cate_Icons,
                         label = forest$NAME,
                         labelOptions = labelOptions(noHide = F, style = list(
                           "color" = "red",
                           "font-family" = "serif",
                           "font-style" = "italic",
                           "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                           "font-size" = "12px",
                           "border-color" = "rgba(0,0,0,0.5)"
                         )))
          })
}