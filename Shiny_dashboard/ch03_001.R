library(shiny)
library(shinydashboard)
library(tidyverse)

body <- dashboardBody(
  
  # Row 1
  fluidRow(
    box(
      width = 12,
      title = "Regular Box, Row 1",
      "Star Wars"
    )
  ), 
  
  # Row 2
  fluidRow(
    box(
      width = 12, 
      title = "Regular Box, Row 2",
      "Nothing but Star Wars"
    )
  )
  
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)

server <- function(input, output) {
  
} 
  
shinyApp(ui, server)