library(shiny)
library(gapminder)

my_css <- "
#download_data {
  /* Change the background color of the download button to orange. */
  background: orange;
  
  /* Change the text size to 20 pixels. */
  font-size: 15px;
}

#table{
  /* Change the text color of the table to red.*/
  color: steelblue;
  font-size : 14px;
} 
  
}
"

ui <- fluidPage(
  
  h1("Gapminder"),
  
  tags$style(my_css),
  
  tabsetPanel(
    # Create an "Input" tab...
    tabPanel("Inputs",
      # Add a slider for life expectancy filer
      sliderInput(inputId = "life", 
                  label = "Life expectancy",
                  min = 0, max = 120, value = c(30, 50)),
      
      # Add a continent selector dropdown..
      selectInput("continent", "Continent", 
                  choices = c("All", levels(gapminder$continent))),
      
      # Add a download button...
      downloadButton(outputId = "download_data", label = "Download")
    ),
    
    tabPanel("Plot",
      # Add a plot output...
      plotOutput("plot")
    ),
    
    tabPanel("Table",
      # Add a placeholder for a table output...
      DT::dataTableOutput("table")
    )
  )
)
  
server <- function(input, output) {
  
  # Create a reactive variable named "filtered_data"...
  filtered_data <- reactive({
    # Filter the data (copied from previous exercise)
    data <- gapminder %>% filter(lifeExp >= input$life[1],
                                 lifeExp <= input$life[2])
    
    if(input$continent != "All") {
      data <- data %>% filter(continent == input$continent)
    }
    data
    
  })
  
  # Call the appropriate render function...
  output$table <- DT::renderDataTable({
    data <- filtered_data()
    data
  })
  
  # Create the plot render function...
  output$plot <- renderPlot({
    # Use the same filtered data that the table uses..
    data <- filtered_data()
    
    ggplot(data, aes(gdpPercap ,lifeExp)) +
      geom_point() +
      scale_x_log10()

  })
  
  # Create a download handler...
  output$download_data <- downloadHandler(
    
    # The download file is named "gapminder_data.csv"
    filename = "gapminder_data.csv",
    
    content = function(file) {
      
      data <- filtered_data()
      
      # Write the filtered data into a CSV file
      write.csv(data, file, row.names = F)
      
    }
  )
  
}

shinyApp(ui, server)