source("dbconn/jdbccon2.R")

dbListTables(conne)

a<-dbGetQuery(conne,"select * from film")
b<-dbSendQuery(conne,"select * from film")
str(b)
b <- dbFetch(b)
dbClearResult()

dbSendUpdate(conne,"create table tmp2 as select * from film")
ss <- dbGetQuery(conne, "select * from tmp2")
dbSendUpdate(conne,"create table tmp3 as select distinct title from film")
c<-dbGetQuery(conne,"select * from tmp3")
dbWriteTable(conne,"c",c)

str(c)

