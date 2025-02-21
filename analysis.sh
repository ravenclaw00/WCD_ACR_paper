#! /bin/tcsh
cd /atm_glomod/user/jomuel001/
#set moduls=(ACCESS-ESM1)
#set moduls=(ACCESS-CM2 ACCESS-ESM1 AWI-ESM-1-1-LR CESM2 CESM2-FV2 CESM2-WACCM CESM2-WACCM-FV2 CMCC-CM2-HR4 CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 FGOALS-f3-L GFDL-CM4 GFDL-ESM4 HadGEM3-GC31-LL INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR MIROC6 MPI-ESM-1-2-HAM MPI-ESM1-2-HR MPI-ESM1-2-LR MRI-ESM2-0 NorESM2-MM SAM0-UNICON UKESM1-0-LL)
#
#
set moduls=(ACCESS-CM2 ACCESS-ESM1 CESM2-WACCM CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 GFDL-CM4 GFDL-ESM4 HadGEM3-GC31-LL INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR KACE-1-0-G MIROC6 MIROC-ES2L MPI-ESM1-2-HR MPI-ESM1-2-LR MRI-ESM2-0 NorESM2-MM UKESM1-0-LL)
#KACE-1-0-G
#set moduls=(KACE-1-0-G MIROC-ES2L) 
#set moduls=(CESM2-WACCM)s

set AREA=.0_360_89.7849_49.3208

#set moduls=(ERA5)
foreach k ($moduls)
	set pfad=/atm_glomod/user/jomuel001/CMIP6_models/
	set mod=$k
	set year=1985-2014
	set year_hist=1985-2014
	set seas=mjjaso
	set dat=${pfad}${mod}/slp_hpa_${mod}_${year}
	#echo ${mod}
	#echo ${pfad}${mod}
	#tar -xf ${pfad}${mod}/${mod}.tar -C ${pfad}${mod}
	#rm ${pfad}${mod}/${mod}.tar 
	#cdo cat ${pfad}${mod}/psl_day_${mod}_ssp370* ${pfad}${mod}/slp_ssp3_${mod}_.nc
	#cdo divc,100 ${pfad}${mod}/slp_ssp3_${mod}_.nc ${pfad}${mod}/slp_hpa_${mod}_ssp3.nc
	
	
	#cdo selyear,2070/2099 ${pfad}${mod}/slp_hpa_${mod}_ssp3.nc ${pfad}${mod}/slp_hpa_ssp3_${mod}_${year}.nc
	
	#./prepare_data_3.sh ${pfad}${mod}/slp_hpa_${mod}_${year} ${seas} ${pfad}${mod}/slp_hpa_${mod}_1985-2014
	
	set dat=${pfad}${mod}/slp_hpa_${mod}_${year}
	
	#cdo remapbil,/atm_glomod/user/jomuel001/CMIP6_models/ERA5/gridERA5.txt ${dat}.Arctic_${seas}_atrbg_aacHrm21.nc ${dat}.Arctic_${seas}_atrbg_aacHrm21_remap.nc
	
	#ncwa -a bnds ${dat}.Arctic_${seas}_atrbg_aacHrm21_remap.nc ${dat}.Arctic_${seas}_atrbg_aacHrm21_remapbnds.nc
	#cdo cat ${pfad}${mod}/slp_hpa_${mod}_1979-2014.N_${seas}_atrbg_aacrm21_remapbnds.nc ${pfad}${mod}/slp_hpa_${mod}_2065-2100.N_${seas}_atrbg_hist_aacrm21_remapbnds.nc ${pfad}${mod}/slp_hpa_${mod}_1979-2021_2065-2100.N_${seas}_atrbg_hist_aacrm21_remapbnds.nc
	#cdo cat ${dat}.N_${seas}_atrbg_aacHrm21_remapbnds.nc 
	echo "alles top"
	mkdir ${pfad}${mod}/AREA${AREA}
	mkdir ${pfad}${mod}/AREA${AREA}/CLUSTER
	mkdir ${pfad}${mod}/AREA${AREA}/EOF
	mkdir ${pfad}${mod}/AREA${AREA}/PLOTS
	mkdir ${pfad}${mod}/AREA${AREA}/CLUSTER/PLOTS
	#rm /CMIP6_models/${mod}/psl_day*
	./auswertung/EOF/Proj_mit_Gebietswahl_sh slp_hpa_${mod}_${year} ${pfad}${mod} ${AREA} _${seas} "_atrbg_aacrm21"
	echo "EOF fertig"
	cd /atm_glomod/user/jomuel001/auswertung/CLUSTER/
	set pfadAREA = "${pfad}${mod}/AREA${AREA}"
	set varAREA = "slp_hpa_${mod}_${year}.Arctic_${seas}_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51985-2014slp_hpa_ERA5_1985-2014_${seas}_atrbg_aacrm21_remapbnds"
	Rscript kmean_eofnc_ATL_PAZ_iera.R "${pfadAREA}" "${varAREA}" "${pfad}ERA5/AREA${AREA}" "${seas}"
	Rscript kmean_eof_dates2tab.R "${pfadAREA}/CLUSTER" "${varAREA}" "${seas}" 2014 1985 #hier rein und Jahre anpassen
	echo "nur noch plotten"
	#exit
	#./plot_nc2gmt.cluster.sh ${pfadAREA}/CLUSTER ${varAREA}
	echo $k "ALLES FERTIG"
	cd /atm_glomod/user/jomuel001
end
exit
set AREA=.90_270_89.7849_29.0866

#set moduls=(ERA5)
set moduls=(ACCESS-CM2 ACCESS-ESM1 CESM2-WACCM CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 GFDL-CM4 GFDL-ESM4 HadGEM3-GC31-LL INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR MIROC6 MPI-ESM1-2-HR MPI-ESM1-2-LR MRI-ESM2-0 NorESM2-MM UKESM1-0-LL)

foreach k ($moduls)
	set pfad=/atm_glomod/user/jomuel001/CMIP6_models/
	set mod=$k
	set year=2070-2099
	set year_hist=1985-2014
	set seas=djfm
	set dat=${pfad}${mod}/slp_hpa_${mod}_${year_hist}
	#echo ${mod}
	#echo ${pfad}${mod}
	#tar -xf ${pfad}${mod}/${mod}.tar -C ${pfad}${mod}
	#rm ${pfad}${mod}/${mod}.tar 
	#cdo cat ${pfad}${mod}/psl_day_${mod}_ssp370* ${pfad}${mod}/slp_ssp3_${mod}_.nc
	#cdo divc,100 ${pfad}${mod}/slp_ssp3_${mod}_.nc ${pfad}${mod}/slp_hpa_${mod}_ssp3.nc
	
	
	#cdo selyear,2070/2099 ${pfad}${mod}/slp_hpa_${mod}_ssp3.nc ${pfad}${mod}/slp_hpa_ssp3_${mod}_${year}.nc
	
	#./prepare_data_3.sh ${pfad}${mod}/slp_hpa_ssp3_${mod}_${year} ${seas} ${pfad}${mod}/slp_hpa_${mod}_1985-2014
	
	set dat=${pfad}${mod}/slp_hpa_${mod}_${year_hist}
	
	#cdo remapbil,/atm_glomod/user/jomuel001/CMIP6_models/ERA5/gridERA5.txt ${dat}.N_${seas}_atrbg_aacHrm21.nc ${dat}.N_${seas}_atrbg_aacHrm21_remap.nc
	
	#ncwa -a bnds ${dat}.N_${seas}_atrbg_aacHrm21_remap.nc ${dat}.N_${seas}_atrbg_aacHrm21_remapbnds.nc
	#cdo cat ${pfad}${mod}/slp_hpa_${mod}_1979-2014.N_${seas}_atrbg_aacrm21_remapbnds.nc ${pfad}${mod}/slp_hpa_${mod}_2065-2100.N_${seas}_atrbg_hist_aacrm21_remapbnds.nc ${pfad}${mod}/slp_hpa_${mod}_1979-2021_2065-2100.N_${seas}_atrbg_hist_aacrm21_remapbnds.nc
	#cdo cat ${dat}.N_${seas}_atrbg_aacHrm21_remapbnds.nc 
	echo "alles top"
	mkdir ${pfad}${mod}/AREA${AREA}
	mkdir ${pfad}${mod}/AREA${AREA}/CLUSTER
	mkdir ${pfad}${mod}/AREA${AREA}/EOF
	mkdir ${pfad}${mod}/AREA${AREA}/PLOTS
	mkdir ${pfad}${mod}/AREA${AREA}/CLUSTER/PLOTS
	#rm /CMIP6_models/${mod}/psl_day*
	./auswertung/EOF/Proj_mit_Gebietswahl_sh slp_hpa_${mod}_${year_hist} ${pfad}${mod} ${AREA} _${seas} "_atrbg_aacrm21"
	echo "EOF fertig"
	cd /atm_glomod/user/jomuel001/auswertung/CLUSTER/
	set pfadAREA = "${pfad}${mod}/AREA${AREA}"
	set varAREA = "slp_hpa_${mod}_${year_hist}.N_${seas}_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51985-2014slp_hpa_ERA5_1985-2014_${seas}_atrbg_aacrm21_remapbnds"
	Rscript kmean_eofnc_ATL_PAZ_iera.R "${pfadAREA}" "${varAREA}" "${pfad}ERA5/AREA${AREA}" "${seas}"
	Rscript kmean_eof_dates2tab.R "${pfadAREA}/CLUSTER" "${varAREA}" "${seas}" 2014 1985 #hier rein und Jahre anpassen
	echo "nur noch plotten"
	#exit
	#./plot_nc2gmt.cluster.sh ${pfadAREA}/CLUSTER ${varAREA}
	echo $k "ALLES FERTIG"
	cd /atm_glomod/user/jomuel001
end
echo "hello"
