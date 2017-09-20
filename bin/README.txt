=======================================
README for the Differential GPS toolkit 
=======================================

developed by Steven Bernsen
University of Maine

-------------------------------------------------------------------------------
This toolkit can be run from the command line to process differential GPS data.
The data must be in a RINEX format so convert Trimble format first. I used 
ConvertToRINEX which is a Windows dependent program that can be downloaded from
the UNAVCO website. That step is standalone but all others can be automated. To
run the program ????? all base station data needs to be in a 'BASE' folder and 
all rover data needs to be in a 'ROVER' folder. Base station height needs to be
in a 'base_height.csv' file. In order to run the program there are certain 
software dependencies. They are 

	teqc - Download from UNAVCO (ubuntu users need x86_64 dynamically 
		linked for CentOS
	RTKLIB - All CUIs need to be compiled 
	R - download from cran.org with installed library(ies): 
			lubridate, 

**CSV file notes 
	- All dates should be in YYYY/MM/DD
	- Base station height is in meters
	- RINEX headers have GMT time zone

The process is as follows:

1. Put metadata for each file in a csv
		appendMeta.r
		getRINEXmeta.bsh

2. Pair base station with rover
		compareBaseRover.r 

3. Modify config file for base station height
		appendHeight.r
		FileHeight.r
		modifyHeight.bsh		


4. Compute dgps


========
ROUTINES
========

##### ------------------------ getRINEXmeta.bsh ------------------------- #####
This program summons the meta data from all of the RINEX files in a folder and 
stores it in a table. Trimble .t01 formatted files must be converted using 
ConvertToRinex (see the Trimble website for details) which must be run in 
Windows. .YYo and .YYn files will be generated with ConvertToRinex, however,
the *.YYn won't return anything. 



===========
SUBROUTINES
===========

##### -------------------------- appendMeta.r --------------------------- #####
This program moves meta data information to a table to make things easier when
processing in RTK. Antenna height must be added before processing 


##### ------------------------------------------------------------------- #####



##### ------------------------------------------------------------------- #####
