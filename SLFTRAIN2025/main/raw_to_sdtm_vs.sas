data sdtmlib.sdtm_vs;
	set mylib.raw_vs;
	label
	VSTESTCD = "Vital Signs Test Short Name"
	VSORRES = "Result or Finding in Original Units"
	VSORRESU = "Original Units"
	VSDTC = "Date of Measurements";
	run;