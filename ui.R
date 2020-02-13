library(leaflet)
library(leaflet.extras)
library(leaflet.minicharts)
library(dplyr)
library(rgdal)
library(shiny)
library(htmltools)
# library(shinyjs)

bootstrapPage(
  # useShinyjs(),
  # extendShinyjs(script = "my_shinyjs.js", functions = "addLengend"),
  div(class = "outer",
      tags$head(
        includeCSS("styles.css")
      ),
      leafletOutput("map", width = "100%", height = "100%")
      # , actionButton(inputId = "go", label = "Add a Lengend")
  )
)