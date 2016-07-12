



990 RETURN

   HEADER DATA
   RETURN DATA
   
      REVENUES
      EXPENSES
      GOVERNANCE
      
        BOARD MEMBERS
      
      REVENUE CATEGORIES
      FUNCTIONAL EXPENSES
      
      SCHEDULES
      
        A
        B
        D
        M
        O
        
END 990 RETURN















# Create List of Core PC Variables

library( foreign )

setwd("C:/Users/jdlecy/Dropbox/04 - PAPERS/01 - In Progress/05 - Nonprofit Growth/Data and Analysis/Data")

dat <- read.spss( "Core 2010 PC.sav",  to.data.frame=FALSE )

> names( dat )

#####  BASIC INFO  #####

  [1] "EIN"     
  [2] "NCCSKEY"    xxxx
  [3] "FISYR"   
  [4] "NAME"    
  [5] "STATE"   
  [6] "NTEE1"      xxxx
  [7] "NTEECC"     xxxx
  [8] "ADDRESS" 
  [9] "CITY"    
 [10] "ZIP"     
 [11] "ZIP5"    
 [12] "FIPS"       xxxx
 [13] "MSA_NECH"   xxxx
 [14] "PMSA"       xxxx
 [15] "STYEAR"  
 [16] "TAXPER"  
 [17] "OUTNCCS"    xxxx
 [18] "OUTREAS"    xxxx
 
#####  CLASSIFICATION  #####

 [19] "SUBSECCD"   xxxx
 [20] "NTMAJ5"     xxxx
 [21] "NTMAJ10"    xxxx
 [22] "NTMAJ12"    xxxx
 [23] "MAJGRPB"    xxxx
 [24] "NTEECONF"   xxxx
 [25] "ACTIV1"     xxxx
 [26] "ACTIV2"     xxxx
 [27] "ACTIV3"     xxxx
 [28] "LEVEL2"     xxxx

#####  REV, EXP & CHANGE IN ASSETS  #####

 [29] "CONT"      
 [30] "PROGREV" 
 [31] "DUES"    
 [32] "INVINC"  
 [33] "SAVINT"  
 [34] "SECINC"  
 [35] "RENTINC" 
 [36] "RENTEXP" 
 [37] "NETRENT" 
 [38] "OTHINVST"
 [39] "SECUR"   
 [40] "SALESEXP"
 [41] "SALESECN"
 [42] "SALEOTHG"
 [43] "SALEOTHE"
 [44] "SALEOTHN"
 [45] "SPEVTG"  
 [46] "DIREXP"  
 [47] "FUNDINC" 
 [48] "INVENTG" 
 [49] "GOODS"   
 [50] "GRPROF"  
 [51] "OTHINC"  
 [52] "TOTREV2" 
 [53] "TOTREV"  
 [54] "GRREC"   
 [55] "SOLICIT" 
 [56] "EXPS"    
 [57] "NETINC"  
 [58] "OTHCHGS" 
 [59] "FUNDBAL" 
 [60] "COMPENS" 
 [61] "OTHSAL"  
 [62] "PAYTAX"  
 [63] "FUNDFEES"

#####  BALANCE SHEET  #####

 [64] "ASS_BOY" 
 [65] "ASS_EOY" 
 [66] "BOND_BOY"
 [67] "BOND_EOY"
 [68] "MRTG_BOY"
 [69] "MRTG_EOY"
 [70] "LIAB_BOY"
 [71] "LIAB_EOY"
 [72] "RETE_BOY"
 [73] "RETEARN" 
 [74] "NETA_BOY"
 
#####  OTHER INFORMATION  #####

 [75] "Q78A"    
 [76] "POLPURP" 
 [77] "INITFEES"
 [78] "GRRECPUB"
 [79] "GRRECMEM"
 [80] "GRRECOTH"
 
#####  SCHEDULE A  #####

 [81] "REASON"  
 [82] "LEGEXP"  
 [83] "CONT4"   
 [84] "DUES4"   
 [85] "GRREC4"  
 [86] "INVINC4" 
 [87] "TAXREV4" 
 [88] "GVTSRV4" 
 [89] "OTHINC4" 
 [90] "INCPURP4"
 [91] "GRROOT"  
 [92] "INFLEXP" 
 [93] "TOTLOB"  
 [94] "LOBOTH"  
 [95] "LOBNOTAX"
 [96] "GRTNONTX"
 [97] "EXGRROOT"
 [98] "EXLOBEXP"
 
#####  OTHER DESCRIPTIVE INFO  #####

 [99] "RULEDATE"
[100] "FNDNCD"  
[101] "FRCD"    
[102] "AFCD"    
[103] "ARED"    
[104] "CONTACT" 
[105] "SEC_NAME"
[106] "GEN"     

#####  OTHER CLASSIFICATION  #####

[107] "LEVEL1"  
[108] "LEVEL3"  
[109] "LEVEL4"  
[110] "CLASSCD" 
[111] "DEDUCTCD"
[112] "NTEEIRS" 
[113] "NAICS"   
[114] "ORGCD"  

#####  MISCELLANEOUS  #####

[115] "NCCSKEY2"
[116] "DLN"     
[117] "VERIFY"  
[118] "DOCCD"   
[119] "ACCPER"  
[120] "LONGITUD"
[121] "RANDNUM" 
[122] "LATITUDE"
[123] "SOIYR"   

#####  SUPPLEMENTAL FIELDS  #####

[124] "NUMEMPES"
[125] "NUMEMPCO"
[126] "NUMEMPYR"
[127] "DIRSUPES"
[128] "DIRSUPCO"
[129] "DIRSUPYR"
[130] "INDSUPES"
[131] "INDSUPCO"
[132] "INDSUPYR"
[133] "PAYAFFLE"
[134] "PAYAFFLC"
[135] "PAYAFFLY"
[136] "UNASEOYE"
[137] "UNASEOYC"
[138] "UNASEOYY"
[139] "INVOTHES"
[140] "INVOTHCO"
[141] "INVOTHYR"
[142] "OTHASSTE"
[143] "OTHASSTC"
[144] "OTHASSTY"
[145] "INVSECES"
[146] "INVSECCO"
[147] "INVSECYR"
[148] "CASHESTI"
[149] "CASHCODE"
[150] "CASHYR"  
[151] "NETLANDE"
[152] "NETLANDC"
[153] "NETLANDY"
[154] "LBEBOYES"
[155] "LBEBOYCO"
[156] "LBEBOYYR"
[157] "PERMRNAE"
[158] "PERMRNAC"
[159] "PERMRNAY"
[160] "TEMPRNAE"
[161] "TEMPRNAC"
[162] "TEMPRNAY"
[163] "GOVGTCOD"
[164] "GOVGTYR" 
[165] "PENSIONE"
[166] "EMPBENES"
[167] "SUPPLYES"
[168] "COMMESTI"
[169] "PROFFEES"
[170] "OCCUESTI"
[171] "INTEREST"
[172] "DEPRECES"
[173] "OTHEXPES"
[174] "GRANTEST"
[175] "BENMEMES"
[176] "COMPOTHE"
[177] "ASSINDES"
[178] "ADMINEXP"
[179] "PROGEXPC"
[180] "PROGEXPY"
[181] "ADMINEX1"
[182] "ADMINEX2"







dat <- read_xml( "https://s3.amazonaws.com/irs-form-990/201541349349307794_public.xml" )
xml_ns_strip( dat )

# NAMES OF FIELDS

dat %>% xml_find_all( '//*') %>% xml_name()

# FULL PATH FOR EASY REFERENCE WHEN NODES ARE NON-UNIQUE

dat %>% xml_find_all( '//*') %>% xml_path()











> dat %>% xml_find_all( '//*') %>% xml_path()

############       MODULE 0 - RETURN TYPE         ############# 

RETURNTYPE <- xml_text( xml_find_all( dat, "//Return/ReturnHeader/ReturnTypeCd" ) ) 
 

############          MODULE 1 - BASIC INFO            ################

  [1] "/Return"                                                                                               
  [2] "/Return/ReturnHeader"    
  
  
  [3] "/Return/ReturnHeader/ReturnTs"                                                                         
  [4] "/Return/ReturnHeader/TaxPeriodEndDt"     
 
 [14] "/Return/ReturnHeader/ReturnTypeCd"                                                                     
 [15] "/Return/ReturnHeader/TaxPeriodBeginDt"                                                                 
 [16] "/Return/ReturnHeader/Filer"                                                                            
 [17] "/Return/ReturnHeader/Filer/EIN"                                                                        
 [18] "/Return/ReturnHeader/Filer/BusinessName"                                                               
 [19] "/Return/ReturnHeader/Filer/BusinessName/BusinessNameLine1Txt"                                          
 [20] "/Return/ReturnHeader/Filer/BusinessNameControlTxt"                                                     
 [21] "/Return/ReturnHeader/Filer/PhoneNum"                                                                   
 [22] "/Return/ReturnHeader/Filer/USAddress"                                                                  
 [23] "/Return/ReturnHeader/Filer/USAddress/AddressLine1Txt"                                                  
 [24] "/Return/ReturnHeader/Filer/USAddress/CityNm"                                                           
 [25] "/Return/ReturnHeader/Filer/USAddress/StateAbbreviationCd"                                              
 [26] "/Return/ReturnHeader/Filer/USAddress/ZIPCd" 
 
 [37] "/Return/ReturnHeader/TaxYr"                                                                            
 [38] "/Return/ReturnHeader/BuildTS" 
 
 
 ### BASIC INFO
 
  [47] "/Return/ReturnData/IRS990/GrossReceiptsAmt"                                                            
  [48] "/Return/ReturnData/IRS990/GroupReturnForAffiliatesInd"                                                 
  [49] "/Return/ReturnData/IRS990/Organization501c3Ind"                                                        
  [50] "/Return/ReturnData/IRS990/WebsiteAddressTxt"   
  [51] "/Return/ReturnData/IRS990/TypeOfOrganizationCorpInd"                                                   
  [52] "/Return/ReturnData/IRS990/FormationYr"                                                                 
  [53] "/Return/ReturnData/IRS990/LegalDomicileStateCd"
 
 
### ACTIVITIES AND GOVERNANCE - FROM PART I
 
 [55] "/Return/ReturnData/IRS990/VotingMembersGoverningBodyCnt"                                               
 [56] "/Return/ReturnData/IRS990/VotingMembersIndependentCnt"                                                 
 [57] "/Return/ReturnData/IRS990/TotalEmployeeCnt"                                                            
 [58] "/Return/ReturnData/IRS990/TotalVolunteersCnt"                                                          
 [59] "/Return/ReturnData/IRS990/TotalGrossUBIAmt"                                                            
 [60] "/Return/ReturnData/IRS990/NetUnrelatedBusTxblIncmAmt" 
 

 

 
 
########## PART II - SIGNATURE BLOCK  (plus external tax preparation fields from above)

 [27] "/Return/ReturnHeader/BusinessOfficerGrp"                                                               
 [28] "/Return/ReturnHeader/BusinessOfficerGrp/PersonNm"                                                      
 [29] "/Return/ReturnHeader/BusinessOfficerGrp/PersonTitleTxt"                                                
 [30] "/Return/ReturnHeader/BusinessOfficerGrp/PhoneNum"                                                      
 [31] "/Return/ReturnHeader/BusinessOfficerGrp/SignatureDt"                                                   
 [32] "/Return/ReturnHeader/BusinessOfficerGrp/DiscussWithPaidPreparerInd" 
 
 
 [33] "/Return/ReturnHeader/PreparerPersonGrp"                                                                
 [34] "/Return/ReturnHeader/PreparerPersonGrp/PreparerPersonNm"                                               
 [35] "/Return/ReturnHeader/PreparerPersonGrp/PTIN"                                                           
 [36] "/Return/ReturnHeader/PreparerPersonGrp/PhoneNum"  

  [5] "/Return/ReturnHeader/PreparerFirmGrp"                                                                  
  [6] "/Return/ReturnHeader/PreparerFirmGrp/PreparerFirmEIN"                                                  
  [7] "/Return/ReturnHeader/PreparerFirmGrp/PreparerFirmName"                                                 
  [8] "/Return/ReturnHeader/PreparerFirmGrp/PreparerFirmName/BusinessNameLine1Txt"                            
  [9] "/Return/ReturnHeader/PreparerFirmGrp/PreparerUSAddress"                                                
 [10] "/Return/ReturnHeader/PreparerFirmGrp/PreparerUSAddress/AddressLine1Txt"                                
 [11] "/Return/ReturnHeader/PreparerFirmGrp/PreparerUSAddress/CityNm"                                         
 [12] "/Return/ReturnHeader/PreparerFirmGrp/PreparerUSAddress/StateAbbreviationCd"                            
 [13] "/Return/ReturnHeader/PreparerFirmGrp/PreparerUSAddress/ZIPCd" 

  

 
 


 
EIN  <- xml_text( xml_find_all( dat, "//Return/ReturnHeader/Filer/EIN" ) )
FISYR <- xml_text( xml_find_all( dat, "/Return/ReturnHeader/TaxYr" ) ) 
NAME <- xml_text( xml_find_all( dat, "//Return/ReturnHeader/Filer/BusinessName/BusinessNameLine1Txt" ) )
STATE  <- xml_text( xml_find_all( dat, "//Return/ReturnHeader/Filer/USAddress/StateAbbreviationCd" ) 
ADDRESS <- xml_text( xml_find_all( dat, "//Return/ReturnHeader/Filer/USAddress/AddressLine1Txt" ) )
CITY  <- xml_text( xml_find_all( dat, "//Return/ReturnHeader/Filer/USAddress/CityNm" ) )
ZIP  <- xml_text( xml_find_all( dat, "//Return/ReturnHeader/Filer/USAddress/ZIPCd" ) )
STYEAR  <- xml_text( xml_find_all( dat, "/Return/ReturnHeader/TaxPeriodBeginDt" ) )
TAXPER <- xml_text( xml_find_all( dat, "/Return/ReturnHeader/TaxPeriodEndDt"  ) )

# extra fields added
TaxPrep <- xml_text( xml_find_all( dat, "//Return/ReturnHeader/BusinessOfficerGrp/DiscussWithPaidPreparerInd" ) ) 
ReturnType <- xml_text( xml_find_all( dat, "//Return/ReturnHeader/ReturnTypeCd" ) ) 

# basic info
GrossReceipts <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/GrossReceiptsAmt" ) ) 
GroupReturn <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/GroupReturnForAffiliatesInd" ) ) 
TaxExmStatus <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/Organization501c3Ind" ) ) 
TypeOfOrg <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/TypeOfOrganizationCorpInd" ) ) 
FormYear <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/FormationYr" ) ) 
Domicile <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/LegalDomicileStateCd" ) ) 
Website <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/WebsiteAddressTxt" ) ) 

    


# from Part I - activities and governance 
VotingMembers <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/VotingMembersGoverningBodyCnt" ) )  
IndVotingMembers <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/VotingMembersIndependentCnt" ) ) 
TotEmployee <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/TotalEmployeeCnt" ) ) 
TotVolunteers <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/TotalVolunteersCnt" ) ) 
TotUBI <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/TotalGrossUBIAmt" ) ) 
NetUBI <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/NetUnrelatedBusTxblIncmAmt" ) ) 








############   NEXT SECTION

 
 [39] "/Return/ReturnData" 
 [40] "/Return/ReturnData/IRS990"  
 
### PRINCIPAL OFFICER 

 [41] "/Return/ReturnData/IRS990/PrincipalOfficerNm"                                                          
 [42] "/Return/ReturnData/IRS990/USAddress"                                                                   
 [43] "/Return/ReturnData/IRS990/USAddress/AddressLine1Txt"                                                   
 [44] "/Return/ReturnData/IRS990/USAddress/CityNm"                                                            
 [45] "/Return/ReturnData/IRS990/USAddress/StateAbbreviationCd"                                               
 [46] "/Return/ReturnData/IRS990/USAddress/ZIPCd"  
 
### BASIC INFO

 [47] "/Return/ReturnData/IRS990/GrossReceiptsAmt"                                                            
 [48] "/Return/ReturnData/IRS990/GroupReturnForAffiliatesInd"                                                 
 [49] "/Return/ReturnData/IRS990/Organization501c3Ind"                                                        
 [50] "/Return/ReturnData/IRS990/WebsiteAddressTxt"   
 [51] "/Return/ReturnData/IRS990/TypeOfOrganizationCorpInd"                                                   
 [52] "/Return/ReturnData/IRS990/FormationYr"                                                                 
 [53] "/Return/ReturnData/IRS990/LegalDomicileStateCd"  



############          MODULE 2 - REV, EXP, CHANGE IN ASSETS            ################

########## PART I - SUMMARY REV EXP ASS  #############

### MISSION
 
 [54] "/Return/ReturnData/IRS990/ActivityOrMissionDesc" 
 
### ACTIVITIES AND GOVERNANCE

 [55] "/Return/ReturnData/IRS990/VotingMembersGoverningBodyCnt"                                               
 [56] "/Return/ReturnData/IRS990/VotingMembersIndependentCnt"                                                 
 [57] "/Return/ReturnData/IRS990/TotalEmployeeCnt"                                                            
 [58] "/Return/ReturnData/IRS990/TotalVolunteersCnt"                                                          
 [59] "/Return/ReturnData/IRS990/TotalGrossUBIAmt"                                                            
 [60] "/Return/ReturnData/IRS990/NetUnrelatedBusTxblIncmAmt"   
 
### REVENUE

 [61] "/Return/ReturnData/IRS990/PYContributionsGrantsAmt"                                                    
 [62] "/Return/ReturnData/IRS990/CYContributionsGrantsAmt"                                                    
 [63] "/Return/ReturnData/IRS990/PYProgramServiceRevenueAmt"                                                  
 [64] "/Return/ReturnData/IRS990/CYProgramServiceRevenueAmt"                                                  
 [65] "/Return/ReturnData/IRS990/PYInvestmentIncomeAmt"                                                       
 [66] "/Return/ReturnData/IRS990/CYInvestmentIncomeAmt"                                                       
 [67] "/Return/ReturnData/IRS990/PYOtherRevenueAmt"                                                           
 [68] "/Return/ReturnData/IRS990/CYOtherRevenueAmt"                                                           
 [69] "/Return/ReturnData/IRS990/PYTotalRevenueAmt"                                                           
 [70] "/Return/ReturnData/IRS990/CYTotalRevenueAmt"  
 
### EXPENSES

 [71] "/Return/ReturnData/IRS990/PYGrantsAndSimilarPaidAmt"                                                   
 [72] "/Return/ReturnData/IRS990/CYGrantsAndSimilarPaidAmt"                                                   
 [73] "/Return/ReturnData/IRS990/PYBenefitsPaidToMembersAmt"                                                  
 [74] "/Return/ReturnData/IRS990/CYBenefitsPaidToMembersAmt"                                                  
 [75] "/Return/ReturnData/IRS990/PYSalariesCompEmpBnftPaidAmt"                                                
 [76] "/Return/ReturnData/IRS990/CYSalariesCompEmpBnftPaidAmt"                                                
 [77] "/Return/ReturnData/IRS990/PYTotalProfFndrsngExpnsAmt"                                                  
 [78] "/Return/ReturnData/IRS990/CYTotalProfFndrsngExpnsAmt"    
 [79] "/Return/ReturnData/IRS990/CYTotalFundraisingExpenseAmt"                                                
 [80] "/Return/ReturnData/IRS990/PYOtherExpensesAmt"                                                          
 [81] "/Return/ReturnData/IRS990/CYOtherExpensesAmt"                                                          
 [82] "/Return/ReturnData/IRS990/PYTotalExpensesAmt"                                                          
 [83] "/Return/ReturnData/IRS990/CYTotalExpensesAmt"                                                          
 [84] "/Return/ReturnData/IRS990/PYRevenuesLessExpensesAmt"                                                   
 [85] "/Return/ReturnData/IRS990/CYRevenuesLessExpensesAmt"  
 
### NET ASSETS

 [86] "/Return/ReturnData/IRS990/TotalAssetsBOYAmt"                                                           
 [87] "/Return/ReturnData/IRS990/TotalAssetsEOYAmt"                                                           
 [88] "/Return/ReturnData/IRS990/TotalLiabilitiesBOYAmt"                                                      
 [89] "/Return/ReturnData/IRS990/TotalLiabilitiesEOYAmt"                                                      
 [90] "/Return/ReturnData/IRS990/NetAssetsOrFundBalancesBOYAmt"                                               
 [91] "/Return/ReturnData/IRS990/NetAssetsOrFundBalancesEOYAmt"  
 






 [29] "CONT"      <- xml_text( xml_find_all( dat, ""  ) )
 [30] "PROGREV"   <- xml_text( xml_find_all( dat, ""  ) )
 [31] "DUES"      <- xml_text( xml_find_all( dat, ""  ) )
 [32] "INVINC"    <- xml_text( xml_find_all( dat, ""  ) )
 [33] "SAVINT"    <- xml_text( xml_find_all( dat, ""  ) )
 [34] "SECINC"    <- xml_text( xml_find_all( dat, ""  ) )
 [35] "RENTINC"   <- xml_text( xml_find_all( dat, ""  ) )
 [36] "RENTEXP"   <- xml_text( xml_find_all( dat, ""  ) )
 [37] "NETRENT"   <- xml_text( xml_find_all( dat, ""  ) )
 [38] "OTHINVST"  <- xml_text( xml_find_all( dat, ""  ) )
 [39] "SECUR"     <- xml_text( xml_find_all( dat, ""  ) )
 [40] "SALESEXP"  <- xml_text( xml_find_all( dat, ""  ) )
 [41] "SALESECN"  <- xml_text( xml_find_all( dat, ""  ) )
 [42] "SALEOTHG"  <- xml_text( xml_find_all( dat, ""  ) )
 [43] "SALEOTHE"  <- xml_text( xml_find_all( dat, ""  ) )
 [44] "SALEOTHN"  <- xml_text( xml_find_all( dat, ""  ) )
 [45] "SPEVTG"    <- xml_text( xml_find_all( dat, ""  ) )
 [46] "DIREXP"    <- xml_text( xml_find_all( dat, ""  ) )
 [47] "FUNDINC"   <- xml_text( xml_find_all( dat, ""  ) )
 [48] "INVENTG"   <- xml_text( xml_find_all( dat, ""  ) )
 [49] "GOODS"     <- xml_text( xml_find_all( dat, ""  ) )
 [50] "GRPROF"    <- xml_text( xml_find_all( dat, ""  ) )
 [51] "OTHINC"    <- xml_text( xml_find_all( dat, ""  ) )
 [52] "TOTREV2"   <- xml_text( xml_find_all( dat, ""  ) )
 [53] "TOTREV"    <- xml_text( xml_find_all( dat, ""  ) )
 [54] "GRREC"     <- xml_text( xml_find_all( dat, ""  ) )
 [55] "SOLICIT"   <- xml_text( xml_find_all( dat, ""  ) )
 [56] "EXPS"      <- xml_text( xml_find_all( dat, ""  ) )
 [57] "NETINC"    <- xml_text( xml_find_all( dat, ""  ) )
 [58] "OTHCHGS"   <- xml_text( xml_find_all( dat, ""  ) )
 [59] "FUNDBAL"   <- xml_text( xml_find_all( dat, ""  ) )
 [60] "COMPENS"   <- xml_text( xml_find_all( dat, ""  ) )
 [61] "OTHSAL"    <- xml_text( xml_find_all( dat, ""  ) )
 [62] "PAYTAX"    <- xml_text( xml_find_all( dat, ""  ) )
 [63] "FUNDFEES"  <- xml_text( xml_find_all( dat, "/Return/ReturnData/IRS990/CYTotalProfFndrsngExpnsAmt"  ) )
    
 
 
 
 
 
########## PART III - STATEMENT OF PROGRAM SERVICE ACCOMPLISHMENTS  #############


### MISSION
 
 [54] "/Return/ReturnData/IRS990/ActivityOrMissionDesc" 
 
### MISSION 
 
 [92] "/Return/ReturnData/IRS990/MissionDesc"   
 
### PROGRAM ACTIVITIES

 [93] "/Return/ReturnData/IRS990/SignificantNewProgramSrvcInd"                                                
 [94] "/Return/ReturnData/IRS990/SignificantChangeInd"                                                        
 [95] "/Return/ReturnData/IRS990/ExpenseAmt"                                                                  
 [96] "/Return/ReturnData/IRS990/RevenueAmt"                                                                  
 [97] "/Return/ReturnData/IRS990/Desc"                                                                        
 [98] "/Return/ReturnData/IRS990/TotalProgramServiceExpensesAmt"
 



########## PART IV - CHECKLIST OF REQUIRED SCHEDULES  #############

 [99] "/Return/ReturnData/IRS990/DescribedInSection501c3Ind"                                                  
[100] "/Return/ReturnData/IRS990/ScheduleBRequiredInd"                                                        
[101] "/Return/ReturnData/IRS990/PoliticalCampaignActyInd"                                                    
[102] "/Return/ReturnData/IRS990/LobbyingActivitiesInd"                                                       
[103] "/Return/ReturnData/IRS990/SubjectToProxyTaxInd"                                                        
[104] "/Return/ReturnData/IRS990/DonorAdvisedFundInd"                                                         
[105] "/Return/ReturnData/IRS990/ConservationEasementsInd"                                                    
[106] "/Return/ReturnData/IRS990/CollectionsOfArtInd"                                                         
[107] "/Return/ReturnData/IRS990/CreditCounselingInd"                                                         
[108] "/Return/ReturnData/IRS990/TempOrPermanentEndowmentsInd"                                                
[109] "/Return/ReturnData/IRS990/ReportLandBuildingEquipmentInd"                                              
[110] "/Return/ReturnData/IRS990/ReportInvestmentsOtherSecInd"                                                
[111] "/Return/ReturnData/IRS990/ReportProgramRelatedInvstInd"                                                
[112] "/Return/ReturnData/IRS990/ReportOtherAssetsInd"                                                        
[113] "/Return/ReturnData/IRS990/ReportOtherLiabilitiesInd"                                                   
[114] "/Return/ReturnData/IRS990/IncludeFIN48FootnoteInd"                                                     
[115] "/Return/ReturnData/IRS990/IndependentAuditFinclStmtInd"                                                
[116] "/Return/ReturnData/IRS990/ConsolidatedAuditFinclStmtInd"                                               
[117] "/Return/ReturnData/IRS990/SchoolOperatingInd"                                                          
[118] "/Return/ReturnData/IRS990/ForeignOfficeInd"                                                            
[119] "/Return/ReturnData/IRS990/ForeignActivitiesInd"                                                        
[120] "/Return/ReturnData/IRS990/MoreThan5000KToOrgInd"                                                       
[121] "/Return/ReturnData/IRS990/MoreThan5000KToIndividualsInd"                                               
[122] "/Return/ReturnData/IRS990/ProfessionalFundraisingInd"                                                  
[123] "/Return/ReturnData/IRS990/FundraisingActivitiesInd"                                                    
[124] "/Return/ReturnData/IRS990/GamingActivitiesInd"                                                         
[125] "/Return/ReturnData/IRS990/OperateHospitalInd"                                                          
[126] "/Return/ReturnData/IRS990/GrantsToOrganizationsInd"                                                    
[127] "/Return/ReturnData/IRS990/GrantsToIndividualsInd"                                                      
[128] "/Return/ReturnData/IRS990/ScheduleJRequiredInd"                                                        
[129] "/Return/ReturnData/IRS990/TaxExemptBondsInd"                                                           
[130] "/Return/ReturnData/IRS990/EngagedInExcessBenefitTransInd"                                              
[131] "/Return/ReturnData/IRS990/PYExcessBenefitTransInd"                                                     
[132] "/Return/ReturnData/IRS990/LoanOutstandingInd"                                                          
[133] "/Return/ReturnData/IRS990/GrantToRelatedPersonInd"                                                     
[134] "/Return/ReturnData/IRS990/BusinessRlnWithOrgMemInd"                                                    
[135] "/Return/ReturnData/IRS990/BusinessRlnWithFamMemInd"                                                    
[136] "/Return/ReturnData/IRS990/BusinessRlnWithOfficerEntInd"                                                
[137] "/Return/ReturnData/IRS990/DeductibleNonCashContriInd"                                                  
[138] "/Return/ReturnData/IRS990/DeductibleArtContributionInd"                                                
[139] "/Return/ReturnData/IRS990/TerminateOperationsInd"                                                      
[140] "/Return/ReturnData/IRS990/PartialLiquidationInd"                                                       
[141] "/Return/ReturnData/IRS990/DisregardedEntityInd"                                                        
[142] "/Return/ReturnData/IRS990/RelatedEntityInd"                                                            
[143] "/Return/ReturnData/IRS990/RelatedOrganizationCtrlEntInd"                                               
[144] "/Return/ReturnData/IRS990/TrnsfrExmptNonChrtblRltdOrgInd"                                              
[145] "/Return/ReturnData/IRS990/ActivitiesConductedPrtshpInd"                                                
[146] "/Return/ReturnData/IRS990/ScheduleORequiredInd"          



########## PART V - STATEMENTS REGARDING OTHER IRS FILINGS AND TAX COMPLIANCE  #############

[147] "/Return/ReturnData/IRS990/IRPDocumentCnt"                                                              
[148] "/Return/ReturnData/IRS990/IRPDocumentW2GCnt"                                                           
[149] "/Return/ReturnData/IRS990/BackupWthldComplianceInd"                                                    
[150] "/Return/ReturnData/IRS990/EmployeeCnt"                                                                 
[151] "/Return/ReturnData/IRS990/EmploymentTaxReturnsFiledInd"                                                
[152] "/Return/ReturnData/IRS990/UnrelatedBusIncmOverLimitInd"                                                
[153] "/Return/ReturnData/IRS990/Form990TFiledInd"                                                            
[154] "/Return/ReturnData/IRS990/ForeignFinancialAccountInd"                                                  
[155] "/Return/ReturnData/IRS990/ProhibitedTaxShelterTransInd"                                                
[156] "/Return/ReturnData/IRS990/TaxablePartyNotificationInd"                                                 
[157] "/Return/ReturnData/IRS990/NondeductibleContributionsInd"                                               
[158] "/Return/ReturnData/IRS990/QuidProQuoContributionsInd"                                                  
[159] "/Return/ReturnData/IRS990/QuidProQuoContriDisclInd"                                                    
[160] "/Return/ReturnData/IRS990/Form8282PropertyDisposedOfInd"                                               
[161] "/Return/ReturnData/IRS990/RcvFndsToPayPrsnlBnftCntrctInd"                                              
[162] "/Return/ReturnData/IRS990/PayPremiumsPrsnlBnftCntrctInd"                                               
[163] "/Return/ReturnData/IRS990/IndoorTanningServicesInd"                                                    
[164] "/Return/ReturnData/IRS990/InfoInScheduleOPartVIInd"  



########## PART V - STATEMENTS REGARDING OTHER IRS FILINGS AND TAX COMPLIANCE  #############

### SECTION A. GOVERNING BODY AND MANAGEMENT

[165] "/Return/ReturnData/IRS990/GoverningBodyVotingMembersCnt"                                               
[166] "/Return/ReturnData/IRS990/IndependentVotingMemberCnt"                                                  
[167] "/Return/ReturnData/IRS990/FamilyOrBusinessRlnInd"                                                      
[168] "/Return/ReturnData/IRS990/DelegationOfMgmtDutiesInd"                                                   
[169] "/Return/ReturnData/IRS990/ChangeToOrgDocumentsInd"                                                     
[170] "/Return/ReturnData/IRS990/MaterialDiversionOrMisuseInd"                                                
[171] "/Return/ReturnData/IRS990/MembersOrStockholdersInd"                                                    
[172] "/Return/ReturnData/IRS990/ElectionOfBoardMembersInd"                                                   
[173] "/Return/ReturnData/IRS990/DecisionsSubjectToApprovaInd"                                                
[174] "/Return/ReturnData/IRS990/MinutesOfGoverningBodyInd"                                                   
[175] "/Return/ReturnData/IRS990/MinutesOfCommitteesInd"                                                      
[176] "/Return/ReturnData/IRS990/OfficerMailingAddressInd"  

### SECTION B. POLICIES

[177] "/Return/ReturnData/IRS990/LocalChaptersInd"                                                            
[178] "/Return/ReturnData/IRS990/Form990ProvidedToGvrnBodyInd"                                                
[179] "/Return/ReturnData/IRS990/ConflictOfInterestPolicyInd"                                                 
[180] "/Return/ReturnData/IRS990/AnnualDisclosureCoveredPrsnInd"                                              
[181] "/Return/ReturnData/IRS990/RegularMonitoringEnfrcInd"                                                   
[182] "/Return/ReturnData/IRS990/WhistleblowerPolicyInd"                                                      
[183] "/Return/ReturnData/IRS990/DocumentRetentionPolicyInd"                                                  
[184] "/Return/ReturnData/IRS990/CompensationProcessCEOInd"                                                   
[185] "/Return/ReturnData/IRS990/CompensationProcessOtherInd"                                                 
[186] "/Return/ReturnData/IRS990/InvestmentInJointVentureInd"   

### SECTION C. DISCLOSURE

[187] "/Return/ReturnData/IRS990/StatesWhereCopyOfReturnIsFldCd"                                              
[188] "/Return/ReturnData/IRS990/OtherWebsiteInd"                                                             
[189] "/Return/ReturnData/IRS990/UponRequestInd"

[190] "/Return/ReturnData/IRS990/BooksInCareOfDetail"                                                         
[191] "/Return/ReturnData/IRS990/BooksInCareOfDetail/BusinessName"                                            
[192] "/Return/ReturnData/IRS990/BooksInCareOfDetail/BusinessName/BusinessNameLine1Txt"                       
[193] "/Return/ReturnData/IRS990/BooksInCareOfDetail/PhoneNum"                                                
[194] "/Return/ReturnData/IRS990/BooksInCareOfDetail/USAddress"                                               
[195] "/Return/ReturnData/IRS990/BooksInCareOfDetail/USAddress/AddressLine1Txt"                               
[196] "/Return/ReturnData/IRS990/BooksInCareOfDetail/USAddress/CityNm"                                        
[197] "/Return/ReturnData/IRS990/BooksInCareOfDetail/USAddress/StateAbbreviationCd"                           
[198] "/Return/ReturnData/IRS990/BooksInCareOfDetail/USAddress/ZIPCd"  




############         PART VII - COMPENSATION         ################

### SECTION A. OFFICERS, DIRECTORS, TRUSTEES, KEY EMPLOYEES, AND HIGHEST COMPENSATED EMPLOYEES

[199] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[1]"                                                
[200] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[1]/PersonNm"                                       
[201] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[1]/TitleTxt"                                       
[202] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[1]/AverageHoursPerWeekRt"                          
[203] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[1]/IndividualTrusteeOrDirectorInd"                 
[204] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[1]/ReportableCompFromOrgAmt"                       
[205] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[1]/ReportableCompFromRltdOrgAmt"                   
[206] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[1]/OtherCompensationAmt"                           
[207] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[2]"                                                
[208] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[2]/PersonNm"                                       
[209] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[2]/TitleTxt"                                       
[210] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[2]/AverageHoursPerWeekRt"                          
[211] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[2]/IndividualTrusteeOrDirectorInd"                 
[212] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[2]/OfficerInd"                                     
[213] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[2]/ReportableCompFromOrgAmt"                       
[214] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[2]/ReportableCompFromRltdOrgAmt"                   
[215] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[2]/OtherCompensationAmt"                           
[216] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[3]"                                                
[217] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[3]/PersonNm"                                       
[218] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[3]/TitleTxt"                                       
[219] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[3]/AverageHoursPerWeekRt"                          
[220] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[3]/IndividualTrusteeOrDirectorInd"                 
[221] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[3]/ReportableCompFromOrgAmt"                       
[222] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[3]/ReportableCompFromRltdOrgAmt"                   
[223] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[3]/OtherCompensationAmt"                           
[224] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[4]"                                                
[225] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[4]/PersonNm"                                       
[226] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[4]/TitleTxt"                                       
[227] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[4]/AverageHoursPerWeekRt"                          
[228] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[4]/IndividualTrusteeOrDirectorInd"                 
[229] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[4]/OfficerInd"                                     
[230] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[4]/ReportableCompFromOrgAmt"                       
[231] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[4]/ReportableCompFromRltdOrgAmt"                   
[232] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[4]/OtherCompensationAmt"                           
[233] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[5]"                                                
[234] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[5]/PersonNm"                                       
[235] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[5]/TitleTxt"                                       
[236] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[5]/AverageHoursPerWeekRt"                          
[237] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[5]/IndividualTrusteeOrDirectorInd"                 
[238] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[5]/ReportableCompFromOrgAmt"                       
[239] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[5]/ReportableCompFromRltdOrgAmt"                   
[240] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[5]/OtherCompensationAmt"                           
[241] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[6]"                                                
[242] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[6]/PersonNm"                                       
[243] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[6]/TitleTxt"                                       
[244] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[6]/AverageHoursPerWeekRt"                          
[245] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[6]/OfficerInd"                                     
[246] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[6]/ReportableCompFromOrgAmt"                       
[247] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[6]/ReportableCompFromRltdOrgAmt"                   
[248] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[6]/OtherCompensationAmt"                           
[249] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[7]"                                                
[250] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[7]/PersonNm"                                       
[251] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[7]/TitleTxt"                                       
[252] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[7]/AverageHoursPerWeekRt"                          
[253] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[7]/OfficerInd"                                     
[254] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[7]/ReportableCompFromOrgAmt"                       
[255] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[7]/ReportableCompFromRltdOrgAmt"                   
[256] "/Return/ReturnData/IRS990/Form990PartVIISectionAGrp[7]/OtherCompensationAmt"  


[257] "/Return/ReturnData/IRS990/TotalReportableCompFromOrgAmt"                                               
[258] "/Return/ReturnData/IRS990/TotReportableCompRltdOrgAmt"                                                 
[259] "/Return/ReturnData/IRS990/TotalOtherCompensationAmt"                                                   
[260] "/Return/ReturnData/IRS990/IndivRcvdGreaterThan100KCnt"                                                 
[261] "/Return/ReturnData/IRS990/FormerOfcrEmployeesListedInd"                                                
[262] "/Return/ReturnData/IRS990/TotalCompGreaterThan150KInd"                                                 
[263] "/Return/ReturnData/IRS990/CompensationFromOtherSrcsInd"   


### SECTION B. INDEPENDENT CONTRACTORS

[264] "/Return/ReturnData/IRS990/CntrctRcvdGreaterThan100KCnt" 

#... should list contractors individually if exist





############         PART VIII - STATEMENT OF REVENUE         ################

### CONTRIBUTIONS, GIFTS AND GRANTS

[265] "/Return/ReturnData/IRS990/MembershipDuesAmt"                                                           
[266] "/Return/ReturnData/IRS990/AllOtherContributionsAmt"                                                    
[267] "/Return/ReturnData/IRS990/NoncashContributionsAmt"                                                     
[268] "/Return/ReturnData/IRS990/TotalContributionsAmt"                    


### PROGRAM SERVICE REVENUES

[269] "/Return/ReturnData/IRS990/ProgramServiceRevenueGrp[1]"                                                 
[270] "/Return/ReturnData/IRS990/ProgramServiceRevenueGrp[1]/Desc"                                            
[271] "/Return/ReturnData/IRS990/ProgramServiceRevenueGrp[1]/BusinessCd"                                      
[272] "/Return/ReturnData/IRS990/ProgramServiceRevenueGrp[1]/TotalRevenueColumnAmt"                           
[273] "/Return/ReturnData/IRS990/ProgramServiceRevenueGrp[1]/RelatedOrExemptFuncIncomeAmt"                    
[274] "/Return/ReturnData/IRS990/ProgramServiceRevenueGrp[2]"                                                 
[275] "/Return/ReturnData/IRS990/ProgramServiceRevenueGrp[2]/Desc"                                            
[276] "/Return/ReturnData/IRS990/ProgramServiceRevenueGrp[2]/BusinessCd"                                      
[277] "/Return/ReturnData/IRS990/ProgramServiceRevenueGrp[2]/TotalRevenueColumnAmt"                           
[278] "/Return/ReturnData/IRS990/ProgramServiceRevenueGrp[2]/UnrelatedBusinessRevenueAmt"   
[279] "/Return/ReturnData/IRS990/TotalProgramServiceRevenueAmt" 

[280] "/Return/ReturnData/IRS990/GrossAmountSalesAssetsGrp"                                                   
[281] "/Return/ReturnData/IRS990/GrossAmountSalesAssetsGrp/SecuritiesAmt"                                     
[282] "/Return/ReturnData/IRS990/LessCostOthBasisSalesExpnssGrp"                                              
[283] "/Return/ReturnData/IRS990/LessCostOthBasisSalesExpnssGrp/SecuritiesAmt"                                
[284] "/Return/ReturnData/IRS990/LessCostOthBasisSalesExpnssGrp/OtherAmt"                                     
[285] "/Return/ReturnData/IRS990/GainOrLossGrp"                                                               
[286] "/Return/ReturnData/IRS990/GainOrLossGrp/SecuritiesAmt"                                                 
[287] "/Return/ReturnData/IRS990/GainOrLossGrp/OtherAmt"                                                      
[288] "/Return/ReturnData/IRS990/NetGainOrLossInvestmentsGrp"                                                 
[289] "/Return/ReturnData/IRS990/NetGainOrLossInvestmentsGrp/TotalRevenueColumnAmt"                           
[290] "/Return/ReturnData/IRS990/NetGainOrLossInvestmentsGrp/RelatedOrExemptFuncIncomeAmt"                    
[291] "/Return/ReturnData/IRS990/TotalRevenueGrp"                                                             
[292] "/Return/ReturnData/IRS990/TotalRevenueGrp/TotalRevenueColumnAmt"                                       
[293] "/Return/ReturnData/IRS990/TotalRevenueGrp/RelatedOrExemptFuncIncomeAmt"                                
[294] "/Return/ReturnData/IRS990/TotalRevenueGrp/UnrelatedBusinessRevenueAmt"                                 
[295] "/Return/ReturnData/IRS990/TotalRevenueGrp/ExclusionAmt"         




############         PART IX - STATEMENT OF FUNCTIONAL EXPENSES         ################


[296] "/Return/ReturnData/IRS990/CompCurrentOfcrDirectorsGrp"                                                 
[297] "/Return/ReturnData/IRS990/CompCurrentOfcrDirectorsGrp/TotalAmt"                                        
[298] "/Return/ReturnData/IRS990/CompCurrentOfcrDirectorsGrp/ProgramServicesAmt"                              
[299] "/Return/ReturnData/IRS990/OtherSalariesAndWagesGrp"                                                    
[300] "/Return/ReturnData/IRS990/OtherSalariesAndWagesGrp/TotalAmt"                                           
[301] "/Return/ReturnData/IRS990/OtherSalariesAndWagesGrp/ProgramServicesAmt"                                 
[302] "/Return/ReturnData/IRS990/OtherSalariesAndWagesGrp/ManagementAndGeneralAmt"                            
[303] "/Return/ReturnData/IRS990/OtherSalariesAndWagesGrp/FundraisingAmt"                                     
[304] "/Return/ReturnData/IRS990/PensionPlanContributionsGrp"                                                 
[305] "/Return/ReturnData/IRS990/PensionPlanContributionsGrp/TotalAmt"                                        
[306] "/Return/ReturnData/IRS990/PensionPlanContributionsGrp/ProgramServicesAmt"                              
[307] "/Return/ReturnData/IRS990/PensionPlanContributionsGrp/ManagementAndGeneralAmt"                         
[308] "/Return/ReturnData/IRS990/PensionPlanContributionsGrp/FundraisingAmt"                                  
[309] "/Return/ReturnData/IRS990/OtherEmployeeBenefitsGrp"                                                    
[310] "/Return/ReturnData/IRS990/OtherEmployeeBenefitsGrp/TotalAmt"                                           
[311] "/Return/ReturnData/IRS990/OtherEmployeeBenefitsGrp/ProgramServicesAmt"                                 
[312] "/Return/ReturnData/IRS990/OtherEmployeeBenefitsGrp/ManagementAndGeneralAmt"                            
[313] "/Return/ReturnData/IRS990/OtherEmployeeBenefitsGrp/FundraisingAmt"                                     
[314] "/Return/ReturnData/IRS990/PayrollTaxesGrp"                                                             
[315] "/Return/ReturnData/IRS990/PayrollTaxesGrp/TotalAmt"                                                    
[316] "/Return/ReturnData/IRS990/PayrollTaxesGrp/ProgramServicesAmt"                                          
[317] "/Return/ReturnData/IRS990/PayrollTaxesGrp/ManagementAndGeneralAmt"                                     
[318] "/Return/ReturnData/IRS990/PayrollTaxesGrp/FundraisingAmt"                                              
[319] "/Return/ReturnData/IRS990/FeesForServicesLegalGrp"                                                     
[320] "/Return/ReturnData/IRS990/FeesForServicesLegalGrp/TotalAmt"                                            
[321] "/Return/ReturnData/IRS990/FeesForServicesLegalGrp/ProgramServicesAmt"                                  
[322] "/Return/ReturnData/IRS990/FeesForServicesAccountingGrp"                                                
[323] "/Return/ReturnData/IRS990/FeesForServicesAccountingGrp/TotalAmt"                                       
[324] "/Return/ReturnData/IRS990/FeesForServicesAccountingGrp/ProgramServicesAmt"                             
[325] "/Return/ReturnData/IRS990/FeesForServicesOtherGrp"                                                     
[326] "/Return/ReturnData/IRS990/FeesForServicesOtherGrp/TotalAmt"                                            
[327] "/Return/ReturnData/IRS990/FeesForServicesOtherGrp/ProgramServicesAmt"                                  
[328] "/Return/ReturnData/IRS990/AdvertisingGrp"                                                              
[329] "/Return/ReturnData/IRS990/AdvertisingGrp/TotalAmt"                                                     
[330] "/Return/ReturnData/IRS990/AdvertisingGrp/ProgramServicesAmt"                                           
[331] "/Return/ReturnData/IRS990/AdvertisingGrp/ManagementAndGeneralAmt"                                      
[332] "/Return/ReturnData/IRS990/AdvertisingGrp/FundraisingAmt"                                               
[333] "/Return/ReturnData/IRS990/OfficeExpensesGrp"                                                           
[334] "/Return/ReturnData/IRS990/OfficeExpensesGrp/TotalAmt"                                                  
[335] "/Return/ReturnData/IRS990/OfficeExpensesGrp/ProgramServicesAmt"                                        
[336] "/Return/ReturnData/IRS990/InformationTechnologyGrp"                                                    
[337] "/Return/ReturnData/IRS990/InformationTechnologyGrp/TotalAmt"                                           
[338] "/Return/ReturnData/IRS990/InformationTechnologyGrp/ProgramServicesAmt"                                 
[339] "/Return/ReturnData/IRS990/OccupancyGrp"                                                                
[340] "/Return/ReturnData/IRS990/OccupancyGrp/TotalAmt"                                                       
[341] "/Return/ReturnData/IRS990/OccupancyGrp/ProgramServicesAmt"                                             
[342] "/Return/ReturnData/IRS990/OccupancyGrp/ManagementAndGeneralAmt"                                        
[343] "/Return/ReturnData/IRS990/OccupancyGrp/FundraisingAmt"                                                 
[344] "/Return/ReturnData/IRS990/TravelGrp"                                                                   
[345] "/Return/ReturnData/IRS990/TravelGrp/TotalAmt"                                                          
[346] "/Return/ReturnData/IRS990/TravelGrp/ProgramServicesAmt"                                                
[347] "/Return/ReturnData/IRS990/ConferencesMeetingsGrp"                                                      
[348] "/Return/ReturnData/IRS990/ConferencesMeetingsGrp/TotalAmt"                                             
[349] "/Return/ReturnData/IRS990/ConferencesMeetingsGrp/ProgramServicesAmt"                                   
[350] "/Return/ReturnData/IRS990/DepreciationDepletionGrp"                                                    
[351] "/Return/ReturnData/IRS990/DepreciationDepletionGrp/TotalAmt"                                           
[352] "/Return/ReturnData/IRS990/DepreciationDepletionGrp/ProgramServicesAmt"                                 
[353] "/Return/ReturnData/IRS990/InsuranceGrp"                                                                
[354] "/Return/ReturnData/IRS990/InsuranceGrp/TotalAmt"                                                       
[355] "/Return/ReturnData/IRS990/InsuranceGrp/ProgramServicesAmt"                                             
[356] "/Return/ReturnData/IRS990/InsuranceGrp/ManagementAndGeneralAmt"                                        
[357] "/Return/ReturnData/IRS990/InsuranceGrp/FundraisingAmt"                                                 
[358] "/Return/ReturnData/IRS990/OtherExpensesGrp[1]"                                                         
[359] "/Return/ReturnData/IRS990/OtherExpensesGrp[1]/Desc"                                                    
[360] "/Return/ReturnData/IRS990/OtherExpensesGrp[1]/TotalAmt"                                                
[361] "/Return/ReturnData/IRS990/OtherExpensesGrp[1]/ProgramServicesAmt"                                      
[362] "/Return/ReturnData/IRS990/OtherExpensesGrp[1]/ManagementAndGeneralAmt"                                 
[363] "/Return/ReturnData/IRS990/OtherExpensesGrp[1]/FundraisingAmt"                                          
[364] "/Return/ReturnData/IRS990/OtherExpensesGrp[2]"                                                         
[365] "/Return/ReturnData/IRS990/OtherExpensesGrp[2]/Desc"                                                    
[366] "/Return/ReturnData/IRS990/OtherExpensesGrp[2]/TotalAmt"                                                
[367] "/Return/ReturnData/IRS990/OtherExpensesGrp[2]/ProgramServicesAmt"                                      
[368] "/Return/ReturnData/IRS990/OtherExpensesGrp[3]"                                                         
[369] "/Return/ReturnData/IRS990/OtherExpensesGrp[3]/Desc"                                                    
[370] "/Return/ReturnData/IRS990/OtherExpensesGrp[3]/TotalAmt"                                                
[371] "/Return/ReturnData/IRS990/OtherExpensesGrp[3]/ProgramServicesAmt"                                      
[372] "/Return/ReturnData/IRS990/OtherExpensesGrp[3]/ManagementAndGeneralAmt"                                 
[373] "/Return/ReturnData/IRS990/OtherExpensesGrp[3]/FundraisingAmt"                                          
[374] "/Return/ReturnData/IRS990/OtherExpensesGrp[4]"                                                         
[375] "/Return/ReturnData/IRS990/OtherExpensesGrp[4]/Desc"                                                    
[376] "/Return/ReturnData/IRS990/OtherExpensesGrp[4]/TotalAmt"                                                
[377] "/Return/ReturnData/IRS990/OtherExpensesGrp[4]/ProgramServicesAmt"                                      
[378] "/Return/ReturnData/IRS990/OtherExpensesGrp[4]/ManagementAndGeneralAmt"                                 
[379] "/Return/ReturnData/IRS990/OtherExpensesGrp[4]/FundraisingAmt"                                          
[380] "/Return/ReturnData/IRS990/AllOtherExpensesGrp"                                                         
[381] "/Return/ReturnData/IRS990/AllOtherExpensesGrp/TotalAmt"                                                
[382] "/Return/ReturnData/IRS990/AllOtherExpensesGrp/ProgramServicesAmt"                                      
[383] "/Return/ReturnData/IRS990/AllOtherExpensesGrp/ManagementAndGeneralAmt"                                 
[384] "/Return/ReturnData/IRS990/AllOtherExpensesGrp/FundraisingAmt"                                          
[385] "/Return/ReturnData/IRS990/TotalFunctionalExpensesGrp"                                                  
[386] "/Return/ReturnData/IRS990/TotalFunctionalExpensesGrp/TotalAmt"                                         
[387] "/Return/ReturnData/IRS990/TotalFunctionalExpensesGrp/ProgramServicesAmt"                               
[388] "/Return/ReturnData/IRS990/TotalFunctionalExpensesGrp/ManagementAndGeneralAmt"                          
[389] "/Return/ReturnData/IRS990/TotalFunctionalExpensesGrp/FundraisingAmt"   


############         PART X - BALANCE SHEET        ################

### ASSETS

[390] "/Return/ReturnData/IRS990/CashNonInterestBearingGrp"                                                   
[391] "/Return/ReturnData/IRS990/CashNonInterestBearingGrp/BOYAmt"                                            
[392] "/Return/ReturnData/IRS990/CashNonInterestBearingGrp/EOYAmt"                                            
[393] "/Return/ReturnData/IRS990/PrepaidExpensesDefrdChargesGrp"                                              
[394] "/Return/ReturnData/IRS990/PrepaidExpensesDefrdChargesGrp/BOYAmt"                                       
[395] "/Return/ReturnData/IRS990/PrepaidExpensesDefrdChargesGrp/EOYAmt"                                       
[396] "/Return/ReturnData/IRS990/LandBldgEquipCostOrOtherBssAmt"                                              
[397] "/Return/ReturnData/IRS990/LandBldgEquipAccumDeprecAmt"                                                 
[398] "/Return/ReturnData/IRS990/LandBldgEquipBasisNetGrp"                                                    
[399] "/Return/ReturnData/IRS990/LandBldgEquipBasisNetGrp/BOYAmt"                                             
[400] "/Return/ReturnData/IRS990/LandBldgEquipBasisNetGrp/EOYAmt"                                             
[401] "/Return/ReturnData/IRS990/OtherAssetsTotalGrp"                                                         
[402] "/Return/ReturnData/IRS990/OtherAssetsTotalGrp/BOYAmt"                                                  
[403] "/Return/ReturnData/IRS990/OtherAssetsTotalGrp/EOYAmt"                                                  
[404] "/Return/ReturnData/IRS990/TotalAssetsGrp"                                                              
[405] "/Return/ReturnData/IRS990/TotalAssetsGrp/BOYAmt"                                                       
[406] "/Return/ReturnData/IRS990/TotalAssetsGrp/EOYAmt"           

### LIABILITIES

[407] "/Return/ReturnData/IRS990/TotalLiabilitiesGrp"                                                         
[408] "/Return/ReturnData/IRS990/TotalLiabilitiesGrp/BOYAmt"                                                  
[409] "/Return/ReturnData/IRS990/TotalLiabilitiesGrp/EOYAmt"    

### LIABILITIES

[410] "/Return/ReturnData/IRS990/OrganizationFollowsSFAS117Ind"                                               
[411] "/Return/ReturnData/IRS990/UnrestrictedNetAssetsGrp"                                                    
[412] "/Return/ReturnData/IRS990/UnrestrictedNetAssetsGrp/BOYAmt"                                             
[413] "/Return/ReturnData/IRS990/UnrestrictedNetAssetsGrp/EOYAmt"                                             
[414] "/Return/ReturnData/IRS990/TotalNetAssetsFundBalanceGrp"                                                
[415] "/Return/ReturnData/IRS990/TotalNetAssetsFundBalanceGrp/BOYAmt"                                         
[416] "/Return/ReturnData/IRS990/TotalNetAssetsFundBalanceGrp/EOYAmt"                                         
[417] "/Return/ReturnData/IRS990/TotLiabNetAssetsFundBalanceGrp"                                              
[418] "/Return/ReturnData/IRS990/TotLiabNetAssetsFundBalanceGrp/BOYAmt"                                       
[419] "/Return/ReturnData/IRS990/TotLiabNetAssetsFundBalanceGrp/EOYAmt"    

############         PART XI - RECONCILIATION       ################

[420] "/Return/ReturnData/IRS990/ReconcilationRevenueExpnssAmt"                                               
[421] "/Return/ReturnData/IRS990/OtherChangesInNetAssetsAmt"      


############         PART XII - BALANCE SHEET        ################

[422] "/Return/ReturnData/IRS990/MethodOfAccountingCashInd"                                                   
[423] "/Return/ReturnData/IRS990/AccountantCompileOrReviewInd"                                                
[424] "/Return/ReturnData/IRS990/FSAuditedInd"                                                                
[425] "/Return/ReturnData/IRS990/FederalGrantAuditRequiredInd"               



############         SCHEDULE A        ################

[426] "/Return/ReturnData/IRS990ScheduleA"                                                                    
[427] "/Return/ReturnData/IRS990ScheduleA/PublicOrganization170Ind"                                           
[428] "/Return/ReturnData/IRS990ScheduleA/GiftsGrantsContriRcvd170Grp"                                        
[429] "/Return/ReturnData/IRS990ScheduleA/GiftsGrantsContriRcvd170Grp/CurrentTaxYearMinus4YearsAmt"           
[430] "/Return/ReturnData/IRS990ScheduleA/GiftsGrantsContriRcvd170Grp/CurrentTaxYearMinus3YearsAmt"           
[431] "/Return/ReturnData/IRS990ScheduleA/GiftsGrantsContriRcvd170Grp/CurrentTaxYearMinus2YearsAmt"           
[432] "/Return/ReturnData/IRS990ScheduleA/GiftsGrantsContriRcvd170Grp/CurrentTaxYearMinus1YearAmt"            
[433] "/Return/ReturnData/IRS990ScheduleA/GiftsGrantsContriRcvd170Grp/CurrentTaxYearAmt"                      
[434] "/Return/ReturnData/IRS990ScheduleA/GiftsGrantsContriRcvd170Grp/TotalAmt"                               
[435] "/Return/ReturnData/IRS990ScheduleA/TotalCalendarYear170Grp"                                            
[436] "/Return/ReturnData/IRS990ScheduleA/TotalCalendarYear170Grp/CurrentTaxYearMinus4YearsAmt"               
[437] "/Return/ReturnData/IRS990ScheduleA/TotalCalendarYear170Grp/CurrentTaxYearMinus3YearsAmt"               
[438] "/Return/ReturnData/IRS990ScheduleA/TotalCalendarYear170Grp/CurrentTaxYearMinus2YearsAmt"               
[439] "/Return/ReturnData/IRS990ScheduleA/TotalCalendarYear170Grp/CurrentTaxYearMinus1YearAmt"                
[440] "/Return/ReturnData/IRS990ScheduleA/TotalCalendarYear170Grp/CurrentTaxYearAmt"                          
[441] "/Return/ReturnData/IRS990ScheduleA/TotalCalendarYear170Grp/TotalAmt"                                   
[442] "/Return/ReturnData/IRS990ScheduleA/SubstantialContributorsTotAmt"                                      
[443] "/Return/ReturnData/IRS990ScheduleA/PublicSupportTotal170Amt"                                           
[444] "/Return/ReturnData/IRS990ScheduleA/OtherIncome170Grp"                                                  
[445] "/Return/ReturnData/IRS990ScheduleA/OtherIncome170Grp/CurrentTaxYearMinus4YearsAmt"                     
[446] "/Return/ReturnData/IRS990ScheduleA/OtherIncome170Grp/CurrentTaxYearMinus3YearsAmt"                     
[447] "/Return/ReturnData/IRS990ScheduleA/OtherIncome170Grp/CurrentTaxYearMinus2YearsAmt"                     
[448] "/Return/ReturnData/IRS990ScheduleA/OtherIncome170Grp/CurrentTaxYearMinus1YearAmt"                      
[449] "/Return/ReturnData/IRS990ScheduleA/OtherIncome170Grp/CurrentTaxYearAmt"                                
[450] "/Return/ReturnData/IRS990ScheduleA/OtherIncome170Grp/TotalAmt"                                         
[451] "/Return/ReturnData/IRS990ScheduleA/TotalSupportAmt"                                                    
[452] "/Return/ReturnData/IRS990ScheduleA/PublicSupportCY170Pct"                                              
[453] "/Return/ReturnData/IRS990ScheduleA/PublicSupportPY170Pct"                                              
[454] "/Return/ReturnData/IRS990ScheduleA/ThirtyThrPctSuprtTestsCY170Ind"   



############         SCHEDULE B        ################

[455] "/Return/ReturnData/IRS990ScheduleB"                                                                    
[456] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp"                                          
[457] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp/ContributorNum"                           
[458] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp/ContributorBusinessName"                  
[459] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp/ContributorBusinessName/BusinessNameLine1"
[460] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp/ContributorUSAddress"                     
[461] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp/ContributorUSAddress/AddressLine1"        
[462] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp/ContributorUSAddress/AddressLine2"        
[463] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp/ContributorUSAddress/City"                
[464] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp/ContributorUSAddress/State"               
[465] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp/ContributorUSAddress/ZIPCode"             
[466] "/Return/ReturnData/IRS990ScheduleB/ContributorInformationGrp/TotalContributionsAmt"  



############         SCHEDULE D        ################

[467] "/Return/ReturnData/IRS990ScheduleD"                                                                    
[468] "/Return/ReturnData/IRS990ScheduleD/LeaseholdImprovementsGrp"                                           
[469] "/Return/ReturnData/IRS990ScheduleD/LeaseholdImprovementsGrp/OtherCostOrOtherBasisAmt"                  
[470] "/Return/ReturnData/IRS990ScheduleD/LeaseholdImprovementsGrp/DepreciationAmt"                           
[471] "/Return/ReturnData/IRS990ScheduleD/LeaseholdImprovementsGrp/BookValueAmt"                              
[472] "/Return/ReturnData/IRS990ScheduleD/EquipmentGrp"                                                       
[473] "/Return/ReturnData/IRS990ScheduleD/EquipmentGrp/OtherCostOrOtherBasisAmt"                              
[474] "/Return/ReturnData/IRS990ScheduleD/EquipmentGrp/DepreciationAmt"                                       
[475] "/Return/ReturnData/IRS990ScheduleD/EquipmentGrp/BookValueAmt"                                          
[476] "/Return/ReturnData/IRS990ScheduleD/OtherLandBuildingsGrp"                                              
[477] "/Return/ReturnData/IRS990ScheduleD/OtherLandBuildingsGrp/OtherCostOrOtherBasisAmt"                     
[478] "/Return/ReturnData/IRS990ScheduleD/OtherLandBuildingsGrp/DepreciationAmt"                              
[479] "/Return/ReturnData/IRS990ScheduleD/OtherLandBuildingsGrp/BookValueAmt"                                 
[480] "/Return/ReturnData/IRS990ScheduleD/TotalBookValueLandBuildingsAmt"           



############         SCHEDULE M        ################

[481] "/Return/ReturnData/IRS990ScheduleM"                                                                    
[482] "/Return/ReturnData/IRS990ScheduleM/SecuritiesPubliclyTradedGrp"                                        
[483] "/Return/ReturnData/IRS990ScheduleM/SecuritiesPubliclyTradedGrp/NonCashCheckboxInd"                     
[484] "/Return/ReturnData/IRS990ScheduleM/SecuritiesPubliclyTradedGrp/ContributionCnt"                        
[485] "/Return/ReturnData/IRS990ScheduleM/SecuritiesPubliclyTradedGrp/NoncashContributionsRptF990Amt"         
[486] "/Return/ReturnData/IRS990ScheduleM/SecuritiesPubliclyTradedGrp/MethodOfDeterminingRevenuesTxt"         
[487] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[1]"                                      
[488] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[1]/NonCashCheckboxInd"                   
[489] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[1]/Desc"                                 
[490] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[1]/ContributionCnt"                      
[491] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[1]/NoncashContributionsRptF990Amt"       
[492] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[1]/MethodOfDeterminingRevenuesTxt"       
[493] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[2]"                                      
[494] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[2]/NonCashCheckboxInd"                   
[495] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[2]/Desc"                                 
[496] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[2]/ContributionCnt"                      
[497] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[2]/NoncashContributionsRptF990Amt"       
[498] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[2]/MethodOfDeterminingRevenuesTxt"       
[499] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[3]"                                      
[500] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[3]/NonCashCheckboxInd"                   
[501] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[3]/Desc"                                 
[502] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[3]/ContributionCnt"                      
[503] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[3]/NoncashContributionsRptF990Amt"       
[504] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[3]/MethodOfDeterminingRevenuesTxt"       
[505] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[4]"                                      
[506] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[4]/NonCashCheckboxInd"                   
[507] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[4]/Desc"                                 
[508] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[4]/ContributionCnt"                      
[509] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[4]/NoncashContributionsRptF990Amt"       
[510] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[4]/MethodOfDeterminingRevenuesTxt"       
[511] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[5]"                                      
[512] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[5]/NonCashCheckboxInd"                   
[513] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[5]/Desc"                                 
[514] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[5]/ContributionCnt"                      
[515] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[5]/NoncashContributionsRptF990Amt"       
[516] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[5]/MethodOfDeterminingRevenuesTxt"       
[517] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[6]"                                      
[518] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[6]/NonCashCheckboxInd"                   
[519] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[6]/Desc"                                 
[520] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[6]/ContributionCnt"                      
[521] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[6]/NoncashContributionsRptF990Amt"       
[522] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[6]/MethodOfDeterminingRevenuesTxt"       
[523] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[7]"                                      
[524] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[7]/NonCashCheckboxInd"                   
[525] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[7]/Desc"                                 
[526] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[7]/ContributionCnt"                      
[527] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[7]/NoncashContributionsRptF990Amt"       
[528] "/Return/ReturnData/IRS990ScheduleM/OtherNonCashContriTableGrp[7]/MethodOfDeterminingRevenuesTxt"       
[529] "/Return/ReturnData/IRS990ScheduleM/AnyPropertyThatMustBeHeldInd"                                       
[530] "/Return/ReturnData/IRS990ScheduleM/ReviewProcessUnusualNCGiftsInd"                                     
[531] "/Return/ReturnData/IRS990ScheduleM/ThirdPartiesUsedInd"                       




############         SCHEDULE O        ################

[532] "/Return/ReturnData/IRS990ScheduleO"                                                                    
[533] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[1]"                                   
[534] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[1]/FormAndLineReferenceDesc"          
[535] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[1]/ExplanationTxt"                    
[536] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[2]"                                   
[537] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[2]/FormAndLineReferenceDesc"          
[538] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[2]/ExplanationTxt"                    
[539] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[3]"                                   
[540] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[3]/FormAndLineReferenceDesc"          
[541] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[3]/ExplanationTxt"                    
[542] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[4]"                                   
[543] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[4]/FormAndLineReferenceDesc"          
[544] "/Return/ReturnData/IRS990ScheduleO/SupplementalInformationDetail[4]/ExplanationTxt"




















########################################################################################
########################################################################################
########################################################################################




buildCore <- function( eins, form.type="990", years, modules="all", index=NULL )
{
  
  library( dplyr )
  library( xml2 )
  
  if( isNULL(index) ) { index <- buildIndex() }
  
  # subset index
  
  these <- index[ index$EIN %in% eins & index$FilingYear %in% years & index$FormType %in% form.type , "URL" ]
  
  core <- NULL
  
  for( i in 1:length(these) )
  {
     one.npo <- scrapeXML( these[i], form.type, modules )
     
     core <- bind_rows( core, one.npo )
  }
  
  return( core )

}




# STEPS

# 1. Build Index
# 2. Select EINs
# 3. Build Core




tiny.index <-
structure(list(EIN = c("562629114", "270678774", "464114252", 
"510311790", "261460932", "270609504", "205710892", "251910030", 
"521548962", "731653383", "731653383", "510311790", "521548962", 
"270678774", "731653383", "270609504", "521548962", "521548962", 
"205710892", "510311790", "731653383", "562629114", "562629114", 
"205710892", "731653383", "270609504", "731653383", "270609504", 
"205710892", "205710892", "562629114", "270678774", "521548962", 
"562629114", "270609504", "261460932"), SubmittedOn = c("2016-02-09", 
"2016-02-09", "2016-02-09", "2016-02-10", "2016-02-10", "2016-02-10", 
"2016-02-10", "2016-02-10", "2016-02-10", "2016-02-10", "2015-03-10", 
"2014-12-29", "2014-12-29", "2014-01-31", "2014-04-10", "2014-12-29", 
"2013-12-31", "2012-12-21", "2011-11-29", "2013-12-20", "2012-05-30", 
"2012-07-09", "2012-11-07", "2012-11-06", "2012-11-19", "2012-12-05", 
"2011-03-09", "2011-10-24", "2014-12-29", "2014-03-11", "2014-12-02", 
"2014-12-29", "2016-02-22", "2013-09-10", "2013-12-23", "2014-12-29"
), TaxPeriod = c("201412", "201509", "201412", "201506", "201412", 
"201412", "201506", "201506", "201412", "201506", "201406", "201406", 
"201312", "201309", "201306", "201312", "201212", "201112", "201106", 
"201306", "201106", "201012", "201112", "201206", "201206", "201112", 
"201006", "201012", "201406", "201306", "201312", "201409", "201312", 
"201212", "201212", "201312"), DLN = c("93492310002195", "93492308002265", 
"93492308002365", "93493322003275", "93493308018295", "93493317062985", 
"93492317011085", "93492317037835", "93493320047685", "93493317073435", 
"93493044018515", "93493342000094", "93493321110804", "93492354003113", 
"93493038015134", "93493318081014", "93493319093053", "93493320089862", 
"93492313004201", "93493294009073", "93493096004312", "93492170000102", 
"93492286001052", "93492235004102", "93493263008032", "93493311013842", 
"93493041001331", "93493181007751", "93492318013474", "93492027003174", 
"93492304002184", "93492322005294", "93493324007125", "93492211001223", 
"93493318038073", "93493318080534"), LastUpdated = c("2016-04-29T13:40:20", 
"2016-03-21T17:23:53", "2016-03-21T17:23:53", "2016-03-21T17:23:53", 
"2016-04-29T13:40:20", "2016-04-29T13:40:20", "2016-04-29T13:40:20", 
"2016-04-29T13:40:20", "2016-04-29T13:40:20", "2016-04-29T13:40:20", 
"2016-03-21T17:23:53", "2016-03-21T17:23:53", "2016-03-21T17:23:53", 
"2016-03-21T17:23:53", "2016-03-21T17:23:53", "2016-03-21T17:23:53", 
"2016-03-21T17:23:53", "2016-03-21T17:23:53", "2016-03-21T17:23:53", 
"2016-03-21T17:23:53", "2016-03-21T17:23:53", "2016-03-21T17:23:53", 
"2016-03-21T17:23:53", "2016-03-21T17:23:53", "2016-03-21T17:23:53", 
"2016-03-21T17:23:53", "2016-03-21T17:23:53", "2016-03-21T17:23:53", 
"2016-03-21T17:23:53", "2016-03-21T17:23:53", "2016-03-21T17:23:53", 
"2016-03-21T17:23:53", "2016-03-21T17:23:53", "2016-03-21T17:23:53", 
"2016-03-21T17:23:53", "2016-03-21T17:23:53"), FormType = c("990EZ", 
"990EZ", "990EZ", "990", "990", "990", "990EZ", "990EZ", "990", 
"990", "990", "990", "990", "990EZ", "990", "990", "990", "990", 
"990EZ", "990", "990", "990EZ", "990EZ", "990EZ", "990", "990", 
"990", "990", "990EZ", "990EZ", "990EZ", "990EZ", "990", "990EZ", 
"990", "990"), ObjectId = c("201543109349200219", "201513089349200226", 
"201513089349200236", "201523229349300327", "201543089349301829", 
"201533179349306298", "201533179349201108", "201533179349203783", 
"201533209349304768", "201533179349307343", "201510449349301851", 
"201443429349300009", "201403219349311080", "201313549349200311", 
"201430389349301513", "201413189349308101", "201303199349309305", 
"201213209349308986", "201103139349200420", "201322949349300907", 
"201210969349300431", "201201709349200010", "201202869349200105", 
"201202359349200410", "201232639349300803", "201243119349301384", 
"201130419349300133", "201101819349300775", "201423189349201347", 
"201420279349200317", "201433049349200218", "201443229349200529", 
"201523249349300712", "201322119349200122", "201323189349303807", 
"201433189349308053"), OrganizationName = c("BROWN COMMUNITY DEVELOPMENT CORPORATION", 
"KIWANIS CLUB OF GLENDORA PROJECTS FUND INC", "CONFETTI FOUNDATION", 
"SHEPHERD PLACE INC", "WISE VOLUNTEER FIRE DEPARTMENT INC", "A HOLE IN THE ROOF FOUNDATION", 
"PTA DBA CARROLL ELEMENTARY PTA CALIFORNIA CONGRESS OF PARENTS", 
"LEAGUE OF THE SAN FRANCISCO CONSULAR CORPS", "TAXICAB LIMOUSINE AND PARATRANSIT FOUNDATION", 
"WHATCOM COUNTY NORTH ROTARY CLUB", "WHATCOM COUNTY NORTH ROTARY CLUB", 
"SHEPHERD PLACE INC", "TAXICAB LIMOUSINE AND PARATRANSIT FOUNDATION", 
"KIWANIS CLUB OF GLENDORA PROJECTS FUND INC", "ROTARY CLUB OF WHATCOM COUNTY NORTH", 
"A HOLE IN THE ROOF FOUNDATION", "TAXICAB LIMOUSINE AND PARATRANSIT FOUNDATION", 
"TAXICAB LIMOUSINE AND PARATRANSIT FOUNDATION", "PTAC CARROLL ELEMENTARY PTA CALIFORNIA CONGRESS OF PARENTS", 
"SHEPHERD PLACE INC", "WHATCOM COUNTY NORTH ROTARY CLUB", "BROWN COMMUNITY DEVELOPMENT CORPORATION", 
"BROWN COMMUNITY DEVELOPMENT CORPORATION", "PTAC DBA CARROLL ELEMENTARY PTA CALIFORNIA CONGRESS OF PARENTS", 
"WHATCOM COUNTY NORTH ROTARY CLUB", "A HOLE IN THE ROOF FOUNDATION", 
"WHATCOM COUNTY NORTH ROTARY CLUB", "A HOLE IN THE ROOF FOUNDATION", 
"PTA CARROL ELEMENTARY CALIFORNIA CONGRESS", "PTAC CARROLL ELEMENTARY PTA CALIFORNIA CONGRESS OF PARENTS", 
"BROWN COMMUNITY DEVELOPMENT CORPORATION", "KIWANIS CLUB OF GLENDORA PROJECTS FUND INC", 
"TAXICAB LIMOUSINE AND PARATRANSIT FOUNDATION", "BROWN COMMUNITY DEVELOPMENT CORPORATION", 
"A HOLE IN THE ROOF FOUNDATION", "WISE VOLUNTEER FIRE DEPARTMENT INC"
), IsElectronic = c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 
TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 
TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 
TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE), IsAvailable = c(TRUE, 
TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 
TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 
TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 
TRUE, TRUE), URL = c("https://s3.amazonaws.com/irs-form-990/201543109349200219_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201513089349200226_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201513089349200236_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201523229349300327_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201543089349301829_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201533179349306298_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201533179349201108_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201533179349203783_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201533209349304768_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201533179349307343_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201510449349301851_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201443429349300009_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201403219349311080_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201313549349200311_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201430389349301513_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201413189349308101_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201303199349309305_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201213209349308986_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201103139349200420_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201322949349300907_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201210969349300431_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201201709349200010_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201202869349200105_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201202359349200410_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201232639349300803_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201243119349301384_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201130419349300133_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201101819349300775_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201423189349201347_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201420279349200317_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201433049349200218_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201443229349200529_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201523249349300712_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201322119349200122_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201323189349303807_public.xml", 
"https://s3.amazonaws.com/irs-form-990/201433189349308053_public.xml"
), FilingYear = c("2014", "2015", "2014", "2015", "2014", "2014", 
"2015", "2015", "2014", "2015", "2014", "2014", "2013", "2013", 
"2013", "2013", "2012", "2011", "2011", "2013", "2011", "2010", 
"2011", "2012", "2012", "2011", "2010", "2010", "2014", "2013", 
"2013", "2014", "2013", "2012", "2012", "2013")), .Names = c("EIN", 
"SubmittedOn", "TaxPeriod", "DLN", "LastUpdated", "FormType", 
"ObjectId", "OrganizationName", "IsElectronic", "IsAvailable", 
"URL", "FilingYear"), row.names = c(2L, 3L, 4L, 5L, 6L, 7L, 9L, 
11L, 12L, 13L, 149688L, 536287L, 544691L, 618530L, 681035L, 1117099L, 
1160660L, 1627887L, 1652677L, 1673174L, 1895881L, 2007557L, 2167297L, 
2170274L, 2237452L, 2276914L, 2393717L, 2772863L, 2929397L, 2947721L, 
2980024L, 2989013L, 3007443L, 3120557L, 3139206L, 3360575L), class = "data.frame")
