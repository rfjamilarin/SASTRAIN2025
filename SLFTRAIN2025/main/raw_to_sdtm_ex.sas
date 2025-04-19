data sdtmlib.sdtm_ex;
	set mylib.raw_ex;
	label
	EXTRT = "Name of Treatment"
	EXDOSE = "Dose"
	EXDOSU = "Dose Units"
	EXSTDTC = "Start Date of Treatment"
	EXENDTC = "End Date of Treatment";
	run;