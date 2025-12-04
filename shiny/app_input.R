library(shiny)

ui <- fluidPage(
  titlePanel("Testando Inputs"),
  textInput(
    inputId = "nome",
    label = "Digite seu nome",
    value = ""
  ),
  textOutput(
    outputId = "saudacao"
  ),
  hr(),
  selectInput(
    inputId = "variavel",
    label = "Selecione uma variável",
    choices = c("Variável 1", "Variável 2", "Variável 3")
  ),
  textOutput(
    outputId = "var"
  ),
)

server <- function(input, output) {
  output$saudacao <- renderText({
    paste0("Olá ", input$nome, ", como vai?")
  })

  output$var <- renderText({
    paste0("Você selecionou a ", input$variavel)
  })

  # output$var <- renderText({
  #   paste0("Olá ", input$nome, ", você selecionou a ", input$variavel)
  # })
}

shinyApp(ui, server)
