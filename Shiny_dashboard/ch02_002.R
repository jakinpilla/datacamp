library("shiny")

server <- function(input, output, session) {
  reactive_starwars_data <- reactiveFileReader(
    filePath = starwars_url,
    intervalMillis = 1000,
    session =session,
    readFunc = function(filePath) { 
      read.csv(url(filePath))
    }
  )
}

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = dashboardBody()
)
shinyApp(ui, server)