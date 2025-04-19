ods pdf file="/home/u60725963/SLFTRAIN2025/mock_dataset/pdf/ae_listing.pdf" style=journal;
	proc print data=sdtmlib.sdtm_ae label noobs;
	var USUBJID AETERM AESEV AEREL AEOUT AESTDTC AEENDTC;
	title Demographics;
	run;
ods pdf close;

ods pdf file="/home/u60725963/SLFTRAIN2025/mock_dataset/pdf/dm_listing.pdf" style=journal;
	proc print data=sdtmlib.sdtm_dm label noobs;
	var USUBJID SUBJID SITEID AGE AGEU SEX RACE ARM;
	title Demographics;
	run;
ods pdf close;

ods pdf file="/home/u60725963/SLFTRAIN2025/mock_dataset/pdf/ex_listing.pdf" style=journal;
	proc print data=sdtmlib.sdtm_ex label noobs;
	var USUBJID EXTRT EXDOSE EXDOSU EXSTDTC EXENDTC;
	title Exposure;
	run;
ods pdf close;

ods pdf file="/home/u60725963/SLFTRAIN2025/mock_dataset/pdf/vs_listing.pdf" style=journal;
	proc print data=sdtmlib.sdtm_vs label noobs;
	var USUBJID VSTESTCD VSORRES VSORRESU VSDTC;
	title Vital Signs;
	run;
ods pdf close;