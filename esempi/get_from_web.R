library(jsonlite)
library(tidyverse)
resp<-fromJSON("http://servizi.toscana.it/RT/mappe/strutturericettiveXall.json?_ga=2.17440825.1225592402.1525851067-977727594.1525851067")
strutture<-resp$strutturericettiveXall$SelXall
strutture[1:10]
summary(strutture)
numtipo=count(strutture,tipologia)
numtipostella=count(strutture,tipologia,stelle)
pivottipostella=spread(numtipostella,stelle,n)
pivottipostella=spread(numtipostella,stelle,n)
write.csv(pivottipostella,file="/home/userregtosc/Documenti/R/progetti/corsoR/esempi/pivottipostella")
pop <- read.csv2("esempi/popolazioneresidenteperetasessoestatocivileanno2013.csv")

ggplot(data=strutture)+geom_bar(mapping=aes(x=tipologia,fill=stelle))+coord_flip()
ggplot(data=strutture)+geom_bar(mapping=aes(x=tipologia))