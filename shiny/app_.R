library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Exemplo com dois inputs e dois outputs"),
  hr(), # linha horizontal
  selectInput(
    inputId = "variavel_A",
    label = "Variável do eixo x do gráfico A",
    choices = names(mtcars),
    selected = "wt" # mudar o padrão da variável selecionada
  ),
  plotOutput(outputId = "grafico_A"),
  hr(),
  selectInput(
    inputId = "variavel_B",
    label = "Variável do eixo x do gráfico B",
    choices = names(mtcars),
    selected = "wt"
  )
)

server <- function(input, output, session) {
  output$grafico_A <- renderPlot({
    print("Rodei código variável A")
    mtcars |>
      ggplot() +
      geom_point(aes(x = .data[[input$variavel_A]], y = mpg))
  }),
  
  output$grafico_B <- renderPlot({
      print("Rodei código variável B")
      mtcars |>
        ggplot() +
          geom_point(aes(x = .data[[input$variavel_B]], y = mpg))
    })

}

shinyApp(ui, server)
