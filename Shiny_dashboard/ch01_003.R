library(shinydashboard)

header <- dashboardHeader(
  # Create a tasks drop down menu
  dropdownMenu(
    type = "tasks",
    taskItem(
      text = "Mission Learn Shiny Dashboard",
      value = 10
    )
  )
)

# Create an empty sidebar
sidebar <- dashboardSidebar()

# Create an empty body
body <- dashboardBody()

# Create the UI using the header, sidebar, and body
ui <- dashboardPage(header = header,
                    sidebar = sidebar,
                    body = body)

server <- function(input, output) {}

shinyApp(ui, server)