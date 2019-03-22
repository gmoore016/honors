label define vlR0173600   1 "CROSS MALE WHITE"  2 "CROSS MALE WH. POOR"  3 "CROSS MALE BLACK"  4 "CROSS MALE HISPANIC"  5 "CROSS FEMALE WHITE"  6 "CROSS FEMALE WH POOR"  7 "CROSS FEMALE BLACK"  8 "CROSS FEMALE HISPANIC"  9 "SUP MALE WH POOR"  10 "SUP MALE BLACK"  11 "SUP MALE HISPANIC"  12 "SUP FEM WH POOR"  13 "SUP FEMALE BLACK"  14 "SUP FEMALE HISPANIC"  15 "MIL MALE WHITE"  16 "MIL MALE BLACK"  17 "MIL MALE HISPANIC"  18 "MIL FEMALE WHITE"  19 "MIL FEMALE BLACK"  20 "MIL FEMALE HISPANIC"
label values R0173600 vlR0173600
label define vlR0214700   1 "HISPANIC"  2 "BLACK"  3 "NON-BLACK, NON-HISPANIC"
label values R0214700 vlR0214700
label define vlR0214800   1 "MALE"  2 "FEMALE"
label values R0214800 vlR0214800
label define vlR0410100   0 "0: < 1"  1 "1"  2 "2"  3 "3"  4 "4"  5 "5"  6 "6"  7 "7"  8 "8"  9 "9"  10 "10"  11 "11"  12 "12"  13 "13"  14 "14"  15 "15"  16 "16"
label values R0410100 vlR0410100
label define vlR0410300   55 "55"  56 "56"  57 "57"  58 "58"  59 "59"  60 "60"  61 "61"  62 "62"  63 "63"  64 "64"  65 "65"  66 "66"  67 "67"  68 "68"  69 "69"  70 "70"
label values R0410300 vlR0410300
label define vlR6940103   0 "0"
label values R6940103 vlR6940103
label define vlR6944402   0 "0"
label values R6944402 vlR6944402
label define vlR7006500   0 "0"
label values R7006500 vlR7006500
label define vlR7007100   0 "NONE"  93 "PRE-KINDERGARTEN"  94 "KINDERGARTEN"  1 "1ST GRADE"  2 "2ND GRADE"  3 "3RD GRADE"  4 "4TH GRADE"  5 "5TH GRADE"  6 "6TH GRADE"  7 "7TH GRADE"  8 "8TH GRADE"  9 "9TH GRADE"  10 "10TH GRADE"  11 "11TH GRADE"  12 "12TH GRADE"  13 "1ST YEAR COLLEGE"  14 "2ND YEAR COLLEGE"  15 "3RD YEAR COLLEGE"  16 "4TH YEAR COLLEGE"  17 "5TH YEAR COLLEGE"  18 "6TH YEAR COLLEGE"  19 "7TH YEAR COLLEGE"  20 "8TH YEAR COLLEGE OR MORE"  95 "UNGRADED"
label values R7007100 vlR7007100
label define vlR7616100   0 "0: 0  CONDITION DOES NOT APPLY"  1 "1: 1  CONDITION APPLIES"
label values R7616100 vlR7616100
label define vlR7703700   0 "0"
label values R7703700 vlR7703700
label define vlR8324800   0 "0: 0  CONDITION DOES NOT APPLY"  1 "1: 1  CONDITION APPLIES"
label values R8324800 vlR8324800
label define vlR8378703   0 "0"
label values R8378703 vlR8378703
label define vlR8379601   0 "0"
label values R8379601 vlR8379601
label define vlR8496100   0 "0"
label values R8496100 vlR8496100
label define vlT0919900   0 "0: 0  CONDITION DOES NOT APPLY"  1 "1: 1  CONDITION APPLIES"
label values T0919900 vlT0919900
label define vlT0987800   0 "0"
label values T0987800 vlT0987800
label define vlT2084600   0 "0: 0  CONDITION DOES NOT APPLY"  1 "1: 1  CONDITION APPLIES"
label values T2084600 vlT2084600
label define vlT2142702   0 "0"
label values T2142702 vlT2142702
label define vlT2143900   0 "0"
label values T2143900 vlT2143900
label define vlT2210000   0 "0"
label values T2210000 vlT2210000
label define vlT3055100   0 "0: 0  CONDITION DOES NOT APPLY"  1 "1: 1  CONDITION APPLIES"
label values T3055100 vlT3055100
label define vlT3107800   0 "0"
label values T3107800 vlT3107800
label define vlT3986700   0 "0: 0  CONDITION DOES NOT APPLY"  1 "1: 1  CONDITION APPLIES"
label values T3986700 vlT3986700
label define vlT4045802   0 "0"
label values T4045802 vlT4045802
label define vlT4047100   0 "0"
label values T4047100 vlT4047100
label define vlT4112300   0 "0"
label values T4112300 vlT4112300
label define vlT4924000   0 "0: 0  CONDITION DOES NOT APPLY"  1 "1: 1  CONDITION APPLIES"
label values T4924000 vlT4924000
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
  rename R0410100 Q1_3_A_M_1981   // Q1-3_A~M
  rename R0410300 Q1_3_A_Y_1981   // Q1-3_A~Y
  rename R6917500 Q13_10_2000   // Q13-10
  rename R6940103 TNFW_TRUNC_2000 
  rename R6944402 RESIDENCE_IMPUTED_TRUNC_2000 
  rename R7006500 TNFI_TRUNC_2000 
  rename R7007100 HGC_2000 
  rename R7616100 Q13_10_2002   // Q13-10
  rename R7703700 TNFI_TRUNC_2002 
  rename R8324800 Q13_10_2004   // Q13-10
  rename R8378703 TNFW_TRUNC_2004 
  rename R8379601 RESIDENCE_IMPUTED_TRUNC_2004 
  rename R8496100 TNFI_TRUNC_2004 
  rename T0919900 Q13_10_2006   // Q13-10
  rename T0987800 TNFI_TRUNC_2006 
  rename T2084600 Q13_10_2008   // Q13-10
  rename T2142702 TNFW_TRUNC_2008 
  rename T2143900 RESIDENCE_IMPUTED_TRUNC_2008 
  rename T2210000 TNFI_TRUNC_2008 
  rename T3055100 Q13_10_2010   // Q13-10
  rename T3107800 TNFI_TRUNC_2010 
  rename T3986700 Q13_10_2012   // Q13-10
  rename T4045802 TNFW_TRUNC_2012 
  rename T4047100 RESIDENCE_IMPUTED_TRUNC_2012 
  rename T4112300 TNFI_TRUNC_2012 
  rename T4924000 Q13_10_2014   // Q13-10
  rename T5022600 TNFI_TRUNC_2014 
*/
  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
