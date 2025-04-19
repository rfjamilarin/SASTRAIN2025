data sdtmlib.sdtm_dm;
	set mylib.raw_dm;
	label
	SUBJID = "Subject Identifier"
	SITEID = "Study Site Identifier"
	AGE = "Age"
	AGEU = "Age Units"
	SEX = "Sex"
	RACE = "Race"
	ARM = "Description of Planned Arm";
	run;