library(shiny)
library(tidyverse)
library(gapminder)
# install.packages("colourpicker")
library(colourpicker)
library(plotly)


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
      checkboxInput("fit", "Add line of best fit", value = F),
      
      # Add radio buttons for colour
      # radioButtons("color", "Point color", 
      #              choices = c("blue", "red", "green", "black")),
      
      # Add colourInput() from colourpicker packages...
      colourInput("color", "Point color", value = "blue"),
      
      # Add a continent dropdown selector
      selectInput("continents", "Continents", 
                  choices = levels(gapminder$continent),
                  multiple = T,
                  selected = "Europe"),
      
      # Add a slider selector for years to filter...
      sliderInput("years", "Years", min = min(gapminder$year), max = max(gapminder$year), value = c(1977, 2002))
      
    ),
    
    mainPanel(
      
      # make the plot 600 pixels wide and 600 pixels...
      plotlyOutput("plot", width = 600, height = 600)
    )
  )
)

# Define the server logic...
server <- function(input, output) {
  output$plot <- renderPlotly({
    
    # Subset the gapminder dataset by the chosen continents...
    ggplotly({
      data <- gapminder %>% 
      filter(continent %in% input$continents) %>%
      filter(year >= input$years[1]) %>%
      filter(year <= input$years[2])
    
    p <-ggplot(data, aes(gdpPercap, lifeExp)) +
             geom_point(size = input$size, 
                        col = input$color) +
             scale_x_log10() + 
             # Use the input value as the plot's title
             ggtitle(input$title)
    
    # if the checkbox is checked...
    if(input$fit) {
      p <- p + geom_smooth(method = "lm") }
    
    p
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)


# ?checkboxInput
# ?radioButtons
# ?sliderInput()
# glimpse(gapminder)
# ?plotOutput()
