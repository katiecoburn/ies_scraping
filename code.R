# install.packages("rvest")
library(rvest)
library(purrr)
# library(tidyverse)
library(stringr)
url <- "https://ies.ed.gov/funding/grantsearch/details.asp?ID=1608"
url <- "https://ies.ed.gov/funding/grantsearch/details.asp?ID=2039"
url <- "https://ies.ed.gov/funding/grantsearch/details.asp?ID=1879"
web_page <- read_html(url)

test <- web_page %>% 
  html_nodes("td") %>% 
  html_text()
test <- test[[(length(test) - 1)]]

test <- web_page %>% 
  html_nodes("td") %>% 
  html_text()
id_num <- test[20]
# 
# test <- web_page %>%
#   html_text()
str_count(test, pattern = "Publications")
# str_locate_all(test, pattern  = "(?s)Publications.*$")
# str_split(test, pattern = "Publications\\$")
str_match(test, pattern = "(?s)Publications.*$")

# str_locate(test, pattern = "[^Publications]+$")


indexurl_page1 <- "https://ies.ed.gov/funding/grantsearch/index.asp?mode=1&sort=1&order=1&searchvals=&SearchType=or&checktitle=on&checkaffiliation=on&checkprincipal=on&checkquestion=on&checkprogram=on&checkawardnumber=on&slctAffiliation=0&slctPrincipal=0&slctYear=0&slctProgram=0&slctGoal=0&slctCenter=0&FundType=1&FundType=2"
# Each page after 1 adds on: &GrantsPageNum=_
# 
# https://ies.ed.gov/funding/grantsearch/index.asp?mode=1&sort=1&order=1&SearchType=or&checktitle=on&checkaffiliation=on&checkprincipal=on&checkquestion=on&checkprogram=on&checkawardnumber=on&slctAffiliation=0&slctPrincipal=0&slctYear=0&slctProgram=0&slctGoal=0&slctCenter=0&FundType=1&FundType=2&GrantsPageNum=2
# https://ies.ed.gov/funding/grantsearch/index.asp?mode=1&sort=1&order=1&SearchType=or&checktitle=on&checkaffiliation=on&checkprincipal=on&checkquestion=on&checkprogram=on&checkawardnumber=on&slctAffiliation=0&slctPrincipal=0&slctYear=0&slctProgram=0&slctGoal=0&slctCenter=0&FundType=1&FundType=2&GrantsPageNum=150


index <- read_html(indexurl_page1)
# test <- index %>% 
#   html_nodes("a") %>% 
#   html_attrs()

progress <- index %>% 
  html_nodes("a") %>% 
  str_subset("details") %>% ## Match ?ID=___\. Whatever numbers are in there.
  str_match("ID=[\\d]+")

#OH SHIT I FUCKIN WROTE A REGEX MYSELF
#
# Okay. So.
# Loop over the number of pages -- I think it's 1 to 159 or some shit
# For each page, extract all the ID numbers to the specific grants
# (code above).
# Then stick those numbers into the code at the top to parse out
# any publications for them!