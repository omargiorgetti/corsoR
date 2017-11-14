
source(file.path(getwd(),"connTo.R"))
conn_dw<-connTo("db2dwt1","55000","DSPS","syscat","og15382","OG15382o")
conn_sor<-connTo("db2dwt1","55000","DSPSSNAP","syscat","og15382","OG15382o")

dw_all<-dbGetQuery(conn_dw,"select * from syscat.columns where tabschema='DM_SALM_NEW' order by tabname")

dw_tabname<-dbGetQuery(conn_dw,"select distinct tabname from syscat.columns where tabschema='DM_SALM_NEW'")
dw_num<-data.frame()
for(i in 1 : nrow(dw_tabname))
{
  

  num<-tryCatch(
      dbGetQuery(
        conn_dw
          ,paste0("select count(*) from DM_SALM_NEW."
                ,dw_tabname[i,]
          )
      )
      ,error=function(e){
          print(paste0(i,"-no"))
          print(e)
          to<-0
          return(to)
      }
  )
  
  print(paste0(i,"#",dw_tabname[i,],"-",num))  
  dw_num<-rbind(dw_num,data.frame(tabname=dw_tabname[i,],numero=num))

}




s_tabname<-dbGetQuery(conn_sor,"select distinct tabname from syscat.columns where tabschema='SALM'")
s_num<-data.frame()
for(i in 1 : nrow(s_tabname))
{
  num<-tryCatch(
    dbGetQuery(conn_sor,paste0("select count(*) from SALM.",s_tabname[i,]))
    ,error=function(e){
      print(paste0(i,"-no"))
      print(e)
      to<-0
      return(to)
    }
  )
    print(paste0(i,"#",s_tabname[i,],"-",num))  
  s_num<-rbind(s_num,data.frame(tabname=s_tabname[i,],numero=num))

}

write.table(dw_num,file="C:\\Documents and Settings\\userregtosc\\Documenti\\ambiti\\SANITA\\SALM\\verifiche\\consegna\\dw_count_table.ODS",
            append = FALSE, 
            quote = FALSE, sep = ";", row.names = FALSE,col.names = TRUE,
            eol = "\n", na = "NA", dec = ",", 
            qmethod = c("escape", "double"))
write.table(s_num,file="C:\\Documents and Settings\\userregtosc\\Documenti\\ambiti\\SANITA\\SALM\\verifiche\\consegna\\s_count_table.ods",
            append = FALSE, 
            quote = FALSE, sep = ";", row.names = FALSE,col.names = TRUE,
            eol = "\n", na = "NA", dec = ",", 
            qmethod = c("escape", "double"))


dw_tabcols<-dbGetQuery(conn_dw,"select distinct tabname,colname,typename from syscat.columns where tabschema='DM_SALM_NEW'")

dw_tabcols_F<-subset(dw_tabcols,substr(dw_tabcols$TABNAME,1,1)=="F")
s_tabcols<-dbGetQuery(conn_sor,"select distinct tabname,colname,typename from syscat.columns where tabschema='SALM' order by tabname,typename")



dw_f_name<-unique(dw_tabcols_F$TABNAME)
path="C:\\Documents and Settings\\userregtosc\\Documenti\\ambiti\\SANITA\\SALM\\verifiche\\consegna\\"

for(i in 1 : length(dw_f_name))
{
  name=dw_f_name[i]
  fname=paste0(name,".ods")
  print(paste0(i,"-",fname))
  tosave<-subset(dw_tabcols_F,dw_tabcols_F$TABNAME==name,select=COLNAME)
  write.table(tosave,file=file.path(paste0(path,fname)),
              append = FALSE, 
              quote = FALSE, sep = ";", row.names = FALSE,col.names = TRUE,
              eol = "\n", na = "NA", dec = ",", 
              qmethod = c("escape", "double"))
}




#tutti i campi data e timestamp 
all_date<-subset(all,all$TYPENAME=="DATE" | all$TYPENAME=="TIMESTAMP",select=TABNAME:COLNAME)
View(all_date)
#############EROGAZIONE############################
#column<-subset(all,all$TABNAME=='EROGAZIONE')
#column1<-subset(all_date,all_date$TABNAME=='EROGAZIONE')
erogazione<-dbGetQuery(conn_sor,"select * from salm.erogazione ")
erogazione$difdate<-as.Date(erogazione$DATA_EVENTO)-as.Date(erogazione$DATA_EROGAZIONE)
erogazione$accad<-ifelse(trim(erogazione$ID_ACCADIMENTO)=='POPOLAMENTO','MIGRAZ','EVENTO')
erogazione$DATA_EROGAZIONE<-as.factor(erogazione$DATA_EROGAZIONE)
summary(erogazione$DATA_EROGAZIONE,maxsum=3)
ris<-aggregate(erogazione$difdate,by=list(erogazione$accad),mean)

##############INSERIMENTO LAVORATIVO ############################
#column<-subset(all,all$TABNAME=='INSERIMENTOLAVORATIVO')
#column1<-subset(all_date,all_date$TABNAME=='INSERIMENTOLAVORATIVO')

inslav<-dbGetQuery(conn_sor,"select * from salm.inserimentolavorativo ")
inslav$difdate<-as.Date(inslav$DATA_EVENTO)-as.Date(inslav$DATA_INIZIO)
inslav$accad<-ifelse(trim(inslav$ID_ACCADIMENTO)=='POPOLAMENTO','MIGRAZ','EVENTO')
inslav$DATA_INIZIO<-as.factor(inslav$DATA_INIZIO)
ris<-aggregate(inslav$difdate,by=list(inslav$accad),mean)
inslav$ID_ACCADIMENTO<-as.factor(inslav$ID_ACCADIMENTO)

################ VALUTAZIONE ######################################
#column<-subset(all,all$TABNAME=='VALUTAZIONE')
#column1<-subset(all_date,all_date$TABNAME=='VALUTAZIONE')
valut<-dbGetQuery(conn_sor,"select * from salm.valutazione")
valut$DATA<-as.factor(valut$DATA)

valut$difdate<-as.Date(valut$DATA_EVENTO)-as.Date(valut$DATA)
valut$accad<-ifelse(trim(valut$ID_ACCADIMENTO)=='POPOLAMENTO','MIGRAZ','EVENTO')
ris<-aggregate(inslav$difdate,by=list(inslav$accad),mean)
inslav$ID_ACCADIMENTO<-as.factor(inslav$ID_ACCADIMENTO)

summary(valut$DATA,maxsum=3)


################ VISITA ######################################
#column<-subset(all,all$TABNAME=='VISITA')
#column1<-subset(all_date,all_date$TABNAME=='VISITA')
visita<-dbGetQuery(conn_sor,"select * from salm.visita")
visita$difdate<-as.Date(visita$DATA_EVENTO)-as.Date(visita$DATA_VISITA)
visita$accad<-ifelse(trim(visita$ID_ACCADIMENTO)=='POPOLAMENTO','MIGRAZ','EVENTO')
visita$DATA_VISITA<-as.factor(visita$DATA_VISITA)
ris<-aggregate(visita$difdate,by=list(visita$accad),mean)

summary(visita$DATA_VISITA,maxsum=3)

################percorso################################
#column<-subset(all,all$TABNAME=='PERCORSOSALM')
#column1<-subset(all_date,all_date$TABNAME=='PERCORSOSALM')

subset(all,all$COLNAME=='PROVENIENZA_FLUSSO',SELECT<-TABNAME)
perc<-dbGetQuery(conn_sor,"select * from salm.percorsosalm ")
str(perc)
perc$difdate<-as.Date(perc$DATA_CREAZIONE)-as.Date(perc$DATA_INIZIO)
perc$DATA_CREAZIONE<-as.factor(perc$DATA_CREAZIONE)
perc$DATA_INIZIO<-as.factor(perc$DATA_INIZIO)
perc$PROVENIENZA_FLUSSO<-as.numeric(perc$PROVENIENZA_FLUSSO)
ris<-aggregate(perc$PROVENIENZA_FLUSSO
               ,by=list(flusso=perc$PROVENIENZA_FLUSSO
                        ,inizio_null=ifelse(is.na(perc$DATA_INIZIO),1,0)
                        ,creazione_null=ifelse(is.na(perc$DATA_CREAZIONE),1,0)
               )
               ,length
)
aggregate(perc$difdate
               ,by=list(perc$PROVENIENZA_FLUSSO
                        ,ifelse(is.na(perc$DATA_INIZIO),1,0)
                        ,ifelse(is.na(perc$DATA_CREAZIONE),1,0)
               )
               ,mean
)

################CONTATTO########################
#column<-subset(all,all$TABNAME=='CONTATTO')
#column1<-subset(all_date,all_date$TABNAME=='CONTATTO')

cont<-dbGetQuery(conn_sor,"select * from salm.contatto ")
C[,colnames(C)]<-lapply(C[,colnames(C)],factor)
summary(C, maxsum=3)


percorso<-dbGetQuery(conn_sor,"select * from salm.percorsosalm ")
contatto<-dbGetQuery(conn_sor,"select * from salm.contatto ")
nrow(percorso)
nrow(contatto)
epicura<-dbGetQuery(conn_sor
  ,"select a.*,b.id_percorsosalm,b.data_apertura,b.data_evento from salm.percorsosalm a left join salm.contatto b on a.id=b.id_percorsosalm ")
nrow(subset(epicura,is.na(epicura$ID_PERCORSOSALM)))

#epicura<-merge.data.frame(percorso,contatto
#                ,by.x = "ID"
#                ,by.Y = "ID_PERCORSOSALM"
#                ,all = TRUE
#)

epicura$ID_PERCORSOSALM<-as.factor(epicura$ID_PERCORSOSALM)
aggregate(epicura$PROVENIENZA_FLUSSO
          ,by=list(flusso=epicura$PROVENIENZA_FLUSSO
                   ,inizio_null=ifelse(is.na(epicura$DATA_INIZIO),1,0)
                   ,creazione_null=ifelse(is.na(epicura$DATA_CREAZIONE),1,0)
                   ,apertura_null=ifelse(is.na(epicura$DATA_APERTURA),1,0)
                   ,evento_null=ifelse(is.na(epicura$DATA_EVENTO),1,0)
                   ,no_perc_contatto=ifelse(is.na(epicura$ID_PERCORSOSALM),1,0)
          )
          ,length
)

aggregate(epicura$PROVENIENZA_FLUSSO
          ,by=list(flusso=epicura$PROVENIENZA_FLUSSO
                   ,inizio_eq_apertura=ifelse(as.Date(epicura$DATA_INIZIO)==as.Date(epicura$DATA_APERTURA),1,0)
          )
          ,length
)

################ACCESSO_STRUTTURA########################\
#column<-subset(all,all$TABNAME=='ACCESSOSTRUTTURA')
#column1<-subset(all_date,all_date$TABNAME=='ACCESSOSTRUTTURA')
subset(column,select=COLNAME)

accs<-dbGetQuery(conn_sor,"select * from salm.accessostruttura")
nrow(accs)
accs$DATA_AMMISSIONE<-as.factor(accs$DATA_AMMISSIONE)
accs$DATA_ORA_ACCESSO_SEMIRES<-as.factor(accs$DATA_ORA_ACCESSO_SEMIRES)
aggregate(accs$ID,by=list(regime=accs$REGIME_ATTIVITA
                          ,accad=ifelse(trim(accs$ID_ACCADIMENTO)=='POPOLAMENTO','MIGRAZ','EVENTO')
                          ,ammiss_null=ifelse(is.na(accs$DATA_AMMISSIONE),1,0)                          
                          ,acc_semires_null=ifelse(is.na(accs$DATA_ORA_ACCESSO_SEMIRES),1,0)                          
                          ),length)



###### analisi delle dimensione


dim<-subset(dw_all,substr(dw_all$TABNAME,1,1)=="D")