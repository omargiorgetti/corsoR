
source("LocalPar.R")
#source("AulaPar.R")



conne<-dbConnect(drv, stringa1, utente, password)	# Attivazione connessione al DB 
str(conne)								# E' un oggetto di classe 'JDBCConnection'

###############################################################################################
#             2 - INTERROGAZIONI E QUERY SUL DB
###############################################################################################

dbListTables(conne)
str(ris)				# Molto numeroso

ris[1:40]						# Le prime 40 tabelle