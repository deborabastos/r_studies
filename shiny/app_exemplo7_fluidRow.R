library(shiny)
library(tidyverse)

ui <- fluidPage(
	titlePanel("Exemplo com dois inputs e dois outputs"),
	hr(),
	fluidRow(
		column(
			width = 6,
		
			selectInput(
				inputId = "variavel_a",
				label = "Variável do Eixo X no gráfico A",
				choices = names(mtcars),
				selected = "wt"
			),
		
			plotOutput(outputId = "grafico_a")
		),
		
		column(
			width = 6,

			selectInput(
					inputId = "variavel_b",
					label = "Variável do Eixo X no gráfico B",
					choices = names(mtcars),
					selected = "hp"
				),	
	
			plotOutput(outputId = "grafico_b")
		)
	)
)

server <- function(input, output, session) {
	output$grafico_a <- renderPlot({
  mtcars |>
    ggplot(aes(x = .data[[input$variavel_a]], y = mpg)) +
    geom_point()
	})


	output$grafico_b <- renderPlot({
  mtcars |>
    ggplot(aes(x = .data[[input$variavel_b]], y = mpg)) +
    geom_point()
	})
}


shinyApp(ui, server)