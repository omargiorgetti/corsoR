library(gdata)
library(RJDBC)
setConnSakila<-function(type)
  
{
  
  if (type=='local'){
    
    
    Percorso="/usr/local/share/drivers/mysql/mysql-connector-java-5.1.44-bin.jar"

    # Stringa di connessione  TEST
    stringa1= "jdbc:mysql://localhost:3306/sakila?useSSL=false"

  }else if(type=='aula'){
    Percorso="C:/mysql-connector-java-5.0.8/mysql-connector-java-5.0.8-bin.jar"
    
    # Stringa di connessione  TEST
    stringa1= "jdbc:mysql://10.12.2.208:3306/sakila?useSSL=false"
  }
  # Assegnazione del driver da usare
  Classe="com.mysql.jdbc.Driver"		# Parametri Classe e Percorso:
  utente   ="ruser" 						#(utente)
  password ="ruser" 						#(password) 
  drv=JDBC(driverClass=Classe, classPath=Percorso, identifier.quote = NA)
  return(list(drv=drv,str=stringa1,utente=utente,password=password))
}


