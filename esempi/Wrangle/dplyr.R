library(dplyr)
setwd("~/Documenti/R/progetti/corsoR/esempi/Wrangle")
source("../dbconn/4_jdbccon.R")
dbListTables(conne)
dbListFields(conne,"film")
a<-tbl(conne,"film")

film<-dbReadTable(conne,'film')
inventory<-dbReadTable(conne,'inventory')
rental<-dbReadTable(conne,'rental')
nrow(film)
select(film,title)
inv_film<-inner_join(film,inventory)
inv_film<-inner_join(film,inventory,by=c("film_id"="film_id"))
rent_inv_film<-inner_join(inv_film,rental)


rent_inv_film1<-film%>%inner_join(inventory,by=c("film_id"="film_id"))%>%inner_join(rental)

s <- rent_inv_film %>% group_by(rating) %>% summarise(num=n())
w <- rent_inv_film %>% 
  filter(grepl('DINOSAUR',title)) %>% 
  select(title) %>% 
  separate(title,into=c('tipo','specie'),sep= " ") %>%
  count(tipo)
