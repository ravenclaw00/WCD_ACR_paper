#! /bin/tcsh

#set moduls=g(r10i1p1f1 r15i1p1f1 r1i1p1f1 r23i1p1f1 r28i1p1f1 r4i1p1f1 r9i1p1f1 r11i1p1f1 r16i1p1f1 r1i2000p1f1 r24i1p1f1 r29i1p1f1 r5i1p1f1 r12i1p1f1 r17i1p1f1 r20i1p1f1 r25i1p1f1 r2i1p1f1 r6i1p1f1 r13i1p1f1 r18i1p1f1 r21i1p1f1 r26i1p1f1 r30i1p1f1 r7i1p1f1 r14i1p1f1 r19i1p1f1 r22i1p1f1 r27i1p1f1 r3i1p1f1 r8i1p1f1)
#set moduls=(ACCESS-CM2 ACCESS-ESM1 CESM2-WACCM CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 GFDL-CM4 GFDL-ESM4 HadGEM3-GC31-LL INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR MIROC6 MPI-ESM1-2-HR MPI-ESM1-2-LR MRI-ESM2-0 NorESM2-MM UKESM1-0-LL MULTIMODEL-hist)
#set moduls=(ACCESS-CM2 ACCESS-ESM1 CESM2-WACCM CNRM-CM6-1 CNRM-CM6-1-HR CNRM-ESM2-1 GFDL-ESM4 INM-CM4-8 INM-CM5-0 IPSL-CM6A-LR MIROC6 MPI-ESM1-2-LR MRI-ESM2-0 UKESM1-0-LL)
#set moduls=(CESM2-WACCM)
set moduls=(ERA5)
#set moduls=(MIROC6)
foreach i ($moduls)
	set mod=$i
	set area="0_360"
	set seas="mjjaso"
	set years="1985-2014"
	#echo ${scan[$k]}
	
	set cluster="CL1"
	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	set cluster="CL2"
	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	set cluster="CL3"
	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	set cluster="CL4"
	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	set cluster="CL5"
	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	#set cluster="CL6"
	#Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	cd /atm_glomod/user/jomuel001
#	set cluster="CL6"#
#	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
#	cd /atm_glomod/user/jomuel001	
exit
	set area="90_270"
	set cluster="Clusternumber-1"
	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	set cluster="Clusternumber-2"
	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	set cluster="Clusternumber-3"
	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	set cluster="Clusternumber-4"
	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	set cluster="Clusternumber-5"
	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years} 
	cd /atm_glomod/user/jomuel001
	echo "ok"
end


#foreach i ($moduls)
#	set mod=$i
#	set area="-90_90"
#	set seas="djfm"
#	set cluster="SCANURALBlock"
#	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R $#{mod} ${cluster} ${area} ${seas} ${years}
#	set cluster="NAOMinus"
#	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years}
#	set cluster="AtlanticTrough"
#	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years}
#	set cluster="NAOPlus"
#	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${#mod} ${cluster} ${area} ${seas} ${years}
#	set cluster="DipolATLBlock"
#	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${#mod} ${cluster} ${area} ${seas} ${years}
#	
#	set area="90_270"
#	set cluster="PacificTrough"
#	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${#mod} ${cluster} ${area} ${seas} ${years}
#	set cluster="PacificWavetrain"
#	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${#mod} ${cluster} ${area} ${seas} ${years}
#	set cluster="AlaskanRidge"
#	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${#mod} ${cluster} ${area} ${seas} ${years}
#	set cluster="ArcticLow"
##	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${mod} ${cluster} ${area} ${seas} ${years}
#	set cluster="ArcticHigh"
#	Rscript /atm_glomod/user/jomuel001/auswertung/TAYLOR/taylor_cluster.historical.select.R ${#mod} ${cluster} ${area} ${seas} ${years}
#	cd /atm_glomod/user/jomuel001
#end
#

