library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Avaliando consumo de gasolina dos carros"),
  selectInput(
    inputId = "cyl",
    label = "Número de cilindros",
    choices = sort(unique(mtcars$cyl))
  ),
  textOutput(outputId = "menor_valor"),
  textOutput(outputId = "maior_valor")
)

server <- function(input, output, session) {
  
  #base_filtrada passa a ser uma função reativa, por isso deve ser chamada com base_filtrada()
  base_filtrada <- reactive({
    mtcars |>
      filter(cyl == input$cyl)
  })
  
  output$menor_valor <- renderText({
    carro <- base_filtrada() |>
      slice_min(order_by = mpg, n = 1, with_ties = FALSE) |>
      tibble::rownames_to_column(var = "nome_carro") |>
      pull(nome_carro)

    glue::glue("O carro de {input$cyl} cilindros com menor consumo é: {carro}")
  })
  

  output$maior_valor <- renderText({
    carro <- base_filtrada() |>
      slice_max(order_by = mpg, n = 1, with_ties = FALSE) |>
      tibble::rownames_to_column(var = "nome_carro") |>
      pull(nome_carro)
    
    glue::glue("O carro de {input$cyl} cilindros com maior consumo é: {carro}")
  })

}

shinyApp(ui, server)
