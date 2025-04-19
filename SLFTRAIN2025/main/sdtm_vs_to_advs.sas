data adamlib.advs;
	set sdtmlib.sdtm_vs(keep=USUBJID VSTESTCD VSORRES VSORRESU VSDTC);
	length PARAM $20 PARAMCD $10 AVAL 4.1 ASDT 8 VSDTC_char VSDTC_char2 $10;
	format ASDT date9.;

	if not missing(VSTESTCD) and not missing (VSORRES) and not missing (VSORRESU) 
		then
			do;

			select(upcase(strip(VSTESTCD)));
				when ('HEIGHT') 
					do;

						if (upcase(strip(VSORRESU)))='CM' then
							AVAL=round(VSORRES * 1, 1);
						else if (upcase(strip(VSORRESU)))='IN' then
							AVAL=round(VSORRES * 2.54, 1);
						else
							AVAL=.;
					end;
				when ('WEIGHT') 
					do;

						if (upcase(strip(VSORRESU)))='KG' then
							AVAL=round(VSORRES * 1, 1);
						else if (upcase(strip(VSORRESU)))='LB' then
							AVAL=round(VSORRES / 2.2, 1);
						else
							AVAL=.;
					end;
				when ('DIABP') 
					do;
						AVAL=VSORRES;
					end;
				when ('SYSBP') 
					do;
						AVAL=VSORRES;
					end;
				when ('PULSE') 
					do;
						AVAL=VSORRES;
					end;
				otherwise AVAL=.;
			end;
		end;
	else
		AVAL=.;
	length PARAM $20 PARAMCD $10;

	if not missing(VSTESTCD) then
		do;

			select(upcase(strip(VSTESTCD)));
				when ('SYSBP') 
					do;
						PARAM='SYSTOLIC BP';
						PARAMCD=VSTESTCD;
					end;
				when ('DIABP') 
					do;
						PARAM='DIASTOLIC BP';
						PARAMCD=VSTESTCD;
					end;
				when ('HEIGHT') 
					do;
						PARAM='HEIGHT';
						PARAMCD=VSTESTCD;
					end;
				when ('WEIGHT') 
					do;
						PARAM='WEIGHT';
						PARAMCD=VSTESTCD;
					end;
				when ('PULSE') 
					do;
						PARAM='PULSE';
						PARAMCD=VSTESTCD;
					end;
				otherwise 
					do;
						PARAM='';
						PARAMCD='';
					end;
			end;
		end;
	else
		do;
			PARAM='';
			PARAMCD='';
		end;
	length ASDT 8 VSDTC_char VSDTC_char2 $10;
	format ASDT date9.;

	if not missing(VSDTC) then
		do;

			if vtype(VSDTC)='N' then
				do;
					VSDTC_char=put(VSDTC, yymmdd10.);
				end;
			else
				do;
					VSDTC_char=VSDTC;
				end;

			if length(VSDTC_char)=10 then
				do;
					VSDTC_char2=substr(VSDTC_char, 1, 10);
				end;
			else
				do;
					VSDTC_char2='';
				end;

			if prxmatch('/^\d{4}-\d{2}-\d{2}$/', VSDTC_char2) then
				do;
					ASDT=input(VSDTC_char2, yymmdd10.);
				end;
		end;
	drop VSTESTCD VSORRES VSORRESU VSDTC VSDTC_char VSDTC_char2;
run;