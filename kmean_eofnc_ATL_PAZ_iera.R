###################################################################################################
#
#   K-Means Clustering
#
# - INPUT-Feld PC-Zeitreihe sind ascii-Daten
# - wenn zuvor keine EOF gerechnet wurde, dann muss das AREA-Verzeichnis perhand angelegt werden
#   ebenso die Verzeichnisse AREA....../PLOTS
#                            AREA....../MEAN
#                            AREA....../CLUSTER
# - output sind wiederum ascii-Daten im GMT-Format, welchen dann mit plot_refresh.sh dargestellt 
#   werden koennen
#
# !!! ACHTUNG: !!!
# Aenderung der Bezeichnung fuer das cluster-Verzeichnis
# ALT: CLUSTER_nstart_100_iter_max_100
# NEU: CLUSTER
#
# Aenderungen bei iter und/oder max MUSS ein anderes Cluster-Verzeichnis angelegt werden
# entsprechende Info in /model2/paleo/AUSWERTUNG_linux/README
#
###################################################################################################


#cat(args, sep = ";")

rm(list=ls())

#library(ncdf4)
## R Version checken; notwendig zum laden von Bibliotheken
v1=R.Version()$major
v2=R.Version()$minor


library(ncdf4,lib.loc=paste("/atm_glomod/work/R_LIB/R.",v1,".",v2,"/",sep=""))
library(cluster)
library(ggplot2)
# Anzahl der maximal zu verwendeten PCs (Dimension des Phasenraumes, in dem Clusteranalyse durchgefuehrt wird)
ndimmin=10 #5 #30 #3
ndimmax=10#5 #30 #6 #6

## clnr - in wieviel Cluster wird der Datensatz aufgeteilt

clnrmin=5 #4 #4
clnrmax=5 #8
clnrstep=1

args <- commandArgs(trailingOnly=TRUE)

# Pfade festlegen
pfad <- (args[1])
pfad_modell <- (args[3])
#pfad <- ("/atm_glomod/user/jomuel001/BCC-ESM1/AREA.90_270_89.7849_29.0866")
#pfad_modell <- ("/atm_glomod/user/jomuel001/BCC-ESM1/AREA.90_270_89.7849_29.0866")

variablen <- c(args[2])
#variable_modell <- c(args[2])
#print(args[4])
seas <- (args[4])
print(seas)
#variablen <- c("psl_hpa_BCC-ESM1_r1i1p1f1_1950-2014_jja_atrbg_aacrm21_remapbnds")
variable_modell <- c("slp_hpa_ERA5_1985-2014_mjjaso_atrbg_aacrm21_remapbnds")
normier <- c("_unnorm")
#normier <- c("")

for (kkk in 1:length(variablen)) {

for (jjj in 1:length(normier)) {

var=variablen[kkk]
var_modell=variable_modell[kkk]
norm =normier[jjj]


#High-ice-Phase  &  Low-ice-Phase fuer das Histogramm
## laenge der low/high-ice-Zeiten setzen

  leg.high.txt="high"
  leg.low.txt="low"

cat("Daten: Pfad",pfad, "PC",var,"_cos_cov_svd",norm,"\n")

dat1 <- read.table(vv <- sprintf("%s/EOF/PC%s_cos_cov_svd%s",pfad,var,norm))
#fnc  <- nc_open(vv <- sprintf("%s/EOF/EOF%s_cos_cov_svd.nc",pfad,var))
fnc  <- nc_open(vv <- sprintf("%s/EOF/EOF%s_cos_cov_svd.nc",pfad_modell,var_modell))
pfad_out <- sprintf("%s/CLUSTER/",pfad)  # pfad

## 

if ( file.exists(pfad_out) == FALSE ) {
  dir.create(pfad_out)
  system(paste("chmod 774 ",pfad_out,sep=""))
  vv6 <- sprintf("%s/PLOTS/",pfad_out)
  dir.create(vv6)
  system(paste("chmod 774 ",vv6,sep=""))
}

########## nc-File  #############
## nlon, nlat, nn aus nc-File lesen
nlon <- fnc$dim$lon$len
nlat <- fnc$dim$lat$len
nn <- fnc$dim$neof$len

## names(fnc$var) liefert den Namen der Variablen
eof <- ncvar_get(fnc,"eof")
##########ENDE  nc-File  #########

## Anzahl der Daten im Datensatz
iend=dim(dat1)[1] 
message(iend)
jj_high=iend/2
jj_low=iend-jj_high


cat(" ===  iend: ",iend,"==== \n")
  #~ jj_high=iend/2
  #~ jj_low=iend/2
  #~ leg.high.txt="HICEp+LICEthin"
  #~ leg.low.txt="HICEhamo+LICEhamothin"

## Datenfeld anlegen, ab 30N
#eof <- array(0,dim=c(nlon*(nlat2-1),nn))

pc <- dat1[,1:ndimmax]


#STD berechnen
s=c(1:ndimmax)

for (k in 1:ndimmax) { 
s[k]=sd(pc[,k]) 
cat("STD PC",k,"=",s[k],"\n")
}


for ( ndim in ndimmin:ndimmax) {

totwithinsum <- c(1:(clnrmax-1))
ratio2 <- c(1:(clnrmax-1))
pairwise_dist <- c(1:(clnrmax-1))
intra_dist <- c(1:(clnrmax-1))
inter_dist <- c(1:(clnrmax-1))


for ( clnr in seq(clnrmin,clnrmax,clnrstep) ) {
#########################################################
cat("ndim=",ndim,"Anzahl der auszusortierenden Cluster: ",clnr,"\n")
cl <- kmeans(pc,clnr,nstart=100,iter.max=100)
#print(attributes(cl))

# Calculate pairwise distances between observations
d <- dist(pc, method = "euclidean")
d_matrix <- as.matrix(d)
pairwise_distances <- d_matrix[upper.tri(d_matrix, diag = TRUE)]
##########################################################
cluster_assignments <- cl$cluster

# Calculate intra-cluster distances
intra_distances <- dist(pc[cluster_assignments == 1, ], method = "euclidean")
for (i in 2:clnr){
  intra_distances <- c(intra_distances, dist(pc[cluster_assignments == i, ], method = "euclidean"))
}

# Calculate inter-cluster distances
centers <- cl$centers
inter_distances <- dist(centers, method = "euclidean")

# cat("str(cl) ",str(cl),"\n")

## Datenfeld(feld) nach kmeans in clnr-Cluster teilen, mit eof multipl und ausschreiben
## Anzahl der Werte pro Cluster: cl$size

cluster <- array(0,dim=c(nlon, nlat, clnr))
center.unnorm=cl$centers
# Normierung der PCs beruecksichtigen bei Rekonstruktion des Clustercenters
for ( k in 1:ndim) { #fuer jede Dimension
for ( m in 1:clnr ) {            # fuer jeden cluster in cl
cat("center dim=",k,"cluster=",m,"=", cl$centers[m,k],cl$centers[m,k]/s[k],"\n")
  cl$centers[m,k]= cl$centers[m,k]/s[k]
  
#cat("center dim=",k,"cluster=",m,"=", cl$centers[m,k],"\n")
  }
}


for ( jj in 1:nlat) { # ueber alle Gitterpunkte
for ( ii in 1:nlon) { # ueber alle Gitterpunkte
for ( m in 1:clnr ) {            # fuer jeden cluster in cl
  cluster[ii,jj,m] <- sum(cl$centers[m,1:ndim]*eof[ii,jj,1:ndim])
}
}}

## absteigend sortieren und schreiben
cat("Besetzung vor sort:  ",cl$size," \n")
sort_anz=sort(cl$size,decreasing=TRUE)
cat("Besetzung nach sort:  ",sort_anz," \n")

######################################
  pos=c(1:clnr)
  pos[]=0

vv3 <- sprintf("%s/KMEANS%s%s_%dcluster_%dPC.nc",pfad_out,var,norm,clnr,ndim)
if ( file.exists(vv3) == TRUE ) {  
  vv7 <- sprintf("rm %s",vv3)
  system(vv7,inter=TRUE)
}
## nc-File definieren
dim.lon=ncdim_def( "lon", "degrees", fnc$dim$lon$vals, longname="longitude" )
dim.lat=ncdim_def( "lat", "degrees", fnc$dim$lat$vals, longname="latitude" )
dim.lev=ncdim_def( "clnr", "number ", 1:clnr, longname="cluster number")
cluster.out=ncvar_def("cluster",units=fnc$var$eof$units,list(dim.lon,dim.lat,dim.lev))
ncnew=nc_create(vv3,cluster.out)


for (  i in 1:clnr ) {
   ii=1
    while ( ii <= clnr ) {
  
    if ( sort_anz[ii] == cl$size[i] & pos[ii] == 0 ) { 
     cat("Datensatz ",i," auf Position ",ii," gerutscht \n")
     pos[ii]=i
     #ncvar_put(ncnew,cluster.out,cluster[,,i],start=c(1,1,i), count=c(nlon,nlat,1) )

   ii=clnr 
  }

  ii=ii+1
}}

for (  i in 1:clnr ) {
  cat("schreibe cluster ",i,"von Position ",pos[i],"\n")
  ncvar_put(ncnew,cluster.out,cluster[,,pos[i]],start=c(1,1,i), count=c(nlon,nlat,1) )
}

nc_close(ncnew)

##------------------------------------------------------------
## welche Zeitpunkte fuer welches Cluster 
vv7 <- sprintf("%s/KMEANS%s%s_%dcluster_%dPC_cl1_dates",pfad_out,var,norm,clnr,ndim)
if ( file.exists(vv7) == TRUE ) {  
  for ( kk in 1:clnr ) { 
    vv8 <- sprintf("rm %s/KMEANS%s%s_%dcluster_%dPC_cl%d_dates",pfad_out,var,norm,clnr,ndim,kk)
    system(vv8,inter=TRUE)
  }
}

for ( jj in 1:length(cl$cluster) ) { 
for ( kk in 1:clnr ) { 
if (cl$cluster[jj]==pos[kk]) {
  vv7 <- sprintf("%s/KMEANS%s%s_%dcluster_%dPC_cl%d_dates",pfad_out,var,norm,clnr,ndim,kk)
  #cat(vv7,"\n")
  write.table(jj, file=vv7, sep=" ", quote=FALSE, col.names=FALSE, row.names=FALSE, append=TRUE)
}}

}


##------------------------------------------------------------
##Clustercenter ausschreiben; mit neuer Sortierung
vv8 <- sprintf("%s/KMEANS%s%s_%dcluster_%dPC_center",pfad_out,var,norm,clnr,ndim)
center.sort.norm=array(0,dim=c(clnr,ndim+1))
center.sort.unnorm=array(0,dim=c(clnr,ndim+1))
cat(vv8,"\n")
for ( i in 1:clnr ) {            # fuer jeden cluster in cl
center.sort.norm[i,1]=i
center.sort.norm[i,2:(ndim+1)]=cl$centers[pos[i],]
center.sort.unnorm[i,1]=i
center.sort.unnorm[i,2:(ndim+1)]=center.unnorm[pos[i],]
}
vv8 <- sprintf("%s/KMEANS%s%s_%dcluster_%dPC_center.norm",pfad_out,var,norm,clnr,ndim)
write.table(center.sort.norm,file=vv8,quote=FALSE, append=FALSE, col.names=FALSE, row.names=FALSE)

vv8 <- sprintf("%s/KMEANS%s%s_%dcluster_%dPC_center.unnorm",pfad_out,var,norm,clnr,ndim)
write.table(center.sort.unnorm,file=vv8,quote=FALSE, append=FALSE, col.names=FALSE, row.names=FALSE)

#------------------------------------------------------------------------------------------

#Histogramm fuer High und Low ice-Phasen

#High-ice-Phase
#jj_high= iend/2 #nday*nyear_high #High-Ice Jahre

zaehlh <- array(0,dim=c(clnr))

for ( jj in 1:jj_high ) { 

for ( kk in 1:clnr ) { 

if (cl$cluster[jj]==pos[kk]) { zaehlh[kk]=zaehlh[kk]+1}
}
}


zaehll <- array(0,dim=c(clnr))

for ( jj in (jj_high+1):iend ) { 

for ( kk in 1:clnr ) { 
#     cat(kk," ",cl$cluster[jj],"\n")

if (cl$cluster[jj]==pos[kk]) {  zaehll[kk]=zaehll[kk]+1}
}

}

numbers=c(1:2*clnr)
x_lim=c(1:2*clnr)
for ( kk in 1:clnr ) { 
numbers[2*(kk-1)+1] <- sprintf("%d",zaehlh[kk])
numbers[2*kk] <- sprintf("%d",zaehll[kk])
x_lim[2*(kk-1)+1] <- sprintf("%s", kk)
x_lim[2*kk] <- sprintf("%s",kk)
}

zaehl <- rbind(zaehlh/jj_high,zaehll/jj_low)
par(las=2)
#barplot(zaehl, main="High Ice 1979-1999 Low Ice 2000-2014",xlab="Cluster with absolute frequency", 
message(x_lim)

vv6 <- sprintf("%s/PLOTS/KMEANS%s%s_%dcluster_bar_plot_%dPC_high_low.ps",pfad_out,"m/s",norm,clnr,ndim)
#postscript(file=vv6,horiz=TRUE,onefile=TRUE)


#vv14 <- sprintf("%s/PLOTS/KMEANS%s%s_%dcluster_bar_plot_%dPC_high_low.pdf",pfad_out,var,norm,clnr,ndim)
#pdf(vv14)
x11()
barplot(zaehl, main="",xlab="Cluster", 
	ylab="relative frequency",col=c("blue","red"), 
	ylim=c(0,round(1/clnr,1)+0.1),beside=TRUE,names.arg=x_lim,cex.names=1.2,cex.axis=1.2,cex.lab=1.2)
#legend(clnr*3-(clnr*2),round(1/clnr,1)+0.1,c("high ice (1950-1982)","low ice 		  	(1982-2014)"),col=c("blue","red"),pch=15) 
vv15 <- sprintf("%s/PLOTS/KMEANS%s%s_%dcluster_bar_plot_%dPC_high_low.txt",pfad_out,"gph",norm,clnr,ndim)
write.table(zaehl, vv15, append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)
#legend(clnr*3-(clnr*0.5),round(1/clnr,1)+0.1,c("1900-1978","1979-2014"),col=c("blue","red"),pch=15) 
#legend(clnr*3-(clnr*0.5),round(1/clnr,1)+0.1,c(leg.high.txt,leg.low.txt),col=c("blue","red"),pch=15) 
 
  
#barplot(zaehll/jj_low, main="Low Ice 2000-2014",
#   xlab="Clusternumber", col=c("darkblue"), ylim=c(0,round(1/clnr,1)+0.1)) 

#vv6 <- sprintf("%s/PLOTS/KMEANS%s%s_%dcluster_bar_plot_%dPC_high_low.ps",pfad_out,var,norm,clnr,ndim)
print(vv6)

dev.print(device=postscript,vv6,paper="a4", horizontal=TRUE)
#postscript(file=vv6,horiz=TRUE,onefile=TRUE)
#vv14 <- sprintf("%s/PLOTS/KMEANS%s%s_%dcluster_bar_plot_%dPC_high_low.pdf",pfad_out,var,norm,clnr,ndim)
#pdf(vv14)
############################



totwithinsum[clnr-1] <- cl$tot.withinss
ratio2[clnr-1]=cl$betweenss/cl$tot.withinss
pairwise_dist[clnr-1]=pairwise_distances
intra_dist[clnr-1]=intra_distances
inter_dist[clnr-1]=inter_distances
cat("Summe der Abstandsquadrate: ",totwithinsum[clnr-1],"\n")
cat("Varianzratio --> moeglichst gross ",ratio2[clnr-1],"\n")
cat("Pairwise Distances", pairwise_dist[clnr-1],"\n")
cat("intra-distance", intra_dist[clnr-1],"\n")
cat("inter-distance", inter_dist[clnr-1],"\n")

#rm(cl)
} # ENDE loop ueber alle Cluster (2-clnrmax)


## Infos zusammensetzen
tab1=c("cl",c(2:clnr))
tab2=c("Summe Abstandsquadrate: ",totwithinsum)
tab3=c("Varianzratio (moeglichst gross) ",ratio2)
tab4=c("Pairwise Distance ", pairwise_dist)
tab5=c("intra-distance", intra_dist)
tab6=c("inter-distance", inter_dist)


vv4 <- sprintf("%s/KMEANS%s%s_all_cluster_totwithinsum_varratio_%dPC",pfad_out,var,norm,ndim)
write.table(cbind(tab1,"\t",tab2,"\t",tab3,"\t", tab4,"\t", tab5, "\t", tab6), file=vv4, sep=" ", quote=FALSE, col.names=FALSE, row.names=FALSE, append=FALSE)

## OLD
#vv4 <- sprintf("%s/KMEANS%s%s_all_cluster_totwithinsum_%dPC",pfad_out,var,norm,ndim)
#write.table(totwithinsum, file=vv4, sep=" ", quote=FALSE, col.names=FALSE, row.names=FALSE, append=FALSE)
#vv8 <- sprintf("%s/KMEANS%s%s_all_cluster_var_ratio_%dPC",pfad_out,var,norm,ndim)
#write.table(ratio2, file=vv8, sep=" ", quote=FALSE, col.names=FALSE, row.names=FALSE, append=FALSE)

} # ende ndim



} # Schleife ueber Normierung

} # Schleife ueber Variablen

q("no")
