# install.packages("rvest")
library(rvest)
library(purrr)
library(tidyverse)
library(stringr)
url <- "https://ies.ed.gov/funding/grantsearch/details.asp?ID=1608"
url <- "https://ies.ed.gov/funding/grantsearch/details.asp?ID=2039"
web_page <- read_html(url)

test <- web_page %>% 
  html_nodes("td") %>% 
  html_text()
test <- test[[(length(test) - 1)]]
# 
# test <- web_page %>%
#   html_text()
str_count(test, pattern = "Publications")
str_locate_all(test, pattern  = "(?s)Publications.*$")
str_split(test, pattern = "Publications\\$")
str_match(test, pattern = "(?s)Publications.*$")

str_locate(test, pattern = "[^Publications]+$")

