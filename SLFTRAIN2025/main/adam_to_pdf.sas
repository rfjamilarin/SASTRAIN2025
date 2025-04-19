ods pdf file="/home/u60725963/SLFTRAIN2025/mock_dataset/pdf/adae.pdf" style=journal;
	proc print data=adamlib.adae label noobs;
	var USUBJID AETERM ASTDT ASTDTF AENDT AENDTF ADURN ADURU AESEVN AERELN;
	title ADAE;
	run;
ods pdf close;

ods pdf file="/home/u60725963/SLFTRAIN2025/mock_dataset/pdf/adsl.pdf" style=journal;
	proc print data=adamlib.adsl label noobs;
	var USUBJID SUBJID AGE AGEGR SEX RACE ARM TRTA DOSEA TRTSDT TRTEDT;
	title ADSL;
	run;
ods pdf close;

ods pdf file="/home/u60725963/SLFTRAIN2025/mock_dataset/pdf/advs.pdf" style=journal;
	proc print data=adamlib.advs label noobs;
	var USUBJID PARAM PARAMCD AVAL ASDT;
	title ADVS;
	run;
ods pdf close;