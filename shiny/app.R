library(shiny)

ui <- fluidPage(
  titlePanel("Página"),
  selectInput(
    inputId = "select",
    label = "Select",
    choices = c("1", "2", "3"),
    selected = "1"
  ),
  textOutput("text")
)

server <- function(input, output) {
  output$text <- renderText({
    # para a renderização e deixa verificar variáveis no terminal - input$select
    # Para o browser() continuar a rodar o código: c
    # Para sair do browser(): Q ou f???
    # browser()
    paste("O número é", input$select)
  })
}

shinyApp(ui = ui, server = server, options = list(launch.browser = FALSE, port = 4242)) # nolint: line_length_linter.
