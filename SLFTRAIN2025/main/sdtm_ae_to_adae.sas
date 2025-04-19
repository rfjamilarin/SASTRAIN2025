libname adamlib "/home/u60725963/SLFTRAIN2025/mock_dataset/adam";

data adamlib.adae (drop=ASTDTC_char ASTDTC_full AENDTC_char AENDTC_full AEOUT AESTDTC 
		AEENDTC AESEV AEREL);
	retain USUBJID AETERM ASTDT ASTDTF AENDT AENDTF ADURN ADURU AESEVN AERELN;
	set sdtmlib.sdtm_ae;

	if not missing (AETERM) then
		AETERM=upcase(AETERM);
	length ASTDT 8 ASTDTC_full $10 ASTDTF $1;
	format ASTDT date9.;

	/* Display as e.g., 02JAN2023 */
	if not missing(AESTDTC) then
		do;

			/* If AESTDTC is numeric (e.g., 20230102), convert to string */
			if vtype(AESTDTC)='N' then
				do;
					ASTDTC_char=put(AESTDTC, yymmdd10.);
				end;
			else
				do;
					ASTDTC_char=AESTDTC;
				end;

			/* Imputation for partial dates */
			if length(ASTDTC_char)=7 then
				do;
					ASTDTC_full=cats(ASTDTC_char, "-01");
					ASTDTF="D";
				end;
			else if length(ASTDTC_char)=4 then
				do;
					ASTDTC_full=cats(ASTDTC_char, "-01-01");
					ASTDTF="M";
				end;
			else
				do;
					ASTDTC_full=substr(ASTDTC_char, 1, 10);
					ASTDTF="";
				end;

			/* Convert ISO8601 string to SAS numeric date */
			if prxmatch('/^\d{4}-\d{2}-\d{2}$/', ASTDTC_full) then
				do;

					/*Checks if ASTDTC_full matches the exact pattern of
					a full ISO date string before converting into numeric data*/
					ASTDT=input(ASTDTC_full, yymmdd10.);
				end;
		end;
	length AENDT 8 AENDTC_full $10 AENDTF $1;
	format AENDT date9.;

	if not missing(AEENDTC) then
		do;

			if vtype(AEENDTC)='N' then
				do;
					AENDTC_char=put(AEENDTC, yymmdd10.);
				end;
			else
				do;
					AENDTC_char=AEENDTC;
				end;

			if length(AENDTC_char)=7 then
				do;
					AENDTC_full=cats(AENDTC_char, "-01");
					AENDTF="D";
				end;
			else if length(AENDTC_char)=4 then
				do;
					AENDTC_full=cats(AENDTC_char, "-01-15");
					AENDTF="M";
				end;
			else
				do;
					AENDTC_full=substr(AENDTC_char, 1, 10);
					AENDTF="";
				end;

			if prxmatch('/^\d{4}-\d{2}-\d{2}$/', AENDTC_full) then
				do;
					AENDT=input(AENDTC_full, yymmdd10.);
				end;
		end;
	length ADURN 8;

	if not missing(ASTDT) and not missing (AENDT) then
		do;
			ADURN=AENDT - ASTDT + 1;
		end;
	length ADURU $10;

	if not missing (ADURN) then
		do;
			ADURU="DAY";
		end;
	length AESEVN 8;

	select (upcase(AESEV));
		when ('MILD') AESEVN=1;
		when ('MODERATE') AESEVN=2;
		when ('SEVERE') AESEVN=3;
	end;
	length AERELN 8;

	select (upcase(AEREL));
		when ('RELATED') AERELN=1;
		when ('UNRELATED') AERELN=2;
	end;
run;