# DOCUMENTATION FOR BASIC INFO MODULE

```
# Created in July 2016 by Jesse Lecy
# Update October 2016 by Francisco Santamarina
```

## Data Dictionary
##### Entries for 990 and 990EZ are in the following format: Part (in roman numerals), section letter (if applicable), row number, sub-row letter, column (if applicable). 
######Values that do not start with roman numerals are in the form header section.
##### "." indicates that version of tax form does not have that field.

Variable | Description | 990 2015 | 990EZ 2015
---------|-------------|-----|------------
URL | Web address of IRS return in XML format | XML | XML
NAME | Nonprofit Name | Header,C | Header,C
EIN | Employer Identification Number | Header,D | Header,D
DBA | Doing-business-as name | Header,C | .
EXEMPTSTATUS | Tax-exempt status | Header,I | Header,J
FORMORG | Form of organization | Header,K | Header,K 
FORMYEAR | Year that the nonprofit was formed | Header,L | .
DOMICILE | State of legal domocile of the nonprofit | Header,M | .
WEBSITE | Web address of the nonprofit | Header,J | Header,I (box location in initial form area)
ADDRESS | Nonprofit address | Header,C | Header,C
CITY | Domicile city of nonprofit | Header,C | Header,C
STATE | Domicile state of nonprofit | Header,C | Header,C
ZIP | 5-digit zip code | Header,C | Header,C
FORM | Type of return: 990 or 990EZ | XML | XML
TAXPREP | Person who prepared the form | Header,F | .
FISYR | Tax year of returns | XML | XML
STYEAR | Start date of tax year for the nonprofit | Header,A | Header,A
ENDYEAR | End date of tax year | Header,A | Header,A
GROSSRECEIPTS | Determines if org. files EZ or PC | Header,G | Header,L
GROUPRETURN | ... | Header,H(a) | .
GROUPEXEMPTNUM | Group exemption number | Header,H(c) | Header,F 
VOTINGMEMBERS | Number of voting board members | I,3  | .
INDVOTINGMEMBERS | Number of indepdendent board members | I,4 | .
TOTEMPLOYEE | Total number of employees | I,5 | .
TOTVOLUNTEERS | Total number of volunteers | I,6 | .
TOTUBI | ... | I,7,a | .
NETUBI | ... | I,7,b | .
CONTRIBPRIOR | Contributions and grants from prior year | I,8,Prior Year | .
CONTRIBCURRENT | Contributions and grants from current year | I,8,Current Year | I,1
PSRPRIOR | Program Service Revenue from prior year | I,9,Prior Year | .
PSRCURRENT | Program Service Revenue from current year | I,9,Current Year | I,2
INVINCPRIOR | Investment Income from prior year | I,10,Prior Year | .
INVINCCURRENT | Investment Income from current year | I,10,Current Year | I,4
OTHERREVPRIOR | ... | I,11,Prior Year | .
OTHERREVCURRENT | ... | I,11,Current Year | I,8
TOTALREVPRIOR | ... | I,12,Prior Year | .
TOTALREVCURRENT | ... | I,12,Current Year | I,9
MEMBERDUES | Membership dues | VIII,1,b | I,3
GROSSSALESOTHER | Gross sales of non-inventory assets | VIII,7a,(ii) Other | I,5,a
SALESCOSTOTHER | Cost, sales expenses from gross sales of non-inventory assets | VIII,7b,(ii) Other | I,5,b
NETSALESOTHER | Sales minus sales expenses | VIII,7c,(ii) Other; 7d includes securities | I,5,c
GROSSINCGAMING | Gross income from gaming | VIII,9a | I,6,a
GROSSINCFNDEVENTS | Gross income from fundraising events | VIII,8a | I,6,b
EXPGAMINGFNDEVENTS | Expenses from gaming and fundraising events | sum VIII,8b and VIII,9b | I,6,c
NETGAMINGFNDEVENTS | Net difference of gaming and fundraising income minus expenses | sum VIII,8c,(A) Total Revenue and VIII,9c, (A) Total Revenue | I,6,d
GROSSSALESINV | Gross sales of inventory assets | VIII,10a | I,7,a
SALESCOSTINV | Cost of goods sold | VIII,10b | I,7,b
NETSALESINV | Net difference of sales minus cost of goods | VIII,10c,(A) Total Revenue | I,7,c
GRANTSPAIDPRIOR | Grants and similar amounts paid in past year | I,13,Prior Year | .
GRANTSPAIDCURRENT | Grants and similar amounts paid in current year | I,13,Current Year | I,10
MEMBERBENPRIOR | Benefits paid to or for members in past year | I,14,Prior Year | .
MEMBERBENCURRENT | Benefits paid to or for members in past year | I,14,Current Year | I,11 
SALARIESPRIOR | ... | I,15,Prior Year | .
SALARIESCURRENT | ... | I,15,Current Year | I,12
PROFUNDFEESPRIOR | Professional fundraising fees from prior year | I,16,a,Prior Year | .
PROFUNDFEESCURRENT | Professional fundraising fees from current year | I,16,a,Current Year | .
TOTFUNDEXP | Total fundraising expenses | I,16,b | .
PROFEESINDEP | Professional fees to indepdent contractors | sum of IX,11a:g,(A) Total expenses | I,13
OCCUPANCY | ... | IX,16,(A) Total Revenue | I,14
OFFICEEXP | Printing, publications, and office expenses | IX,13,(A) Total Revenue | I,15
OTHEREXPPRIOR | ... | I,17,Prior Year | .
OTHEREXPCURRENT | ... | I,17,Current Year | I,16
TOTALEXPPRIOR | ... | I,18,Prior Year | .
TOTALEXPCURRENT | ... | I,18,Current Year | I,17
REVLESSEXPPRIOR | Must equal TOTALEXPPRIOR minus TOTALREVPRIOR | I,18,Prior Year | .
REVLESSEXPCURRENT | Must equal TOTALEXPCURRENT minus TOTALREVCURRENT | I,18,Current Year | I,18
TOTALASSETSBEGYEAR | ... | I,20,Beginning of Current Year | II,25,(A)Beginning of year
TOTALASSETSENDYEAR | ... | I,20,End of Year | II,25,(B)End of year
TOTALLIABBEGYEAR | Total liabilities at beginning of year | I,21,Beginning of Current Year | II,26,(A)Beginning of year
TOTALLIABENDYEAR | Total liabilities at end of year | I,21,End of Year | II,26,(B)End of year
NETASSETSBEGYEAR | Net assets from beginning of year | I,22,Beginning of Current Year | I,19; should equal II,27,(A)Beginning of year
OTHERASSETSCHANGES | Other changes in net assets or fund balances | . | I,20
NETASSETSENDYEAR | Net assets from end of year | I,22,End of Year | I,21; should equal II,27,(B)End of year
CASHBEGYEAR | Cash at beginning of year | X,1,(A)Beginning of year | .
CASHENDYEAR | Cash at end of year | X,1,(B)End of year | .
SAVINVBEGYEAR | Savings and temp. cash investments at beginning of year | X,2,(A)Beginning of year | .
SAVINVENDYEAR | Savings and temp. cash investments at end of year | X,2,(B)End of year | .
CASHINVBEGYEAR | Cash, savings, and investments at beginning of year | Sum of CASHBEGYEAR and SAVINVBEGYEAR | II,22,(A)Beginning of year
CASHINVENDYEAR | Cash, savings, and investments at end of year | Sum of CASHENDYEAR and SAVINVENDYEAR | II,22,(B)End of year
LANDBLDEQUIPCOST | Cost of land, buildings, and equipment | X,10,a | .
LANDBLDEQUIPDEP | Accumulated depreciation of the land, etc. | X,10,b | .
LANDBEGYEAR | Land and buildings less appreciation at beginning of year | X,10,c,(A)Beginning of year | II,23,(A)Beginning of year
LANDENDYEAR | Land and buildings less appreciation at end of year | X,10,c,(B)End of year | II,23,(B)End of year
OTHERASSETSBEGYEAR | Other assets at beginning of year | X,15,(A)Beginning of year | II,24,(A)Beginning of year
OTHERASSETSENDYEAR | Other assets at end of year | X,15,(B)End of year | II,24,(B)End of year
TOTALPROGSERVEXP | Total program service expenses | III,4,e | III,32


	                          
Notes: 

Fix TAXPREP so it represents whether an external agency filed the return - currently represents whether third party is authorized to speak with IRS regarding the returns.

TYPEOFORG - this field is supposed to represent the type of organization, but currently only indicates whether the nonprofit selected any of the options, but not which one was selected

TAXEXMSTATUS - this field is supposed to report the type of tax exempt status granted to the organization, but it currently only indicates whether the nonprofit selected any of the options, but not which one was selected
