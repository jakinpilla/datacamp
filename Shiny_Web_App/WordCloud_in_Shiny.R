library(shiny)
# install.packages("wordcloud2")
library(wordcloud2)
library(tm)


create_wordcloud <- function(data, num_words=100, background="white") {
  if(is.character(data)) {
    corpus <- Corpus(VectorSource(data))
    corpus <- tm_map(corpus, tolower)
    corpus <- tm_map(corups, removePunctuation)
    corpus <- tm_map(corpus, removeNumbers)
    corpus <- tm_map(corpus, removeWords, stopwords("english"))
    tdm <- as.matrix(TermDocumentMatrix(corpus))
    
    data <- sort(rowSums(tdm), decreasing = T)
    data <- data.frame(word)
  }
}

ui <- fluidPage(
  h1("Word Cloud"),
  sidebarLayout(
    sidebarPanel(
      # Add a textarea input
      textAreaInput("text", "Enter text", rows=7),
      numericInput("num", "Maximum number of words",
                   value = 100, min = 5),
      colourInput("col", "Background color", value ="white")
    ),
    
    mainPanel(
      wordcloud2Output("cloud")
    )
  )
)

server <- function(input, output) {
  output$cloud <- renderWordcloud2({
    create_wordcloud(data = input$text, 
                     num_words = input$num,
                     background = input$col)
  })
}

shinyApp(ui = ui, server = server)