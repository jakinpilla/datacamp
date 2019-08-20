library(shiny)
library(shinydashboard)
library(tidyverse)

header <- dashboardHeader(
  dropdownMenu(
    type = "notifications",
    notificationItem(
      text = "The International Space Station is overhead!",
      icon = icon("rocket")
    )
  )
)

ui <- dashboardPage(header = header,
                    sidebar = dashboardSidebar(),
                    body = dashboardBody())


server <- function(input, output) {
}


shinyApp(ui, server)