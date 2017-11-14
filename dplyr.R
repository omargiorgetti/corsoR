source("dbi.R")
dbListTables(conn)




str(airquality)			# data frame con i dati sulla qualit? dell'aria a New York
# da Maggio a Settembre 1973 usato negli esempi che seguono


######################### filter() ############################################################
# Restituisce il data frame le cui righe soddisfano la condizione

str(filter(airquality, Temp>90))			# Le 14 righe per le quali Temp>90 
filter(airquality, Temp>90 & Month==8)		# Caso con criterio multiplo
filter(airquality, Temp>90, Month==8)		# Argumenti multipli equivalgono a and (&)

######################### select() ############################################################
# Seleziona le colonne

str(select(airquality, Wind, Temp, Ozone))	# Seleziono e guardo la struttura del risultato

str(select(airquality, Wind:Day))			# Seleziono le colonne da : a

str(select(airquality, matches("a")))		# Seleziono le colonne che nel nome hanno una 'a'

######################### rename() ############################################################
# rinomina una o pi? colonne. Nota come il risultato sia un nuovo data frame

str(rename(airquality, Mese=Month, Giorno=Day))


######################### mutate() ############################################################
# Modifica il data frame aggiungendo una nuova variabile
# In questo esempio aaggiungiamo la temperatura in gradi Celsiue e un flag a 0 se Ozone=NA

airquality2 <- mutate(airquality, Temp.C=(Temp-32)*5/9, flag = ifelse(is.na(Ozone), 0, 1) )

str(airquality2)					# Ha aggiunto 'Temp.C' e 'flag'   (R base)			
head(airquality2, n=7)				# Visulaizzo le prime 7 righe     (R base)
sum(airquality2$flag)				# Conto i valori non NA in Ozone  (R base)
sum(airquality2$flag==0)			# Conto i valori NA in Ozone      (R base)
addmargins(table(airquality2$flag))		# Tanella di spoglio              (R base)

######################### arrange() ###########################################################
# Ordina le righe secono una o pi? variabili

ord1<-arrange(airquality, desc(Month), Temp)
ord1[1:20,]			# Ordinamento per mese decrescente e per temperatura crescente

# Vari modi di calcolare il rango di una variabile
vet<-c(1,1,2,7,5, NA)
min_rank(vet)			# 1 1 3 5 4 NA
dense_rank(vet)			# 1 1 2 4 3 NA
row_number(vet)			# 1 2 3 5 4 NA
percent_rank(vet)			# 0.00 0.00 0.50 1.00 0.75   NA
cume_dist(vet)			# 0.4 0.4 0.6 1.0 0.8  NA
# Proportione di tutti i valori minori o uguali al rango corrente
ntile(vet, n=3)			# Spezza il vettore in n ranghi
ntile(runif(100), n=5)
table(ntile(runif(100), n=5))	# Ciascun segmento di rango ha la stessa frequenza!

######################### summarise() ##########################################################
# Sintetizza una o pi? variabili, secondo una o pi? funzioni

summarise(airquality2, "Media ozono" = mean(Ozone, na.rm=TRUE), 
          "Giorni con dato" = sum(flag==1),
          "Giorni senza dato" = sum(flag==0),
          "Giorni%"  = 100*mean(flag)  ) 

######################### group_by() ##########################################################
# Raggruppa i dati in base a una o pi? variabili

gruppi.mese<-group_by(airquality, Month)
str(gruppi.mese)						# E' un oggetto della classe grouped_df
attributes(gruppi.mese)					# Lista degli attributi dell'oggetto

attributes(gruppi.mese)$group_sizes			# Vettore delle dimensioni dei gruppi

summarize(group_by(airquality, Month), 
          "Medie mensili Temp"=mean(Temp, na.rm=TRUE),
          "Varianze mensili" =var(Temp, na.rm=TRUE))


######################### distint() ##########################################################
# Estrae i valori distinti di una variabile

str(distinct(airquality, Ozone))	# Un data frame con 68 righe e 1 variabile



############################ count() ##########################################################
# Calcola le frequenze delle occorrenze di una o pi? variabili. Nota come il risultato
# sia ancora un data frame, mentre in R base sarebbe un oggetto 'table'

count(airquality2, Month)
conteggi<-count(airquality2, Month, flag)

class(conteggi)						# E' un oggetto della classe grouped_df
is.data.frame(conteggi)					# TRUE

conteggi2<-table(airquality2$Month, airquality2$flag)
class(conteggi2)
is.data.frame(conteggi2)				# FALSE


############################ sample_n(), sample_frac() ########################################
Seleziona un numero di righe o una frazione di righe casualmente

dim(airquality)					# Il dataset ha 153 righe e 6 colonne
sample_n(airquality, size=12) 		# selezione casuale di 12 righe
sample_frac(airquality, size=0.1)		# selezione casuale del 10% di righe

dim(sample_frac(airquality, size=0.1))	# un subset casuale di 15 righe e le 6 colonne


############################# operatore pipe %>% ##############################################
# L'operatore %>% pu? essere usato per concatenare il codice, in alternativa al metodo della
# funzione composta in R base o alla assegnazione di risultati parziali con dplyr

# Esempio
# Soluzione con assegnazioni intermedie, spesso superflue

dati.filtrati<-filter(airquality, Month>6)		# Filtro i mesi 7, 8, 9
dati.raggrup <-group_by(dati.filtrati, Month)		# Definisco il raggruppamento per mese
summarize(dati.raggrup, mean(Temp, na.rm=TRUE)		# Calcolo la temperatura media per mese
          
          
          # Soluzione con operatore pipe
          
          airquality %>% filter(Month>6) %>% group_by(Month) %>% summarize(mean(Temp, na.rm=TRUE))
          
          # Pu? essere utile, per catene molto lunghe andare a capo con indentazione
          
          airquality %>% 
            filter(Month>6) %>% 
            group_by(Month) %>% 
            summarize(mean(Temp, na.rm=TRUE))
          
          # Adesso dopo aver filtrato le righe con flag=1 (Ozono non NA) calcolo la temperatura media
          # e il livello medio di ozono per mese, quindi estraggo i mesi per i quali la 
          # tempoeratura media ? superiore 75 
          
          airquality2 %>% 
            filter(flag==1) %>% 
            group_by(Month) %>% 
            summarize(media.temp=mean(Temp, na.rm=TRUE), media.ozono=mean(Ozone)) %>%
            filter(media.temp > 75) 
          
          
          
          ############## Aplicazione di summarize() secondo gli input ##############################
          # numero di varibili da sintetizzare:  una / molte
          # numero di funzioni di sintesi:       una / molte
          # sottogruppi:				    si / no
          
          data(mtcars)		# Considero il data frame 'mtcars' (dati su 32 modelli di auto)
          str(mtcars)			# 32 osservazioni e 11 variabili
          
          # 	mpg 	Miles/(US) gallon
          # 	cyl 	Number of cylinders
          # 	disp 	Displacement (cu.in.)
          # 	hp 	Gross horsepower
          # 	drat 	Rear axle ratio
          # 	wt 	Weight (1000 lbs)
          # 	qsec 	1/4 mile time
          # 	vs 	V/S
          # 	am 	Transmission (0 = automatic, 1 = manual)
          # 	gear 	Number of forward gears
          # 	carb 	Number of carburetors 	
          
          cars<-tbl_df(mtcars)		# lo trasformo in un oggetto 'tbl'
          
          
          # Caso 1a -- Una variabile, una funzione, nessun sottogruppo
          cars %>% summarize("Miglia media" = mean(mpg) )
          
          # Caso 1b -- Una variabile, una funzione, sottogruppi
          cars %>% group_by(cyl) %>% summarize("Miglia media" = mean(mpg) )
          
          
          
          # Caso 2a -- Una variabile, molte funzioni, nessun sottogruppo
          cars %>% summarize("Miglia massimo" = max(mpg), "Miglia minimo" = min(mpg) )
          
          # Caso 2b -- Una variabile, molte funzioni, sottogruppi
          cars %>% group_by(cyl) %>%
            summarize("Miglia massimo" = max(mpg), "Miglia minimo" = min(mpg) )
          
          
          
          # Caso 3a -- Molte variabili, una funzione, nessun sottogruppo
          cars %>% summarize("Miglia media" = mean(mpg), "cilindrata media" = mean(disp) )
          
          # Caso 3b -- Molte variabili, una funzione, sottogruppi
          cars %>% group_by(cyl) %>% 
            summarize("Miglia media" = mean(mpg), "cilindrata media" = mean(disp) )
          
          
          
          # Caso 4a -- Molte variabili, molte funzioni, nessun sottogruppo
          cars %>% summarize("Miglia media"  = mean(mpg), "cilindrata media" = mean(disp),
                             "Potenza media" = mean(hp),  "Massimo qsec"     =  max(qsec), N=n() )
          
          # Caso 4b -- Molte variabili, molte funzioni, sottogruppi
          cars %>% group_by(cyl) %>% 
            summarize("Miglia media"  = mean(mpg), "cilindrata media" = mean(disp),
                      "Potenza media" = mean(hp),  "Massimo qsec"     =  max(qsec), N=n() )
          
          # Nota: la funzione n() calcola la numerosit? in ciascu ngruppo
          
          
          ############## CONFRONTO FRA SINTASSI DI R base e R con le funzioni di dplyr  ############
          
          tapply(mtcars$mpg, mtcars$cyl, mean)			# Sintassi di R base
          
          summarize(group_by(mtcars, cyl), mean(mpg) )		# Sintassi di R - dplyr
          
          mtcars %>% group_by(cyl) %>% summarize(mean(mpg))	# Sintassi di R - dplyr e pipe %>%
          
          
          ########################## JOIN DATASETS con dplyr ########################################
          
          x<-data.frame(
            nome=c("Luigi", "Piero", "Gianni", "Luca", "Giorgio", "Fabio"),
            strumento=c("chitarra", "basso", "chitarra", "tastiera", "basso", "tastiera"),
            stringsAsFactors =FALSE)
          str(x)
          
          y<-data.frame(
            nome=c("Luigi", "Piero", "Gianni", "Luca", "Andrea"),
            band=c(T, T, T, T, F), stringsAsFactors =FALSE )
          str(y)
          
          # Tipi di join. Se by=NULL la join usa le colonne dei due dataset con gli stessi nomi
          
          # inner_join(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...)
          # left_join (x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...)
          # right_join(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...)
          # full_join (x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...)
          # semi_join (x, y, by = NULL, copy = FALSE, ...)
          # anti_join (x, y, by = NULL, copy = FALSE, ...) 
          
          # In questo esempio la chiave per le join ? il campo "nome" presente in entrambi i dataset
          
          inner_join(x, y)			# solo le chiavi comuni ai due dataset
          
          left_join(x, y)			# tutte le chiavi del dataset x
          right_join(x, y)			# tutte le chiavi del dataset y
          
          # Verifico che left_join(x,y) ? uguale a right_join(y,x) a meno dell'ordine delle colonne
          left_join(x, y)[,c("nome", "strumento", "band")] == 
            right_join(y, x)[,c("nome", "strumento", "band")]
          
          full_join(x, y)			# Tutte le chiavi di entrambi i dataset x e y
          
          semi_join(x, y)			# subset x che ha le chiavi in y
          semi_join(y, x)			# subset y che ha le chiavi in x
          
          anti_join(x, y)			# subset x che non ha le chiavi in y	
          anti_join(y, x)			# subset y che non ha le chiavi in x
          
          #############################################################################################
          
          