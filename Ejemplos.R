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


# Ejemplo 3

db_3 <- dbConnect(
  RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

rs <- dbSendQuery(db_3, "SELECT * FROM City Limit 5")
rs

city_df <- dbFetch(rs)

#desconectar de la bd

dbClearResult(rs)
dbDisconnect(db_3)


# Ejemplo 4

install.packages("rjson")
library(rjson)

json <- fromJSON(file = 'json_ejemplo4.json')

str(json)

json$Pets[2]

as.data.frame(json)

# XML

install.packages("XML")
library(XML)

link <- "http://www-db.deis.unibo.it/courses/TW/DOCS/w3schools/xml/cd_catalog.xml"

xml_file <- xmlTreeParse(link)

summary(xml_file)

top_xml <- xmlSApply(xml_file, function(x) xmlSApply(x, xmlValue))

xml_df <- data.frame(t(top_xml), row.names = NULL)

xml_df$PRICE <- as.numeric(xml_df$PRICE)


#html

install.packages("rvest")
library(rvest)

url <- "https://solarviews.com/span/data2.htm"
html <- read_html(url)

tables <- html_nodes(html, "table")

table_html <- html_table(tables[4], fill = TRUE)

table_html







