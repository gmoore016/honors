label define vlR0173600   1 "CROSS MALE WHITE"  2 "CROSS MALE WH. POOR"  3 "CROSS MALE BLACK"  4 "CROSS MALE HISPANIC"  5 "CROSS FEMALE WHITE"  6 "CROSS FEMALE WH POOR"  7 "CROSS FEMALE BLACK"  8 "CROSS FEMALE HISPANIC"  9 "SUP MALE WH POOR"  10 "SUP MALE BLACK"  11 "SUP MALE HISPANIC"  12 "SUP FEM WH POOR"  13 "SUP FEMALE BLACK"  14 "SUP FEMALE HISPANIC"  15 "MIL MALE WHITE"  16 "MIL MALE BLACK"  17 "MIL MALE HISPANIC"  18 "MIL FEMALE WHITE"  19 "MIL FEMALE BLACK"  20 "MIL FEMALE HISPANIC"
label values R0173600 vlR0173600
label define vlR0214700   1 "HISPANIC"  2 "BLACK"  3 "NON-BLACK, NON-HISPANIC"
label values R0214700 vlR0214700
label define vlR0214800   1 "MALE"  2 "FEMALE"
label values R0214800 vlR0214800
label define vlR6940103   0 "0"
label values R6940103 vlR6940103
label define vlR6944402   0 "0"
label values R6944402 vlR6944402
label define vlR7006500   0 "0"
label values R7006500 vlR7006500
label define vlR7703700   0 "0"
label values R7703700 vlR7703700
label define vlR8378703   0 "0"
label values R8378703 vlR8378703
label define vlR8379601   0 "0"
label values R8379601 vlR8379601
label define vlR8496100   0 "0"
label values R8496100 vlR8496100
label define vlT0987800   0 "0"
label values T0987800 vlT0987800
label define vlT2142702   0 "0"
label values T2142702 vlT2142702
label define vlT2143900   0 "0"
label values T2143900 vlT2143900
label define vlT2210000   0 "0"
label values T2210000 vlT2210000
label define vlT3107800   0 "0"
label values T3107800 vlT3107800
label define vlT4045802   0 "0"
label values T4045802 vlT4045802
label define vlT4047100   0 "0"
label values T4047100 vlT4047100
label define vlT4112300   0 "0"
label values T4112300 vlT4112300
label define vlT5022600   0 "0"
label values T5022600 vlT5022600
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */
/*
  rename R0000100 CASEID_1979 
  rename R0173600 SAMPLE_ID_1979 
  rename R0214700 SAMPLE_RACE_78SCRN 
  rename R0214800 SAMPLE_SEX_1979 
  rename R6940103 TNFW_TRUNC_2000 
  rename R6944402 RESIDENCE_IMPUTED_TRUNC_2000 
  rename R7006500 TNFI_TRUNC_2000 
  rename R7703700 TNFI_TRUNC_2002 
  rename R8378703 TNFW_TRUNC_2004 
  rename R8379601 RESIDENCE_IMPUTED_TRUNC_2004 
  rename R8496100 TNFI_TRUNC_2004 
  rename T0987800 TNFI_TRUNC_2006 
  rename T2142702 TNFW_TRUNC_2008 
  rename T2143900 RESIDENCE_IMPUTED_TRUNC_2008 
  rename T2210000 TNFI_TRUNC_2008 
  rename T3107800 TNFI_TRUNC_2010 
  rename T4045802 TNFW_TRUNC_2012 
  rename T4047100 RESIDENCE_IMPUTED_TRUNC_2012 
  rename T4112300 TNFI_TRUNC_2012 
  rename T5022600 TNFI_TRUNC_2014 
*/
  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
