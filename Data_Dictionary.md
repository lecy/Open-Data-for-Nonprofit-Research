
# DOCUMENTATION FOR BASIC INFO MODULE 
 
``` 
# Created in July 2016 by Jesse Lecy 
# Update February 2017 by Francisco Santamarina 
``` 
 
## Data Dictionary 
Entries for 990 and 990EZ are in the following format: Part (in roman numerals), section letter (if applicable), row number, sub-row letter, column (if applicable).  

Values that do not start with roman numerals are in the form header section. 

"." indicates that version of tax form does not have that field. 
 
 
Variable | Description | 990 PC 2015 | 990EZ 2015 | 2013 and after Field Name | Pre-2013 Field Name | Production Rules  
---------|-------------|-------------|---------------|------------|----- |------------------------------------------------
EIN | Employer Identification Number | Header,D | EIN | Header,D | EIN | .  
NAME | Nonprofit Name | Header,C | Header,C | BusinessNameLine1Txt | BusinessNameLine1 | .  
DBA | Doing-business-as name | Header,C | . | BusinessNameLine2Txt | BusinessNameLine2 | . 
FISYR | Tax year of returns | XML | XML | TaxYr | TaxYear | . 


STATE | Domicile state of nonprofit | Header,C | Header,C | . 
ADDRESS | Nonprofit address | Header,C | Header,C | . 
CITY | Domicile city of nonprofit | Header,C | Header,C | . 
ZIP | 5-digit zip code | Header,C | Header,C | . 
STYEAR | Start date of tax year for the nonprofit | Header,A | Header,A | . 
ENDYEAR | End date of tax year | Header,A | Header,A | . 
TAXPREP | Person who prepared the form | Header,F | . | . 
TAXFORM | Type of return: 990 or 990EZ | XML | XML | . 
GROSSRECEIPTS | Determines if org. files EZ or PC | Header,G | Header,L | . 
GROUPRETURN | ... | Header,H(a) | . | . 
GROUPEXEMPTNUM | Group exemption number | Header,H(c) | Header,F  | . 
FORMYEAR | Year that the nonprofit was formed | Header,L | . | . 
DOMICILE | State of legal domicile of the nonprofit | Header,M | (Not on form but in XML) | . 
WEBSITE | Web address of the nonprofit | Header,J | Header,I (box location in initial form area) | . 
URL | Web address of IRS return in XML format | XML | XML | . | . | . 
FORMORGASSOC | Form of organization is an assocation | Header,K | Header,K | Replace null with NA. If the value is "X", replace with "Assocation" 
FORMORGCORP | Form of organization is a corporation | Header,K | Header,K | Replace null with NA. If the value is "X", replace with "Corporation" 
FORMORGTRUST | Form of organization is a trust | Header,K | Header,K | Replace null with NA. If the value is "X", replace with "Trust" 
FORMORGOTHER | Form of organization is Other (write-in) | Header,K | Header,K | Replace null with NA. If the value is "X", replace with "" 
FORMORGOTHERDESC | Written-in description of the organization's form | Header,K | Header,K | . 
FORMORG | Reports form of the organization | . | . | Collapse the values of the other FORMORG-variables and strips NAs. If no other values, return NA. 
ACCTACCRUAL | Accrual accounting method | XII,1 | Header,G | Replace null with NA. If the value is "X", replace with "Accrual" 
ACCTCASH | Cash accounting method | XII,1 | Header,G | Replace null with NA. If the value is "X", replace with "Cash" 
ACCTOTHER | Accrual accounting method | XII,1 | Header,G | Replace null with NA; otherwise, should return a string 
ACCTMETHOD | Reports accounting method of the organization | . | . | Collapse the values of the other Accounting variables and strips NAs. If no other values, return NA. 
EXEMPT4947A1 | Tax-exempt status | Header,I | Header,J | Replace null with NA. If the value is "X", replace with "4947a1" 
EXEMPT501C | Tax-exempt status | Header,I | Header,J | Replace null with NA. If the value is "X", replace with "501c" 
EXEMPT501CNUM | Tax-exempt status | Header,I | Header,J | . 
EXEMPT501C3 | Tax-exempt status | Header,I | Header,J | Replace null with NA. If the value is "X", replace with "501c3" 
EXEMPT527 | Tax-exempt status | Header,I | Header,J | Replace null with NA. If the value is "X", replace with "527" 
EXEMPTSTATUS | Reports tax exempt status | . | . | Collapse the values of the other EXEMPT-variables and strips NAs. If no other values, return NA. 
MISSION | Brief description of organization's mission | I,1 | . | .  
DISCOPS | Checked box if organization discontinued operations or disposed of >25% of assets | I,2 | . | .  
VOTINGMEMBERS | Number of voting board members | I,3  | . | . 
INDVOTINGMEMBERS | Number of indepdendent board members | I,4 | . | . 
TOTEMPLOYEE | Total number of employees | I,5 | . | . 
TOTVOLUNTEERS | Total number of volunteers | I,6 | . | . 
TOTUBI | Total unrelated business income | I,7,a | . | . 
NETUBI | Net unrelated business income | I,7,b | . | . 
CONTRIBPRIOR | Contributions and grants from prior year | I,8,Prior Year | . | . 
CONTRIBCURRENT | Contributions and grants from current year | I,8,Current Year | I,1 | . 
PSRPRIOR | Program Service Revenue from prior year | I,9,Prior Year | . | . 
PSRCURRENT | Program Service Revenue from current year | I,9,Current Year | I,2 | . 
INVINCPRIOR | Investment Income from prior year | I,10,Prior Year | . | . 
INVINCCURRENT | Investment Income from current year | I,10,Current Year | I,4 | . 
OTHERREVPRIOR | Other revenue in the prior year | I,11,Prior Year | . | . 
OTHERREVCURRENT | Other revenue in the current year | I,11,Current Year | I,8 | Replace NA with 0 
TOTALREVPRIOR | Total revenue in the prior year | I,12,Prior Year | . | . 
TOTALREVCURRENT | Other revenue in the current year | I,12,Current Year | I,9 | . 
MEMBERDUES | Membership dues | VIII,1,b | I,3 | . 
GROSSSALESOTHER | Gross sales of non-inventory assets | VIII,7a,(ii) Other | I,5,a | . 
SALESCOSTOTHER | Cost, sales expenses from gross sales of non-inventory assets | VIII,7b,(ii) Other | I,5,b | . 
NETSALESOTHER | Sales minus sales expenses | VIII,7c,(ii) Other; 7d includes securities | I,5,c | . 
GROSSINCGAMING | Gross income from gaming | VIII,9a | I,6,a | . 
GROSSINCFNDEVENTS | Gross income from fundraising events | VIII,8a | I,6,b | . 
GAMINGEXP | Expenses from gaming | VIII,8b | . | Replace null with NA.  
FNDEVENTSEXP | Expenses from fundraising events | VIII,9b | . | Replace null with NA.  
EXPGAMINGFNDEVENTS | Expenses from gaming and fundraising events | . | I,6,c | For PC, sum of GAMINGEXP and FNDEVENTSEXP. 
GAMINGNET | Net gain or loss from gaming | VIII,8c,(A) Total Revenue | . | Replace null with NA.  
FNDEVENTSNET | Net gain or loss from fundraising events | VIII,9c, (A) Total Revenue | . | Replace null with NA.  
NETGAMINGFNDEVENTS | Net difference of gaming and fundraising income minus expenses | sum GAMINGNET and FNDEVENTSNET | I,6,d | For PC, sum GAMINGNET and FNDEVENTSNET. 
GROSSSALESINV | Gross sales of inventory assets | VIII,10a | I,7,a | . 
SALESCOSTINV | Cost of goods sold | VIII,10b | I,7,b | . 
NETSALESINV | Net difference of sales minus cost of goods | VIII,10c,(A) Total Revenue | I,7,c | . 
GRANTSPAIDPRIOR | Grants and similar amounts paid in past year | I,13,Prior Year | . | . 
GRANTSPAIDCURRENT | Grants and similar amounts paid in current year | I,13,Current Year | I,10 | . 
MEMBERBENPRIOR | Benefits paid to or for members in past year | I,14,Prior Year | . | . 
MEMBERBENCURRENT | Benefits paid to or for members in past year | I,14,Current Year | I,11 | . 
SALARIESPRIOR | Salaries in the prior year | I,15,Prior Year | . | . 
SALARIESCURRENT | Salaries in the current year | I,15,Current Year | I,12 | . 
PROFUNDFEESPRIOR | Professional fundraising fees from prior year | I,16,a,Prior Year | . | . 
PROFUNDFEESCURRENT | Professional fundraising fees from current year | I,16,a,Current Year | . | . 
TOTFUNDEXP | Total fundraising expenses | I,16,b | . | . 
FEESMGMT | Fees for management services | IX,11a,(A) Total expenses | . | Replace null with NA.  
FEESLEGAL | Fees for legal services | IX,11b,(A) Total expenses | . | Replace null with NA.  
FEESACCT | Fees for accounting services | IX,11c,(A) Total expenses | . | Replace null with NA.  
FEESLOBBY | Fees for lobbying services | IX,11d,(A) Total expenses | . | Replace null with NA.  
FEESPROFND | Fees for professional fundraising services | IX,11e,(A) Total expenses | . | Replace null with NA.  
FEESINVMGMT | Fees for investment management services | IX,11f,(A) Total expenses | . | Replace null with NA.  
FEESOTHER | Fees for other services | IX,11g,(A) Total expenses | . | Replace null with NA.  
PROFEESINDEP | Professional fees to indepdent contractors | . | I,13 | For PC, sum the 7 variables beginning with "FEES". 
OCCUPANCY | ... | IX,16,(A) Total Revenue | I,14 | . 
OFFICEEXP | Printing, publications, and office expenses | IX,13,(A) Total Revenue | I,15 | . 
OTHEREXPPRIOR | Other expenses in the prior year | I,17,Prior Year | . | . 
OTHEREXPCURRENT | Other expenses in the current year | I,17,Current Year | I,16 | . 
TOTALEXPPRIOR | Total expenses in the prior year | I,18,Prior Year | . | . 
TOTALEXPCURRENT | Total expenses in the current year | I,18,Current Year | I,17 | . 
REVLESSEXPPRIOR | Must equal TOTALEXPPRIOR minus TOTALREVPRIOR | I,18,Prior Year | . | . 
REVLESSEXPCURRENT | Must equal TOTALEXPCURRENT minus TOTALREVCURRENT | I,18,Current Year | I,18 | . 
TOTALASSETSBEGYEAR | Total assets at beginning of year | I,20,Beginning of Current Year | II,25,(A)Beginning of year | . 
TOTALASSETSENDYEAR | Total assets at end of year | I,20,End of Year | II,25,(B)End of year | . 
TOTALLIABBEGYEAR | Total liabilities at beginning of year | I,21,Beginning of Current Year | II,26,(A)Beginning of year | . 
TOTALLIABENDYEAR | Total liabilities at end of year | I,21,End of Year | II,26,(B)End of year | . 
NETASSETSBEGYEAR | Net assets from beginning of year | I,22,Beginning of Current Year | I,19; should equal II,27,(A)Beginning of year | . 
OTHERASSETSCHANGES | Other changes in net assets or fund balances | . | I,20 | . 
NETASSETSENDYEAR | Net assets from end of year | I,22,End of Year | I,21; should equal II,27,(B)End of year | . 
CASHBEGYEAR | Cash at beginning of year | X,1,(A)Beginning of year | . | Replace null with NA. 
CASHENDYEAR | Cash at end of year | X,1,(B)End of year | . | Replace null with NA. 
SAVINVBEGYEAR | Savings and temp. cash investments at beginning of year | X,2,(A)Beginning of year | . | Replace null with NA. 
SAVINVENDYEAR | Savings and temp. cash investments at end of year | X,2,(B)End of year | . | Replace null with NA. 
CASHINVBEGYEAR | Cash, savings, and investments at beginning of year | . | II,22,(A)Beginning of year | For PC, sum of CASHBEGYEAR and SAVINVBEGYEAR. 
CASHINVENDYEAR | Cash, savings, and investments at end of year | . | II,22,(B)End of year | For PC, sum of CASHENDYEAR and SAVINVENDYEAR. 
LANDBLDEQUIPCOST | Cost of land, buildings, and equipment | X,10,a | . | . 
LANDBLDEQUIPDEP | Accumulated depreciation of the land, etc. | X,10,b | . | . 
LANDBEGYEAR | Land and buildings less appreciation at beginning of year | X,10,c,(A)Beginning of year | II,23,(A)Beginning of year | . 
LANDENDYEAR | Land and buildings less appreciation at end of year | X,10,c,(B)End of year | II,23,(B)End of year | . 
OTHERASSETSBEGYEAR | Other assets at beginning of year | X,15,(A)Beginning of year | II,24,(A)Beginning of year | . 
OTHERASSETSENDYEAR | Other assets at end of year | X,15,(B)End of year | II,24,(B)End of year | . 
TOTALPROGSERVEXP | Total program service expenses | III,4,e | III,32 | . 
LOBBYING | Organization engaged in lobbying activities | IV, 4 | VI, 47 | . 
SCHEDOPARTVI | Check box if Schedule O contains responses to this part | VI, top check box | . | .  
VMGOVERNING | Voting members in the governing body | VI, 1a | . | . 
IVMGOVERNING | Voting members in the governing body | VI, 1b | . | . 
PLEDGEGRANTBEGYEAR | Pledges and grants receivable at beginning of year | X,3,(A)Beginning of year | . | . 
PLEDGEGRANTENDYEAR | Pledges and grants receivable at end of year | X,3,(B)End of year | . | . 
ACCTRECBEGYEAR | Accounts receivable at beginning of year | X,4,(A)Beginning of year | . | . 
ACCTRECENDYEAR | Accounts receivable at end of year | X,4,(B)End of year | . | . 
LOANSFROMOFFBEGYEAR | Loans from current/former officers, etc. at beginning of year | X,5,(A)Beginning of year | . | . 
LOANSFROMOFFENDYEAR | Loan from current/former officers, etc. at end of year | X,5,(B)End of year | . | . 
LOANSDQPBEGYEAR | Loans from disqualified persons at beginning of year | X,6,(A)Beginning of year | . | . 
LOANSDQPENDYEAR | Loan from disqualified persons at end of year | X,6,(B)End of year | . | . 
LOANSNOTESBEGYEAR | Net notes and loans receivable at beginning of year | X,7,(A)Beginning of year | . | . 
LOANSNOTESENDYEAR | Net notes and loans receivable at end of year | X,7,(B)End of year | . | . 
INVENTORYBEGYEAR | Inventories for sale or use at beginning of year | X,8,(A)Beginning of year | . | . 
INVENTORYENDYEAR | Inventories for sale or use at end of year | X,8,(B)End of year | . | . 
PREEXPBEGYEAR | Prepaid expenses and deferred charges at beginning of year | X,9,(A)Beginning of year | . | . 
PREEXPENDYEAR | Prepaid expenses and deferred charges at end of year | X,9,(B)End of year | . | . 
INVESTPUBBEGYEAR | Publicly-traded securities investments at beginning of year | X,11,(A)Beginning of year | . | . 
INVESTPUBENDYEAR | Publicly-traded securities investments at end of year | X,11,(B)End of year | . | . 
INVESTOTHBEGYEAR | Other securities investments at beginning of year | X,12,(A)Beginning of year | . | . 
INVESTOTHENDYEAR | Other securities investments at end of year | X,12,(B)End of year | . | . 
INVESTPRGBEGYEAR | Program-related investments at beginning of year | X,13,(A)Beginning of year | . | . 
INVESTPRGENDYEAR | Program-related investments at end of year | X,13,(B)End of year | . | . 
INTANASSETSBEGYEAR | Intangible assets at beginning of year | X,14,(A)Beginning of year | . | . 
INTANASSETSENDYEAR | Intangible assets at end of year | X,14,(B)End of year | . | . 
TABALSHEETBEGYEAR | Total assets at beginning of year, should equal TOTALASSETSBEGYEAR | X,16,(A)Beginning of year | . | . 
TABALSHEETENDYEAR | Total assets at end of year, should equal TOTALASSETSENDYEAR | X,16,(B)End of year | . | . 
ACCTPAYBEGYEAR | Accounts payable at beginning of year | X,17,(A)Beginning of year | . | . 
ACCTPAYENDYEAR | Accounts payable at end of year | X,17,(B)End of year | . | . 
GRANTSPAYBEGYEAR | Grants payable at beginning of year | X,18,(A)Beginning of year | . | . 
GRANTSPAYENDYEAR | Grants payable at end of year | X,18,(B)End of year | . | . 
DEFREVBEGYEAR | Deferred revenue at beginning of year | X,19,(A)Beginning of year | . | . 
DEFREVENDYEAR | Deferred revenue at end of year | X,19,(B)End of year | . | . 
BONDBEGYEAR | Tax-exempt bond liabilities at beginning of year | X,20,(A)Beginning of year | . | . 
BONDENDYEAR | Tax-exempt bond liabilities at end of year | X,20,(B)End of year | . | . 
ESCROWBEGYEAR | Escrow liabilities at beginning of year | X,21,(A)Beginning of year | . | . 
ESCROWENDYEAR | Escrow liabilities at end of year | X,21,(B)End of year | . | . 
LOANSTOOFFBEGYEAR | Loans to current/former officers, etc. at beginning of year | X,22,(A)Beginning of year | . | . 
LOANSTOOFFENDYEAR | Loans to current/former officers, etc. at end of year | X,22,(B)End of year | . | . 
MORTGAGEBEGYEAR | Secured mortgages at beginning of year | X,23,(A)Beginning of year | . | . 
MORTGAGEENDYEAR | Secured mortgages at end of year | X,23,(B)End of year | . | . 
UNSECNOTESBEGYEAR | Unsecured notes at beginning of year | X,24,(A)Beginning of year | . | . 
UNSECNOTESENDYEAR | Unsecured notes at end of year | X,24,(B)End of year | . | . 
OTHERLIABBEGYEAR | Other liabilities at beginning of year | X,25,(A)Beginning of year | . | . 
OTHERLIABENDYEAR | Other liabilities at end of year | X,25,(B)End of year | . | . 
TLBALSHEETBEGYEAR | Total liabilities at beginning of year, should equal TOTALLIABBEGYEAR | X,26,(A)Beginning of year | . | . 
TLBALSHEETENDYEAR | Total liabilities at end of year, should equal TOTALLIABENDYEAR | X,26,(B)End of year | . | . 
ORGSFAS117 | Organizations that follow SFAS 117 or ASC 958 | X,between 26 and 27 | . | . 
ORGNOTSFAS117 | Organizations do not that follow SFAS 117 or ASC 958 | X,between 29 and 30 | . | . 
URESTNABEGYEAR | Unrestricted net assets at beginning of year | X,27,(A)Beginning of year | . | . 
URESTNAENDYEAR | Unrestricted net assets at end of year | X,27,(B)End of year | . | . 
TRESTNABEGYEAR | Temporarily restricted net assets at beginning of year | X,28,(A)Beginning of year | . | . 
TRESTNAENDYEAR | Temporarily restricted net assets at end of year | X,28,(B)End of year | . | . 
PRESTNABEGYEAR | Permanently restricted net assets at beginning of year | X,29,(A)Beginning of year | . | . 
PRESTNAENDYEAR | Permanently restricted net assets at end of year | X,29,(B)End of year | . | . 
STOCKBEGYEAR | Capital stock or current funds at beginning of year | X,30,(A)Beginning of year | . | . 
STOCKENDYEAR | Capital stock or current funds at end of year | X,30,(B)End of year | . | . 
SURPLUSBEGYEAR | Paid-in surplus at beginning of year | X,31,(A)Beginning of year | . | . 
SURPLUSENDYEAR | Paid-in surplus at end of year | X,31,(B)End of year | . | . 
EARNINGSBEGYEAR | Retained earnings at beginning of year | X,32,(A)Beginning of year | . | . 
EARNINGSENDYEAR | Retained earnings at end of year | X,32,(B)End of year | . | . 
TOTNETASSETSBEGYEAR | Total net assets or fund balances at beginning of year | X,32,(A)Beginning of year | . | . 
TOTNETASSETSENDYEAR | Total net assets or fund balances at end of year | X,32,(B)End of year | . | . 
TOTLIABNABEGYEAR | Total liabilities and net assets/fund balances at beginning of year | X,33,(A)Beginning of year | . | . 
TOTLIABNAENDYEAR | Total liabilities and net assets/fund balances at end of year | X,33,(B)End of year | . | . 
LOBPOFILING | Public opinion/grass roots lobbying expenses of the filing organization  | Schedule C,II-A,1a(a) | Schedule C,II-A,1a(a) | . 
LOBPOAFFIL | Public opinion/grass roots lobbying expenses of affiliated groups | Schedule C,II-A,1a(b) | Schedule C,II-A,1a(b) | . 
LOBLBFILING | Legislative body/direct lobbying expenses of the filing organization | Schedule C,II-A,1b(a) | Schedule C,II-A,1b(a) | . 
LOBLBAFFIL | Legislative body/direct lobbying expenses of affiliated groups | Schedule C,II-A,1b(b) | Schedule C,II-A,1b(b) | . 
TOTLOBEXPFILING | Total lobbying expenses of the filing organization | Schedule C,II-A,1c(a) | Schedule C,II-A,1c(a) | . 
TOTLOBEXPAFFIL | Total lobbying expenses of affiliated groups | Schedule C,II-A,1c(b) | Schedule C,II-A,1c(b) | . 
OTHEREXMTFILING | Other exempt expenses of the filing organization | Schedule C,II-A,1d(a) | Schedule C,II-A,1d(a) | . 
OTHEREXMTAFFIL | Other exempt expenses of affiliated groups | Schedule C,II-A,1d(b) | Schedule C,II-A,1d(b) | . 
TOTEXMTFILING | Total exempt expenses of the filing organization | Schedule C,II-A,1e(a) | Schedule C,II-A,1e(a) | . 
TOTEXMTAFFIL | Total exempt expenses of affiliated groups | Schedule C,II-A,1e(b) | Schedule C,II-A,1e(b) | . 
LOBNTFILING | Lobbying nontaxable amount of the filing organization | Schedule C,II-A,1f(a) | Schedule C,II-A,1f(a) | . 
LOBNTAFFIL | Lobbying nontaxable amount of affiliated groups | Schedule C,II-A,1f(b) | Schedule C,II-A,1f(b) | . 
 
 
	                           
Notes:  
 
ACCTMETHOD - removed and broken out into 1 variable for each accounting method: Accrual, Cash, Other.  
 
Fix TAXPREP so it represents whether an external agency filed the return - currently represents whether third party is authorized to speak with IRS regarding the returns. 
 
FORMORG - this field is supposed to represent the form or type of organization, but currently only indicates whether the nonprofit selected any of the options, but not which one was selected. It has been broken out into the 4 options on the forms
