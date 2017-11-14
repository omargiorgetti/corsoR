library(DBI)
library(RJDBC)
drv<-dbDriver("JDBC")
str= "jdbc:mysql://10.12.2.208:3306/sakila?useSSL=false"
utente   ="ruser" 						#(utente)
password ="ruser" 						#(password) 

conn<-dbConnect(drv,str, utente, password)



