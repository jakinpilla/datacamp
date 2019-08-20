library(shinydashboard)

header <- dashboardHeader(
  # Create a notification drop down menu
  dropdownMenu(
    type = "notifications",
    notificationItem(
      text = "The International Space Station is overhead!"
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