options(java.parameters = "-Xmx1024m")
library(rJava)
library(RJDBC)

drv <- JDBC(driverClass="com.ibm.db2.jcc.DB2Driver"
            , classPath="C:/Users/userregtosc/Documents/driver/db2/db2jcc.jar"
            , identifier.quote=NA)

connj<-dbConnect(drv,"jdbc:db2://db2dwt1.regione.toscana.it:55000/DSPS:currentSchema=DM_EMURSDO;","og15382","OG15382o")
source(file="query.R")
stime <- Sys.time()
df=dbGetQuery(connj,sql_str)
etime <- Sys.time()
time<- etime - stime
time
