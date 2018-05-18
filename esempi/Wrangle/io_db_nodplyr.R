setwd("~/Documenti/R/progetti/corsoR/esempi/Wrangle")
source("../dbconn/4_jdbccon.R")

dbListTables(conne)

film<-dbReadTable(conne,'film')
film<-dbGetQuery(conne,'select * from film')
payment<-dbGetQuery(conne,'select * from payment')
inventory<-dbGetQuery(conne,'select * from inventory')
rental<-dbGetQuery(conne,'select * from rental')
dbListFields(conne,'film')
dbListFields(conne,'payment')
dbListFields(conne,'rental')
dbListFields(conne,'inventory')


a<-dbGetQuery(conne,"select * from film")
b<-dbSendQuery(conne,"select * from film")
str(b)
b <- dbFetch(b)
dbClearResult()

dbSendUpdate(conne,"create table tmp5 as select * from film")
ss <- dbGetQuery(conne, "select * from tmp5")
dbSendUpdate(conne,"create table tmp3 as select distinct title from film")
c<-dbGetQuery(conne,"select * from tmp3")
dbWriteTable(conne,"c",c)

str(c)

