#! /bin/tcsh
set pfad=/atm_glomod/user/jomuel001/ERA5/gph_500/
set mod=ERA5
set year=1940-2022
set seas=sond



set AREA=.-90_90_89.7849_29.0866
#cdo selyear,1940/2022 ${pfad}gph_50_ERA5_1940-2023.nc ${pfad}gph_50_ERA5_1940-2022.nc

set dat=${pfad}gph_500_ERA51_1940-2022
#./prepare_data.sh ${pfad}gph_500_ERA51_1940-2022 ${seas}

#cdo remapbil,/atm_glomod/user/jomuel001/CMIP6_models/ERA5/gridERA5.txt ${dat}.N_${seas}_atrbg_aacrm21.nc ${dat}.N_${seas}_atrbg_aacrm21_remap.nc
#exit
#cdo --reduce_dim -copy ${dat}.N_${seas}_atrbg_aacrm21_remap.nc ${dat}.N_${seas}_atrbg_aacrm21_remap1.nc
#ncwa -a bnds ${dat}.N_${seas}_atrbg_aacrm21_remap1.nc ${dat}.N_${seas}_atrbg_aacrm21_remapbnds.nc
echo alles top
#mkdir ${pfad}AREA.-90_90_89.7849_29.0866
#mkdir ${pfad}AREA.-90_90_89.7849_29.0866/CLUSTER
#mkdir ${pfad}AREA.-90_90_89.7849_29.0866/EOF
#mkdir ${pfad}AREA.-90_90_89.7849_29.0866/PLOTS
#mkdir ${pfad}AREA.-90_90_89.7849_29.0866/CLUSTER/PLOTS
#./auswertung/EOF/Proj_mit_Gebietswahl_sh slp_hpa_${mod}_${year} ${mod} # hier muss man Jahr ändern

#./auswertung/EOF/EOF_mit_Gebietswahl_s_t_mode_nc_sh gph_500_ERA51_1940-2022 ${seas} -90 90 30 ${pfad}
echo EOF fertig
cd /atm_glomod/user/jomuel001/auswertung/CLUSTER/
set pfadAREA = "${pfad}AREA.-90_90_89.7849_29.0866"
set varAREA = "gph_500_ERA51_1940-2022_sond_atrbg_aacrm21_remap1"
#set varAREA = "gph_500.4dx4dy_jjas_abgtr_aacrm21"
#Rscript kmean_eofnc_ATL_PAZ_iera.R "${pfadAREA}" "${varAREA}" "${pfad}AREA${AREA}" "${seas}" #hier rein und jahre anpassen

#Rscript kmean_eof_dates2tab.R "${pfadAREA}/CLUSTER" "${varAREA}" "${seas}" 2022 1940
echo nur noch plotten
./plot_nc2gmt.cluster.sh ${pfadAREA}/CLUSTER ${varAREA}
exit
rm ${pfad}${mod}/psl_day*
echo ALLES FERTIG
set AREA=.90_270_89.7849_29.0866
mkdir ${pfad}AREA.90_270_89.7849_29.0866
mkdir ${pfad}AREA.90_270_89.7849_29.0866/CLUSTER
mkdir ${pfad}AREA.90_270_89.7849_29.0866/EOF
mkdir ${pfad}AREA.90_270_89.7849_29.0866/PLOTS
mkdir ${pfad}AREA.90_270_89.7849_29.0866/CLUSTER/PLOTS
#./auswertung/EOF/Proj_mit_Gebietswahl_sh slp_hpa_${mod}_${year} ${mod} # hier muss man Jahr ändern

#./auswertung/EOF/EOF_mit_Gebietswahl_s_t_mode_nc_sh gph_500_ERA51_1940-2022 ${seas} 90 270 30 ${pfad}
echo EOF fertig
cd /atm_glomod/user/jomuel001/auswertung/CLUSTER/
set pfadAREA = "${pfad}AREA.90_270_89.7849_29.0866"
set varAREA = "gph_100_ERA51_1940-2022_jjas_atrbg_aacrm21_remap1"
#set varAREA = "gph_500.4dx4dy_jjas_abgtr_aacrm21"
Rscript kmean_eofnc_ATL_PAZ_iera.R "${pfadAREA}" "${varAREA}" "${pfad}AREA${AREA}" "${seas}" #hier rein und jahre anpassen
Rscript kmean_eof_dates2tab.R "${pfadAREA}/CLUSTER" "${varAREA}" "${seas}" 2022 1940
echo nur noch plotten
./plot_nc2gmt.cluster.sh ${pfadAREA}/CLUSTER ${varAREA}

rm ${pfad}${mod}/psl_day*
echo ALLES FERTIG


