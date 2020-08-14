library(tidyverse)
library(janitor)
library(rvest)
library(purrr)
library(stringr)

our_sample <- read_csv(file = "our_sample.csv", col_names = TRUE) %>% 
  clean_names()

test <- our_sample %>% 
  select(principal_name, principal_affiliation_name)

test[1,]
test[100,]

test$principal_name %>% factor() %>% table()

# pull out the name and affiliation, paste them together with +s, add to end
# of google search url
url <- "https://www.google.com/search?q=Cunningham+Anne+University+of+California+Berkeley"

web_page <- read_html(url)

# pull out all the links of the google search
all_links <- web_page %>% 
  html_nodes('a') %>% # actual results seem to all start with url
  str_subset("url") # extract from url?q=_______________\

link1 <- all_links[1] # pull the first one (im feeling lucky)

str_extract(link1, regex("htt(.)+(?=\"\\><h3 class)", dotall = TRUE)) # parse out all the gobbledygook
# ^ don't know how the fuck i did that

url2 <- str_extract(link1, regex("htt(.)+(?=\"\\><h3 class)", dotall = TRUE))


read_html(url2) %>% # go to that link
  html_nodes('a') %>% # pull out all links on page
  str_subset("mailto") # select links that go to email
# ^ problem is, won't match emails that aren't mailto links
# but i think that will probably capture the vast majority
# will have to experiment
# and wrap all this jazz in a loop
# and also pull out unique name/place combos only
# (keep same name/different place in case people moved)