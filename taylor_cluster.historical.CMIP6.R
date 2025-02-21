#input <- commandArgs(TRUE)

#schliessen der aktuellen grafik
graphics.off()

#UNIX-Fenster
x11()
v1=R.Version()$major
v2=R.Version()$minor

##   Terminal:  /opt/R-2.15.1/bin/Rscript taylor_eof_fesom_nao_ao_pna.R

## Interpolation (aspline)
library(akima,lib.loc=paste("/atm_glomod/work/R_LIB/R.",v1,".",v2,"/",sep=""))

#install.packages("ncdf4",lib="/atm_glomod/work/AUSWERTUNG_linux/R")
#library(ncdf4,lib.loc="/atm_glomod/work/AUSWERTUNG_linux/R")
library(ncdf4,lib.loc=paste("/atm_glomod/work/R_LIB/R.",v1,".",v2,"/",sep=""))


### Uebergabe-Daten einlesen
#print(input)

anz= 27	        ## Anzahl der Modelle
nbez <- 27	## Anz der Legendeneintraege

rr0=1		### max. Score-Wert 
plotRMS=1	## Darstellung von RMS Difference: 0-nein, 1-ja
plotSCORE=0	## Darstellung der SCORE-Linien: 0-nein, 1-SCORE1, 2-SCORE2

max=4 #3 #6
ystep=0.5 #1 #0.5 #1


## Uebergabe des Programms(funktion) fuer den Taylorplot
fkt="taylor"

models <- list.files(path = "/atm_glomod/user/jomuel001/CMIP6_models/")
message(models[[12]])


f <- c(1:anz)
legende <- c(1:nbez)
legende[1] <- models[[12]]; ii=2
legende[ii] <- models[[1]] ; ii=ii+1
legende[ii] <- models[[2]] ; ii=ii+1
legende[ii] <- models[[3]] ; ii=ii+1
legende[ii] <- models[[4]] ; ii=ii+1
legende[ii] <- models[[5]] ; ii=ii+1
legende[ii] <- models[[6]] ; ii=ii+1
legende[ii] <- models[[7]] ; ii=ii+1
legende[ii] <- models[[8]] ; ii=ii+1
legende[ii] <- models[[9]] ; ii=ii+1
legende[ii] <- models[[10]] ; ii=ii+1
legende[ii] <- models[[11]] ; ii=ii+1
legende[ii] <- models[[13]] ; ii=ii+1
legende[ii] <- models[[14]] ; ii=ii+1
legende[ii] <- models[[15]] ; ii=ii+1
legende[ii] <- models[[16]] ; ii=ii+1
legende[ii] <- models[[17]] ; ii=ii+1
legende[ii] <- models[[18]] ; ii=ii+1
legende[ii] <- models[[19]] ; ii=ii+1
legende[ii] <- models[[20]] ; ii=ii+1
legende[ii] <- models[[21]] ; ii=ii+1
legende[ii] <- models[[22]] ; ii=ii+1
legende[ii] <- models[[23]] ; ii=ii+1
legende[ii] <- models[[24]] ; ii=ii+1
legende[ii] <- models[[25]] ; ii=ii+1
legende[ii] <- models[[26]] ; ii=ii+1
legende[ii] <- models[[27]] ; ii=ii+1






area="-90_90"
seas="jjas"
var = paste(seas,"_atrbg_aacrm21_remapbnds_unnorm_5cluster_10PC.nc",sep="")
varD = paste(seas,"_atrbg_aacrm21_remapbnds_unnorm_5cluster_10PC.nc",sep="")
## 
f[1] = paste("/atm_glomod/user/jomuel001/CMIP6_models/ERA5/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_ERA5_1979-2014_",varD,sep="");ii=2

f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1

f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1

f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1

f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1

f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1

f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1

f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[ii],"_1979-2014.N_jjas_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51979-2014slp_hpa_ERA5_1979-2014_",var,sep=""); ii=ii+1







## !!!!!  WENN varD detrend Daten, dann wird neof[1] NACH outputfile umgesetzt  !!!!!!!  wenn notwendig
## welche EOF; Angabe fuer jeden Datensatz
if ( seas == "djfm" & area == "-90_90" ) { 
max=7 ; ystep=1
#~ neof = c(1,1,2,1,2,5,5,2,5)
#~ neof = c(2,4,5,4,5,1,1,4,1)
#~ neof = c(3,3,1,2,1,4,3,1,3)
#~ neof = c(4,2,3,3,3,3,4,3,4)
#~neof = c(5,5,4,5,4,2,2,5,2)
}

if ( seas == "jjas" & area == "90_270" ) { 
max=4  ; ystep=0.5 
neof = c(3,4,1,5,5,2,1,2,3,2,5,2,1,4,4,3,1,2,4,2,2,4,1,4,1,2,3) #Cl3
#~neof = c(1,2,2,1,2,4,2,1,1,3,1,4,2,5,3,1,2,1,2,1,1,1,3,2,2,1,3) #Cl1
#~neof = c(4,1,5,3,1,4,4,5,2,4,2,4,5,3,2,2,1,4,3,3,4,5,2,3,1,5,5) #Cl4
#~neof = c(2,3,4,2,3,5,3,4,5,1,5,5,4,2,1,4,4,5,5,4,5,4,5,4,5,3,4) #Cl2
#~neof = c(5,5,3,4,3,3,5,3,4,4,3,3,3,3,5,5,3,3,5,5,3,3,4,5,3,4,1)  #Cl5
}

if ( seas == "djfm" & area == "90_270" ) { 
max=7  ; ystep=1 
#~ neof = c(1,1,1,1,1,2,1,1,1)
#~ neof = c(2,3,2,2,3,3,3,3,2)
#~ neof = c(3,2,3,3,2,1,2,2,3)
#~ neof = c(4,4,5,4,4,4,4,4,4)
neof = c(5,5,4,5,5,5,5,5,5)
}

#Pacific Trough
if ( seas == "jjas" & area == "-90_90" ) { 
max=3  ; ystep=0.5 
#~neof = c(2,5,5,5,1,4,3,2,4,4,5,2,4,2,5,2,4,5,5,2,4,4,4,4,3,2,2) #NAOMinus
#~neof = c(1,1,1,1,3,1,4,3,1,3,1,1,1,4,1,5,2,2,4,1,3,3,1,5,2,1,1) #Scandinavian
#~neof = c(4,2,2,3,5,5,1,4,2,2,4,5,3,5,2,4,3,3,2,4,1,5,5,1,5,5,5)   #NAOPlus
#~neof = c(5,3,3,4,4,3,2,1,5,5,3,4,5,3,4,3,5,1,3,3,5,2,3,2,1,4,4) #Dipolatlblock
neof = c(3,4,4,2,2,2,5,1,3,1,2,3,2,1,3,1,1,4,1,5,2,1,2,3,4,3,3) #AtlanticTrpugh
}
print(neof)


## Farbe und Form festlegen
col = c("black","red2","royalblue","lawngreen", "maroon2","skyblue3", "grey65","gold3","darkorange2","royalblue","gold3","royalblue","lawngreen", "maroon2","skyblue3", "grey65")
col = c(1:anz)
col[] = "grey80"

col = c("black","red2","red2","red2","blue","blue","blue","lawngreen","lawngreen")
  
form = c(21,21,23,8,21,23,8,21,23)


## function laden
source(vv<-sprintf("/atm_glomod/work/AUSWERTUNG_linux/R/code/%s.R",fkt))
source("/atm_glomod/work/AUSWERTUNG_linux/R/code/taylor.R")

txtzusatz='' 
#if ( grep("detrend",varD) == 1 ) { txtzusatz='.detrend' }

if ( area == "90_270" ) {
if ( seas == "djfm" ) {titel = paste("ERA5 Cluster ",neof[1]," -  DJFM  - PAZ") }
if ( seas == "jjas" ) {titel = paste("ERA5 Cluster",neof[1]," -  JJAS  -  PAZ") }
outfile=paste("/atm_glomod/user/jomuel001/auswertung/TAYLOR/Cluster/taylor_cluster_historical.slp_",seas,".cl",neof[1],"_paz.refERA5",txtzusatz,".ps",sep="")
outfilescore=paste("/atm_glomod/user/jomuel001/auswertung/TAYLOR/Cluster/taylor_cluster_polex.slp_",seas,".cl",neof[1],"_paz.refERA5",txtzusatz,".txt",sep="")
} else {
if ( seas == "djfm" ) {titel = paste("ERA5 Cluster",neof[1]," -  DJFM  - ATL") }
if ( seas == "jjas" ) {titel = paste("ERA5 Cluster",neof[1]," -  JJAS  -  ATL") }  
outfile=paste("/atm_glomod/user/jomuel001/auswertung/TAYLOR/Cluster/taylor_cluster_polex.slp_",seas,".cl",neof[1],"_atl.refERA5",txtzusatz,".ps",sep="")
outfilescore=paste("/atm_glomod/user/jomuel001/auswertung/TAYLOR/Cluster/taylor_cluster_polex.slp_",seas,".cl",neof[1],"_atl.refERA5",txtzusatz,".txt",sep="")
}
## welche EOF; Angabe fuer jeden Datensatz

print(neof)

## Felddimension festlegen
STDs <- c(1:anz)
CORs <- c(1:anz)
SCORE1 <- c(1:anz)
SCORE2 <- c(1:anz) 

if ( file.exists("out.txt") == TRUE ) { system("rm out.txt ",inter=TRUE)}

for ( mo in 1:anz )
{
  cat("Modell ",mo,f[mo],neof[mo],"\n")
  
  ## Daten einlesen; read.tabel durch netcdf ersetzen
  #dat_orig <- read.table(f[mo])
 # fnc=nc_open(f[mo])
  
  ## horizontale Inter[polation wird durch CDO ersetzt
  if ( mo > 1 ) {
    shell<-paste("cdo interpolate,griddes.txt ",f[mo]," new.nc")
    system(shell)
    fnc=nc_open("new.nc")
  } else {
    shell<-paste("cdo griddes",f[1],"> griddes.txt")
    system(shell)
   fnc=nc_open(f[mo])
  }
  
    #~ shell<-paste("cdo interpolate,grid_polex.txt ",f[mo]," new.nc")
    #~ system(shell)
    #~ fnc=nc_open("new.nc")

    
  ## Berechnung der neuen Stuetzpunkte und Interpolieren == cos-Korrektur
  z=1
  suedlat=fnc$dim$lat$vals[1]
  nlat=fnc$dim$lat$len
  lon1=fnc$dim$lon$vals[1]
  lon=fnc$dim$lon$vals
  lonend=180 #270 # 180 #270 #180 #fnc$dim$lon$vals[fnc$dim$lon$len]
  #bei negativen longituden ist es lon[last]-lon[1], z.B. -90_90 => lonend=180
  
  #Daten lesen
  ncvar=names(fnc$var)
  dat=ncvar_get(fnc,ncvar)

  
  while ( z <= nlat ) {    
    rm(lonneu)
    lat<-fnc$dim$lat$vals[z]  #dat$ncepy[z]
    #suedlat<-dat$ncepy[nz]

    nphi=round((cos(lat*pi/180)*nlat)/cos(suedlat*pi/180))   # Anzahl Gridpoints auf der jeweiligen Breite
    lonneu<-c(1:nphi)
    step=0
    if ( nphi > 1 ) { step<-(lonend/(nphi - 1)) }
    #if ( nphi > 1 ) { step<-(length(lon)/(nphi - 1)) }
    cat(file='out.txt',"lat",lat," nphi ",nphi,"step",step,"\n",append=TRUE)
    
    for ( ii in 1:nphi ) {                                   # Berechnung der neuen Stuetzpunkte 
     lonneu[ii]<- lon1+(ii-1)*step
     }
    #cat(file='out.txt',"lonneu ",lonneu,"\n",append=TRUE)
    patn=dat[,z,neof[mo]]  ## ALLE werte fuer eine LAT
    
    rm(pati)
    cat(file='out.txt',"lonneu ",lonneu,"\n",append=TRUE)
    dummy<-aspline(lon,patn,lonneu)  
    pati<-dummy$y                         # Interpolierungssfunktion fuer Daten
    #cat(file='out.txt',"nach pati\n",append=TRUE)
    #cat(file='out.txt',"patn IN ",patn,"\n",append=TRUE)
    #cat(file='out.txt',"pati OUT",pati,"\n",append=TRUE)
    #cat(file='out.txt',"sum patn/pati",sum(patn),sum(pati),"\n",append=TRUE)
    #cat(file='out.txt',"mittel patn/pati",mean(patn),mean(pati),"\n\n",append=TRUE)
   if ( z==1 ) {		                             # Erstellen eines Vektors aus allen pati
    	pat_int<-pati
	}
    else
       { pat_int<-c(pat_int,pati)
    }
    z=z+1
    #cat("pati ",pati,"\n")
    #cat("pat_int ",pat_int,"\n")
  }
  if (mo==1) {
  ## Felddimension festlegen
  eof <- matrix(nrow=anz,ncol=length(pat_int))
  }
  eof[mo,]<-pat_int
  nc_close(fnc)
} #ENDE ueber alle Modelle

cat(file=outfilescore," \t \t  STD \t COR \t SCORE1 \t SCORE2  \n\n",append = FALSE)
#cat("ii   STDs    CORs    SCORE1   SCORE2   \n")

for ( ii in 1:anz )
{
  CORs[ii] <- (cor(eof[1,], eof[ii,]))
  STDs[ii] <- sd(eof[ii,])
  
  # Berechnung Skill Score in 2 Varianten nach Taylor (JGR, 2001)
  SCORE1[ii] <- (4*(1+CORs[ii])/((STDs[ii]/STDs[1]+STDs[1]/STDs[ii])^2)/(1+rr0))
  SCORE2[ii] <- (4*((1+CORs[ii])^4)/((STDs[ii]/STDs[1]+STDs[1]/STDs[ii])^2)/((1+rr0)^4))

  cat(ii,legende[ii],STDs[ii],abs(CORs[ii]),SCORE1[ii],SCORE2[ii]," \n")
  txt <- sprintf("%-12s %.3f  \t  %.3f \t  %.3f \t  %.3f",legende[ii],STDs[ii],abs(CORs[ii]),SCORE1[ii],SCORE2[ii])
  cat(file=outfilescore,txt,"\n",append = TRUE)
}

cat("vor funkitonsaufruf \n")
## Aufruf der eigentlichen taylor-rotine, welche zubeginn geladen wurde

#taylor.list <- fkt(CORs,STDs,plotRMS,plotSCORE,max,ystep,nbez,legende[1:nbez])
taylor.list <- Taylor(CORs,STDs,plotRMS,plotSCORE,max,ystep,nbez,legende[1:nbez],col,form)

#title(f[anz+1],cex.main=1.4)   
title(titel,cex.main=1.4)   

#nx=0.25*taylor.list$maxray
nx<-taylor.list$maxray-taylor.list$maxray*0.9
ny<-taylor.list$maxray-taylor.list$maxray*1.01 #+taylor.list$maxray*0.1

cat("nx ny",nx,ny,"\n\n")

#if ( anz==6 ) {
#legend(x=nx,y=ny,c("NAO        ","AO         ","PNA        "),pch=c(16,8,1),col="black",bg="black",bty="n",ncol=3,cex=1.2) 
#}


#dev.print(device=postscript,"taylor_intp3.ps",paper="a4",horizontal=FALSE)
########

dev.print(device=postscript,outfile,paper="a4",horizontal=FALSE)

## Abschliessend Header des ps-Files mit Zusatzinfos anpassen
cat(file="infoheader.txt","\n%% Input-Dateien  &  cluster  \n",append = FALSE)
for ( ii in 1:anz )
{
 txt <- sprintf("\n%% cl=%s  %s  ",neof[ii],f[ii])
  cat(file="infoheader.txt",txt,append = TRUE) 
}
cat(file="infoheader.txt","\n\n",append = TRUE)



## ps File in 2 Teile haken und dazwischen die Zusatzinfos schreiben
txt <- sprintf("grep -n EndComments %s | cut -d\":\" -f1",outfile)
cat("shell Kommando: ",txt,"\n")

zeile=as.integer(system(txt,inter=TRUE))
cat("zeile: ",zeile,"\n")

txt <- sprintf("more %s | head -%d > header_teil1.ps",outfile,zeile-1)
cat("shell Kommando: ",txt,"\n")
system(txt,inter=TRUE)

txt <- sprintf("more %s | tail +%d > header_teil2.ps",outfile,zeile)
cat("shell Kommando: ",txt,"\n")
system(txt,inter=TRUE)

txt <- sprintf("cat header_teil1.ps infoheader.txt header_teil2.ps > %s",outfile)
cat("shell Kommando: ",txt,"\n")
system(txt,inter=TRUE)
system("rm header_teil1.ps infoheader.txt header_teil2.ps",inter=TRUE)


#if ( file.exist(griddes.txt) == TRUE ) { system("rm griddes.txt",inter=TRUE)}
#if ( file.exist(new.nc) == TRUE ) { system("rm new.nc",inter=TRUE)}

## beenden von R ohne speichern  (Save workspace image? [y/n/c]: n)
#q("no")

