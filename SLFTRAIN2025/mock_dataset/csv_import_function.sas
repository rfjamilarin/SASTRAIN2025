%let csv_path = /home/u60725963/SLFTRAIN2025/mock_dataset/csv;
%let raw_path = /home/u60725963/SLFTRAIN2025/mock_dataset/raw;

%macro import_domains(lib=, csv_path=, raw_path=);
    /* Set up the library for raw datasets */
    libname &lib "&raw_path";

    %let domains = ae dm ex vs; /* List of domains */

    %do i = 1 %to %sysfunc(countw(&domains));
        %let dom = %scan(&domains, &i);

        /* Import CSV file into a temporary dataset */
        proc import datafile="&csv_path./raw_&dom..csv"
            out=work.raw_&dom._import
            dbms=csv
            replace;
            guessingrows=MAX;
        run;

        /* Save the imported dataset to the specified library */
        data &lib..raw_&dom;
            set work.raw_&dom._import;
        run;
    %end;
%mend;

/* Call the macro with the appropriate paths */
%import_domains(lib=mylib, csv_path=&csv_path, raw_path=&raw_path);
