setwd("~/Documenti/R/progetti/corsoR/esempi/dbconn")
source("connSakila.R")

drvstr<-setConnSakila("local")
conne<-dbConnect(drvstr$drv, drvstr$str, drvstr$utente, drvstr$password)	# Attivazione connessione al DB 
str(conne)								# E' un oggetto di classe 'JDBCConnection'

dbListTables(conne)

