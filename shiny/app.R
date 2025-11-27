library(shiny)
library(tidyverse)

# User Interface
ui <- fluidPage(
  titlePanel("Meu APP"),
  textOutput(outputId = "text"),
  tableOutput(outputId = "table"),
  plotOutput(outputId = "plot"),
  plotOutput(outputId = "ggplot")
)


# Programa que roda por trás do app: todo código R que vai definir as
# visualizaçs que aparecerão na tela
server <- function(input, output) {
  
  output$plot <- renderPlot({
    plot(x = mtcars$wt, y = mtcars$mpg)
  })

  output$ggplot <- renderPlot({
    mtcars |>
      ggplot(aes(x = wt, y = mpg)) +
      geom_point()
  })

  output$table <- renderTable({
    mtcars |>
      group_by(cyl) |>
      summarise(
        mpg = mean(mpg)
      ) |>
      rename(
        "Número de cilindros" = cyl,
        "Consumo de combustível (milhas/galão)" = mpg
      )
  })

  output$text <- renderText({
    versao <- paste0(R.version$major, ".", R.version$minor)
    paste0("A versão do R utilizada é: ", versao) # Sempre a última linha será retornada
  })

}


shinyApp(ui, server)
