library(shiny)
library(tidyverse)

ui <- fluidPage(
  tags$head(
		tags$link(rel = "stylesheet", href = "custom.css")
	),
	img(
		src = "logo_col_branco.webp", 
		width = "200px",
		style = "display: block; margin: auto"),
  h1("Painel de dados do Curso-R"),
  hr(),
  includeMarkdown("descricao_html.md"),
	strong("Aqui fica negrito"),
	a(href = "http://lipsum.com/", "clique aqui"),
	plotOutput("grafico"),
)

server <- function(input, output, session) {
	output$grafico <- renderPlot(
  tibble::tibble(
    ano = 2015:2023,
    n_alunos = round(50 + (0:8) * 100 + runif(9, -50, 50))
  ) |>
    ggplot(aes(x = ano, y = n_alunos)) +
    geom_col() +
    theme_minimal()
	)
}

shinyApp(ui, server)
