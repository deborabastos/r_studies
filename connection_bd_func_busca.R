library(DeaexR)
library(tidyverse)

dados <- busca("SELECT * FROM BD.AE_2025_MES") |>
  janitor::clean_names() |>
  glimpse()


