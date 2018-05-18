library(gdata)
library(RJDBC)
connTodb2<-function(server,port,database,schema,usr,psw){
  driverClass<-"com.ibm.db2.jcc.DB2Driver"
  classPath<-"C:/Documents and Settings/UserRegTosc/Documenti/driver/db2/db2jcc.jar"
  server<-paste0(server,".regione.toscana.it")
  constr<-paste0("jdbc:db2://",trim(server),":",trim(port),"/",trim(database),":currentSchema=",trim(schema),";")
  #------------- ESECUZIONE ----------------------
  drv <- JDBC(driverClass,file.path(classPath) , identifier.quote=NA)
  conn<-dbConnect(drv,constr,usr,psw)
  return(conn)
}
