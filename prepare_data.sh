#!/bin/tcsh                                                                                                                                                                                        

set echo on 
set pfad= #N:/atm_glomod/user/jomuel001/ERA5/
set dat=$1 #slp_hpa_ERA5_1979-2021
set seas=$2 #jjas
  

  
  
#cd /atm_glomod/user/sawalz001/CMIP6/INM-CM5-0


#fm = fieldmean
#tr =trended




cdo selmon,9,10,11,12 -del29feb ${dat}.nc ${dat}.N_${seas}.nc #sep
cdo sellonlatbox,0,360,30,90 ${dat}.N_${seas}.nc ${dat}.Nor_${seas}.nc

#für mai und oktober 
cdo selmon,1,8,9,10,11,12 -del29feb ${dat}.nc ${dat}.N_${seas}_ext.nc #mit okt #ext ##hier beides


#Trendberechnung mit a und bfile mit mai und oktober inbegriffen
cdo fldmean ${dat}.Nor_${seas}.nc ${dat}.Nor_${seas}_an.nc
cdo trend ${dat}.Nor_${seas}_an.nc ${dat}.Nor_atrend1 ${dat}.Nor_btrend1

cdo enlarge,${dat}.N_${seas}_ext.nc ${dat}.Nor_atrend1 ${dat}.Nor_atrend
cdo enlarge,${dat}.N_${seas}_ext.nc ${dat}.Nor_btrend1 ${dat}.Nor_btrend
rm ${dat}.Nor_atrend1
rm ${dat}.Nor_btrend1



cdo subtrend ${dat}.N_${seas}_ext.nc ${dat}.Nor_atrend ${dat}.Nor_btrend ${dat}.N_${seas}_ext_tr.nc

#tagesmittel berechnen
cdo ydaymean ${dat}.N_${seas}_ext_tr.nc ${dat}.N_${seas}_ext_ydaymean.nc #tr

cdo splitmon ${dat}.N_${seas}_ext_ydaymean.nc mon.
cdo copy mon.01.nc mon.08.nc mon.09.nc mon.10.nc mon.11.nc mon.12.nc ydaymean.nc #ext   ###hier beides
rm mon.??.nc

#21 tage mittel berechnen
cdo runmean,21 ydaymean.nc ydaymean_rm21.nc
cdo splitmon ydaymean_rm21.nc rm21.

cdo copy rm21.09.nc rm21.10.nc rm21.11.nc rm21.12.nc aacrm21.nc #rm21.09.nc #normal

cdo sub -selmon,9,10,11,12 ${dat}.N_${seas}_ext_tr.nc aacrm21.nc ${dat}.N_${seas}_atrbg_aacrm21.nc #tr #normal
#mv ${dat}.N_${seas}_ext.nc ${dat}.N_${seas}_atrbg_aacrm21.nc
#rm rm21.??.nc
#rm ydaymean_rm21.nc
#rm ydaymean.nc






rm ${dat}.N_${seas}_ext_ydaymean.nc
#rm ${dat}.N_${seas}_ext_tr.nc
rm aacrm21.nc 
