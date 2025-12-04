library(shiny)
library(tidyverse)

ui <- navbarPage(
  title = "navbar page",
  tabPanel(
    title = "Página 1",
    titlePanel("Título da página 1"),
    fluidRow(
      column(
        width = 6,
        plotOutput("graficoA")
      ),
      column(
        width = 6,
        tableOutput("tableB")
      )
    )
  ),
  tabPanel(
    title = "Página 2",
    titlePanel("Título da página 2"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "var",
          label = "Escolha uma variável",
          choices = names(mtcars)
        )
      ),
      mainPanel(
        plotOutput("graficoC")
      )
    )
  ),
  navbarMenu(
    title = "Várias páginas",
    tabPanel(
      title = "Página 3",
      titlePanel("Título da página 3")
    ),
    tabPanel(
      title = "Página 4",
      titlePanel("Título da página 4")
    ),
    tabPanel(
      title = "Página 5",
      titlePanel("Título da página 5")
    )
  )
)


server <- function(input, output) {
  output$graficoA <- renderPlot({
    mtcars |>
      ggplot(aes(x = .data[["wt"]], y = .data[["mpg"]])) +
      geom_point()
  })

  output$tableB <- renderTable({
    mtcars |>
      filter(mpg > mean(mpg))
  })

  output$graficoC <- renderPlot({
    mtcars |>
      ggplot(aes(x = .data[[input$var]], y = .data[["mpg"]])) +
      geom_point()
  })
}

shinyApp(ui, server)
