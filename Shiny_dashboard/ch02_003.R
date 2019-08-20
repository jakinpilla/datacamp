library(shiny)
library(shinydashboard)
library(tidyverse)
data("starwars")

# starwars %>% 
#   select(name:species) %>% write_csv("./starwars.csv")
# 

body <- dashboardBody(
  tableOutput("table")
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)


server <- function(input, output, session) {
  reactive_starwars_data <- reactiveFileReader(
    intervalMillis = 1000,
    session = session,
    filePath = "~/datacamp/Shiny_dashboard/starwars.csv",
    readFunc = function(filePath) { 
      read_csv(filePath)
    }
  )
  
  output$table <- renderTable({
    reactive_starwars_data()
  })
}


shinyApp(ui, server)