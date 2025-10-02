options(java.parameters = "-Xmx8g")

library(RJDBC)
library(tidyverse)

USU='consultas'

SEN='deaexsecex01'

drv <- RJDBC::JDBC("oracle.jdbc.OracleDriver", classPath = glue::glue('{Sys.getenv("OneDriveDIEST")}/ojdbc/ojdbc5.jar'), " ")

conn <- DBI::dbConnect(
    drv,
    "jdbc:oracle:thin:@10.209.43.140:1521/orclProd.mdic.gov.br",
    USU,
    SEN
)

dado <- RJDBC::dbGetQuery(conn, "SELECT * FROM BD.AE_2025_MES")

RJDBC::dbDisconnect(conn)

dado |> glimpse()
 