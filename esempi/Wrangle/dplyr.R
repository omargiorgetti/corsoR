library(dbplyr)

setwd("~/Documenti/R/progetti/corsoR/esempi/Wrangle")
conne<-dbConnect(odbc::odbc(),"sakila")
dbListTables(conne)
dbListFields(conne,"film")
film<-tbl(conne,"film")

film<-dbReadTable(conne,"film")
inventory<-dbReadTable(conne,'inventory')
rental<-dbReadTable(conne,'rental')
nrow(film)
select(film,title)
inv_film<-inner_join(film,inventory)
inv_film<-inner_join(film,inventory,by=c("film_id"="film_id"))
rent_inv_film<-inner_join(inv_film,rental)


rent_inv_film1<-film%>%inner_join(inventory,by=c("film_id"="film_id"))%>%inner_join(rental)
rent_inv_film1 %>%show_query() 
s <- rent_inv_film %>% group_by(rating) %>% summarise(num=n())
a %>% show_query()
w <- rent_inv_film %>% 
  filter(grepl('DINOSAUR',title)) %>% 
  select(title) %>% 
  separate(title,into=c('tipo','specie'),sep= " ") %>%
  count(tipo)
