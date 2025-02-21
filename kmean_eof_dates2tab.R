########################################################################
#
# ALLE dates-files EINER clusteranalyse einlesen und als Tabelle ausschreiben
#
#
#  Tabelle:
#  YYYY MM DD clnr
#
#~ 	preset-MR_e6_HICEhamo+LICEhamothin               /daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/KMEANS_djfm_del29feb_aacTOT_unnorm_5cluster_cl1_5PC_dates
#~	 preset-MR_e6_HICEp+HICEhamo                      /daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/KMEANSslp_djfm_del29feb_aacTOT_unnorm_5cluster_cl1_5PC_dates
#~	 preset-MR_e6_HICEp+LICEhamothin                  /daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/KMEANSslp_djfm_del29feb_aacTOT_unnorm_5cluster_cl1_5PC_dates
#~ 	preset-MR_e6_HICEp+LICEthin                      /daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/KMEANSslp_djfm_del29feb_aacTOT_unnorm_5cluster_cl1_5PC_dates
#~ preset-MR_e6_HICEp+LICEthin+HICEhamo+LICEhamothin/daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/KMEANSslp_djfm_del29feb_aacTOT_unnorm_5cluster_cl1_5PC_dates
#~ preset-MR_e6_LICEthin+LICEhamothin               /daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/KMEANSslp_djfm_del29feb_aacTOT_unnorm_5cluster_cl1_5PC_dates


rm(list=ls())


#pfad='/atm_glomod/data/IERA40/daymean_1979-2019/AREA.-90_90_88_30/CLUSTER/'  #_nstart_100_iter_max_100/'
#pfad='/atm_glomod/data/NCEP/daymean_1979-2018/AREA.-90_90_87.5_30/CLUSTER/'  #_nstart_100_iter_max_100/'
args <- commandArgs(trailingOnly=TRUE)
pfad <- (args[1])  #4dx4dy

#~ mo='preset-MR_e6_HICEp+LICEthin+HICEhamo+LICEhamothin'
#~ pfad <- paste('/atm_glomod/data/ECHAM6/',mo,'/daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/',sep='')

#~ pfad <- '/atm_glomod/data/ECHAM6/preset-MR_swift1215_NH_HICEp+LICEthin/daymean/AREA.-90_90_88.5722_28.9115/CLUSTER/'
#~ pfad <- '/atm_glomod/data/ERA5/daymean_1979-2020/AREA.90_270_89.7849_29.0866//CLUSTER/'


seas <- (args[3]) #'mjja' #'sond' #'mamj' #'djfm' #
#~ var <- paste("slp_",seas,"_del29feb_aac",sep="")
#~ var <- paste("slp_",seas,"_aacTOTrm21",sep="")
#~ var <- paste("slp_",seas,"_aac",sep="")psl_hpa_day_MIROC6_r1i1p1f1_1950-2014.rb.N_jja_atrbg_aacrm21
var <- paste((args[2]),sep="")
norm <- "_unnorm" 

ncl=5  # Anzahl der Cluster
npc=10  # Anzahl der PCs

start_year=as.integer(args[5]) #1 #1979
last_year= as.integer(args[4])
 #400 #2016


nm=nchar(seas)
ndy=c(1:nm)
#################  DJFM  #################
if ( seas == "djfm" ) { ndy=c(31,28,31,31) ; mm=c(1,2,3,12) }
if ( seas == "jjas" )  { ndy=c(30,31,31,30) ; mm=c(6,7,8,9) }
if ( seas == "sond" ) { ndy=c(30,31,30,31) ; mm=c(9,10,11,12)}
if ( seas == "mamj" ){ ndy=c(31,30,31,30) ; mm=c(3,4,5,6) }
if ( seas == "mjjaso" ){ ndy=c(31,30,31,31,30,31) ; mm=c(5,6,7,8,9,10) }
if ( seas == "jja" ){ ndy=c(30,31,31) ; mm=c(6,7,8) }
ndatmax=(last_year-start_year+1)*sum(ndy)
ymdcl=array(0,dim=c(ndatmax,nm)) 
#ymdcl=array(0,dim=c(24200,nm)) #200yr
#ymdcl=array(0,dim=c(48400,nm)) #400yr


## Zeitvektor anlegen
ndat=0
for ( ny in start_year:last_year ) {
nmm=nm
if ( ny == last_year ) { nmm=nchar(seas) }
for ( kk in 1:nmm ) {

  ## Schaltjahr
  #if ( ndy[2] < 30 ) {
  #if (  ( ny%%4 == 0 ) &&  ( ! ny%%100 == 0 ) || ( ny%%400 == 0 ) ) {
  #ndy[2]=29 }
  #else {
  #ndy[2]=28 }
  #if ( grepl("del29feb",var) == TRUE ) { ndy[2]=28 }
  #}
  
   #ndy[2]=28
message(ndy)
message(nmm)
message(ndy[kk])
for ( ii in 1:ndy[kk] ) {
ndat=ndat+1
ymdcl[ndat,1]=ny
ymdcl[ndat,2]=mm[kk]
ymdcl[ndat,3]=ii

cat('ndat ',ndat,':',ny,mm[kk],ii,'\n')

} # ENDE Tage im Monate
} # ENDE MOnat
} # ENDE ueber alles Jahre

#for ( ny in start_year_late:last_year_late  ) {
#nmm=nm
#if ( ny == last_year_late ) { nmm=nchar(seas) }
#for ( kk in 1:nmm ) {

  ## Schaltjahr
  #if ( ndy[2] < 30 ) {
  #if (  ( ny%%4 == 0 ) &&  ( ! ny%%100 == 0 ) || ( ny%%400 == 0 ) ) {
  #ndy[2]=29 }
  #else {
  #ndy[2]=28 }
  #if ( grepl("del29feb",var) == TRUE ) { ndy[2]=28 }
  #}
  
   #ndy[2]=28
#message(ndy)
#message(nmm)
#message(ndy[kk])
#for ( ii in 1:ndy[kk] ) {
#ndat=ndat+1
#ymdcl[ndat,1]=ny
#ymdcl[ndat,2]=mm[kk]
#ymdcl[ndat,3]=ii

#cat('ndat ',ndat,':',ny,mm[kk],ii,'\n')

#} # ENDE Tage im Monate
#} # ENDE MOnat
#} # ENDE ueber alles Jahre


for ( clnr in 1:ncl ) {
dates=read.table(vv<-sprintf("%s/KMEANS%s%s_%scluster_%dPC_cl%d_dates",pfad,var,norm,ncl,npc,clnr))
cat('ANz im Cluster: ',length(dates[,1]),'\n')

for ( ii in 1:length(dates[,1])) { ymdcl[dates[ii,1],4]=clnr }
}


## Tabelle ausschreiben
filetab <- paste(pfad,"/KMEANS",var,norm,"_",ncl,"tabcluster_",npc,"tabPC_dates",sep="")
write.table(ymdcl[1:ndat,], file=filetab, sep=" ", quote=FALSE, col.names=FALSE, row.names=FALSE, append=FALSE)
q('no')
