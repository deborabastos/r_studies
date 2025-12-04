library(shiny)
library(tidyverse)

ui <- fluidPage(
	titlePanel("Sidebar Layout"),
	sidebarLayout(
		sidebarPanel = sidebarPanel(
			varSelectInput(
				inputId = "var",
				label = "Selecione uma variável",
				data = mtcars
			)
		),
		mainPanel = mainPanel(
			plotOutput("grafico")
		)	
	)

)

server <- function(input, output, session) {
	output$grafico <- renderPlot({
		plot(x = mtcars[[input$var]], y = mtcars[["mpg"]])
	})
}

shinyApp(ui, server)