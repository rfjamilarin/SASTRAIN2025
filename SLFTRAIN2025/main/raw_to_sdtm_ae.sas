libname sdtmlib "/home/u60725963/SLFTRAIN2025/mock_dataset/sdtm";

data sdtmlib.sdtm_ae;
	set mylib.raw_ae;
	label 
	AETERM = "Reported Term for the Adverse Event"
	AESTDTC = "Start Date of Adverse Event"
	AEENDTC = "End Date of Adverse Event"
	AESEV = "Severity"
	AEREL = "Causality"
	AEOUT = "Outcome of Adverse Event";
	run;