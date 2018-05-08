library("dbplyr")
  con <- dbConnect(odbc::odbc(),"DB2conn")
  con <- dbConnect(odbc::odbc(),"DB2connl")
  con <- dbConnect(odbc::odbc(),"DB2")

con <- dbConnect(odbc::odbc(),
      driver="/usr/lib/libdb2.so",
      servername="db2dwp1.regione.toscana.it",
      database="DSPSSNAP",
      UserName="og15382",
      Password="OG15382o",
      port=50000
)


library(DBI)
con <- dbConnect(odbc::odbc(),
                 .connection_string = "Driver={DB2};
                 Uid=og15382;Pwd=OG15382o;
                 Host=db2dwp1.regione.toscana.it;
                 Port=50000;Database=DSPSSNAP;")

