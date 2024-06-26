# Reto 01

library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

#crear una base de datos

base <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

dbListTables(base)

dbListFields(base, "CountryLanguage")

#query

sl_countries <- dbGetQuery(base,"SELECT * FROM CountryLanguage WHERE Language = 'SPANISH'")
class(df) #function
typeof(df) # closure


sl_countries <- sl_countries %>%
  mutate(Oficial = ifelse(IsOfficial == "T", "Oficial", "No Oficial"))

ggplot(sl_countries, aes(x = Percentage, y = CountryCode, fill = Oficial)) +
  geom_bin2d(binwidth = 5) +
  scale_fill_manual(values = c("Oficial" = "blue", "No Oficial" = "red")) +
  coord_flip() +
  labs(title = "Porcentaje de Hablantes de Español por País",
       x = "Porcentaje",
       y = "País") +
  theme_minimal()

# Reto 02

library(httr)
library(rvest)

url <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
glassdoor_response <- GET(url, add_headers('user-agent' = 'data science student (yolandamtz17@gmail.com)'))

glassdoor_html <- content(glassdoor_response, as = "text", encoding = "UTF-8")
glassdoor_parsed <- read_html(glassdoor_html)

tables <- html_nodes(glassdoor_parsed, "table")

## El Reto no se pudo hacer por que se necesitan varios permisos y el URL no trae la tabla como tal


# Reto 03


