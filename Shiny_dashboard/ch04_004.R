library(shiny)
library(shinydashboard)
library(tidyverse)
setwd("~/datacamp/Shiny_dashboard")

load('nasa_fireball.rda')

sidebar <- dashboardSidebar(
  sliderInput(inputId = "threshold", 
              label = "Color Threshold", 
              min = 0, max = 100, value = 10)
)

server <- function(input, output) {
  output$us_box <- renderValueBox({
    valueBox(
      value = n_us,
      subtitle = "Number of Fireballs in the US",
      icon = icon("globe"),
      color = if (n_us < input$threshold) {
        "blue"
      } else {
        "fuchsia"
      }
    )
  })
}


ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)
shinyApp(ui, server)