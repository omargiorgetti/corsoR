source("dbconn/jdbccon2.R")

dbListTables(conne)

a<-dbGetQuery(conne,"select * from film")
b<-dbSendQuery(conne,"select * from film")
dbFetch(b)
dbClearResult()

dbSendUpdate(conne,"create table tmp as select * from film")
dbSendUpdate(conne,"create table tmp1 as select distinct title from film")
c<-dbGetQuery(conne,"select * from tmp1")
dbWriteTable(conne,"c",c)

str(c)

