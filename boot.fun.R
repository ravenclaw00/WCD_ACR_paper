#######################################################################
# funktion fuer bootstrap
# teilweise kopiert von kmean_eof_split_month.R
#
# ndat.h, ndat.l - Laenge des Datenvektors fuer high-ice und low-ice
#
# daten - original daten-Feld
# dat.out - entstanden aus daten, ziehen mit zuruecklegen
#         - stype=i => dat.out enthaelt die indizes
#         - stype=f => dat.out enthaelt Haefigkeiten, d.h. wie oft wurde welche Position benutzt

boot.fun <- function(daten, dat.out, ndat.h, ndat.l, nm)
{

#print("====  boot.fun  ==== ")
#cat("daten: ",daten[1:10],"\n")

daten.new = daten[dat.out]

#cat("dat.out ",dat.out[1:10],"\n")
#cat("daten.new ",daten.new[1:10],"\n")


## Anzahl fuer jedes Cluster bestimmen getrennt nach low/high-ice
## normieren mit der Laenge der einzelnen Phasen
nm=5
ncl <- array(0,c(2,nm))
## high-Ice
dat.new.h=daten.new[1:ndat.h]
ncl[1,1] = length(dat.new.h[dat.new.h%in%1])/ndat.h
ncl[1,2] = length(dat.new.h[dat.new.h%in%2])/ndat.h
ncl[1,3] = length(dat.new.h[dat.new.h%in%3])/ndat.h
ncl[1,4] = length(dat.new.h[dat.new.h%in%4])/ndat.h
if ( nm > 4 ) { ncl[1,5] = length(dat.new.h[dat.new.h%in%5])/ndat.h }
if ( nm > 5 ) { ncl[1,6] = length(dat.new.h[dat.new.h%in%6])/ndat.h }
if ( nm > 6 ) { ncl[1,7] = length(dat.new.h[dat.new.h%in%7])/ndat.h }
if ( nm > 7 ) { ncl[1,8] = length(dat.new.h[dat.new.h%in%8])/ndat.h }
if ( nm > 8 ) { ncl[1,9] = length(dat.new.h[dat.new.h%in%9])/ndat.h }

## low-Ice
dat.new.l=daten.new[(ndat.h+1):length(dat.out)]
ncl[2,1] = length(dat.new.l[dat.new.l%in%1])/ndat.l
ncl[2,2] = length(dat.new.l[dat.new.l%in%2])/ndat.l
ncl[2,3] = length(dat.new.l[dat.new.l%in%3])/ndat.l
ncl[2,4] = length(dat.new.l[dat.new.l%in%4])/ndat.l
if ( nm > 4 ) { ncl[2,5] = length(dat.new.l[dat.new.l%in%5])/ndat.l }
if ( nm > 5 ) { ncl[2,6] = length(dat.new.l[dat.new.l%in%6])/ndat.l }
if ( nm > 6 ) { ncl[2,7] = length(dat.new.l[dat.new.l%in%7])/ndat.l }
if ( nm > 7 ) { ncl[2,8] = length(dat.new.l[dat.new.l%in%8])/ndat.l }
if ( nm > 8 ) { ncl[2,9] = length(dat.new.l[dat.new.l%in%9])/ndat.l }

#print(ncl[1,])
#print(ncl[2,])
#print(ncl[2,]-ncl[1,])

## Farben fuer die Balken
colblue1=rgb(1,0.5,0.5) #rgb(0.5,0.5,1)
colblue2=rgb(0.3,0.3,1)
colblue3=rgb(0.1,0.1,1)
colblue4=rgb(0,0,0.8)
colblue5=rgb(0,0,0.5)
colred1=rgb(1,0.5,0.5)
colred2=rgb(1,0.3,0.3)
colred3=rgb(1,0.1,0.1)
colred4=rgb(0.8,0,0)
colred5=rgb(0.5,0,0)
space.nm.start = c(0,0,0.5,0,0.5,0,0.5,0,0.5,0)
space.nm = c(3,0,0.5,0,0.5,0,0.5,0,0.5,0) 
col.nm = c(colblue1,colred1,colblue2,colred2,colblue3,colred3,colblue4,colred4,colblue5,colred5) 

#message("ok")

#barplot(ncl, main="",   beside=TRUE, col=col.nm )
#legend("topright", c("HICE", "LICE"), fill=c(col=rgb(1,0,0,0.5),rgb(0,0,1,0.5)),cex=1.5)
#box()

c(ncl[2,]-ncl[1,])
#system('sleep 10')

}


