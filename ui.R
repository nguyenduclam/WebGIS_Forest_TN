library(leaflet)
library(rgdal)
library(shiny)
library(htmltools)

bootstrapPage(
  titlePanel("My Map"),
  div(class = "outer",
      tags$head(
      # Include our custom CSS
      includeCSS("styles.css"),
      ),
      leafletOutput("map", width = "100%", height = "100%")
  )
)