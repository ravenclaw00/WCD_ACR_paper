#! /bin/tcsh
cd /atm_glomod/user/jomuel001/
# als erstes ACCESS-CM2 into multimodelmean machen
#set moduls=(ACCESS-CM2 ACCESS-ESM1 CESM2-WACCM CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 GFDL-ESM4 INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR MIROC6 MPI-ESM1-2-LR MRI-ESM2-0 UKESM1-0-LL)

set moduls=(ACCESS-CM2 ACCESS-ESM1 CESM2-WACCM CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 GFDL-CM4 GFDL-ESM4 HadGEM3-GC31-LL INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR KACE-1-0-G MIROC6 MIROC-ES2L MPI-ESM1-2-LR MRI-ESM2-0 NorESM2-MM UKESM1-0-LL)
#${pfad}GFDL-CM4${anfang}GFDL-CM4${ende} ${pfad}HadGEM3-GC31-LL${anfang}HadGEM3-GC31-LL${ende} 
#${pfad}MPI-ESM1-2-HR${anfang}MPI-ESM1-2-HR${ende} ${pfad}NorESM2-MM${anfang}NorESM2-MM${ende}

set AREA=.0_360_89.7849_59.4379
set pfad=/atm_glomod/user/jomuel001/CMIP6_models/
set mmm=MULTIMODEL-hist
set anfang=/slp_hpa_
set ende=_1985-2014.Nord_mjjaso_atrbg_aacrm21_remapbnds.nc
set year=1985-2014
set seas=mjjaso
#cdo mergetime ${pfad}ACCESS-CM2${anfang}ACCESS-CM2${ende} ${pfad}ACCESS-ESM1${anfang}ACCESS-ESM1${ende} ${pfad}CESM2-WACCM${anfang}CESM2-WACCM${ende} ${pfad}CNRM-CM6-1${anfang}CNRM-CM6-1${ende} ${pfad}CNRM-CM6-1-HR${anfang}CNRM-CM6-1-HR${ende} ${pfad}CNRM-ESM2-1${anfang}CNRM-ESM2-1${ende} ${pfad}GFDL-CM4${anfang}GFDL-CM4${ende} ${pfad}GFDL-ESM4${anfang}GFDL-ESM4${ende} ${pfad}HadGEM3-GC31-LL${anfang}HadGEM3-GC31-LL${ende} ${pfad}INM-CM4-8${anfang}INM-CM4-8${ende} ${pfad}INM-CM5-0${anfang}INM-CM5-0${ende} ${pfad}IPSL-CM6A-LR${anfang}IPSL-CM6A-LR${ende} ${pfad}KACE-1-0-G${anfang}KACE-1-0-G${ende} ${pfad}MIROC6${anfang}MIROC6${ende} ${pfad}MIROC-ES2L${anfang}MIROC-ES2L${ende} ${pfad}MPI-ESM1-2-HR${anfang}MPI-ESM1-2-HR${ende} ${pfad}MPI-ESM1-2-LR${anfang}MPI-ESM1-2-LR${ende} ${pfad}MRI-ESM2-0${anfang}MRI-ESM2-0${ende} ${pfad}NorESM2-MM${anfang}NorESM2-MM${ende} ${pfad}UKESM1-0-LL${anfang}UKESM1-0-LL${ende} ${pfad}${mmm}${anfang}${mmm}${ende}

mkdir ${pfad}${mmm}/AREA${AREA}
mkdir ${pfad}${mmm}/AREA${AREA}/CLUSTER
mkdir ${pfad}${mmm}/AREA${AREA}/EOF
mkdir ${pfad}${mmm}/AREA${AREA}/PLOTS
mkdir ${pfad}${mmm}/AREA${AREA}/CLUSTER/PLOTS
#./auswertung/EOF/Proj_mit_Gebietswahl_sh slp_hpa_${mmm}_${year} ${pfad}${mmm} ${AREA} _${seas} "_atrbg_aacrm21"
#exit
cd /atm_glomod/user/jomuel001/auswertung/CLUSTER/
set pfadAREA = "${pfad}${mmm}/AREA${AREA}"
set varAREA = "slp_hpa_${mmm}_${year}.Nord_${seas}_atrbg_aacrm21_remapbnds_proj_on_EOF_ERA51985-2014slp_hpa_ERA5_1985-2014_${seas}_atrbg_aacrm21_remapbnds"
Rscript kmean_eofnc_ATL_PAZ_iera.R "${pfadAREA}" "${varAREA}" "${pfad}/ERA5/AREA${AREA}" "${seas}"
Rscript kmean_eof_dates2tab.R "${pfadAREA}/CLUSTER" "${varAREA}" "${seas}" 2099 1530 #hier rein und
./plot_nc2gmt.cluster.sh ${pfadAREA}/CLUSTER ${varAREA}
