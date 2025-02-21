#!/bin/tcsh                                                                                                                                                                                        

set echo on 
set pfad= #N:/atm_glomod/user/jomuel001/ERA5/
set dat=$1 #slp_hpa_ERA5_1979-2021
set seas=$2 #jjas
set dat_hist=$3

#just define variables


#fm = fieldmean
#tr =trended



#select only May-October (and delete leap year but thats not necessary)
cdo selmon,5,6,7,8,9,10 -del29feb ${dat}.nc ${dat}.N_${seas}.nc #sep
#this is Arctic region, its E,W,S,N borders
#Atlantic_Euraisan region would be cdo sellonlatbox,-90,90,60,90 
cdo sellonlatbox,0,360,50,90 ${dat}.N_${seas}.nc ${dat}.N_${seas}.nc

#since we apply 21day running mean later on we also need take april and november into account 
cdo selmon,4,5,6,7,8,9,10,11 -del29feb ${dat}.nc ${dat}.N_${seas}_ext.nc #mit okt #ext


#claculation of background trend here
cdo fldmean ${dat}.N_${seas}.nc ${dat}.N_${seas}_an.nc #fieldmean
cdo trend ${dat}.N_${seas}_an.nc ${dat}.Nor_atrend1 ${dat}.Nor_btrend1 #linear trend of that

#enlarge the trend over the whole area (respect the input file))
cdo enlarge,${dat}.N_${seas}_ext.nc ${dat}.Nor_atrend1 ${dat}.Nor_atrend
cdo enlarge,${dat}.N_${seas}_ext.nc ${dat}.Nor_btrend1 ${dat}.Nor_btrend
rm ${dat}.Nor_atrend1
rm ${dat}.Nor_btrend1


# substract the trend from the arpil to november dataset 
cdo subtrend ${dat}.N_${seas}_ext.nc ${dat}.Nor_atrend ${dat}.Nor_btrend ${dat}.N_${seas}_ext_tr.nc

#daymean calculation from the detrended data

cdo ydaymean ${dat_hist}.N_${seas}_ext_tr.nc ${dat_hist}.N_${seas}_ext_ydaymean.nc #tr

#split the daymean out of all months so we can only substract the relevant months later on
cdo splitmon ${dat_hist}.N_${seas}_ext_ydaymean.nc mon.
cdo copy mon.04.nc mon.05.nc mon.06.nc mon.07.nc mon.08.nc mon.09.nc mon.10.nc mon.11.nc ydaymean.nc #ext
rm mon.??.nc

#calculate 21day running mean
cdo runmean,21 ydaymean.nc ydaymean_rm21.nc
cdo splitmon ydaymean_rm21.nc rm21.

#seasonal cycle here
cdo copy rm21.05.nc rm21.06.nc rm21.07.nc rm21.08.nc rm21.09.nc rm21.10.nc aacrm21.nc #rm21.09.nc #normal

#substract the seasonal cycle from the detrended data
cdo sub -selmon,5,6,7,8,9,10 ${dat}.N_${seas}_ext_tr.nc aacrm21.nc ${dat}.Arctic_${seas}_atrbg_aacHrm21.nc #tr #normal
#rm rm21.??.nc
#rm ydaymean_rm21.nc
#rm ydaymean.nc






rm ${dat}.N_${seas}_ext_ydaymean.nc
#rm ${dat}.N_${seas}_ext_tr.nc
rm aacrm21.nc 
