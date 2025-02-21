#! /bin/tcsh
cd /atm_glomod/user/jomuel001/
#set moduls=(ACCESS-ESM1)
#set moduls_2=(CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 GFDL-CM4 GFDL-ESM4 HadGEM3-GC31-LL INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR MIROC6 MPI-ESM1-2-HR MPI-ESM1-2-LR MRI-ESM2-0 NorESM2-MM UKESM1-0-LL)
#set moduls=(ACCESS-CM2 ACCESS-ESM1 CESM2-WACCM CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 GFDL-CM4 GFDL-ESM4 HadGEM3-GC31-LL INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR MIROC6 MPI-ESM1-2-HR MPI-ESM1-2-LR MRI-ESM2-0 NorESM2-MM UKESM1-0-LL)
#set moduls=(HadGEM3-GC31-LL UKESM1-0-LL)
#set moduls=(NorESM2-MM UKESM1-0-LL)
#set moduls=(r10i1p1f1 r15i1p1f1 r1i1p1f1 r23i1p1f1 r28i1p1f1 r4i1p1f1 r9i1p1f1 r11i1p1f1 r16i1p1f1 r1i2000p1f1 r24i1p1f1 r29i1p1f1 r5i1p1f1 r12i1p1f1 r17i1p1f1 r20i1p1f1 r25i1p1f1 r2i1p1f1 r6i1p1f1 r13i1p1f1 r18i1p1f1 r21i1p1f1 r26i1p1f1 r30i1p1f1 r7i1p1f1 r14i1p1f1 r19i1p1f1 r22i1p1f1 r27i1p1f1 r3i1p1f1 r8i1p1f1)
#set moduls=(r10i1p1f1)

set pfad=/atm_glomod/user/jomuel001/CMIP6_models/
set moduls=(ERA5)

#cdo selyear,1985/2014 ${pfad}${mod}/slp_hpa_${mod}_1979-2014.nc ${pfad}${mod}/slp_hpa_${mod}_${year_early}.nc
set AREA=.0_360_89.7849_39.3203


cd /atm_glomod/user/jomuel001

#set moduls=(ACCESS-ESM1)
#set moduls=(ACCESS-CM2 ACCESS-ESM1 AWI-ESM-1-1-LR CESM2 CESM2-FV2 CESM2-WACCM CESM2-WACCM-FV2 CMCC-CM2-HR4 CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 FGOALS-f3-L GFDL-CM4 GFDL-ESM4 HadGEM3-GC31-LL INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR MIROC6 MPI-ESM-1-2-HAM MPI-ESM1-2-HR MPI-ESM1-2-LR MRI-ESM2-0 NorESM2-MM SAM0-UNICON UKESM1-0-LL)
#

#set moduls=(ACCESS-CM2 ACCESS-ESM1 CESM2-WACCM CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 GFDL-CM4 GFDL-ESM4 HadGEM3-GC31-LL INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR MIROC6 MPI-ESM1-2-HR MPI-ESM1-2-LR MRI-ESM2-0 NorESM2-MM UKESM1-0-LL)

set moduls=(ERA5)
#set moduls=(ACCESS-CM2 ACCESS-ESM1 CESM2-WACCM CNRM-CM6-1 CNRM-CM6-1-HR)
#set moduls=(HadGEM3-GC31-LL UKESM1-0-LL)
#set moduls=(NorESM2-MM UKESM1-0-LL)
#set moduls=(r10i1p1f1 r15i1p1f1 r1i1p1f1 r23i1p1f1 r28i1p1f1 r4i1p1f1 r9i1p1f1 r11i1p1f1 r16i1p1f1 r1i2000p1f1 r24i1p1f1 r29i1p1f1 r5i1p1f1 r12i1p1f1 r17i1p1f1 r20i1p1f1 r25i1p1f1 r2i1p1f1 r6i1p1f1 r13i1p1f1 r18i1p1f1 r21i1p1f1 r26i1p1f1 r30i1p1f1 r7i1p1f1 r14i1p1f1 r19i1p1f1 r22i1p1f1 r27i1p1f1 r3i1p1f1 r8i1p1f1)
#set moduls=(r10i1p1f1)

set AREA=.0_360_89.7849_59.4379
#set AREA=.-90_90_89.7849_29.0866

foreach i ($moduls)
	set pfad=/atm_glomod/user/jomuel001/CMIP6_models/
	set mod=$i
	set year_hist=1985-2014
	#set year_fut=2007-2022
	set seas=mjjaso
	set dat_hist=${pfad}${mod}/slp_hpa_ERA5_${year_hist}
	#set dat_fut=${pfad}${mod}/slp_hpa_ERA5_${year_fut}
	#cdo divc,100 ${pfad}${mod}/slp_ERA5-1_2000-2006.nc ${pfad}${mod}/slp_hpa_ERA51_2000-2006.nc
	#cdo selyear,1979/2022 ${dat_hist}.nc ${pfad}${mod}/slp_hpa_51_ERA5_1979-2022.nc
	#set year_hist=1979-2022
	#cdo selyear,2007/2022 ${pfad}${mod}/slp_hpa_ERA5_1940-2023.nc ${dat_fut}.nc
	#cdo mergetime ${dat_hist}.nc ${pfad}${mod}/slp_hpa_ERA51_2000-2006.nc ${dat_fut}.nc ${pfad}${mod}/slp_hpa_51_ERA5_1940-2022.nc
	set dat_hist=${pfad}${mod}/slp_hpa_ERA5_1985-2014
	#./prepare_data_3.sh ${dat_hist} ${seas} ${dat_hist}
	#cdo setgridtype,regular ${pfad}${mod}/slp_hpa_51_ERA5_1979-2022.N_sond_atrbg_aacrm21.nc ${pfad}${mod}/slp_hpa_51_ERA5_1979-2022.N_sond_atrbg_aacrm21_grid.nc

	#cdo remapbil,/atm_glomod/user/jomuel001/CMIP6_models/ERA5/gridERA5.txt ${dat_hist}.Arctic_${seas}_atrbg_aacrm21.nc ${dat_hist}.Arctic_${seas}_atrbg_aacrm21_remap.nc

	#ncwa -a bnds ${dat_hist}.Arctic_${seas}_atrbg_aacrm21_remap.nc ${dat_hist}.Arctic_${seas}_atrbg_aacrm21_remapbnds.nc
	echo "alles top"
	#./auswertung/EOF/EOF_mit_Gebietswahl_s_t_mode_nc_sh slp_hpa_${mod}_${year_hist} ${seas} 0 360 40 ${pfad}/ERA5/
	mkdir ${pfad}${mod}/AREA${AREA}
	mkdir ${pfad}${mod}/AREA${AREA}/CLUSTER
	mkdir ${pfad}${mod}/AREA${AREA}/EOF
	mkdir ${pfad}${mod}/AREA${AREA}/PLOTS
	mkdir ${pfad}${mod}/AREA${AREA}/CLUSTER/PLOTS
	echo "EOF fertig"
	cd /atm_glomod/user/jomuel001/auswertung/CLUSTER/
	set pfadAREA = "${pfad}${mod}/AREA${AREA}"
	set varAREA = "slp_hpa_${mod}_${year_hist}_${seas}_atrbg_aacrm21_remapbnds"
	Rscript kmean_eofnc_ATL_PAZ_iera.R "${pfadAREA}" "${varAREA}" "${pfad}/ERA5/AREA${AREA}" "${seas}" #hier rein und jahre anpassen
	Rscript kmean_eof_dates2tab.R "${pfadAREA}/CLUSTER" "${varAREA}" "${seas}" 2014 1985 #hier rein und Jahre anpassen
	echo "nur noch plotten"
	./plot_nc2gmt.cluster.sh ${pfadAREA}/CLUSTER ${varAREA}
	echo $i "ALLES FERTIG"
	cd /atm_glomod/user/jomuel001
end
echo "hello"
exit
set AREA=.90_270_89.7849_29.0866


foreach i ($moduls)
	set pfad=/atm_glomod/user/jomuel001/CMIP6_models/
	set mod=$i
	set year_hist=1979-2022
	set year_fut=2070-2099
	set seas=sond
	set dat_hist=${pfad}${mod}/slp_hpa_51_${mod}_${year_hist}
	#cdo divc,100 ${pfad}${mod}/slp_ERA5_1940-2023.nc ${pfad}${mod}/slp_hpa_ERA5_1940-2023.nc
	#cdo selyear,1940/2022 ${pfad}${mod}/slp_hpa_ERA5_1940-2023.nc ${dat_hist}
	#./prepare_data_3.sh ${dat_hist} ${seas} #${dat_hist}
	#cdo remapbil,/atm_glomod/user/jomuel001/CMIP6_models/ERA5/gridERA5.txt ${dat_hist}.N_${seas}_atrbg_aacrm21.nc ${dat_hist}.N_${seas}_atrbg_aacrm21_remap.nc
	#cdo remapbil,/atm_glomod/user/jomuel001/CMIP6_models/ERA5/gridERA5.txt ${dat_hist}.N_${seas}_atrbg_aacrm21_.nc ${dat_hist}.N_${seas}_atrbg_aacrm21_remap.nc
	#ncwa -a bnds ${dat_hist}.N_${seas}_atrbg_aacrm21_remap.nc ${dat_hist}.N_${seas}_atrbg_aacrm21_remapbnds.nc
	echo "alles top"
	./auswertung/EOF/EOF_mit_Gebietswahl_s_t_mode_nc_sh slp_hpa_51_${mod}_${year_hist} ${seas} 90 270 30
	echo "EOF fertig"
	cd /atm_glomod/user/jomuel001/auswertung/CLUSTER/
	set pfadAREA = "${pfad}${mod}/AREA${AREA}"
	set varAREA = "slp_hpa_51_${mod}_${year_hist}_${seas}_atrbg_aacrm21_remapbnds"
	Rscript kmean_eofnc_ATL_PAZ_iera.R "${pfadAREA}" "${varAREA}" "${pfad}/ERA5/AREA${AREA}" "${seas}" #hier rein und ganz klar modell anpassen kein plan warum genau
	
	Rscript kmean_eof_dates2tab.R "${pfadAREA}/CLUSTER" "${varAREA}" "${seas}" 2022 1979 #hier rein und Jahre anpassen
	echo "nur noch plotten"
	./plot_nc2gmt.cluster.sh ${pfadAREA}/CLUSTER ${varAREA}
	echo $i "ALLES FERTIG"
	cd /atm_glomod/user/jomuel001
end

