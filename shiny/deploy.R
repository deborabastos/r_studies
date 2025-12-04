rsconnect::deployApp(
  appName = "meuApp",
  account = "meuuser"
)

# Se tiver dentro do Golem, usa a função deploy
deploy <- function() {
  rsconnect::deployApp(
    appName = "meuApp",
    account = "meuuser"
  )
}


# https://www.shinyapps.io/admin/#/dashboard


# Para publicar, no console:
#library(rsconnect)
#   rsconnect::deployApp("C:/Users/debora.bastos/OneDrive - mtegovbr/Documentos/r_studies/shiny")

# Mais informações
# https://shiny.posit.co/r/articles/share/shinyapps/?_gl=1*sbyzgp*_ga*MTY5MDQxMDMzNy4xNzY0MzU3Nzg2*_ga_2C0WZ1JHG0*czE3NjQzNTc3ODYkbzEkZzEkdDE3NjQzNTc4MDgkajM4JGwwJGgw