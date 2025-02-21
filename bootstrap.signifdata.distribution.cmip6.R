rm(list=ls())
#.libPaths("/home/guest/jomuel001/R/x86_64-pc-linux-gnu-library/3.6")
#install.packages("StatDA", lib = "/home/guest/jomuel001/R/x86_64-pc-linux-gnu-library/3.6")

## Fenstergroesse einstellen, par("din") zeigt die aktuelle Fenstergroesse in inch an
x11(width=8,height=11)

library(boot)
library(dplyr)
#library(plotrix)
#library(StatDA)
#message(help("plotrix"))

args <- commandArgs(trailingOnly=TRUE)
scenario <- (args[8])
Modell <- (args[6])
#Modell <- "ERA5"
#pfad="/glomod/data/ECHAM6/preset-MR_e6_HICEp+LICEthin/daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/"
#pfad="/glomod/data/ECHAM6/preset-MR_swift1215_NH_HICEp+LICEthin/daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/"
#pfad="/atm_glomod/user/jomuel001/CMIP6_models/ERA5/AREA.-90_90_89.7849_29.0866/CLUSTER"

pfad <- (args[1])

#pf <- c("HICEp+LICEthin")#,"HICEhamo+LICEhamothin","HICEp+HICEhamo","HICEp+LICEhamothin","LICEthin+LICEhamothin") 
#'HICEp+LICEthin+HICEhamo+LICEhamothin')

#for (pfpf in 1:length(pf)) {
#pfad <- paste("/glomod/data/ECHAM6/preset-MR_swift1215_NH_",pf[pfpf],"/daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/",sep="")

## Startjahr
start_year_early <- (args[2])
#start_year <- 1979
## Endjahr
last_year_early <- (args[3])
#last_year <- 2021

start_year_late <- (args[4])
last_year_late <- (args[5])
#mid_year <- 2000

seas <- (args[7])

if (Modell == "ERA5") {
	start_year <- 1985
	## Endjahr
	last_year <- 2014

	mid_year <- 1996
	var <- paste("slp_hpa_",Modell,"_",start_year,"-",last_year,"_",seas,"_atrbg_aacrm21_remapbnds",sep="")
} else {
	var <- paste("slp_hpa_",Modell,"_",start_year_early,"-",last_year_early,".North_",seas,"_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51985-2014slp_hpa_ERA5_1985-2014_",seas,"_atrbg_aacrm21_remapbnds",sep="")
	var2 <- 
paste("slp_hpa_",scenario,Modell,"_",start_year_late,"-",last_year_late,".North_",seas,"_atrbg_aacHrm21_remapbnds_proj_on_EOF_ERA51985-2014slp_hpa_ERA5_1985-2014_",seas,"_atrbg_aacrm21_remapbnds",sep="")
}
#var <- paste("gph_500_",seas,"_aac",sep="")
norm <- "_unnorm_projectedpattern" 



anzcluster=5

# Anzahl der maximal zu verwendeten PCs (Dimension des Phasenraumes, in dem Clusteranalyse durchgefuehrt wird)
ndimmax=10 #6

#################  DJFM  #################
if ( seas == "jja" ) {
nm=3
ndy=c(1:nm)
ndy[1]=30  #Junoutputfile_minmax
ndy[2]=31  #jul
ndy[3]=31  #aug
#ndy[4]=30  #sep
#year.hl = c(mid_year,mid_year,mid_year)
#year.hl = c(1120,1120,1120,1120)
}

if ( seas == "djfm" ) {
nm=4
ndy=c(1:nm)
ndy[1]=31  #Jjan
ndy[2]=28  #feb
ndy[3]=31  #mar
ndy[4]=31  #dec
#year.hl = c(mid_year,mid_year,mid_year)
#year.hl = c(1120,1120,1120,1120)
}

if ( seas == "mjjaso" ) {
nm=6
ndy=c(1:nm)
ndy[1]=31  #mai
ndy[2]=30  #jun
ndy[3]=31  #jul
ndy[4]=31  #aug
ndy[5]=30  #sep
ndy[6]=31  #okt
#year.hl = c(mid_year,mid_year,mid_year)
#year.hl = c(1120,1120,1120,1120)
}




all.cluster=array(0,dim=c(2,5520*2))
for ( clnr in 1:anzcluster ) {
dates1=read.table(vv<-sprintf("%s/KMEANS%s%s_%scluster_%dPC_cl%d_dates",pfad,var,norm,anzcluster,ndimmax,clnr))

dates2=read.table(vv<-sprintf("%s/KMEANS%s%s_%scluster_%dPC_cl%d_dates",pfad,var2,norm,anzcluster,ndimmax,clnr))
dates2 <- dates2 + 5520
dates <- bind_rows(dates1, dates2)
print(dates)
print(dim(dates))
#print(clnr)
#print(length(dates[,1]))

for ( ii in 1:length(dates[,1]) ) {
all.cluster[1,dates[ii,1]]=clnr
all.cluster[2,dates[ii,1]]=dates[ii,1]
}

}

## Alle cluster splitten auf die einzelnen Monate
nt.high.1=0
nt.high.2=0
nt.high.3=0
nt.high.4=0
nt.high.5=0
nt.high.6=0
#nt.high.5=0
#nt.high.6=0
#nt.high.4=0
nt.low.1=0
nt.low.2=0
nt.low.3=0
nt.low.4=0
nt.low.5=0
nt.low.6=0
#nt.low.4=0

ndat=0
#### high ice = CNTL
for ( ny in start_year_early:last_year_early ) 
{
for ( kk in 1:nm ) {

  #~ ## Schaltjahr
  #~ if ( ndy[2] < 30 ) {
  #~ if (  ( ny%%4 == 0 ) &&  ( ! ny%%100 == 0 ) || ( ny%%400 == 0 ) ) {
  #~ ndy[2]=29 } else { ndy[2]=28 }
  #~ }

for ( ii in 1:ndy[kk] ) {
ndat=ndat+1
#message(ndy[kk])
#message(ny)
if ( kk==1 ) { nt.high.1 = c(nt.high.1,all.cluster[1,ndat])}
if ( kk==2 ) { nt.high.2 = c(nt.high.2,all.cluster[1,ndat])}   
if ( kk==3 ) { nt.high.3 = c(nt.high.3,all.cluster[1,ndat])}
if ( kk==4 ) { nt.high.4 = c(nt.high.4,all.cluster[1,ndat])}
if ( kk==5 ) { nt.high.5 = c(nt.high.5,all.cluster[1,ndat])}
if ( kk==6 ) { nt.high.6 = c(nt.high.6,all.cluster[1,ndat])}
} #Ende ueber alle Tage im Monat
} #Ende ueber alle Monate
} #Ende loop ueber alle Jahre


### low ice = LICE
for ( ny in start_year_late:last_year_late ) {
for ( kk in 1:nm ) {

  #~ ## Schaltjahr
  #~ if ( ndy[2] < 30 ) {
  #~ if (  ( ny%%4 == 0 ) &&  ( ! ny%%100 == 0 ) || ( ny%%400 == 0 ) ) {
  #~ ndy[2]=29 } else { ndy[2]=28 }
  #~ }

for ( ii in 1:ndy[kk] ) {
ndat=ndat+1
if ( kk==1 ) { nt.low.1 = c(nt.low.1,all.cluster[1,ndat])}
if ( kk==2 ) { nt.low.2 = c(nt.low.2,all.cluster[1,ndat])}
if ( kk==3 ) { nt.low.3 = c(nt.low.3,all.cluster[1,ndat])}
if ( kk==4 ) { nt.low.4 = c(nt.low.4,all.cluster[1,ndat])}
if ( kk==5 ) { nt.low.5 = c(nt.low.5,all.cluster[1,ndat])}
if ( kk==6 ) { nt.low.6 = c(nt.low.6,all.cluster[1,ndat])}

} #Ende ueber alle Tage im Monat
} #Ende ueber alle Monate
} #Ende loop ueber alle Jahre


#######################################################################
#cat("low & nice-Jahre zusammenfuegen\n")

## high und low zusammensetzen fuer jeden einzelnen Monat
nt.all.1 = c(nt.high.1[-1],nt.low.1[-1])
nt.all.2 = c(nt.high.2[-1],nt.low.2[-1])
nt.all.3 = c(nt.high.3[-1],nt.low.3[-1])
nt.all.4 = c(nt.high.4[-1],nt.low.4[-1])
nt.all.5 = c(nt.high.5[-1],nt.low.5[-1])
nt.all.6 = c(nt.high.6[-1],nt.low.6[-1])


nrr=1000 # Anzahl der bootstrap-Wiederholungen

# Vergleich von result.boot$t0 mit result.boot$t fuer alle Wiederholungen und alle Cluster
boot.cl=array(0,dim=c(6,anzcluster))

quant = c(0.01, 0.05, 0.1, 0.9,0.95,0.99) # Qunatile

boot.cl.sdt=array(0,dim=c(6,anzcluster))
boot.cl.meant=array(0,dim=c(6,anzcluster))
boot.cl.meant0=array(0,dim=c(6,anzcluster))
boot.cl.quantile=array(0,dim=c(6,anzcluster,length(quant)))

boot.t=array(NA,dim=c(6,nrr,anzcluster))
boot.t0=array(0,dim=c(6,anzcluster))

## function laden
source("./boot.fun.R") #hier clusteranzahl verändern

#######################################################################
# boostrap - ziehen mit zuruecklegen

#cat("vor loop ueber alle Monate \n")

## loop ueber alle Monate

for ( kk in 1:nm ) {
cat("BOOT: monat ",kk,"\n")
rm(daten)
if ( kk==1 ) {  daten=nt.all.1
                nh=length(nt.high.1[-1])
                nl=length(nt.low.1[-1]) }

if ( kk==2 ) {  daten=nt.all.2
                nh=length(nt.high.2[-1])
                nl=length(nt.low.2[-1]) }

if ( kk==3 ) {  daten=nt.all.3
                nh=length(nt.high.3[-1])
                nl=length(nt.low.3[-1]) }

if ( kk==4 ) {  daten=nt.all.4
                nh=length(nt.high.4[-1])
                nl=length(nt.low.4[-1]) }
  
if ( kk==5 ) {  daten=nt.all.5
                nh=length(nt.high.5[-1])
                nl=length(nt.low.5[-1]) }

if ( kk==6 ) {  daten=nt.all.6
                nh=length(nt.high.6[-1])
                nl=length(nt.low.6[-1]) }

cat("VOR boot.fun \n")
#source("boot.fun.R")
result.boot <- boot(daten, boot.fun, R=nrr, stype="i" ,ndat.h=nh, ndat.l=nl)


## Ergebnisse von boot weiter verarbeiten

# result.boot$t0 - enthaelt die Differenzen fuer jedes cluster vom Ausgangsdatensatz
# result.boot$t  - enthaelt die Differenzen fuer jedes cluster vom gebooteten Datensatz

#
#print(dim(boot.t[kk,,]))
#print(dim(result.boot$t))
#print(range(daten))
boot.t[kk,,]=result.boot$t
boot.t0[kk,]=result.boot$t0


# percentile erhaelt man auch mit quantile !!

for ( clnr in 1:anzcluster ) {
if ( result.boot$t0[clnr] < 0 ) {
  for ( rr in 1:nrr ) 
  {
    if (  result.boot$t[rr,clnr] < result.boot$t0[clnr] ) { boot.cl[kk,clnr]=boot.cl[kk,clnr]+1}
  }
  } else {
  for ( rr in 1:nrr ) 
  {
    if (  result.boot$t[rr,clnr] > result.boot$t0[clnr] ) { boot.cl[kk,clnr]=boot.cl[kk,clnr]+1}
  }
  
  }
}

## Berechnung Mean fuer result.boot$t0
boot.cl.meant[kk,]=colMeans(result.boot$t)
boot.cl.meant0[kk,]=result.boot$t0

## Standardabweichund und Quantile
for ( clnr in 1:anzcluster ) {  
  boot.cl.sdt[kk,clnr]=sd(result.boot$t[,clnr]) 
  boot.cl.quantile[kk,clnr,]=quantile(result.boot$t[,clnr], quant)
  }

} ## ENDE boot ueber alle Monate



###############################################################################################
##         P L O T
##
## Darstellung von boot.cl.meant
##                 boot.cl.sdt
##                 boot.cl.quantile 

ymin=-0.1 #-0.1
ymax=0.1 #0.1
par(mfrow=c(4,6),mar=c(6,4,4,2)+0.2)#letzte und erste
#clbez=c("NAO+","SCAN","ATL-","NAO-","DIPOL")
clbez=c("cl1","cl2","cl3","cl4","cl5")#,"cl6")#,"cl7","cl8","cl9")
#output as txt, since we need the append-kwarg* we remove the txt file, otherwise the file just extend

outputfile <- sprintf("%s/PLOTS/KMEANS%s%s_%scluster%dPC_high_low.month.signif_bootstrap.txt",pfad,var2,norm,anzcluster,ndimmax)

outputfile_minmax <- sprintf("%s/PLOTS/KMEANS%s%s_%scluster%dPC_high_low.month.signif_bootstrap_minmaxwhiskers.txt",pfad,var2,norm,anzcluster,ndimmax)

if (file.exists(outputfile))
	unlink(outputfile)
	message('deleted the outputfile')
if (file.exists(outputfile_minmax))
	unlink(outputfile_minmax)
	message('deleted the outputfile_minmax')
kk=1
for ( clnr in 1:anzcluster ) {
#tt = paste("cluster ",clnr,sep="")
## StatDA 
#boxplotperc(boot.t[kk,,clnr], data = grid,quant=c(0.05,0.95),ylim=c(ymin,ymax))
boxplot(boot.t[kk,,clnr],quantile = c(0.25,0.75,0.1,0.9),range=1,ylim=c(ymin,ymax))

write.table(c(quantile(boot.t[kk,,clnr], probs = c(0.1, 0.9)),quantile(boot.t[kk,,clnr], probs = c(0.05, 0.95)),quantile(boot.t[kk,,clnr], probs = c(0.01, 0.99))), outputfile_minmax, append = TRUE, sep = " ", dec = ".",row.names = TRUE, col.names = TRUE)
par(new=T)
yt=""
if ( clnr == 1 ) { yt = "jan" }
plot(boot.t0[kk,clnr],ylim=c(ymin,ymax),pch=6,lwd=2,col=2,xaxt="n",xlab="",ylab=yt,main=clbez[clnr],col.main="blue", col.lab="blue",cex.main=1.6,cex.lab=1.6)
write.table(boot.t0[kk,clnr], outputfile, append = TRUE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)
}



for ( kk in 2:(nm) ) {
for ( clnr in 1:anzcluster ) {
yt=""
if ( (clnr == 1 ) & ( kk==1 )) { yt = "may" }
if ( (clnr == 1 ) & ( kk==2 )) { yt = "jun" }
if ( (clnr == 1 ) & ( kk==3 )) { yt = "jul" }
if ( (clnr == 1 ) & ( kk==4 )) { yt = "aug" }
if ( (clnr == 1 ) & ( kk==5 )) { yt = "sep" }
if ( (clnr == 1 ) & ( kk==6 )) { yt = "oct" }
#boxplotperc(boot.t[kk,,clnr], data = grid,quant=c(0.05,0.95),ylim=c(ymin,ymax))
boxplot(boot.t[kk,,clnr],quantile = c(0.25,0.75,0.1,0.9),range=1,ylim=c(ymin,ymax))

write.table(c(quantile(boot.t[kk,,clnr], probs = c(0.1, 0.9)),quantile(boot.t[kk,,clnr], probs = c(0.05, 0.95)),quantile(boot.t[kk,,clnr], probs = c(0.01, 0.99))), outputfile_minmax, append = TRUE, sep = " ", dec = ".",row.names = TRUE, col.names = TRUE)
plot(boot.t0[kk,clnr],ylim=c(ymin,ymax),pch=6,lwd=2,col=2,xaxt="n",xlab="",ylab=yt, col.lab="blue",cex.lab=1.6)

write.table(boot.t0[kk,clnr], outputfile, append = TRUE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)
     
            
}}
vv<-sprintf("%s/PLOTS/KMEANS%s%s_%scluster_bar_plot_%dPC_high_low.month.signif_bootstrap.ps",pfad,var,norm,anzcluster,clnr,ndimmax)
dev.print(device=postscript,vv,paper="a4",horizontal=FALSE)




#dev.print(device=postscript,"test.cluster.iera.r1000.ps",paper="a4",horizontal=FALSE)
 #ENDE loop ueber mehrer Verzeichnisse

