text <- c("find 20 hidden mickeys on the Tower of Terror",
          "Find a paint brush on Tom Sawyer Island", 
          "Meet Chewbacca")

value <- c(60, 0, 100)

task_data <- data.frame(text = text, value = value)


server <- function(input, output) {
  output$task_menu <- renderMenu({
    tasks <- apply(task_data, 1, function(row) {
      taskItem(text = row[["text"]],
               value = row[["value"]])
    })
    
    dropdownMenu(type = "tasks", .list = tasks)
  })
}

header <- dashboardHeader(dropdownMenuOutput("task_menu"))

ui <- dashboardPage(header = header,
                    sidebar = dashboardSidebar(),
                    body = dashboardBody()
)
shinyApp(ui, server)