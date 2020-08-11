num_pages <- 4
final_id_num <- NULL
final_pub_text <- NULL

index_url_orig <- "https://ies.ed.gov/funding/grantsearch/index.asp?mode=1&sort=1&order=1&searchvals=&SearchType=or&checktitle=on&checkaffiliation=on&checkprincipal=on&checkquestion=on&checkprogram=on&checkawardnumber=on&slctAffiliation=0&slctPrincipal=0&slctYear=0&slctProgram=0&slctGoal=0&slctCenter=0&FundType=1&FundType=2"

for(i in 2:num_pages){
  
  index_url <- paste(index_url_orig, "&GrantsPageNum=", i, sep = "")
  
  index_page_ids <- read_html(index_url) %>% 
    html_nodes("a") %>% 
    str_subset("details") %>% 
    str_match("ID=[\\d]+")
  
  for(j in 1:(dim(index_page_ids)[1])){
    
    grant_url <- paste("https://ies.ed.gov/funding/grantsearch/details.asp?", 
                       index_page_ids[j, 1], sep = "")
    
    initial_parse <- read_html(grant_url) %>% 
      html_nodes("td") %>% 
      html_text()
    
    id_num <- initial_parse[20]

    detail_text <- initial_parse[[(length(initial_parse) - 1)]]
    
    if(str_count(detail_text, pattern = "Publications") > 0){
      
      pub_text <- str_match(detail_text, pattern = "(?s)Publications.*$")
      
    }else{
      
      pub_text <- NA
      
    }
    
    grant_output <- tibble(id = id_num, pub_text = pub_text, url = grant_url)
    write_csv(grant_output, "test.csv", append = TRUE)
    
  }
  
}

# That ^ almost works perfectly, except need a better way of parsing ID number