
DATI<-read.csv("abbandono.csv", header=TRUE, sep = ";", as.is=TRUE, dec=",")
str(DATI)
write.csv(DATI,file='prova.csv')
