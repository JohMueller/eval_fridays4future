# Write function to scrape and clean a Google Trends timeline for one organisation
#install.packages("drat")       # CRAN version is not workin anymore
#drat:::add("ghrr")             
install.packages("gtrendsR")  

library(gtrendsR)
library(dplyr)
library(lubridate)


get_gtrends <- function(health_day){
  weekly_hits <-  gtrends(health_day, 
                          time = "2015-01-01 2019-03-19",
                          geo = "DE",
                          low_search_volume = TRUE)$interest_over_time
  
  weekly_hits <-   weekly_hits %>%
    group_by(year=year(date), week = week(date)) %>%
    summarise(google = hits)
  
  return(weekly_hits)
}

gtrends_climate <- get_gtrends("klimawandel")
gtrends_heat <- get_gtrends("hitze")
gtrends_warm <- get_gtrends("wärme")
gtrends_trump <- get_gtrends("trump klimawandel")
gtrends_afd <- get_gtrends("afd klimawandel")

gtrends_data <- gtrends_climate
gtrends_data$heat <- gtrends_heat$google
gtrends_data$warm <- gtrends_warm$google
gtrends_data$trump <- gtrends_trump$google
gtrends_data$afd <- gtrends_afd$google

View(gtrends_data)
################
################
################
### Finished ###
################
################
