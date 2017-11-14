Classe<-"com.mysql.jdbc.Driver"		# Parametri Classe e Percorso:
Percorso<-"C:/mysql-connector-java-5.0.8/mysql-connector-java-5.0.8-bin.jar"

# Assegnazione del driver da usare
drv<-JDBC(driverClass=Classe, classPath=Percorso, identifier.quote = NA)

# Stringa di connessione  TEST
stringa1<- "jdbc:mysql://10.12.2.208:3306/sakila"
utente   <-"ruser" 						#(utente)
password <-"ruser" 						#(password)