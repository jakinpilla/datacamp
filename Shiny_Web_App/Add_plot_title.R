library(shiny)
library(tidyverse)
library(gapminder)

# Load the ggplot2 package for plotting

# Define UI for the application

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      # Add a title text input
      textInput("title", "Title", "GDP vs life exp"),
      
      # Add a size numeric input
      numericInput("size", "Point size", 1, min = 1),
      
      # Add a checkbox input
      checkboxInput("fit", "Add line of best fit", value = F)
    ),
    
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define the server logic...
server <- function(input, output) {
  output$plot <- renderPlot({
    p <-ggplot(gapminder, aes(gdpPercap, lifeExp)) +
             geom_point(size = input$size) +
             scale_x_log10() + 
             # Use the input value as the plot's title
             ggtitle(input$title)
    
    # if the checkbox is checked...
    if(input$fit) {
      p <- p + geom_smooth(method = "lm") }
    
    p
  })
}

# Run the application
shinyApp(ui = ui, server = server)


?checkboxInput
