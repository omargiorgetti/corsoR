Classe<-"com.mysql.jdbc.Driver"		# Parametri Classe e Percorso:
Percorso<-"/usr/local/share/drivers/mysql/mysql-connector-java-5.1.44-bin.jar"
Classe<-"com.mysql.jdbc.Driver"		# Parametri Classe e Percorso:
Percorso<-"C:/mysql-connector-java-5.0.8/mysql-connector-java-5.0.8-bin.jar"

# Assegnazione del driver da usare
drv<-JDBC(driverClass=Classe, classPath=Percorso, identifier.quote = NA)

# Stringa di connessione  TEST
stringa1<- "jdbc:mysql://localhost:3306/sakila?useSSL=false"
stringa1<- "jdbc:mysql://10.12.2.208:3306/sakila"
utente   <-"ruser" 						#(utente)
password <-"ruser" 						#(password)



conne<-dbConnect(drv, stringa1, utente, password)	# Attivazione connessione al DB 
str(conne)								# E' un oggetto di classe 'JDBCConnection'

###############################################################################################
#             2 - INTERROGAZIONI E QUERY SUL DB
###############################################################################################

dbListTables(conne)
str(ris)				# Molto numeroso

ris[1:40]						# Le prime 40 tabelle