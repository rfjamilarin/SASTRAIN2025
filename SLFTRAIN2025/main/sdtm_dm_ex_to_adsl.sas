data adamlib.adsl (keep=USUBJID SUBJID AGE AGEGR SEX RACE ARM TRTA DOSEA TRTSDT TRTEDT);
	merge sdtmlib.sdtm_dm(keep=USUBJID SUBJID AGE AGEU SEX RACE ARM in=dm) 
		sdtmlib.sdtm_ex(keep=USUBJID EXTRT EXDOSE EXDOSU EXSTDTC EXENDTC in=ex);
	by USUBJID;

	if ex;

	if not missing(AGE) and not missing (AGEU) then
		do;

			select(upcase(strip(AGEU)));
				when ('Y') AGE=AGE;
				when ('M') AGE=round(AGE / 12, 1);
				otherwise AGE=.;
			end;
		end;
	else
		AGE=.;
	length AGEGR $10;

	if not missing(AGE) then
		do;

			select;
				when (AGE < 18) AGEGR='Below 18';
				when (18 <=AGE and AGE <=64) AGEGR='18 to 64';
				when (AGE > 64) AGEGR='Over 64';
				otherwise AGEGR='';
			end;
		end;
	else
		AGEGR='';

	if not missing (ARM) then
		ARM=upcase(ARM);

	if not missing (EXTRT) then
		do;
			TRTA=upcase(EXTRT);
		end;
	length DOSEA 8;

	if not missing(EXDOSE) and not missing (EXDOSU) then
		do;

			select(upcase(strip(EXDOSU)));
				when ('MG') DOSEA=EXDOSE;
				when ('G') DOSEA=ROUND (EXDOSE * 1000, 1);
			end;
		end;
	else
		DOSEA='';
	length TRTSDT 8 EXSTDTC_char EXSTDTC_char2 $10;
	format TRTSDT date9.;

	if not missing(EXSTDTC) then
		do;

			if vtype(EXSTDTC)='N' then
				do;
					EXSTDTC_char=put(EXSTDTC, yymmdd10.);
				end;
			else
				do;
					EXSTDTC_char=EXSTDTC;
				end;

			if length(EXSTDTC_char)=10 then
				do;
					EXSTDTC_char2=substr(EXSTDTC_char, 1, 10);
				end;
			else
				do;
					EXSTDTC_char2='';
				end;

			if prxmatch('/^\d{4}-\d{2}-\d{2}$/', EXSTDTC_char2) then
				do;
					TRTSDT=input(EXSTDTC_char2, yymmdd10.);
				end;
		end;
	length TRTEDT 8 EXENDTC_char EXENDTC_char2 $10;
	format TRTEDT date9.;

	if not missing(EXENDTC) then
		do;

			if vtype(EXENDTC)='N' then
				do;
					EXENDTC_char=put(EXENDTC, yymmdd10.);
				end;
			else
				do;
					EXENDTC_char=EXENDTC;
				end;

			if length(EXENDTC_char)=10 then
				do;
					EXENDTC_char2=substr(EXENDTC_char, 1, 10);
				end;
			else
				do;
					EXENDTC_char2='';
				end;

			if prxmatch('/^\d{4}-\d{2}-\d{2}$/', EXENDTC_char2) then
				do;
					TRTEDT=input(EXENDTC_char2, yymmdd10.);
				end;
		end;
run;