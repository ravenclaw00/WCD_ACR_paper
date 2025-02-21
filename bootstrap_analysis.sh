#! /bin/tcsh
set pfad=/atm_glomod/user/jomuel001/CMIP6_models/
set pfad_=/AREA.0_360_89.7849_49.3208/CLUSTER

## Startjahr
set start_year_late=2070
## Endjahr
set last_year_late=2099
set seas=mjjaso
set start_year_early=1985
set last_year_early = 2014

#set moduls=(ACCESS-CM2)
#set moduls=(KACE-1-0-G MIROC-ES2L)
set moduls=(ACCESS-CM2 ACCESS-ESM1 CESM2-WACCM CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 GFDL-CM4 GFDL-ESM4 HadGEM3-GC31-LL INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR KACE-1-0-G MIROC6 MIROC-ES2L MPI-ESM1-2-HR MPI-ESM1-2-LR MRI-ESM2-0 NorESM2-MM UKESM1-0-LL)

foreach i ($moduls)
	set mod=$i
	set pfadend=${pfad}${mod}${pfad_}
	#Rscript bootstrap.testcluster.distribution.cmip6.R "${pfadend}" "${start_year}" "${last_year}" "${mid_year}" "${mod}"
	Rscript bootstrap.signifdata.distribution.cmip6.R "${pfadend}" "${start_year_early}" "${last_year_early}" "${start_year_late}" "${last_year_late}" "${mod}" "${seas}" ""
end
