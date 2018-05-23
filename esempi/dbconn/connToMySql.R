library(stringr)
library(RJDBC)
connToMySql<-function(server,port,database,usr,psw){
  driverClass<-"com.mysql.jdbc.Driver"
  #classPath<-"C:/Documents and Settings/UserRegTosc/Documenti/driver/db2/db2jcc.jar"
  classPath<-"/usr/local/share/drivers/mysql/mysql-connector-java-5.1.44-bin.jar"
  #classPath<-"/usr/share/java/mysql-connector-java-8.0.11.jar"
  constr<-paste0("jdbc:mysql://",str_trim(server),":",str_trim(port),"/",str_trim(database),"?useSSL=false")
  #------------- ESECUZIONE ----------------------
  drv <- JDBC(driverClass,file.path(classPath) , identifier.quote=NA)
  conn<-dbConnect(drv,constr,usr,psw)
  return(conn)
}
