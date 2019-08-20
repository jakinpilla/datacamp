library(shiny)
library(shinydashboard)
library(tidyverse)

sidebar <- dashboardSidebar(
  actionButton("click", "Update click box")
) 

server <- function(input, output) {
  output$click_box <- renderValueBox({
    valueBox(
      value = input$click,
      subtitle = "Click Box"
    )
  })
}

body <- dashboardBody(
  valueBoxOutput("click_box")
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)
shinyApp(ui, server)