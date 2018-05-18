#DM_EMURSDO@DSPS@DB2DWP1
library(ibmdbR)
conn<-idaConnect('DSPSDWP1','og15382','#########', conType='odbc')
idaInit(conn)
idaShowTables(TRUE,'F_EMUR_SDO','DM_EMURSDO')
data<-ida.data.frame('DM_EMURSDO.F_EMUR_SDO')
dim(data)
head(data)

