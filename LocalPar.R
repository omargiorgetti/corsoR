Classe<-"com.mysql.jdbc.Driver"		# Parametri Classe e Percorso:
Percorso<-"/usr/local/share/drivers/mysql/mysql-connector-java-5.1.44-bin.jar"

# Assegnazione del driver da usare
drv<-JDBC(driverClass=Classe, classPath=Percorso, identifier.quote = NA)

# Stringa di connessione  TEST
stringa1<- "jdbc:mysql://localhost:3306/sakila?useSSL=false"
utente   <-"ruser" 						#(utente)
password <-"ruser" 						#(password)