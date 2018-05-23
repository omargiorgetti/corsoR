# 10.12.2.208 sakila ruser
library(RODBC)
channel <- odbcConnect("sakila")
odbcGetInfo(channel)
sqlTables(channel)
sqlColumns(channel,'actor')