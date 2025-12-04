library(shiny)

ui <- fluidPage(
	titlePanel("Fluid Page"),
	fluidRow(
		column(
			width = 4,

			# selectInput(
			# 	inputId = "var_a",
			# 	label = "Selecione uma variável",
			# 	choices = names(mtcars)
			# )

			varSelectInput(
				inputId = "var_a",
				label = "Selecione uma variável",
				data = mtcars
			)

			),
		column(
			width = 8,
			plotOutput(outputId = "grafico")
			)
	)
)

server <- function(input, output, session) {
	output$grafico <- renderPlot({
		plot(x = mtcars[[input$var_a]], y = mtcars[["mpg"]])
	})
}

shinyApp(ui, server)