library(shiny)

ui <- fluidPage(
  h1("DataCamp"),
  h2("Shiny use cases course"),
  em("Shiny"),
  strong("is fun")
)

server <- function(input, output) {}
shinyApp(ui = ui, server = server)