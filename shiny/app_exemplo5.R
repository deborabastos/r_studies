library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Preencha o formuário"),
  hr(),
  textInput(
    inputId = "nome",
    label = "Nome",
    value = "",
    placeholder = "Nome completo"
  ),
  dateInput(
    inputId = "data_nascimento",
    label = "Data de nascimento",
    max = Sys.Date(),
    value = Sys.Date(),
    language = "pt-BR",
    format = "dd-mm-yyyy"
  ),
  selectInput(
    inputId = "estado",
    label = "UF",
    choices = c("Pará", "Rio de Janeiro", "São Paulo", "Ceará")
  ),
  # Funciona como uma cancela. somente após acioná-lo a reatividade é iniciada
  actionButton(
    inputId = "enviar",
    label = "Enviar" 
  ),

  hr(),
  textOutput(outputId = "saida")
)

server <- function(input, output, session) {
  
  # eventReactive só é acionado quando input$enviar muda de estado
  # o reactive() observa alteração em todos os valores que estão dentro dele
  # o eventReactive observa somente o input$enviar
  # valores_enviados <- eventReactive(input$enviar, {
  #   glue::glue("Nome: {input$nome} - Data de nascimento: {input$data_nascimento} - Estado: {input$estado}")
  # })

  # No shiny mais recente, recomenda-se o uso do reactive() + bindEvent(), pois
  # o bindEvent() pode receber mais de um input para observar
  valores_enviados <- reactive({
    glue::glue("Nome: {input$nome} - Data de nascimento: {input$data_nascimento} - Estado: {input$estado}")
  }) |> bindEvent(input$enviar)


  output$saida <- renderText({
    valores_enviados()
  })
}

shinyApp(ui, server)


