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

anz= 6         ## Anzahl der Modelle
nbez <- 6	## Anz der Legendeneintraege

rr0=1		### max. Score-Wert 
plotRMS=1	## Darstellung von RMS Difference: 0-nein, 1-ja
plotSCORE=0	## Darstellung der SCORE-Linien: 0-nein, 1-SCORE1, 2-SCORE2

max=5 #3 #6
ystep=0.5 #1 #0.5 #1


## Uebergabe des Programms(funktion) fuer den Taylorplot
args <- commandArgs(trailingOnly=TRUE)
fkt="taylor"
pattern=args[2]

models <- list.files(path = "/atm_glomod/user/jomuel001/CMIP6_models/")
#message(models[[12]])

model <- args[1]

f <- c(1:anz)
legende <- c(1:nbez)
legende[1] <- "ERA5"; ii=2
legende[ii] <- model ; ii=ii+1
legende[ii] <- model ; ii=ii+1
legende[ii] <- model ; ii=ii+1
legende[ii] <- model ; ii=ii+1
legende[ii] <- model ; ii=ii+1
#legende[ii] <- model ; ii=ii+1





area=args[3]
seas <- args[4]
years <- args[5]
var = paste("_atrbg_aacrm21_remapbnds_unnorm_5cluster_10PC.nc",sep="")
varD = paste("_atrbg_aacrm21_remapbnds_unnorm_5cluster_10PC.nc",sep="")
## 
#f[1] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[1], "/AREA.",area,"_89.7849_29.0866/CLUSTER/KMEANSslp_hpa_",legende[1],"_1985-2014_",varD,sep="");ii=2
f[1] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[1] ,"/AREA.",area,"_89.7849_49.3208/CLUSTER/KMEANS_5cluster_final.nc", sep=""); ii=2
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_49.3208/CLUSTER/SANDRA_5cluster_final.nc", sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_49.3208/CLUSTER/SANDRA_5cluster_final.nc", sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_49.3208/CLUSTER/SANDRA_5cluster_final.nc", sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_49.3208/CLUSTER/SANDRA_5cluster_final.nc", sep=""); ii=ii+1
f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_49.3208/CLUSTER/SANDRA_5cluster_final.nc", sep=""); ii=ii+1
#f[ii] = paste("/atm_glomod/user/jomuel001/CMIP6_models/",legende[ii] ,"/AREA.",area,"_89.7849_49.3208/CLUSTER/SANDRA_update_Trimmed_slp_hpa_",legende[ii],"_",years,"_",seas,var,sep="");







## !!!!!  WENN varD detrend Daten, dann wird neof[1] NACH outputfile umgesetzt  !!!!!!!  wenn notwendig
## welche EOF; Angabe fuer jeden Datensatz
if ( seas == "djfm" & area == "-90_90" ) { 
max=3  ; ystep=0.5 
if ( pattern=="SCANURALBlock") {
neof = c(1,1,2,3,4,5)
} 
if ( pattern=="NAOMinus") {
neof = c(5,1,2,3,4,5)
} 
if ( pattern=="AtlanticTrough") {
neof = c(4,1,2,3,4,5)
} 
if ( pattern=="NAOPlus") {
neof = c(3,1,2,3,4,5)
} 
if ( pattern=="DipolATLBlock") {
neof = c(2,1,2,3,4,5)
}
}

if ( seas == "mjjaso" & area == "-90_90" ) { 
max=4  ; ystep=0.5 
if ( pattern=="SCANURALBlock") {
neof = c(1,1,2,3,4,5) #1
} 
if ( pattern=="NAOMinus") {
neof = c(4,1,2,3,4,5) #4
} 
if ( pattern=="AtlanticTrough") {
neof = c(2,1,2,3,4,5) #2
} 
if ( pattern=="NAOPlus") {
neof = c(3,1,2,3,4,5) #3
} 
if ( pattern=="DipolATLBlock") {
neof = c(5,1,2,3,4,5) #5
}  #atl trough 3 # nao+ 4 #dipolatlblock 5 #scanuralbock 1 #NAO- 2
#~ neof = c(2,1,1,1,1,3,1,2,2)
#~ neof = c(3,3,2,3,2,1,2,1,1)
#~ neof = c(4,5,3,5,5,5,5,4,5)
#~ neof = c(5,4,4,4,4,4,4,5,4)
}


if ( seas == "mjjaso" & area == "0_360" ) { 
max=4  ; ystep=0.5 
if ( pattern=="CL1") {
neof = c(1,1,2,3,4,5,6) #1
} 
if ( pattern=="CL2") {
neof = c(2,1,2,3,4,5,6) #1
}
if ( pattern=="CL3") {
neof = c(3,1,2,3,4,5,6) #4
} 
if ( pattern=="CL4") {
neof = c(4,1,2,3,4,5,6) #2
} 
if ( pattern=="CL5") {
neof = c(5,1,2,3,4,5,6) #3
} 
if ( pattern=="CL6") {
neof = c(6,1,2,3,4,5,6) #5
} 
}

if ( seas == "djfm" & area == "90_270" ) { 
max=3  ; ystep=0.5 
#~ neof = c(2,1,5,3,3,5,5,3,1,2,1,4,2,4,4,5,1,1,2,4,2,2,3,2,3,3,5) #pacific trough
if ( pattern=="PacificWavetrain") {
neof = c(1,1,2,3,4,5)
} 
if ( pattern=="PacificTrough") {
neof = c(2,1,2,3,4,5)
} 
if ( pattern=="ArcticHigh") {
neof = c(3,1,2,3,4,5)
} 
if ( pattern=="ArcticLow") {
neof = c(4,1,2,3,4,5)
} 
if ( pattern=="AlaskanRidge") {
neof = c(5,1,2,3,4,5)
}
} 


if ( seas == "mjjaso" & area == "90_270" ) { 
max=3  ; ystep=0.5 
#~ neof = c(2,1,5,3,3,5,5,3,1,2,1,4,2,4,4,5,1,1,2,4,2,2,3,2,3,3,5) #pacific trough
if ( pattern=="Clusternumber-1") {
neof = c(1,1,2,3,4,5)
} 
if ( pattern=="Clusternumber-2") {
neof = c(3,1,2,3,4,5)
} 
if ( pattern=="Clusternumber-3") {
neof = c(2,1,2,3,4,5)
} 
if ( pattern=="Clusternumber-4") {
neof = c(5,1,2,3,4,5)
} 
if ( pattern=="Clusternumber-5") {
neof = c(4,1,2,3,4,5)
}  #alaskan ridge1 #pacific 2 #wavetrain 4 #arctic low 5 #arctic high 3
#~ neof = c(3,5,4,4,4,5,4,4,5)
#~ neof = c(4,4,5,5,5,4,5,5,4)
#~ neof = c(5,1,3,2,2,1,3,1,2)
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
if ( seas == "mjjaso" ) {titel = paste("ERA5 Cluster",neof[1]," -  MJJASO  -  PAZ") }
outfile=paste("/atm_glomod/user/jomuel001/auswertung/TAYLOR/Cluster/",pattern,"/taylor_cluster_historical_mmm3_",years,".slp_",seas,".cl",neof[1],"_paz.refERA5",model,".ps",sep="")
outfilescore=paste("/atm_glomod/user/jomuel001/auswertung/TAYLOR/Cluster/",pattern,"/taylor_cluster_historical_mmm3_",years,".slp_",seas,".cl",neof[1],"_paz.refERA5",model,".txt",sep="")
} else {
if ( seas == "djfm" ) {titel = paste("ERA5 Cluster",neof[1]," -  DJFM  - ATL") }
if ( seas == "jjas" ) {titel = paste("ERA5 Cluster",neof[1]," -  JJAS  -  ATL") }  
if ( seas == "mjjaso" ) {titel = paste("ERA5 Cluster",neof[1]," -  MJJASO  -  ARC") } 
outfile=paste("/atm_glomod/user/jomuel001/auswertung/TAYLOR/Cluster/",pattern,"/taylor_cluster_historical_mmm3_",years,".slp_",seas,".cl",neof[1],"_arc.refERA5",model,".ps",sep="")
outfilescore=paste("/atm_glomod/user/jomuel001/auswertung/TAYLOR/Cluster/", pattern, "/taylor_cluster_historical_mmm3_",years,".slp_",seas,".cl",neof[1],"_arc.refERA5",model,".txt",sep="")
}
## welche EOF; Angabe fuer jeden Datensatz
print("ok")
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
  print(mo)
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
  message(length(pat_int))
  message(length(eof[mo,]))
  if (length(pat_int) > ncol(eof)) {
    pat_int <- pat_int[1:ncol(eof)]
    }
  message(length(pat_int))
  message(length(eof[mo,]))
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

  cat(ii,legende[ii],STDs[ii],(CORs[ii]),SCORE1[ii],SCORE2[ii]," \n")
  txt <- sprintf("%-12s %.3f  \t  %.3f \t  %.3f \t  %.3f",legende[ii],STDs[ii],(CORs[ii]),SCORE1[ii],SCORE2[ii])
  cat(file=outfilescore,txt,"\n",append = TRUE)
}

cat("vor funkitonsaufruf \n")
## Aufruf der eigentlichen taylor-rotine, welche zubeginn geladen wurde

#taylor.list <- fkt(CORs,STDs,plotRMS,plotSCORE,max,ystep,nbez,legende[1:nbez])
#taylor.list <- Taylor(CORs,STDs,plotRMS,plotSCORE,max,ystep,nbez,legende[1:nbez],col,form)

#title(f[anz+1],cex.main=1.4)   
#title(titel,cex.main=1.4)   

#nx=0.25*taylor.list$maxray
#nx<-taylor.list$maxray-taylor.list$maxray*0.9
#ny<-taylor.list$maxray-taylor.list$maxray*1.01 #+taylor.list$maxray*0.1

#cat("nx ny",nx,ny,"\n\n")

#if ( anz==6 ) {
#legend(x=nx,y=ny,c("NAO        ","AO         ","PNA        "),pch=c(16,8,1),col="black",bg="black",bty="n",ncol=3,cex=1.2) 
#}


#dev.print(device=postscript,"taylor_intp3.ps",paper="a4",horizontal=FALSE)
########

#dev.print(device=postscript,outfile,paper="a4",horizontal=FALSE)

## Abschliessend Header des ps-Files mit Zusatzinfos anpassen
#cat(file="infoheader.txt","\n%% Input-Dateien  &  cluster  \n",append = FALSE)
#for ( ii in 1:anz )
#{
# txt <- sprintf("\n%% cl=%s  %s  ",neof[ii],f[ii])
#  cat(file="infoheader.txt",txt,append = TRUE) 
#}
#cat(file="infoheader.txt","\n\n",append = TRUE)



## ps File in 2 Teile haken und dazwischen die Zusatzinfos schreiben
#txt <- sprintf("grep -n EndComments %s | cut -d\":\" -f1",outfile)
#cat("shell Kommando: ",txt,"\n")

#zeile=as.integer(system(txt,inter=TRUE))
#cat("zeile: ",zeile,"\n")

#txt <- sprintf("more %s | head -%d > header_teil1.ps",outfile,zeile-1)
#cat("shell Kommando: ",txt,"\n")
#system(txt,inter=TRUE)

#txt <- sprintf("more %s | tail +%d > header_teil2.ps",outfile,zeile)
#cat("shell Kommando: ",txt,"\n")
#system(txt,inter=TRUE)

#txt <- sprintf("cat header_teil1.ps infoheader.txt header_teil2.ps > %s",outfile)
#cat("shell Kommando: ",txt,"\n")
#system(txt,inter=TRUE)
#system("rm header_teil1.ps infoheader.txt header_teil2.ps",inter=TRUE)


#if ( file.exist(griddes.txt) == TRUE ) { system("rm griddes.txt",inter=TRUE)}
#if ( file.exist(new.nc) == TRUE ) { system("rm new.nc",inter=TRUE)}

## beenden von R ohne speichern  (Save workspace image? [y/n/c]: n)
#q("no")


