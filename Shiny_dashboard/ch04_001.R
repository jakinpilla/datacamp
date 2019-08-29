library(shiny)
library(shinydashboard)
library(tidyverse)
setwd("~/datacamp/Shiny_dashboard")

load('nasa_fireball.rda')

nasa_fireball %>% head()
glimpse(nasa_fireball)


# Print the nasa_fireball data frame
nasa_fireball

# Examine the types of variables present
sapply(nasa_fireball, class)

# Observe the number of observations in this data frame
nrow(nasa_fireball)

# Check for missing data
sapply(nasa_fireball, anyNA)

max_vel <- max(nasa_fireball$vel, na.rm = TRUE)
max_impact_e <- max(nasa_fireball$impact_e)
max_energy <- max(nasa_fireball$energy)

body <- dashboardBody(
  fluidRow(
    
    valueBox(
      value = max_energy, 
      subtitle = "Maximum total radiated energy (Joules)",
      icon = icon("lightbulb-o")
    ),
    
    valueBox(
      value = max_impact_e, 
      subtitle = "Maximum impact energy (kilotons of TNT)",
      icon = icon("star")
    ),
    
    # Add a value box for maximum velocity
    valueBox(
      value = max_vel,
      subtitle = "Maximum pre-impact velocity", 
      icon = icon("fire")
    )
  )
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)

server <- function(input, output) {
  
}


shinyApp(ui, server)
