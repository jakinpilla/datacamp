library(shiny)

ui <- fluidPage(
  "Shiny is fun"
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)