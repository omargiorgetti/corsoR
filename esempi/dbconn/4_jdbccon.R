setwd("~/Documenti/R/progetti/corsoR/esempi/dbconn")
source("connToMySql.R")

conne<-connToMySql('localhost','3306','sakila','ruser','ruser')
str(conne)								# E' un oggetto di classe 'JDBCConnection'
dbListTables(conne)


