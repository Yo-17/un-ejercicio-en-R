# Ejemplo 2

install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")

library(DBI)
library(RMySQL)
library(dplyr)

#crear una base de datos

base <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

dbListTables(base)

dbListFields(base, "Country")

#query

df <- dbGetQuery(base,"Select * from City where Population > 5000")
class(df) #function
typeof(df) # closure

mean(df$Population)

df %>% filter(CountryCode == 'MEX', Name == 'Tijuana') %>% head(5)
