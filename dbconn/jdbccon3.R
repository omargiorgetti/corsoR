setwd("~/Documenti/R/progetti/corsoR")
source("dbconn/conn.R")

drvstr<-setConn("local")
conne<-DBI::dbConnect(drvstr$drv, drvstr$str, drvstr$utente, drvstr$password)	# Attivazione connessione al DB 
str(conne)								# E' un oggetto di classe 'JDBCConnection'



