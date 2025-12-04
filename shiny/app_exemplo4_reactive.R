library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Teste de reatividade"),
  textInput(
    inputId = "entrada",
    label = "Escreva um texto"
  ),
  textOutput(outputId = "saida")
)


server <- function(input, output, session) {

  texto <- reactive({
    input$entrada
  })

  output$saida <- renderText({
    texto()
    # veja se colocarmos aqui input$entrada no lugar de texto(), o shiny deixa
    # de chamar a função anterior, visto que ela não é utilizada
  })
}


shinyApp(ui, server)
