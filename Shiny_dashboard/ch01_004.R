library(shiny)
library(shinydashboard)
library(tidyverse)
data("starwars")

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

# sidebar
sidebar <- dashboardSidebar(
  sidebarMenu(
    
    # menuItem...
    
    menuItem(
      text = "Dashboard",
      tabName = "dashboard"
    ),
    
    menuItem(
      text = "Inputs",
      tabName = "inputs" #, 
      
      # sliderInput(
      #   inputId = "height", 
      #   label = "Height",
      #   min = 66, max = 264, value = 264
      # ), 
      # 
      # selectInput(
      #   inputId = "name",
      #   label = "Name", 
      #   choice = starwars$name
      # )
    ), 
    
    menuItem(
      text = "Select Name",
      tabName = "select_name",
      selectInput(
        inputId = "name",
        label = "Name",
        choice = starwars$name
      )
    )
  )
)

# body
body <- dashboardBody(
  
  tabItems(
    
    tabItem(
      tabName = "dashboard",
      tabBox(
        title = "International Space Station Fun Facts",
        tabPanel("Fun Fact 1"),
        tabPanel("Fun Fact 2")
      )
    ), 
    
    tabItem(
      tabName = "inputs", 
      "intputs body",
      textOutput("name")
    ), 
    
    tabItem(
      tabName = "select_name",
      textOutput("name")
    )
  )
)

# Create the UI using the header, sidebar, and body
ui <- dashboardPage(header = header,
                    sidebar = sidebar,
                    body = body)

server <- function(input, output) {
  output$name <- renderText({
    input$name
  })
}

shinyApp(ui, server)