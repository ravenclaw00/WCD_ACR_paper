#! /bin/tcsh
#
set MV = /usr/bin/mv
set RM=/usr/bin/rm

set echo on

#####################################################################
#
# input: nc-file
# plot einer Variablen aus dem nc-File mit GMT
#

set pfad=$1
#set pfad=/atm_glomod/user/jomuel001/MIROC6/AREA.90_270_89.7849_29.0866/CLUSTER

#set pfad=/atm_glomod/user/sawalz001/CMIP6/MPI-ESM-1-2-HAM/AREA.-90_90_89.7849_29.0853/CLUSTER/


set JPG=1 # umwandeln der plots in jpg/png mit convert
set lonfull = 1 # lon: 0_360	
set DaddMEAN = 0 #1 # ADD: Clustermuster + climatologisches Mittel



foreach var ( $2)  #slp.4dx4dy_djfm_abg_aacrm21 )#gph_010.000-099_djfm_abg_aacTOTrm21 )
#UMbenennen weil die Dateien cl%d vor 5PC genannt werden, hier genau andersrum aber eingelesen werde nsollen (zuerst 5PC dann cl%d. Finde im PRogramm nicht wo die Dateinamen gesetzt werden, daher hier umbenennugn


foreach clpc ( '5cluster_10PC'  ) #'5cluster_10PC' )
#foreach clpc ( '5cluster_cl'  ) #'5cluster_10PC' )

set ncfile=KMEANS${var}_unnorm_${clpc}.nc  #hier
#set ncfile=KMEANS${var}_equ_${clpc}.nc
set filepl=$ncfile:r


if ( $DaddMEAN == 1 ) then

if ( $var == gph_010_jf_aac  | $var == gph_010.2dx_jf_aac | $var == gph_010_jf_aacTOT ) set varmean=gph_010.N_jf.nc
if ( $var == gph_010.200-299_jf_aac  | $var == gph_010.200-299.2dx_jf_aac  | $var == gph_010.200-299.2dx_jf_aacTOT  | $var == gph_010.200-299_jf_aacTOT) set varmean=gph_010.N_jf.nc
if ( $var == gph_010.100-199_jf_aac  | $var == gph_010.100-199.2dx_jf_aac  | $var == gph_010.100-199.2dx_jf_aacTOT | $var == gph_010.100-199_jf_aacTOT) set varmean=gph_010.N_jf.nc
if ( $var == gph_010.000-099_jf_aac  | $var == gph_010.000-099.2dx_jf_aac  | $var == gph_010.000-099.2dx_jf_aacTOT  | $var == gph_010.000-099_jf_aacTOT) set varmean=gph_010.N_jf.nc
if ( $var == gph_010_djfm_aac | $var == gph_010_djfm_aacTOT ) set varmean=gph_010.N_djfm.nc
if ( $var == gph_010.2dx_djfm_aac | $var == gph_010.2dx_djfm_aacTOT ) set varmean=gph_010.N_djfm.nc
if ( $var == gph_010.000-099_djfm_aacTOT_unnorm ) set varmean=gph_010.000-099.N_djfm.nc
if ( $var == gph_010.100-199_djfm_aacTOT_unnorm ) set varmean=gph_010.100-199.N_djfm.nc
if ( $var == gph_010.200-299_djfm_aacTOT ) set varmean=gph_010.200-299.N_djfm.nc
if ( $var == gph_010.4dx4dy_djfm_aac_unnorm ) set varmean=gph_010.4dx4dy.N_djfm.nc
if ( $var == gph_010.4dx4dy_jf_aac_unnorm ) set varmean=gph_010.4dx4dy.N_jf.nc
#set varmean=gph_010.4dx4dy.N_djfm.nc
set varmean=gph_010.N_djfm.nc
echo $varmean

#~ ncks -d lon,0,,2 /atm_glomod/data/CMIP6/PAMIP/11_11T/daymean/MEANgph_010.225yr.N_jf.nc dummy.nc
ncwa -a levels,bnds,time ${pfad}/../../MEAN$varmean  dummy2.nc
#if ( $var == gph_010.200-299.2dx_jf_aacTOT  |  $var == gph_010.2dx_djfm_aac |  $var == gph_010.2dx_jf_aac |  $var == gph_010.000-099.2dx_jf_aacTOT  |  $var == gph_010.100-199.2dx_jf_aacTOT  ) then

set fragea=`echo $var | awk ' $1 ~ /2dx/'`
if ( $#fragea == 1 ) then
  echo " == 2dx == "
  ncks -d lon,0,,2 dummy2.nc dumm.nc
  mv dumm.nc dummy2.nc
endif
cdo invertlat -sellonlatbox,0,360,49,90 dummy2.nc dummy3.nc
#cdo -sellonlatbox,0,360,59,88 dummy2.nc dummy.nc
#ncrename -d longitude,lon,latitude,lat dummy.nc dummy3.nc
cdo divc,1000 -add ${pfad}/${ncfile} dummy3.nc dummy4.nc
rm dummy.nc dummy2.nc dummy3.nc
set ncfile=dummy4.nc
endif



#set steps=(-30 -20 -15 -7 -5 -3 3 5 7 15 20 30) # slp_djfm
set steps=(-15 -10 -8 -3 -2 -1  1 2 3 8 10 15 ) # slp_djfm
#set steps=(-3000 -2000 -1200 -720 -400 -300 300 400 720 1200 2000 3000) #gph 500

set farb = polar                   # blau-weiss-rot
#set farb = jet                   # Name der Farbpalette
#set farb = gray                   # Name der Farbpalette
#set farb = roma #drywet #dem1                   #gruen bis gelb/braun

set PROJEC = 0/90/16             # Projektion -JSlon0/lat0/width 
set EINHEIT="SLP [hPa]"     #  mslp
#set EINHEIT="[m/s]"     #  GPH: [gpm] oder [gpkm]
#set EINHEIT="[gpm]"

if ( $DaddMEAN == 1 ) then
set farb = roma  #gruen bis gelb/braun
set EINHEIT="[gpkm]"     #  GPH: [gpm] oder [gpkm]
set steps=(28.2  28.6 29 29.4 29.8  30.2 30.6 31 ) # gph_010 + mean
endif


if ( -f filestep.dat ) rm filestep.dat
set ii=1
while ( $ii <= $#steps ) 
cat >> filestep.dat << EOF   
${steps[$ii]} c f18a0
EOF
@ ii = $ii + 1
end

## color-Tabel anlegen
if ( $DaddMEAN == 1 ) then 
   gmt makecpt -I -C${farb} -Tfilestep.dat > color.cpt
else
gmt makecpt -C${farb} -Tfilestep.dat > color.cpt
endif

echo $farb $DaddMEAN 


###############################################################
### loop ueber alle cluster
if ( $DaddMEAN == 1 ) then
  set clnrmax=`cdo nlevel ${ncfile}`
else
  set clnrmax=`cdo nlevel ${pfad}/${ncfile}|head -1`
endif

set clnr=1
echo "clnrmax: "$clnrmax
while ( $clnr <= $clnrmax ) 
set filepl=$ncfile:r
echo ${filepl}
set FILEPLOT=${pfad}/PLOTS/${filepl}_cl${clnr}.ps #_with_mean.ps
if ( $DaddMEAN == 1 ) set FILEPLOT=${pfad}/PLOTS/${filepl}_cl${clnr}_with_mean.ps

set TITEL="$ncfile:r  cl$clnr"
if ( $DaddMEAN == 1 ) set TITEL=" cl$clnr"

echo "PWD: "pwd
echo "FILEPLOT: "$FILEPLOT
#set FILEPLOT=test.ps

## level selektieren und dimension entfernen
if ( $DaddMEAN == 1 ) then 
  cdo sellevel,$clnr ${ncfile} lev.nc
else
  cdo sellevel,$clnr ${pfad}/${ncfile} lev.nc
endif

ncwa -a clnr lev.nc lev2.nc
rm lev.nc
set ncfilenew=lev2.nc


###############################################
## lon aufblaehen, wenn 0_360 geplottet wird
if ( $lonfull == 1 ) then
cdo griddes $ncfilenew > griddes.txt
cp griddes.txt griddes_orig.txt
#nawk '{if ($1 == xsize) {print "xsize = "}  else { print $0 }}' griddes.txt  > griddes2.txt
nawk '{ if ($1 == "xsize" ) {print "xsize = "$3 + 1 }  else { print $0 }}' griddes.txt  > griddes2.txt
set yy = `nawk '{ if ($1 == "ysize" ) {print $3 }  }' griddes.txt `
echo $yy
nawk '{ if ($1 == "gridsize" ) {print "gridsize = "$3 + yy }   else { print $0 }}' yy=$yy griddes2.txt  > griddes.txt
rm griddes2.txt 

#cdo enlargegrid,griddes.txt $ncfilenew lev3.nc
cdo remapnn,griddes.txt $ncfilenew lev3.nc
set ncfilenew=lev3.nc

endif



## AREA-Angaben aus dem netcdf lesen
set xmin = `gmt grdinfo -Cn ${ncfilenew} | awk '{print $1 }'`
set xmax = `gmt grdinfo -Cn ${ncfilenew} | awk '{print $2 }'`
set ymin = `gmt grdinfo -Cn ${ncfilenew} | awk '{print $3 }'`
set ymax = `gmt grdinfo -Cn ${ncfilenew} | awk '{print $4 }'`
set dx = `gmt grdinfo -Cn ${ncfilenew} | awk '{print $7/5 }'`
set dy = `gmt grdinfo -Cn ${ncfilenew} | awk '{print $8/5 }'`

echo $xmin $xmax $ymin $ymax
echo $dx $dy


## plotten 

## Daten glaetten
gmt grdsample ${ncfilenew} -Gfgridnew.grd -I${dx}/${dy} -R${xmin}/${xmax}/${ymin}/${ymax}

## plot
gmt grdimage fgridnew.grd -JS$PROJEC -R${xmin}/${xmax}/${ymin}/${ymax} -Yc -Ccolor.cpt -nl -K > $FILEPLOT   
## plot ohne glaetten
#gmt grdimage ${ncfilenew} -JS$PROJEC -R${xmin}/${xmax}/${ymin}/${ymax} -Yc -Ccolor.cpt -nl -K > $FILEPLOT   


## contour-Linien blau/rot
if ( $DaddMEAN == 1 ) then 
gmt grdcontour ${ncfilenew} -JS$PROJEC -Cfilestep.dat  -L-1000/-1000 -Wcthin,black -O -K >> $FILEPLOT     
else
gmt grdcontour ${ncfilenew} -JS$PROJEC -Cfilestep.dat  -L0.001/1700 -Wcthin,red -O -K >> $FILEPLOT     
gmt grdcontour ${ncfilenew} -JS$PROJEC -Cfilestep.dat  -L-1000/-0.01 -Wcthin,blue -O -K >> $FILEPLOT     
endif


## Legende
#gmt psscale -D8/-2/17/0.5h -L -Ccolor.cpt -B:"$EINHEIT": -O -K >> $FILEPLOT     
gmt psscale -D8/-2/17/0.5h -L -Ccolor.cpt -B+l"$EINHEIT" -O -K >> $FILEPLOT     

## Land-See-Maske
echo $TITEL
gmt pscoast -JS$PROJEC -R${xmin}/${xmax}/${ymin}/${ymax} -Ba30f10g30Sn:."$TITEL": -Dl -A5000/0/1 -Wthin -O >> $FILEPLOT


evince $FILEPLOT &
rm lev2.nc
if ( -f lev3.nc ) rm lev3.nc


if ( $JPG == 1 ) then
  set FILEPLOT2=$FILEPLOT:r
  convert -density 144x144 -page 600x700 $FILEPLOT PNG:${FILEPLOT2}.png
endif

@ clnr = $clnr + 1
end
### ENDE loop ueber alle Cluster im nc-File

if ( -f dummy4.nc ) rm dummy4.nc


end ## end foreach var
end ## end foreach clpc
end ## end foreach pf

