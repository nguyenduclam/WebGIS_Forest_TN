library(leaflet)
library(leaflet.extras)
library(rgdal)
library(shiny)
library(htmltools)
# library(shinyjs)

forest <- readOGR("data/forest.shp")
base <- readOGR("data/base.shp")

grades = c("Vườn quốc gia", "Khu bảo vệ cảnh quan", "Khu bảo tồn thiên nhiên")
labels = c("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAABmJLR0QA/wD/AP+gvaeTAAAFFUlEQVR4nO3dWYgcVRTG8d9MJibuGgIqKokLuIARNERFcQnGlyDmRZ/cUVFxQSEqinlQcUVRiQsoChoDajAuaIgibkFxF/QhYlxAAu4So4kxjuXDTTOTMEtPd9W93dX3D99Dz/RMnXO+rqq7VpPJZDKZTCaTyWQymUwmk8lkMplMJpPJZDKZTCaTicqc1AFkhtgTX2O71IFkAvNR4PzUgWQCNwqGrEZf4lgyWCkYUuC4xLH0PFPwlyFDHkkbTmauITMKrMMOSSNqg/7UAZTAadu83gULUgSSYQA/2PoMKYR7SiYBjebutvoX+ySMq2d5y8iGFLg+YVw9yUlGN6PAGrlPEo1+vG9sQwqhBZaJwIXGN6PA0lQB9hJ742fNGfIP9k0TZm8wGW9rzoyG7kkSaY+w2MTMKLAe01IEW3fuNHEzGrotQby1pV+47LRqRoGNmBk57lqyO17WnhkNPR059pbo5I7TJFyA/ba8LvAbfsd1OKCF/7kAL5QSXQZh7uN5zZ8Vq3EpnsRaobm8Z/Soa0o/lpv4pephQ1eCA+R+SWm008q6OkG8teYc7d3QN2F29KhrysH4U/utrC+Fe1CmDSZrblS3Wd0QN/z6cZfyzCiE1SkzomZQI+YIU7FlGlLIQ/ItMYBPlG9GgUHMipdKPbhONWY09Ey8VLqfA7FBtYYM4vBYCXUz/cZeSVKmXoqUU1ezUBwzGjoxSlZdyqHCvEVMQ1ZFyawL2V51rarxdHGE/LqKPqFvkMKMQjgrD6s8yy7iGunMaOhTXbyFoUxOVU1vvBW9iqnVptvZnCL+TXw8rdSjI8LzVN/5a1UfYP/qUu885ktnxt/4Suipj/W+tTiqqgKMxUDk4y0UFq1NGvazDfgMH23RTGHeoopLxxS8JxR7D+yEXfGfsDdxHX7CHxUcu6OYigeEWbsVuFfY5D/L1h+Ka4TiVH2mvIvdKsq1Ntws7uXrY2EhXmYb+nC3NPeUVcIoQWYYd0hjRkNLqk+xe7hcWjMaurbqRLuBs8W5gTejQZxQbbqdzbFCnyC1EcP1vR69yc/Aj9IbMJKeqjDvjmRHYWQ1deHH0lmVZd9htLp6PbbW46CKatBR3C99sZvVh2o+FB978UIZWm7rMbfa0I1mNPSEzt72N2EWSV/UdvWYGjx+dgD3SV/MsrQK00utUESm4w3piziePhGmAr5p8v1rcHyJdYrCMZpPcD2ew+PClrPYhmwSxrD6hUdvzNvyeim+wOYR/mYQt+uCZ1VOFuYzRlpB8pswbfo6HsJlOEK4rF0kjRnD9YaRd+ZOEWYvj8bJwizjgbrADMLmmjOET9lsYfvxNKO3UPqEWcPUl62GfhGeUNeT9GntqT5VazOuqDDvjmSS0IxMXfyxtFhNO4Tb0odHpS94M1qmBn2P8bhF+kJPRCvUeL79EukL3IrexM7llyMtC3TOgupWTanNmXKIsBowdVHb1Yvir/Isnd2FDmHqYpalJbqkUzgSk2z9rTd10b1lFikmZT+jpJO0qMQ6ReE86YtWta4qrVoVM1d4vHfqglWtQZxZUs0q4yBhZDd1sWLpX+FLATqSGZqfB2lX3wkjs1dGOt5Y+k9YM9BRxDJjI24Vdj0R+gWjrYB8DecKj4mNYcxtOmQxxEx8q9pkf8RN2GuE4y8b5W9e2fL7fpyOdyqOscCzhj4sSThSWKBcRXKDwl7A8429YG20vSWvjvDeWXgQv1YUc4HPhVnFlvkfES0spZZM4aIAAAAASUVORK5CYII=",
           "data:image/png;base64,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",
           "data:image/png;base64,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")

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
  # observeEvent(
  #    eventExpr = input$go,
  #    handlerExpr = js$addLengend()
  # )
  output$map <- renderLeaflet({
                                leaflet() %>%
                                  addProviderTiles(providers$OpenStreetMap, group = "Open Street Map") %>%
                                  addProviderTiles(providers$Esri.WorldImagery, group = "Esri Word Map") %>%
                                  addProviderTiles(providers$CartoDB, group = "CartoDB") %>%
                                  setView(lng = 108.384, lat = 13.794, zoom = 7) %>%
                                  # htmlwidgets::onRender("
                                  #    function(el,x) {
                                  #        map = this;
                                  #    }
                                  # ")
                                  addResetMapButton()
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
                         group = "marker",
                         label = forest$NAME,
                         labelOptions = labelOptions(noHide = F, style = list(
                           "color" = "red",
                           "font-family" = "serif",
                           "font-style" = "italic",
                           "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                           "font-size" = "12px",
                           "border-color" = "rgba(0,0,0,0.5)"
                         ))) %>%
              addSearchFeatures(
                targetGroups = "marker",
                options = searchFeaturesOptions(
                  zoom = 12, openPopup = TRUE, firstTipSubmit = TRUE,
                  autoCollapse = TRUE, hideMarkerOnCollapse = TRUE)) %>%
              addControl(html = paste("<h2>Chú giải</h2>",
                                      "<div class='container'>",
                                      "<div id='overlay0'></div>",
                                      "<img src=", labels[1], "width='40' height='50'>",
                                      "<span class='label_legend'>", grades[1], "</span>",
                                      "</div>", '<br>',
                                      "<div class='container'>",
                                      "<div id='overlay1'></div>",
                                      "<img src=", labels[2], "width='30' height='40' style='margin:0px 0px 0px 10px'>",
                                      "<span class='label_legend'>", grades[2], "</span>",
                                      "</div>", '<br>',
                                      "<div class='container'>",
                                      "<div id='overlay2'></div>",
                                      "<img src=", labels[3], "width='20' height='30' style='margin:0px 0px 0px 20px'>",
                                      "<span class='label_legend'>", grades[3], "</span>",
                                      "</div>"), position = "bottomright") %>%
              addLayersControl(baseGroups = c("Open Street Map", "Esri Word Map", "CartoDB"),
                               options = layersControlOptions(collapsed = FALSE))
          })
}