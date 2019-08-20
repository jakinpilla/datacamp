# Update the skin
ui <- dashboardPage(
  skin = "purple",
  header = dashboardHeader(),
  sidebar = dashboardSidebar(),
  body = body)

server <- function(input, output) {
}

# Run the app
shinyApp(ui, server)