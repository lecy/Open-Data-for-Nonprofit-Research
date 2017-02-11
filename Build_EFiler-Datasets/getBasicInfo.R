# FUNCTION TO COLLECT HEADER MODULE
#
# Argument:  doc = xml document
#
# Return Value:  doca frame


getBasicInfo <- function( doc, url )
{


	#### FROM NCCS CORE - HEADER DATA

	## EIN
	#### EIN field is the same for all forms

	EIN  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/EIN" ) )



	## NAME
	## Name field is the same for forms of the same year (990 and 990EZ post-2013; 990 and 990EZ pre-2013)

	V_990NAMEpost2014 <- "//Return/ReturnHeader/Filer/BusinessName/BusinessNameLine1Txt"
	V_990NAME_2013 <- "//Return/ReturnHeader/Filer/BusinessName/BusinessNameLine1"
	V_990NAMEpre2013  <- "//Return/ReturnHeader/Filer/Name/BusinessNameLine1"
	name.xpath <- paste( V_990NAME_2013, V_990NAMEpre2013, V_990NAMEpost2014, sep="|" )
	NAME <- xml_text( xml_find_all( doc, name.xpath ) )



	## DOING BUSINESS AS

	V_990DBApost2013 <- "//Return/ReturnHeader/Filer/BusinessName/BusinessNameLine2Txt"
	V_990DBApre2013  <- "//Return/ReturnHeader/Filer/Name/BusinessNameLine2"
	dba.xpath <- paste( V_990DBApost2013, V_990DBApre2013, sep="|" )
	DBA  <- xml_text( xml_find_all( doc, dba.xpath ) )



	## FISCAL YEAR
	## Fiscal Year field is the same for forms of the same year (990 and 990EZ post-2013; 990 and 990EZ pre-2013)

	V_990FYRpost2013 <- "//Return/ReturnHeader/TaxYr"
	V_990FYRpre2013  <- "//Return/ReturnHeader/TaxYear"
	fiscal.year.xpath <- paste( V_990FYRpost2013, V_990FYRpre2013, sep="|" )
	FISYR <- xml_text( xml_find_all( doc, fiscal.year.xpath ) )



	## STATE
	## State field is the same for forms of the same year (990 and 990EZ post-2013; 990 and 990EZ pre-2013)

	V_990STATEpost2013 <- "//Return/ReturnHeader/Filer/USAddress/StateAbbreviationCd"
	V_990STATEpre2013  <- "//Return/ReturnHeader/Filer/USAddress/State"
	state.xpath <- paste( V_990STATEpost2013, V_990STATEpre2013, sep="|" )
	STATE <- xml_text( xml_find_all( doc, state.xpath ) )



	## ADDRESS
	## Address field is the same for forms of the same year (990 and 990EZ post-2013; 990 and 990EZ pre-2013)

	V_990ADDRpost2013 <- "//Return/ReturnHeader/Filer/USAddress/AddressLine1Txt"
	V_990ADDRpre2013  <- "//Return/ReturnHeader/Filer/USAddress/AddressLine1"
	address.xpath <- paste( V_990ADDRpost2013, V_990ADDRpre2013, sep="|" )
	ADDRESS <- xml_text( xml_find_all( doc, address.xpath ) )



	## CITY
	## City field is the same for forms of the same year (990 and 990EZ post-2013; 990 and 990EZ pre-2013)

	V_990CITYpost2013 <- "//Return/ReturnHeader/Filer/USAddress/CityNm"
	V_990CITYpre2013  <- "//Return/ReturnHeader/Filer/USAddress/City"
	city.xpath <- paste( V_990CITYpost2013, V_990CITYpre2013, sep="|" )
	CITY <- xml_text( xml_find_all( doc, city.xpath ) )



	## ZIP CODE
	## Zip field is the same for forms of the same year (990 and 990EZ post-2013; 990 and 990EZ pre-2013)

	V_990ZIPpost2013 <- "//Return/ReturnHeader/Filer/USAddress/ZIPCd"
	V_990ZIPpre2013  <- "//Return/ReturnHeader/Filer/USAddress/ZIPCode"
	zip.xpath <- paste( V_990ZIPpost2013, V_990ZIPpre2013, sep="|" )
	ZIP <- xml_text( xml_find_all( doc, zip.xpath ) )



	## START OF YEAR
	## Start of year field is the same for forms of the same year (990 and 990EZ post-2013; 990 and 990EZ pre-2013)

	V_990SYpost2013 <- "//Return/ReturnHeader/TaxPeriodBeginDt"
	V_990SYpre2013  <- "//Return/ReturnHeader/TaxPeriodBeginDate"
	start.year.xpath <- paste( V_990SYpost2013, V_990SYpre2013, sep="|" )
	STYEAR <- xml_text( xml_find_all( doc, start.year.xpath ) )



	## END OF YEAR
	## End of year field is the same for forms of the same year (990 and 990EZ post-2013; 990 and 990EZ pre-2013)

	V_990EYpost2013 <- "//Return/ReturnHeader/TaxPeriodEndDt"
	V_990EYpre2013  <- "//Return/ReturnHeader/TaxPeriodEndDate"
	end.year.xpath <- paste( V_990EYpost2013, V_990EYpre2013, sep="|" )
	ENDYEAR <- xml_text( xml_find_all( doc, end.year.xpath ) )



	## TAX PREPARER
	## Tax preparer field is the same for forms of the same year (990 and 990EZ post-2013; 990 and 990EZ pre-2013)

	V_990TPpost2013 <- "//Return/ReturnHeader/PreparerPersonGrp/PreparerPersonNm"
	V_990TPpre2013  <- "//Return/ReturnHeader/Preparer/Name"
	tax.prep.xpath <- paste( V_990TPpost2013, V_990TPpre2013, sep="|" )
	TAXPREP <- xml_text( xml_find_all( doc, tax.prep.xpath ) )



	## TYPE OF TAX FORM
	## Tax form field is the same for forms of the same year (990 and 990EZ post-2013; 990 and 990EZ pre-2013)

	V_990TFpost2013 <- "//Return/ReturnHeader/ReturnTypeCd"
	V_990TFpre2013  <- "//Return/ReturnHeader/ReturnType"
	tax.form.xpath <- paste( V_990TFpost2013, V_990TFpre2013, sep="|" )
	TAXFORM <- xml_text( xml_find_all( doc, tax.form.xpath ) )



	#------------------------------------------------------------------------------------------------------------------------
	##### BASIC INFO

	## GROSS RECEIPTS

	V_990GRCpost2013 <- "//Return/ReturnHeader/IRS990/GrossReceiptsAmt"
	V_990GRCpre2013  <- "//Return/ReturnHeader/IRS990/GrossReceipts"
	V_990GRC.EZpost2013 <- "//Return/ReturnHeader/IRS990EZ/GrossReceiptsAmt"
	V_990GRC.EZpre2013  <- "//Return/ReturnHeader/IRS990EZ/GrossReceipts"
	greceipts.xpath <- paste( V_990GRCpost2013, V_990GRCpre2013, V_990GRC.EZpost2013, V_990GRC.EZpre2013, sep="|" )
	GROSSRECEIPTS <- xml_text( xml_find_all( doc, greceipts.xpath ) ) 



	## GROUP RETURNS  

	V_990GRTpost2013 <- "//Return/ReturnHeader/IRS990/GroupReturnForAffiliatesInd"
	V_990GRTpre2013  <- "//Return/ReturnHeader/IRS990/GroupReturnForAffiliates"
	greturn.xpath <- paste( V_990GRTpost2013, V_990GRTpre2013, sep="|" )
	GROUPRETURN <- xml_text( xml_find_all( doc, greturn.xpath ) ) 



	## GROUP EXEMPTION NUMBER

	V_990GENpost2013 <- "//Return/ReturnHeader/IRS990/GroupExemptionNum"
	V_990GENpre2013  <- "//Return/ReturnHeader/IRS990/GroupExemptionNumber"
	V_990GEN.EZpost2013 <- "//Return/ReturnHeader/IRS990EZ/GroupExemptionNum"
	V_990GEN.EZpre2013  <- "//Return/ReturnHeader/IRS990EZ/GroupExemptionNumber"
	gexempt.number.xpath <- paste( V_990GENpost2013, V_990GENpre2013, V_990GEN.EZpost2013, V_990GEN.EZpre2013, sep="|" )
	GROUPEXEMPTNUM <- xml_text( xml_find_all( doc, gexempt.number.xpath ) ) 



	## FORM YEAR

	V_990FORMYRpost2013 <- "//Return/ReturnHeader/IRS990/FormationYr"
	V_990FORMYRpre2013  <- "//Return/ReturnHeader/IRS990/YearFormation"
	form.year.xpath <- paste( V_990FORMYRpost2013, V_990FORMYRpre2013, sep="|" )
	FORMYEAR <- xml_text( xml_find_all( doc, form.year.xpath ) ) 



	## STATE OF LEGAL DOMICILE

	V_990DOMpost2013 <- "//Return/ReturnHeader/IRS990/LegalDomicileStateCd"
	V_990DOMpre2013  <- "//Return/ReturnHeader/IRS990/StateLegalDomicile"
	V_990DOM.EZpost2013 <- "//Return/ReturnHeader/IRS990EZ/StatesWhereCopyOfReturnIsFldCd"
	V_990DOM.EZpre2013  <- "//Return/ReturnHeader/IRS990EZ/StatesWhereCopyOfReturnIsFiled"
	domicile.xpath <- paste( V_990DOMpost2013, V_990DOMpre2013, V_990DOM.EZpost2013, V_990DOM.EZpre2013, sep="|" )
	DOMICILE <- xml_text( xml_find_all( doc, domicile.xpath ) ) 



	## WEBSITE

	V_990WEBpost2013 <- "//Return/ReturnHeader/IRS990/WebsiteAddressTxt"
	V_990WEBpre2013  <- "//Return/ReturnHeader/IRS990/WebSite"
	V_990WEB.EZpost2013 <- "//Return/ReturnHeader/IRS990EZ/WebsiteAddressTxt"
	V_990WEB.EZpre2013  <- "//Return/ReturnHeader/IRS990EZ/WebSite"
	website.xpath <- paste( V_990WEBpost2013, V_990WEBpre2013, V_990WEB.EZpost2013, V_990WEB.EZpre2013, sep="|" )
	WEBSITE <- xml_text( xml_find_all( doc, website.xpath ) ) 



	## URL

	URL <- url



	## FORM OF ORGANIZATION: represent the 4 possible values, broken out
	## ORGANIZATION IS ASSOCATION

	V_990FOApost2013 <- "//Return/ReturnHeader/IRS990/TypeOfOrganizationAssocInd"
	V_990FOApre2013  <- "//Return/ReturnHeader/IRS990/TypeOfOrganizationAssociation"
	V_990FOA.EZpost2013 <- "//Return/ReturnHeader/IRS990EZ/TypeOfOrganizationAssocInd"
	V_990FOA.EZpre2013  <- "//Return/ReturnHeader/IRS990EZ/TypeOfOrganizationAssociation"
	type.org.assoc.xpath <- paste( V_990FOApost2013, V_990FOApre2013, V_990FOA.EZpost2013, V_990FOA.EZpre2013, sep="|" )
	FORMORGASSOC <- xml_text( xml_find_all( doc, type.org.assoc.xpath ) ) 



	## ORGANIZATION IS CORPORATION

	V_990FOCpost2013 <- "//Return/ReturnHeader/IRS990/TypeOfOrganizationCorpInd"
	V_990FOCpre2013  <- "//Return/ReturnHeader/IRS990/TypeOfOrganizationCorporation"
	V_990FOC.EZpost2013 <- "//Return/ReturnHeader/IRS990EZ/TypeOfOrganizationCorpInd"
	V_990FOC.EZpre2013  <- "//Return/ReturnHeader/IRS990EZ/TypeOfOrganizationCorporation"
	type.org.corp.xpath <- paste( V_990FOCpost2013, V_990FOCpre2013, V_990FOC.EZpost2013, V_990FOC.EZpre2013, sep="|" )
	FORMORGCORP <- xml_text( xml_find_all( doc, type.org.corp.xpath ) ) 



	## ORGANIZATION IS TRUST

	V_990FOTpost2013 <- "//Return/ReturnHeader/IRS990/TypeOfOrganizationTrustInd"
	V_990FOTpre2013  <- "//Return/ReturnHeader/IRS990/TypeOfOrganizationTrust"
	V_990FOT.EZpost2013 <- "//Return/ReturnHeader/IRS990EZ/TypeOfOrganizationTrustInd"
	V_990FOT.EZpre2013  <- "//Return/ReturnHeader/IRS990EZ/TypeOfOrganizationTrust"
	type.org.trust.xpath <- paste( V_990FOTpost2013, V_990FOTpre2013, V_990FOT.EZpost2013, V_990FOT.EZpre2013, sep="|" )
	FORMORGTRUST <- xml_text( xml_find_all( doc, type.org.trust.xpath ) ) 



	## ORGANIZATION IS OTHER (WRITE-IN)

	V_990FOOpost2013 <- "//Return/ReturnHeader/IRS990/TypeOfOrganizationOtherInd"
	V_990FOOpre2013  <- "//Return/ReturnHeader/IRS990/TypeOfOrganizationOther"
	V_990FOO.EZpost2013 <- "//Return/ReturnHeader/IRS990EZ/TypeOfOrganizationOtherInd"
	V_990FOO.EZpre2013  <- "//Return/ReturnHeader/IRS990EZ/TypeOfOrganizationOther"
	type.org.other.xpath <- paste( V_990FOOpost2013, V_990FOOpre2013, V_990FOO.EZpost2013, V_990FOO.EZpre2013, sep="|" )
	FORMORGOTHER <- xml_text( xml_find_all( doc, type.org.other.xpath ) ) 



	##  ACCOUNTING METHODS: represent the 3 possible values, broken out
	## ACCRUAL ACCOUNTING METHOD

	V_990AMApost2013 <- "//Return/ReturnData/IRS990/MethodOfAccountingAccrualInd"
	V_990AMApre2013  <- "//Return/ReturnData/IRS990/MethodOfAccountingAccrual"
	V_990AMA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingAccrualInd"
	V_990AMA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingAccrual"
	accounting.accrual.xpath <- paste( V_990AMApost2013, V_990AMApre2013, V_990AMA.EZpost2013, V_990AMA.EZpre2013, sep="|" )
	ACCTACCRUAL <- xml_text( xml_find_all( doc, accounting.accrual.xpath ) ) 



	## CASH ACCOUNTING METHOD

	V_990AMCpost2013 <- "//Return/ReturnData/IRS990/MethodOfAccountingCashInd"
	V_990AMCpre2013  <- "//Return/ReturnData/IRS990/MethodOfAccountingCash"
	V_990AMC.EZpost2013 <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingCashInd"
	V_990AMC.EZpre2013  <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingCash"
	accounting.cash.xpath <- paste( V_990AMCpost2013, V_990AMCpre2013, V_990AMC.EZpost2013, V_990AMC.EZpre2013, sep="|" )
	ACCTCASH <- xml_text( xml_find_all( doc, accounting.cash.xpath ) ) 



	## OTHER ACCOUNTING METHOD

	V_990AMOpost2013 <- "//Return/ReturnData/IRS990/MethodOfAccountingOtherInd"
	V_990AMOpre2013  <- "//Return/ReturnData/IRS990/MethodOfAccountingOther"
	V_990AMO.EZpost2013 <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingOtherDesc"
	V_990AMO.EZpre2013  <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingOther"
	accounting.other.xpath <- paste( V_990AMOpost2013, V_990AMOpre2013, V_990AMO.EZpost2013, V_990AMO.EZpre2013, sep="|" )
	ACCTOTHER <- xml_text( xml_find_all( doc, accounting.other.xpath ) ) 


	##  TAX EXEMPT STATUS: represent the 5 possible values, broken out
	## EXEMPT STATUS 4947(a)(1)

	V_990.4947post2013 <- "//Return/ReturnData/IRS990/Organization4947a1NotPFInd"
	V_990.4947pre2013  <- "//Return/ReturnData/IRS990/Organization4947a1"
	V_990.4947.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Organization4947a1NotPFInd"
	V_990.4947.EZpre2013  <- "//Return/ReturnData/IRS990EZ/Organization4947a1"
	exempt.4947.xpath <- paste( V_990.4947post2013, V_990.4947pre2013, V_990.4947.EZpost2013, V_990.4947.EZpre2013, sep="|" )
	EXEMPT4947A1 <- xml_text( xml_find_all( doc, exempt.4947.xpath ) ) 



	## EXEMPT STATUS 501(c)(other than 3)

	V_990.501Cpost2013 <- "//Return/ReturnData/IRS990/Organization501cInd"
	V_990.501Cpre2013  <- "//Return/ReturnData/IRS990/Organization501c"
	V_990.501C.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Organization501cInd"
	V_990.501C.EZpre2013  <- "//Return/ReturnData/IRS990EZ/Organization501c"
	exempt.501c.xpath <- paste( V_990.501Cpost2013, V_990.501Cpre2013, V_990.501C.EZpost2013, V_990.501C.EZpre2013, sep="|" )
	EXEMPT501C <- xml_text( xml_find_all( doc, exempt.501c.xpath ) ) 



	## NUMBER OF EXEMPT STATUS 501(c)(other than 3)

	V_990.501C.NUMpost2013 <- "//Return/ReturnData/IRS990/Organization501cInd/@organization501cTypeTxt"
	V_990.501C.NUMpre2013  <- "//Return/ReturnData/IRS990/Organization501c/@typeOf501cOrganization"
	V_990.501C.NUM.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Organization501cInd/@organization501cTypeTxt"
	V_990.501C.NUM.EZpre2013  <- "//Return/ReturnData/IRS990EZ/Organization501c/@typeOf501cOrganization"
	exempt.num.xpath <- paste( V_990.501C.NUMpost2013, V_990.501C.NUMpre2013, V_990.501C.NUM.EZpost2013, V_990.501C.NUM.EZpre2013, sep="|" )
	EXEMPT501CNUM <- xml_text( xml_find_all( doc, exempt.num.xpath ) ) 



	## EXEMPT STATUS 501(c)(3)

	V_990.501C.3post2013 <- "//Return/ReturnData/IRS990/Organization501c3Ind"
	V_990.501C.3pre2013  <- "//Return/ReturnData/IRS990/Organization501c3"
	V_990.501C.3.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Organization501c3Ind"
	V_990.501C.3.EZpre2013  <- "//Return/ReturnData/IRS990EZ/Organization501c3"
	exempt.501c.3.xpath <- paste( V_990.501C.3post2013, V_990.501C.3pre2013, V_990.501C.3.EZpost2013, V_990.501C.3.EZpre2013, sep="|" )
	EXEMPT501C3 <- xml_text( xml_find_all( doc, exempt.501c.3.xpath ) ) 



	## EXEMPT STATUS 527

	V_990.527post2013 <- "//Return/ReturnData/IRS990/Organization527Ind"
	V_990.527pre2013  <- "//Return/ReturnData/IRS990/Organization527"
	V_990.527.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Organization527Ind"
	V_990.527.EZpre2013  <- "//Return/ReturnData/IRS990EZ/Organization527"
	exempt.527.xpath <- paste( V_990.527post2013, V_990.527pre2013, V_990.527.EZpost2013, V_990.527.EZpre2013, sep="|" )
	EXEMPT527 <- xml_text( xml_find_all( doc, exempt.527.xpath ) ) 



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART I - ACTIVITIES AND GOVERNANCE 

	## VOTING MEMBERS

	V_990VMpost2013 <- "//Return/ReturnData/IRS990/VotingMembersGoverningBodyCnt"
	V_990VMpre2013  <- "//Return/ReturnData/IRS990/NbrVotingMembersGoverningBody"
	voting.mbrs.xpath <- paste( V_990VMpost2013, V_990VMpre2013, sep="|" )
	VOTINGMEMBERS <- xml_text( xml_find_all( doc, voting.mbrs.xpath ) ) 



	## INDEPENDENT VOTING MEMBERS

	V_990IVMpost2013 <- "//Return/ReturnData/IRS990/VotingMembersIndependentCnt"
	V_990IVMpre2013  <- "//Return/ReturnData/IRS990/NbrIndependentVotingMembers"
	indvoting.mbrs.xpath <- paste( V_990IVMpost2013, V_990IVMpre2013, sep="|" )
	INDVOTINGMEMBERS <- xml_text( xml_find_all( doc, indvoting.mbrs.xpath ) ) 



	## TOTAL EMPLOYEE COUNT

	V_990TEpost2013 <- "//Return/ReturnData/IRS990/TotalEmployeeCnt"
	V_990TEpre2013  <- "//Return/ReturnData/IRS990/TotalNbrEmployees"
	tot.employee.xpath <- paste( V_990TEpost2013, V_990TEpre2013, sep="|" )
	TOTEMPLOYEE <- xml_text( xml_find_all( doc, tot.employee.xpath ) ) 



	## TOTAL VOLUNTEER COUNT

	V_990TVpost2013 <- "//Return/ReturnData/IRS990/TotalVolunteersCnt"
	V_990TVpre2013  <- "//Return/ReturnData/IRS990/TotalNbrVolunteers"
	tot.volunteers.xpath <- paste( V_990TVpost2013, V_990TVpre2013, sep="|" )
	TOTVOLUNTEERS <- xml_text( xml_find_all( doc, tot.volunteers.xpath ) )



	## TOTAL GROSS UBI

	V_990TGUpost2013 <- "//Return/ReturnData/IRS990/TotalGrossUBIAmt"
	V_990TGUpre2013  <- "//Return/ReturnData/IRS990/TotalGrossUBI"
	tot.ubi.xpath <- paste( V_990TGUpost2013, V_990TGUpre2013, sep="|" )
	TOTUBI <- xml_text( xml_find_all( doc, tot.ubi.xpath ) )



	## NET UBI

	V_990NUpost2013 <- "//Return/ReturnData/IRS990/NetUnrelatedBusTxblIncmAmt"
	V_990NUpre2013  <- "//Return/ReturnData/IRS990/NetUnrelatedBusinessTxblIncome"
	net.ubi.xpath <- paste( V_990NUpost2013, V_990NUpre2013, sep="|" )
	NETUBI <- xml_text( xml_find_all( doc, net.ubi.xpath ) )



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART I - REVENUES 
	## The 990-PC forms split columns in this area into Current Year and Prior Year, the 990-EZs do not. 990-EZ data
	## in this section only maps to current year values unless indicated otherwise.

	## PRIOR YEAR CONTRIBUTIONS

	V_990PCpost2013 <- "//Return/ReturnData/IRS990/ContributionsGrantsPriorYear"
	V_990PCpre2013  <- "//Return/ReturnData/IRS990/PYContributionsGrantsAmt"
	contrib.prior.xpath <- paste( V_990PCpost2013, V_990PCpre2013, sep="|" )
	CONTRIBPRIOR <- xml_text( xml_find_all( doc, contrib.prior.xpath ) ) 



	## CURRENT YEAR CONTRIBUTIONS

	V_990CCpost2013 <- "//Return/ReturnData/IRS990/CYContributionsGrantsAmt"
	V_990CCpre2013  <- "//Return/ReturnData/IRS990/ContributionsGrantsCurrentYear"
	V_990CC.EZpost2013 <- "//Return/ReturnData/IRS990EZ/ContributionsGiftsGrantsEtc"
	V_990CC.EZpre2013  <- "//Return/ReturnData/IRS990EZ/ContributionsGiftsGrantsEtcAmt"
	contrib.current.xpath <- paste( V_990CCpost2013, V_990CCpre2013, V_990CC.EZpost2013, V_990CC.EZpre2013, sep="|" )
	CONTRIBCURRENT <- xml_text( xml_find_all( doc, contrib.current.xpath ) ) 



	## PRIOR YEAR PROGRAM SERVICE REVENUE

	V_990PPSRpost2013 <- "//Return/ReturnData/IRS990/PYProgramServiceRevenueAmt"
	V_990PPSRpre2013  <- "//Return/ReturnData/IRS990/ProgramServiceRevenuePriorYear"
	psr.prior.xpath <- paste( V_990PPSRpost2013, V_990PPSRpre2013, sep="|" )
	PSRPRIOR <- xml_text( xml_find_all( doc, psr.prior.xpath ) ) 


	## CURRENT YEAR PROGRAM SERVICE REVENUE

	V_990CPSRpost2013 <- "//Return/ReturnData/IRS990/CYProgramServiceRevenueAmt"
	V_990CPSRpre2013  <- "//Return/ReturnData/IRS990/ProgramServiceRevenueCY"
	V_990CPSR.EZpost2013 <- "//Return/ReturnData/IRS990EZ/ProgramServiceRevenueAmt"
	V_990CPSR.EZpre2013  <- "//Return/ReturnData/IRS990EZ/ProgramServiceRevenue"
	psr.current.xpath <- paste( V_990CPSRpost2013, V_990CPSRpre2013, V_990CPSR.EZpost2013, V_990CPSR.EZpre2013, sep="|" )
	PSRCURRENT <- xml_text( xml_find_all( doc, psr.current.xpath ) )  



	## PRIOR YEAR INVESTMENT INCOME

	V_990PIVpost2013 <- "//Return/ReturnData/IRS990/PYInvestmentIncomeAmt"
	V_990PIVpre2013  <- "//Return/ReturnData/IRS990/InvestmentIncomePriorYear"
	invest.income.prior.xpath <- paste( V_990PIVpost2013, V_990PIVpre2013, sep="|" )
	INVINCPRIOR <- xml_text( xml_find_all( doc, invest.income.prior.xpath ) )  



	## CURRENT YEAR INVESTMENT INCOME

	V_990CIVpost2013 <- "//Return/ReturnData/IRS990/CYInvestmentIncomeAmt"
	V_990CIVpre2013  <- "//Return/ReturnData/IRS990/InvestmentIncomeCurrentYear"
	V_990CIV.EZpost2013 <- "//Return/ReturnData/IRS990EZ/InvestmentIncomeAmt"
	V_990CIV.EZpre2013  <- "//Return/ReturnData/IRS990EZ/InvestmentIncome"
	invest.income.current.xpath <- paste( V_990CIVpost2013, V_990CIVpre2013, V_990CIV.EZpost2013, V_990CIV.EZpre2013, sep="|" )
	INVINCCURRENT <- xml_text( xml_find_all( doc, invest.income.current.xpath ) )  



	## PRIOR YEAR OTHER REVENUE

	V_990PORpost2013 <- "//Return/ReturnData/IRS990/PYOtherRevenueAmt"
	V_990PORpre2013  <- "//Return/ReturnData/IRS990/OtherRevenuePriorYear"
	other.rev.prior.xpath <- paste( V_990PORpost2013, V_990PORpre2013, sep="|" )
	OTHERREVPRIOR <- xml_text( xml_find_all( doc, other.rev.prior.xpath ) )  



	## CURRENT YEAR OTHER REVENUE

	V_990CORpost2013 <- "//Return/ReturnData/IRS990/CYOtherRevenueAmt"
	V_990CORpre2013  <- "//Return/ReturnData/IRS990/OtherRevenueCurrentYear"
	V_990CR.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherRevenueTotalAmt"
	V_990CR.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OtherRevenueTotal"
	other.rev.current.xpath <- paste( V_990CORpost2013, V_990CORpre2013, V_990CR.EZpost2013, V_990CR.EZpre2013, sep="|" )
	OTHERREVCURRENT <- xml_text( xml_find_all( doc, other.rev.current.xpath ) )  



	## PRIOR YEAR TOTAL REVENUE

	V_990PTRpost2013 <- "//Return/ReturnData/IRS990/PYTotalRevenueAmt"
	V_990PTRpre2013  <- "//Return/ReturnData/IRS990/TotalRevenuePriorYear"
	total.rev.prior.xpath <- paste( V_990PTRpost2013, V_990PTRpre2013, sep="|" )
	TOTALREVPRIOR <- xml_text( xml_find_all( doc, total.rev.prior.xpath ) )  



	## CURRENT YEAR TOTAL REVENUE

	V_990CTRpost2013 <- "//Return/ReturnData/IRS990/CYTotalRevenueAmt"
	V_990CTRpre2013  <- "//Return/ReturnData/IRS990/TotalRevenuePriorYear"
	V_990CTR.EZpost2013 <- "//Return/ReturnData/IRS990EZ/TotalRevenueAmt"
	V_990CTR.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TotalRevenue"
	total.rev.current.xpath <- paste( V_990CTRpost2013, V_990CTRpre2013, V_990CTR.EZpost2013, V_990CTR.EZpre2013, sep="|" )
	TOTALREVCURRENT <- xml_text( xml_find_all( doc, total.rev.current.xpath ) )  



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART I - REVENUES (990EZ-specific fields)
	## Some of the paths here are on the 990 Pc but in different areas. They are included here to help
	## with mapping across forms. Some of the PC fields here roll up to map to 1 EZ field.

	## MEMBERSHIP DUES

	V_990MBRDpost2013 <- "//Return/ReturnData/IRS990/MembershipDuesAmt"
	V_990MBRDpre2013  <- "//Return/ReturnData/IRS990/MembershipDues"
	V_990MBRD.EZpost2013 <- "//Return/ReturnData/IRS990EZ/MembershipDuesAmt"
	V_990MBRD.EZpre2013  <- "//Return/ReturnData/IRS990EZ/MembershipDues"
	member.dues.xpath <- paste( V_990MBRDpost2013, V_990MBRDpre2013, V_990MBRD.EZpost2013, V_990MBRD.EZpre2013, sep="|" )
	MEMBERDUES <- xml_text( xml_find_all( doc, member.dues.xpath ) )  



	## GROSS SALES OF NON-INVENTORY ASSETS

	V_990GSNApost2013 <- "//Return/ReturnData/IRS990/GrossAmountSalesAssetsGrp/OtherAmt"
	V_990GSNApre2013  <- "//Return/ReturnData/IRS990/GrossAmountSalesAssets/Other"
	V_990GSNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SaleOfAssetsGrossAmt"
	V_990GSNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GrossAmountFromSaleOfAssets"
	grosssales.nonasset.xpath <- paste( V_990GSNApost2013, V_990GSNApre2013, V_990GSNA.EZpost2013, V_990GSNA.EZpre2013, sep="|" )
	GROSSSALESOTHER <- xml_text( xml_find_all( doc, grosssales.nonasset.xpath ) )  



	## COST AND SALES EXPENSES FROM NON-INVENTORY ASSET SALES

	V_990TSNApost2013 <- "//Return/ReturnData/IRS990/LessCostOthBasisSalesExpnssGrp/OtherAmt"
	V_990TSNApre2013  <- "//Return/ReturnData/IRS990/LessCostOthBasisSalesExpenses/Other"
	V_990TSNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/CostOrOtherBasisExpenseSaleAmt"
	V_990TSNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/CostOtherBasisAndSalesExpenses"
	totalsales.nonasset.xpath <- paste( V_990TSNApost2013, V_990TSNApre2013, V_990TSNA.EZpost2013, V_990TSNA.EZpre2013, sep="|" )
	SALESCOSTOTHER <- xml_text( xml_find_all( doc, totalsales.nonasset.xpath ) )  



	## NET SALES OF NON-INVENTORY ASSETS
	## includes securities for the PC forms

	V_990NSNApost2013 <- "//Return/ReturnData/IRS990/NetGainOrLossInvestmentsGrp/TotalRevenueColumnAmt"
	V_990NSNApre2013  <- "//Return/ReturnData/IRS990/NetGainOrLossInvestments/TotalRevenueColumn"
	V_990NSNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GainOrLossFromSaleOfAssetsAmt"
	V_990NSNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GainOrLossFromSaleOfAssets"
	netsales.nonassets.xpath <- paste( V_990NSNApost2013, V_990NSNApre2013, V_990NSNA.EZpost2013, V_990NSNA.EZpre2013, sep="|" )
	NETSALESOTHER <- xml_text( xml_find_all( doc, netsales.nonassets.xpath ) )  



	## GROSS INCOME FROM GAMING

	V_990GIGpost2013 <- "//Return/ReturnData/IRS990/GamingGrossIncomeAmt"
	V_990GIGpre2013  <- "//Return/ReturnData/IRS990/GrossIncomeGaming"
	V_990GIG.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GamingGrossIncomeAmt"
	V_990GIG.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GamingGrossIncome"
	grossinc.gaming.xpath <- paste( V_990GIGpost2013, V_990GIGpre2013, V_990GIG.EZpost2013, V_990GIG.EZpre2013, sep="|" )
	GROSSINCGAMING <- xml_text( xml_find_all( doc, grossinc.gaming.xpath ) )  



	## GROSS INCOME FROM FUNDRAISING EVENTS

	V_990GIFpost2013 <- "//Return/ReturnData/IRS990/FundraisingGrossIncomeAmt"
	V_990GIFpre2013  <- "//Return/ReturnData/IRS990/GrossIncomeFundraisingEvents"
	V_990GIF.EZpost2013 <- "//Return/ReturnData/IRS990EZ/FundraisingGrossIncomeAmt"
	V_990GIF.EZpre2013  <- "//Return/ReturnData/IRS990EZ/FundraisingGrossIncome"
	grossinc.fundrs.xpath <- paste( V_990GIFpost2013, V_990GIFpre2013, V_990GIF.EZpost2013, V_990GIF.EZpre2013, sep="|" )
	GROSSINCFNDEVENTS <- xml_text( xml_find_all( doc, grossinc.fundrs.xpath ) )  



	## EXPENSES FROM GAMING EVENTS
	## PC only

	V_990gamexppost2013 <- "//Return/ReturnData/IRS990/GamingDirectExpensesAmt"
	V_990gamexppre2013 <- "//Return/ReturnData/IRS990/GamingDirectExpenses"
	gaming.exp.xpath <- paste( V_990gamexppost2013, V_990gamexppre2013, sep="|" )
	GAMINGEXP <- xml_text( xml_find_all( doc, gaming.exp.xpath ) )  



	## EXPENSES FROM GAMING EVENTS
	## PC only

	V_990fndexppost2013 <- "//Return/ReturnData/IRS990/GamingDirectExpensesAmt"
	V_990fndexppre2013 <- "//Return/ReturnData/IRS990/GamingDirectExpenses"
	fnd.events.exp.xpath <- paste( V_990gamexppost2013, V_990gamexppre2013, sep="|" )
	FNDEVENTSEXP <- xml_text( xml_find_all( doc, fnd.events.exp.xpath ) )  



	## EXPENSES FROM GAMING AND FUNDRAISING EVENTS 
	### Does not include summed values of GAMINGEXP and FNDEVENTSEXP

	#V_990EGFpost2013 <- sum( V_990gamexppost2013, V_990fndexppost2013, na.rm=T )
	#V_990EGFpre2013  <- sum( V_990gamexppre2013, V_990gamexppre2013, na.rm=T )
	V_990EGF.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SpecialEventsDirectExpensesAmt"
	V_990EGF.EZpre2013  <- "//Return/ReturnData/IRS990EZ/SpecialEventsDirectExpenses"
	#exp.gaming.fundrs.xpath <- paste( V_990EGFpost2013, V_990EGFpre2013, V_990EGF.EZpost2013, V_990EGF.EZpre2013, sep="|" )
	exp.gaming.fundrs.xpath <- paste( V_990EGF.EZpost2013, V_990EGF.EZpre2013, sep="|" )
	EXPGAMINGFNDEVENTS <- xml_text( xml_find_all( doc, exp.gaming.fundrs.xpath ) )  



	## NET GAIN OR LOSS FROM GAMING EVENTS
	## PC only

	V_990totrevgampost2013 <- "//Return/ReturnData/IRS990/NetIncomeFromGamingGrp/TotalRevenueColumnAmt"
	V_990totrevgampre2013 <- "//Return/ReturnData/IRS990/NetIncomeFromGaming/TotalRevenueColumn"
	gaming.net.xpath <- paste( V_990totrevgampost2013, V_990totrevgampre2013, sep="|" )
	GAMINGNET <- xml_text( xml_find_all( doc, gaming.net.xpath ) )  



	## NET GAIN OR LOSS FROM FUNDRAISING EVENTS
	## PC only

	V_990totrevfndpost2013 <- "//Return/ReturnData/IRS990/NetIncmFromFundraisingEvtGrp/TotalRevenueColumnAmt"
	V_990totrevfndpre2013 <- "//Return/ReturnData/IRS990/NetIncomeFromFundraisingEvents/TotalRevenueColumn"
	fnd.events.net.xpath <- paste( V_990totrevfndpost2013, V_990totrevfndpre2013, sep="|" )
	FNDEVENTSNET <- xml_text( xml_find_all( doc, fnd.events.net.xpath ) )  



	## NET DIFFERENCE FOR GAMING AND FUNDRAISING EVENTS
	### Does not include summed values of GAMINGEXP and FNDEVENTSEXP

	#V_990NGFpost2013 <- sum(  V_990totrevgampost2013, V_990totrevfndpost2013, na.rm = TRUE )
	#V_990NGFpre2013  <- sum(  V_990totrevgampre2013, V_990totrevfndpre2013, na.rm = TRUE )
	V_990NGF.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SpecialEventsNetIncomeLossAmt"
	V_990NGF.EZpre2013  <- "//Return/ReturnData/IRS990EZ/SpecialEventsNetIncomeLoss"
	#net.gaming.fundrs.xpath <- paste( V_990NGFpost2013, V_990NGFpre2013, V_990NGF.EZpost2013, V_990NGF.EZpre2013, sep="|" )
	net.gaming.fundrs.xpath <- paste( V_990NGF.EZpost2013, V_990NGF.EZpre2013, sep="|" )
	NETGAMINGFNDEVENTS <- xml_text( xml_find_all( doc, net.gaming.fundrs.xpath ) )  



	## GROSS SALES OF INVENTORY ASSETS

	V_990GSIpost2013 <- "//Return/ReturnData/IRS990/GrossSalesOfInventoryAmt"
	V_990GSIpre2013  <- "//Return/ReturnData/IRS990/GrossSalesOfInventory"
	V_990GSI.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GrossProfitLossSlsOfInvntryAmt"
	V_990GSI.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GroProfitLossSalesOfInventory"
	gross.salesinv.xpath <- paste( V_990GSIpost2013, V_990GSIpre2013, V_990GSI.EZpost2013, V_990GSI.EZpre2013, sep="|" )
	GROSSSALESINV <- xml_text( xml_find_all( doc, gross.salesinv.xpath ) )  



	## COST OF GOODS SOLD

	V_990CSIpost2013 <- "//Return/ReturnData/IRS990/CostOfGoodsSoldAmt"
	V_990CSIpre2013  <- "//Return/ReturnData/IRS990/CostOfGoodsSold"
	V_990CSI.EZpost2013 <- "//Return/ReturnData/IRS990EZ/CostOfGoodsSoldAmt"
	V_990CSI.EZpre2013  <- "//Return/ReturnData/IRS990EZ/CostOfGoodsSold"
	cost.salesinv.xpath <- paste( V_990CSIpost2013, V_990CSIpre2013, V_990CSI.EZpost2013, V_990CSI.EZpre2013, sep="|" )
	SALESCOSTINV <- xml_text( xml_find_all( doc, cost.salesinv.xpath ) )  



	## NET DIFFERENCE OF SALES MINUS COST OF GOODS

	V_990NSIpost2013 <- "//Return/ReturnData/IRS990/NetIncomeOrLossGrp/TotalRevenueColumnAmt"
	V_990NSIpre2013  <- "//Return/ReturnData/IRS990/NetIncomeOrLoss/TotalRevenueColumn"
	V_990NSI.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GrossProfitLossSlsOfInvntryAmt"
	V_990NSI.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GroProfitLossSalesOfInventory"
	net.salesinv.xpath <- paste( V_990NSIpost2013, V_990NSIpre2013, V_990NSI.EZpost2013, V_990NSI.EZpre2013, sep="|" )
	NETSALESINV <- xml_text( xml_find_all( doc, net.salesinv.xpath ) )  



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART I - EXPENSES
	## The 990-PC forms split columns in this area into Current Year and Prior Year, the 990-EZs do not. 990-EZ data
	## in this section only maps to current year values unless indicated otherwise.

	## PRIOR YEAR GRANTS PAID

	V_990PGPpost2013 <- "//Return/ReturnData/IRS990/PYGrantsAndSimilarPaidAmt"
	V_990PGPpre2013  <- "//Return/ReturnData/IRS990/GrantsAndSimilarAmntsPriorYear"
	grants.paid.prior.xpath <- paste( V_990PGPpost2013, V_990PGPpre2013, sep="|" )
	GRANTSPAIDPRIOR <- xml_text( xml_find_all( doc, grants.paid.prior.xpath ) ) 



	## CURRENT YEAR GRANTS PAID

	V_990CGPpost2013 <- "//Return/ReturnData/IRS990/CYGrantsAndSimilarPaidAmt"
	V_990CGPpre2013  <- "//Return/ReturnData/IRS990/GrantsAndSimilarAmntsCY"
	V_990CGP.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GrantsAndSimilarAmountsPaidAmt"
	V_990CGP.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GrantsAndSimilarAmountsPaid"
	grants.paid.current.xpath <- paste( V_990CGPpost2013, V_990CGPpre2013, V_990CGP.EZpost2013, V_990CGP.EZpre2013, sep="|" )
	GRANTSPAIDCURRENT <- xml_text( xml_find_all( doc, grants.paid.current.xpath ) ) 



	## PRIOR YEAR BENEFITS PAID TO OR FOR MEMBERS 

	V_990PBPpost2013 <- "//Return/ReturnData/IRS990/PYBenefitsPaidToMembersAmt"
	V_990PBPpre2013  <- "//Return/ReturnData/IRS990/BenefitsPaidToMembersPriorYear"
	benefits.paid.prior.xpath <- paste( V_990PGPpost2013, V_990PGPpre2013, sep="|" )
	MEMBERBENPRIOR <- xml_text( xml_find_all( doc, benefits.paid.prior.xpath ) ) 



	## CURRENT YEAR BENEFITS PAID TO OR FOR MEMBERS 

	V_990CBPpost2013 <- "//Return/ReturnData/IRS990/CYBenefitsPaidToMembersAmt"
	V_990CBPpre2013  <- "//Return/ReturnData/IRS990/BenefitsPaidToMembersCY"
	V_990CBP.EZpost2013 <- "//Return/ReturnData/IRS990EZ/BenefitsPaidToOrForMembersAmt"
	V_990CBP.EZpre2013  <- "//Return/ReturnData/IRS990EZ/BenefitsPaidToOrForMembers"
	benefits.paid.current.xpath <- paste( V_990CBPpost2013, V_990CBPpre2013, V_990CBP.EZpost2013, V_990CBP.EZpre2013, sep="|" )
	MEMBERBENCURRENT <- xml_text( xml_find_all( doc, benefits.paid.current.xpath ) ) 



	## PRIOR YEAR SALARIES PAID

	V_990PSPpost2013 <- "//Return/ReturnData/IRS990/PYSalariesCompEmpBnftPaidAmt"
	V_990PSPpre2013  <- "//Return/ReturnData/IRS990/SalariesEtcPriorYear"
	salaries.prior.xpath <- paste( V_990PSPpre2013, V_990PSPpost2013, sep="|" )
	SALARIESPRIOR <- xml_text( xml_find_all( doc, salaries.prior.xpath ) ) 



	## CURRENT YEAR SALARIES PAID

	V_990CSPpost2013 <- "//Return/ReturnData/IRS990/CYSalariesCompEmpBnftPaidAmt"
	V_990CSPpre2013  <- "//Return/ReturnData/IRS990/SalariesEtcCurrentYear"
	V_990CSP.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SalariesOtherCompEmplBnftAmt"
	V_990CSP.EZpre2013  <- "//Return/ReturnData/IRS990EZ/SalariesOtherCompEmplBenefits"
	salaries.current.xpath <- paste( V_990CSPpost2013, V_990CSPpre2013, V_990CSP.EZpost2013, V_990CSP.EZpre2013, sep="|" )
	SALARIESCURRENT <- xml_text( xml_find_all( doc, salaries.current.xpath ) ) 



	## PRIOR YEAR PROFESSIONAL FUNDRAISING FEES

	V_990PFFpost2013 <- "//Return/ReturnData/IRS990/PYTotalProfFndrsngExpnsAmt"
	V_990PFFpre2013  <- "//Return/ReturnData/IRS990/TotalProfFundrsngExpPriorYear"
	profund.fees.prior.xpath <- paste( V_990PFFpre2013, V_990PFFpost2013, sep="|" )
	PROFUNDFEESPRIOR <- xml_text( xml_find_all( doc, profund.fees.prior.xpath ) ) 



	## CURRENT YEAR PROFESSIONAL FUNDRAISING FEES

	V_990CFFpost2013 <- "//Return/ReturnData/IRS990/CYTotalProfFndrsngExpnsAmt"
	V_990CFFpre2013  <- "//Return/ReturnData/IRS990/TotalProfFundrsngExpCY"
	profund.fees.current.xpath <- paste( V_990CFFpost2013, V_990CFFpre2013, sep="|" )
	PROFUNDFEESCURRENT <- xml_text( xml_find_all( doc, profund.fees.current.xpath ) ) 



	## TOTAL FUNDRAISING EXPENSES

	V_990TFFpost2013 <- "//Return/ReturnData/IRS990/CYTotalFundraisingExpenseAmt"
	V_990TFFpre2013  <- "//Return/ReturnData/IRS990/TotalFundrsngExpCurrentYear"
	totexp.fundrs.xpath <- paste( V_990TFFpost2013, V_990TFFpre2013, sep="|" )
	TOTFUNDEXP <- xml_text( xml_find_all( doc, totexp.fundrs.xpath ) ) 



	## FEES FOR SERVICES: MANAGEMENT

	V_990F4S.mgmt.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesManagementGrp/TotalAmt"
	V_990F4S.mgmt.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesManagement/Total"
	fees.mgmt.xpath <- paste( V_990TFFpost2013, V_990TFFpre2013, sep="|" )
	FEESMGMT <- xml_text( xml_find_all( doc, fees.mgmt.xpath ) ) 



	## FEES FOR SERVICES: LEGAL

	V_990F4S.legal.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesLegalGrp/TotalAmt"  
	V_990F4S.legal.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesLegal/Total"
	fees.legal.xpath <- paste( V_990TFFpost2013, V_990TFFpre2013, sep="|" )
	FEESLEGAL <- xml_text( xml_find_all( doc, fees.legal.xpath ) ) 



	## FEES FOR SERVICES: ACCOUNTING

	V_990F4S.accting.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesAccountingGrp/TotalAmt"
	V_990F4S.accting.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesAccounting/Total"
	fees.acct.xpath <- paste( V_990TFFpost2013, V_990TFFpre2013, sep="|" )
	FEESACCT <- xml_text( xml_find_all( doc, fees.acct.xpath ) ) 



	## FEES FOR SERVICES: LOBBYING

	V_990F4S.lobbying.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesLobbyingGrp/TotalAmt"
	V_990F4S.lobbying.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesLobbying/Total"
	fees.lobby.xpath <- paste( V_990TFFpost2013, V_990TFFpre2013, sep="|" )
	FEESLOBBY <- xml_text( xml_find_all( doc, fees.lobby.xpath ) ) 



	## FEES FOR SERVICES: PROFESSIONAL FUNDRAISING
	## Should equal PROFUNDFEESCURRENT

	V_990F4S.profundserv.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesProfFundraising/TotalAmt"
	V_990F4S.profundserv.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesProfFundraising/Total"
	fees.profund.xpath <- paste( V_990TFFpost2013, V_990TFFpre2013, sep="|" )
	FEESPROFND <- xml_text( xml_find_all( doc, fees.profund.xpath ) ) 



	## FEES FOR SERVICES: INVESTMENT MANAGEMENT

	V_990F4S.invmgmt.post2013 <- "//Return/ReturnData/IRS990/FeesForSrvcInvstMgmntFeesGrp/TotalAmt"
	V_990F4S.invmgmt.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesInvstMgmntFees/Total"
	fees.invmgmt.xpath <- paste( V_990TFFpost2013, V_990TFFpre2013, sep="|" )
	FEESINVMGMT <- xml_text( xml_find_all( doc, fees.invmgmt.xpath ) ) 



	## FEES FOR SERVICES: OTHER

	V_990F4S.other.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesOtherGrp/TotalAmt"
	V_990F4S.other.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesOther/Total"
	fees.other.xpath <- paste( V_990TFFpost2013, V_990TFFpre2013, sep="|" )
	FEESOTHER <- xml_text( xml_find_all( doc, fees.other.xpath ) ) 



	## PRO. FEES AND OTHERS TO INDEPENDENT CONTRACTORS   
	### Does not include summed values for PC-Specific fees for services

	#V_990PFIDpost2013 <-  sum( V_990F4S.mgmt.post2013, V_990F4S.legal.post2013, V_990F4S.accting.post2013, 
	#                            V_990F4S.lobbying.post2013, V_990F4S.profundserv.post2013, 
	#                            V_990F4S.invmgmt.post2013, V_990F4S.other.post2013, na.rm = T  )
	###Assuming that, if no values are reported (NA), it is acceptable to return a 0
	#V_990PFIDpre2013 <-  sum( V_990F4S.mgmt.pre2013, V_990F4S.legal.pre2013, V_990F4S.accting.pre2013,
	#                           V_990F4S.lobbying.pre2013, V_990F4S.profundserv.pre2013, 
	#                           V_990F4S.invmgmt.pre2013, V_990F4S.other.pre2013, na.rm = T  )
	###Assuming that, if no values are reported (NA), it is acceptable to return a 0
	V_990PFID.EZpost2013 <- "//Return/ReturnData/IRS990EZ/FeesAndOtherPymtToIndCntrctAmt"
	V_990PFID.EZpre2013  <- "//Return/ReturnData/IRS990EZ/FeesAndOthPymtToIndContractors"
	#profees.indep.contractors.xpath <- paste( V_990PFIDpost2013, V_990PFIDpre2013, V_990PFID.EZpost2013, V_990PFID.EZpre2013, sep="|" )
	profees.indep.contractors.xpath <- paste( V_990PFID.EZpost2013, V_990PFID.EZpre2013, sep="|" )
	PROFEESINDEP <- xml_text( xml_find_all( doc, profees.indep.contractors.xpath ) ) 



	## OCCUPANCY

	V_990RENTpost2013 <- "//Return/ReturnData/IRS990/OccupancyGrp/TotalAmt"
	V_990RENTpre2013  <- "//Return/ReturnData/IRS990/Occupancy/Total"
	V_990RENT.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OccupancyRentUtltsAndMaintAmt"
	V_990RENT.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OccupancyRentUtilitiesAndMaint"
	occupancy.xpath <- paste( V_990RENTpost2013, V_990RENTpre2013, V_990RENT.EZpost2013, V_990RENT.EZpre2013, sep="|" )
	OCCUPANCY <- xml_text( xml_find_all( doc, occupancy.xpath ) ) 



	## OFFICE EXPENSES

	V_990EXPOFpost2013 <- "//Return/ReturnData/IRS990/OfficeExpensesGrp/TotalAmt"
	V_990EXPOFpre2013  <- "//Return/ReturnData/IRS990/OfficeExpenses/Total"
	V_990EXPOF.EZpost2013 <- "//Return/ReturnData/IRS990EZ/PrintingPublicationsPostageAmt"
	V_990EXPOF.EZpre2013  <- "//Return/ReturnData/IRS990EZ/PrintingPublicationsPostage"
	exp.office.xpath <- paste( V_990EXPOFpost2013, V_990EXPOFpre2013, V_990EXPOF.EZpost2013, V_990EXPOF.EZpre2013, sep="|" )
	OFFICEEXP <- xml_text( xml_find_all( doc, exp.office.xpath ) ) 



	## PRIOR YEAR OTHER EXPENSES

	V_990POEpost2013 <- "//Return/ReturnData/IRS990/PYOtherExpensesAmt"
	V_990POEpre2013  <- "//Return/ReturnData/IRS990/OtherExpensePriorYear"
	other.exp.prior.xpath <- paste( V_990POEpost2013, V_990POEpre2013, sep="|" )
	OTHEREXPPRIOR <- xml_text( xml_find_all( doc, other.exp.prior.xpath ) ) 



	## CURRENT YEAR CURRENT EXPENSES

	V_990COEpost2013 <- "//Return/ReturnData/IRS990/CYOtherExpensesAmt"
	V_990COEpre2013  <- "//Return/ReturnData/IRS990/OtherExpensesCurrentYear"
	V_990COE.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherExpensesTotalAmt"
	V_990COE.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OtherExpensesTotal"
	other.exp.current.xpath <- paste( V_990COEpost2013, V_990COEpre2013, V_990COE.EZpost2013, V_990COE.EZpre2013, sep="|" )
	OTHEREXPCURRENT <- xml_text( xml_find_all( doc, other.exp.current.xpath ) ) 



	## PRIOR YEAR TOTAL EXPENSES

	V_990PTEpost2013 <- "//Return/ReturnData/IRS990/PYTotalExpensesAmt"
	V_990PTEpre2013  <- "//Return/ReturnData/IRS990/TotalExpensesPriorYear"
	total.exp.prior.xpath <- paste( V_990PTEpost2013, V_990PTEpre2013, sep="|" )
	TOTALEXPPRIOR <- xml_text( xml_find_all( doc, total.exp.prior.xpath ) ) 



	## CURRENT YEAR TOTAL EXPENSES

	V_990CTEpost2013 <- "//Return/ReturnData/IRS990/CYTotalExpensesAmt"
	V_990CTEpre2013  <- "//Return/ReturnData/IRS990/TotalExpensesCurrentYear"
	V_990CTE.EZpost2013 <- "//Return/ReturnData/IRS990EZ/TotalExpensesAmt"
	V_990CTE.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TotalExpenses"
	total.exp.current.xpath <- paste( V_990CTEpost2013, V_990CTEpre2013, V_990CTE.EZpost2013, V_990CTE.EZpre2013, sep="|" )
	TOTALEXPCURRENT <- xml_text( xml_find_all( doc, total.exp.current.xpath ) ) 



	## PRIOR YEAR REVENUES LESS EXPENSES

	V_990PRLEpost2013 <- "//Return/ReturnData/IRS990/PYRevenuesLessExpensesAmt"
	V_990PRLEpre2013  <- "//Return/ReturnData/IRS990/RevenuesLessExpensesPriorYear"
	rev.less.exp.prior.xpath <- paste( V_990PRLEpost2013, V_990PRLEpre2013, sep="|" )
	REVLESSEXPPRIOR <- xml_text( xml_find_all( doc, rev.less.exp.prior.xpath ) ) 



	## CURRENT YEAR REVENUES LESS EXPENSES

	V_990CRLEpost2013 <- "//Return/ReturnData/IRS990/CYRevenuesLessExpensesAmt"
	V_990CRLEpre2013  <- "//Return/ReturnData/IRS990/RevenuesLessExpensesCY"
	V_990CRLE.EZpost2013 <- "//Return/ReturnData/IRS990EZ/ExcessOrDeficitForYearAmt"
	V_990CRLE.EZpre2013  <- "//Return/ReturnData/IRS990EZ/ExcessOrDeficitForYear"
	rev.less.exp.current.xpath <- paste( V_990CRLEpost2013, V_990CRLEpre2013, V_990CRLE.EZpost2013, V_990CRLE.EZpre2013, sep="|" )
	REVLESSEXPCURRENT <- xml_text( xml_find_all( doc, rev.less.exp.current.xpath ) ) 



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART I - NET ASSETS
	## The 990-PC forms split columns in this area into Beginning of Year and End of Year.
	## Some 990-EZ data is located in Part II of that form.

	## BEGINNING OF YEAR TOTAL ASSETS

	V_990BOYTApost2013 <- "//Return/ReturnData/IRS990/TotalAssetsBOYAmt"
	V_990BOYTApre2013  <- "//Return/ReturnData/IRS990/TotalAssetsBOY"
	V_990BOYTA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Form990TotalAssetsGrp/BOYAmt"
	V_990BOYTA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TotalAssets/BOY"
	total.assets.beg.xpath <- paste( V_990BOYTApost2013, V_990BOYTApre2013, V_990BOYTA.EZpost2013, V_990BOYTA.EZpre2013, sep="|" )
	TOTALASSETSBEGYEAR <- xml_text( xml_find_all( doc, total.assets.beg.xpath ) ) 



	## END OF YEAR TOTAL ASSETS

	V_990EOYTApost2013 <- "//Return/ReturnData/IRS990/TotalAssetsEOYAmt"
	V_990EOYTApre2013  <- "//Return/ReturnData/IRS990/TotalAssetsEOY"
	V_990EOYTA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Form990TotalAssetsGrp/EOYAmt"
	V_990EOYTA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TotalAssets/EOY"
	total.assets.end.xpath <- paste( V_990EOYTApost2013, V_990EOYTApre2013, V_990EOYTA.EZpost2013, V_990EOYTA.EZpre2013, sep="|" )
	TOTALASSETSENDYEAR <- xml_text( xml_find_all( doc, total.assets.end.xpath ) ) 



	## BEGINNING OF YEAR TOTAL LIABILITIES

	V_990BOYTLpost2013 <- "//Return/ReturnData/IRS990/TotalLiabilitiesBOYAmt"
	V_990BOYTLpre2013  <- "//Return/ReturnData/IRS990/TotalLiabilitiesBOY"
	V_990BOYTL.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SumOfTotalLiabilitiesGrp/BOYAmt"
	V_990BOYTL.EZpre2013  <- "//Return/ReturnData/IRS990EZ/SumOfTotalLiabilities/BOY"
	total.liab.beg.xpath <- paste( V_990BOYTLpost2013, V_990BOYTLpre2013, V_990BOYTL.EZpost2013, V_990BOYTL.EZpre2013, sep="|" )
	TOTALLIABBEGYEAR <- xml_text( xml_find_all( doc, total.liab.beg.xpath ) ) 



	## END OF YEAR TOTAL LIABILITIES

	V_990EOYTLpost2013 <- "//Return/ReturnData/IRS990/TotalLiabilitiesEOYAmt"
	V_990EOYTLpre2013  <- "//Return/ReturnData/IRS990/TotalLiabilitiesEOY"
	V_990EOYTL.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SumOfTotalLiabilitiesGrp/EOYAmt"
	V_990EOYTL.EZpre2013  <- "//Return/ReturnData/IRS990EZ/SumOfTotalLiabilities/EOY"
	total.liab.end.xpath <- paste( V_990EOYTLpost2013, V_990EOYTLpre2013, V_990EOYTL.EZpost2013, V_990EOYTL.EZpre2013, sep="|" )
	TOTALLIABENDYEAR <- xml_text( xml_find_all( doc, total.liab.end.xpath ) ) 



	## BEGINNING OF YEAR NET ASSETS

	V_990BOYNApost2013 <- "//Return/ReturnData/IRS990/NetAssetsOrFundBalancesBOYAmt"
	V_990BOYNApre2013  <- "//Return/ReturnData/IRS990/NetAssetsOrFundBalancesBOY"
	V_990BOYNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/NetAssetsOrFundBalancesGrp/BOYAmt"
	V_990BOYNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/NetAssetsOrFundBalances/BOY"
	net.assets.beg.xpath <- paste( V_990BOYNApost2013, V_990BOYNApre2013, V_990BOYNA.EZpost2013, V_990BOYNA.EZpre2013, sep="|" )
	NETASSETSBEGYEAR <- xml_text( xml_find_all( doc, net.assets.beg.xpath ) ) 



	## OTHER CHANGES IN NET ASSETS

	V_990NAOC.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherChangesInNetAssetsAmt"
	V_990NAOC.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OtherChangesInNetAssets"
	exp.gaming.fundrs.xpath <- paste( V_990NAOC.EZpre2013, sep="|" )
	OTHERASSETSCHANGES <- xml_text( xml_find_all( doc, exp.gaming.fundrs.xpath ) )  



	## END OF YEAR NET ASSETS

	V_990EOYNApost2013 <- "//Return/ReturnData/IRS990/NetAssetsOrFundBalancesEOYAmt"
	V_990EOYNApre2013  <- "//Return/ReturnData/IRS990/NetAssetsOrFundBalancesEOY"
	V_990EOYNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/NetAssetsOrFundBalancesGrp/EOYAmt"
	V_990EOYNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/NetAssetsOrFundBalances/EOY"
	profund.fees.current.xpath <- paste( V_990EOYNApost2013, V_990EOYNApre2013, V_990EOYNA.EZpost2013, V_990EOYNA.EZpre2013, sep="|" )
	NETASSETSENDYEAR <- xml_text( xml_find_all( doc, profund.fees.current.xpath ) ) 



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART II(EZ) / X (PC) - BALANCE SHEET
	#####   Organized to capture the values present on both PC and EZ first, then PC-specific values after

	## BEGINNING OF YEAR CASH

	V_990BOYCpost2013 <- "//Return/ReturnData/IRS990/CashNonInterestBearingGrp/BOYAmt"
	V_990BOYCpre2013  <- "//Return/ReturnData/IRS990/CashNonInterestBearing/BOY"
	cash.beg.xpath <- paste( V_990BOYCpost2013, V_990BOYCpre2013, sep="|" )
	CASHBEGYEAR <- xml_text( xml_find_all( doc, cash.beg.xpath ) ) 



	## END OF YEAR CASH

	V_990EOYCpost2013 <- "//Return/ReturnData/IRS990/CashNonInterestBearingGrp/EOYAmt"
	V_990EOYCpre2013  <- "//Return/ReturnData/IRS990/CashNonInterestBearing/EOY"
	cash.end.xpath <- paste( V_990EOYCpost2013, V_990EOYCpre2013, sep="|" )
	CASHENDYEAR <- xml_text( xml_find_all( doc, cash.end.xpath ) ) 



	## BEGINNING OF YEAR SAVINGS AND TEMPORARY INVESTMENTS

	V_990BOYSIpost2013 <- "//Return/ReturnData/IRS990/SavingsAndTempCashInvstGrp/BOYAmt"
	V_990BOYSIpre2013  <- "//Return/ReturnData/IRS990/SavingsAndTempCashInvestments/BOY"
	sav.tempinv.beg.xpath <- paste( V_990BOYSIpost2013, V_990BOYSIpre2013, sep="|" )
	SAVINVBEGYEAR <- xml_text( xml_find_all( doc, sav.tempinv.beg.xpath ) ) 



	## END OF YEAR SAVINGS AND TEMPORARY INVESTMENTS

	V_990EOYSIpost2013 <- "//Return/ReturnData/IRS990/SavingsAndTempCashInvstGrp/EOYAmt"
	V_990EOYSIpre2013  <- "//Return/ReturnData/IRS990/SavingsAndTempCashInvestments/EOY"
	sav.tempinv.end.xpath <- paste( V_990EOYSIpost2013, V_990EOYSIpre2013, sep="|" )
	SAVINVENDYEAR <- xml_text( xml_find_all( doc, sav.tempinv.end.xpath ) )



	## BEGINNING OF YEAR CASH, SAVINGS, AND INVESTMENTS
	### Does not include summed values of CASHBEGYEAR and SAVINVBEGYEAR

	#V_990BOYCSIpost2013 <- sum( V_990BOYCpost2013, V_990BOYSIpost2013, na.rm=T )
	#V_990BOYCSIpre2013  <- sum( V_990BOYCpre2013, V_990BOYSIpre2013, na.rm=T  )
	V_990BOYCSI.EZpost2013 <- "//Return/ReturnData/IRS990EZ/CashSavingsAndInvestmentsGrp/BOYAmt"
	V_990BOYCSI.EZpre2013  <- "//Return/ReturnData/IRS990EZ/CashSavingsAndInvestments/BOY"
	#cash.inv.beg.xpath <- paste( V_990BOYNApost2013, V_990BOYCSIpre2013, V_990BOYCSI.EZpost2013, V_990BOYCSI.EZpre2013, sep="|" )
	cash.inv.beg.xpath <- paste( V_990BOYCSI.EZpost2013, V_990BOYCSI.EZpre2013, sep="|" )
	CASHINVBEGYEAR <- xml_text( xml_find_all( doc, cash.inv.beg.xpath ) ) 



	## END OF YEAR CASH, SAVINGS, AND INVESTMENTS
	### Does not include summed values of CASHENDYEAR and SAVINVENDYEAR

	#V_990EOYNApost2013 <- sum( V_990EOYCpost2013, V_990EOYSIpost2013, na.rm=T )
	#V_990EOYNApre2013  <- sum( V_990EOYCpre2013, V_990EOYSIpre2013, na.rm=T )
	V_990EOYNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/CashSavingsAndInvestmentsGrp/EOYAmt"
	V_990EOYNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/CashSavingsAndInvestments/EOY"
	#cash.inv.end.xpath <- paste( V_990EOYNApost2013, V_990EOYNApre2013, V_990EOYNA.EZpost2013, V_990EOYNA.EZpre2013, sep="|" )
	cash.inv.end.xpath <- paste( V_990EOYNA.EZpost2013, V_990EOYNA.EZpre2013, sep="|" )
	CASHINVENDYEAR <- xml_text( xml_find_all( doc, cash.inv.end.xpath ) ) 



	## COST OF LAND, BUILDINGS, AND EQUIPMENT

	V_990CLBEpost2013 <- "//Return/ReturnData/IRS990/LandBldgEquipCostOrOtherBssAmt"
	V_990CLBEpre2013  <- "//Return/ReturnData/IRS990/LandBuildingsEquipmentBasis"
	lbe.cost.xpath <- paste( V_990CLBEpost2013, V_990CLBEpre2013, sep="|" )
	LANDBLDEQUIPCOST <- xml_text( xml_find_all( doc, lbe.cost.xpath ) ) 



	## DEPRECIATION OF LAND, BUILDINGS, AND EQUIPMENT

	V_990DLBEpost2013 <- "//Return/ReturnData/IRS990/LandBldgEquipAccumDeprecAmt"
	V_990DLBEpre2013  <- "//Return/ReturnData/IRS990/LandBldgEquipmentAccumDeprec"
	lbe.depreciation.xpath <- paste( V_990DLBEpost2013, V_990DLBEpre2013, sep="|" )
	LANDBLDEQUIPDEP <- xml_text( xml_find_all( doc, lbe.depreciation.xpath ) )



	## BEGINNING OF YEAR LAND AND BUILDINGS (AND EQUIPMENT FOR 990-PC ONLY)

	V_990BOYLBpost2013 <- "//Return/ReturnData/IRS990/LandBldgEquipBasisNetGrp/BOYAmt"
	V_990BOYLBpre2013  <- "//Return/ReturnData/IRS990/LandBuildingsEquipmentBasisNet/BOY"
	V_990BOYLB.EZpost2013 <- "//Return/ReturnData/IRS990EZ/LandAndBuildingsGrp/BOYAmt"
	V_990BOYLB.EZpre2013  <- "//Return/ReturnData/IRS990EZ/LandAndBuildings/BOY"
	land.buildings.beg.xpath <- paste( V_990BOYLBpost2013, V_990BOYLBpre2013, V_990BOYLB.EZpost2013, V_990BOYLB.EZpre2013, sep="|" )
	LANDBEGYEAR <- xml_text( xml_find_all( doc, land.buildings.beg.xpath ) ) 



	## END OF YEAR LAND AND BUILDINGS (AND EQUIPMENT FOR 990-PC ONLY)

	V_990EOYLBpost2013 <- "//Return/ReturnData/IRS990/LandBldgEquipBasisNetGrp/EOYAmt"
	V_990EOYLBpre2013  <- "//Return/ReturnData/IRS990/LandBuildingsEquipmentBasisNet/EOY"
	V_990EOYLB.EZpost2013 <- "//Return/ReturnData/IRS990EZ/LandAndBuildingsGrp/EOYAmt"
	V_990EOYLB.EZpre2013  <- "//Return/ReturnData/IRS990EZ/LandAndBuildings/EOY"
	land.buildings.end.xpath <- paste( V_990EOYLBpost2013, V_990EOYLBpre2013, V_990EOYLB.EZpost2013, V_990EOYLB.EZpre2013, sep="|" )
	LANDENDYEAR <- xml_text( xml_find_all( doc, land.buildings.end.xpath ) ) 



	## BEGINNING OF YEAR OTHER ASSETS

	V_990BOYOApost2013 <- "//Return/ReturnData/IRS990/OtherAssetsTotalGrp/BOYAmt"
	V_990BOYOApre2013  <- "//Return/ReturnData/IRS990/OtherAssetsTotal/BOY"
	V_990BOYOA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherAssetsTotalDetail/BOYAmt"
	V_990BOYOA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OtherAssetsTotal/BOY"
	other.assets.beg.xpath <- paste( V_990BOYOApost2013, V_990BOYOApre2013, V_990BOYOA.EZpost2013, sep="|" )
	OTHERASSETSBEGYEAR <- xml_text( xml_find_all( doc, other.assets.beg.xpath ) ) 



	## END OF YEAR OTHER ASSETS 

	V_990EOYOApost2013 <- "//Return/ReturnData/IRS990/OtherAssetsTotalGrp/EOYAmt"
	V_990EOYOApre2013  <- "//Return/ReturnData/IRS990/OtherAssetsTotal/EOY"
	V_990EOYOA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherAssetsTotalDetail/EOYAmt"
	V_990EOYOA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OtherAssetsTotal/EOY"
	other.assets.end.xpath <- paste( V_990EOYOApost2013, V_990EOYOApre2013, V_990EOYOA.EZpost2013, V_990EOYOA.EZpre2013, sep="|" )
	OTHERASSETSENDYEAR <- xml_text( xml_find_all( doc, other.assets.end.xpath ) ) 



	#------------------------------------------------------------------------------------------------------------------------
	####  PART III - STATEMENT OF PROGRAM SERVICE ACCOMPLISHMENTS

	## TOTAL PROGRAM SERVICE EXPENSES

	V_990TPSEpost2013 <- "//Return/ReturnData/IRS990/TotalProgramServiceExpensesAmt"
	V_990TPSEpre2013  <- "//Return/ReturnData/IRS990/TotalProgramServiceExpense"
	V_990TPSE.EZpost2013 <- "//Return/ReturnData/IRS990EZ/TotalProgramServiceExpensesAmt"
	V_990TPSE.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TotalProgramServiceExpenses"
	land.buildings.end.xpath <- paste( V_990TPSEpost2013, V_990TPSEpre2013, V_990TPSE.EZpost2013, V_990TPSE.EZpre2013, sep="|" )
	TOTALPROGSERVEXP <- xml_text( xml_find_all( doc, land.buildings.end.xpath ) ) 



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART X - ASSETS
	#####   PC-specific Values

	## BEGINNING OF YEAR PLEDGES AND GRANTS

	V_990BOYPGpost2013 <- "//Return/ReturnData/IRS990/PledgesAndGrantsReceivableGrp/BOYAmt"
	V_990BOYPGpre2013  <- "//Return/ReturnData/IRS990/PledgesAndGrantsReceivable/BOY"
	pledges.grants.beg.xpath <- paste( V_990BOYPGpost2013, V_990BOYPGpre2013, sep="|" )
	PLEDGEGRANTBEGYEAR <- xml_text( xml_find_all( doc, pledges.grants.beg.xpath ) ) 



	## END OF YEAR PLEDGES AND GRANTS

	V_990EOYPGpost2013 <- "//Return/ReturnData/IRS990/PledgesAndGrantsReceivableGrp/EOYAmt"
	V_990EOYPGpre2013  <- "//Return/ReturnData/IRS990/PledgesAndGrantsReceivable/EOY"
	pledges.grants.end.xpath <- paste( V_990EOYPGpost2013, V_990EOYPGpre2013, sep="|" )
	PLEDGEGRANTENDYEAR <- xml_text( xml_find_all( doc, pledges.grants.end.xpath ) ) 



	## BEGINNING OF YEAR ACCOUNTS RECEIVABLE

	V_990BOYAROpost2013 <- "//Return/ReturnData/IRS990/AccountsReceivableGrp/BOYAmt"
	V_990BOYAROpre2013  <- "//Return/ReturnData/IRS990/AccountsReceivable/BOY"
	accts.receivable.beg.xpath <- paste( V_990BOYAROpost2013, V_990BOYAROpre2013, sep="|" )
	ACCTRECBEGYEAR <- xml_text( xml_find_all( doc, accts.receivable.beg.xpath ) ) 



	## END OF YEAR ACCOUNTS RECEIVABLE

	V_990EOYAROpost2013 <- "//Return/ReturnData/IRS990/AccountsReceivableGrp/EOYAmt"
	V_990EOYAROpre2013  <- "//Return/ReturnData/IRS990/AccountsReceivable/EOY"
	accts.receivable.end.xpath <- paste( V_990EOYAROpost2013, V_990EOYAROpre2013, sep="|" )
	ACCTRECENDYEAR <- xml_text( xml_find_all( doc, accts.receivable.end.xpath ) ) 



	## BEGINNING OF YEAR LOANS FROM OFFICERS
	## Confirm which Xpath

	V_990BOYLFOpost2013 <- "//Return/ReturnData/IRS990/ReceivablesFromOfficersEtcGrp/BOYAmt"
	V_990BOYLFOpre2013  <- "//Return/ReturnData/IRS990/ReceivablesFromOfficersEtc/BOY"
	loans.from.officers.beg.xpath <- paste( V_990BOYLFOpost2013, V_990BOYLFOpre2013, sep="|" )
	LOANSFROMOFFBEGYEAR <- xml_text( xml_find_all( doc, loans.from.officers.beg.xpath ) ) 



	## END OF YEAR LOANS FROM OFFICERS
	## Confirm which Xpath

	V_990EOYLFOpost2013 <- "//Return/ReturnData/IRS990/ReceivablesFromOfficersEtcGrp/EOYAmt"
	V_990EOYLFOpre2013  <- "//Return/ReturnData/IRS990/ReceivablesFromOfficersEtc/EOY"
	loans.from.officers.end.xpath <- paste( V_990EOYLFOpost2013, V_990EOYLFOpre2013, sep="|" )
	LOANSFROMOFFENDYEAR <- xml_text( xml_find_all( doc, loans.from.officers.end.xpath ) ) 



	## BEGINNING OF YEAR LOANS FROM DISQUALIFIED PERSONS

	V_990BOYLDQpost2013 <- "//Return/ReturnData/IRS990/RcvblFromDisqualifiedPrsnGrp/BOYAmt"
	V_990BOYLDQpre2013  <- "//Return/ReturnData/IRS990/ReceivablesFromDisqualPersons/BOY"
	loans.disqual.persons.beg.xpath <- paste( V_990BOYLDQpost2013, V_990BOYLDQpre2013, sep="|" )
	LOANSDQPBEGYEAR <- xml_text( xml_find_all( doc, loans.disqual.persons.beg.xpath ) ) 



	## END OF YEAR LOANS FROM DISQUALIFIED PERSONS

	V_990EOYLDQpost2013 <- "//Return/ReturnData/IRS990/RcvblFromDisqualifiedPrsnGrp/EOYAmt"
	V_990EOYLDQpre2013  <- "//Return/ReturnData/IRS990/ReceivablesFromDisqualPersons/EOY"
	loans.disqual.persons.end.xpath <- paste( V_990EOYLDQpost2013, V_990EOYLDQpre2013, sep="|" )
	LOANSDQPENDYEAR <- xml_text( xml_find_all( doc, loans.disqual.persons.end.xpath ) ) 



	## BEGINNING OF YEAR NET NOTES AND LOANS RECEIVABLE

	V_990BOYNNLpost2013 <- "//Return/ReturnData/IRS990/OthNotesLoansReceivableNetGrp/BOYAmt"
	V_990BOYNNLpre2013  <- "//Return/ReturnData/IRS990/OtherNotesLoansReceivableNet/BOY"
	net.notes.beg.xpath <- paste( V_990BOYNNLpost2013, V_990BOYNNLpre2013, sep="|" )
	LOANSNOTESBEGYEAR <- xml_text( xml_find_all( doc, net.notes.beg.xpath ) ) 



	## END OF YEAR NET NOTES AND LOANS RECEIVABLE

	V_990EOYNNLpost2013 <- "//Return/ReturnData/IRS990/OthNotesLoansReceivableNetGrp/EOYAmt"
	V_990EOYNNLpre2013  <- "//Return/ReturnData/IRS990/OtherNotesLoansReceivableNet/EOY"
	net.notes.end.xpath <- paste( V_990EOYNNLpost2013, V_990EOYNNLpre2013, sep="|" )
	LOANSNOTESENDYEAR <- xml_text( xml_find_all( doc, net.notes.end.xpath ) ) 



	## BEGINNING OF YEAR INVENTORIES FOR SALE OR USE

	V_990BOYISUpost2013 <- "//Return/ReturnData/IRS990/InventoriesForSaleOrUseGrp/BOYAmt"
	V_990BOYISUpre2013  <- "//Return/ReturnData/IRS990/InventoriesForSaleOrUse/BOY"
	inventory.beg.xpath <- paste( V_990BOYISUpost2013, V_990BOYISUpre2013, sep="|" )
	INVENTORYBEGYEAR <- xml_text( xml_find_all( doc, inventory.beg.xpath ) ) 



	## END OF YEAR INVENTORIES FOR SALE OR USE

	V_990EOYISUpost2013 <- "//Return/ReturnData/IRS990/InventoriesForSaleOrUseGrp/EOYAmt"
	V_990EOYISUpre2013  <- "//Return/ReturnData/IRS990/InventoriesForSaleOrUse/EOY"
	inventory.end.xpath <- paste( V_990EOYISUpost2013, V_990EOYISUpre2013, sep="|" )
	INVENTORYENDYEAR <- xml_text( xml_find_all( doc, inventory.end.xpath ) ) 



	## BEGINNING OF YEAR PREPAID EXPENSES

	V_990BOYPPEpost2013 <- "//Return/ReturnData/IRS990/PrepaidExpensesDefrdChargesGrp/BOYAmt"
	V_990BOYPPEpre2013  <- "//Return/ReturnData/IRS990/PrepaidExpensesDeferredCharges/BOY"
	prepaid.expenses.beg.xpath <- paste( V_990BOYPPEpost2013, V_990BOYPPEpre2013, sep="|" )
	PREEXPBEGYEAR <- xml_text( xml_find_all( doc, prepaid.expenses.beg.xpath ) ) 



	## END OF YEAR PREPAID EXPENSES

	V_990EOYPPEpost2013 <- "//Return/ReturnData/IRS990/PrepaidExpensesDefrdChargesGrp/EOYAmt"
	V_990EOYPPEpre2013  <- "//Return/ReturnData/IRS990/PrepaidExpensesDeferredCharges/EOY"
	prepaid.expenses.end.xpath <- paste( V_990EOYPPEpost2013, V_990EOYPPEpre2013, sep="|" )
	PREEXPENDYEAR <- xml_text( xml_find_all( doc, prepaid.expenses.end.xpath ) ) 



	## BEGINNING OF YEAR PUBLICLY-TRADED SECURITIES

	V_990BOYPTSpost2013 <- "//Return/ReturnData/IRS990/InvestmentsPubTradedSecGrp/BOYAmt"
	V_990BOYPTSpre2013  <- "//Return/ReturnData/IRS990/InvestmentsPubTradedSecurities/BOY"
	investments.public.beg.xpath <- paste( V_990BOYPTSpost2013, V_990BOYPTSpre2013, sep="|" )
	INVESTPUBBEGYEAR <- xml_text( xml_find_all( doc, investments.public.beg.xpath ) ) 



	## END OF YEAR PUBLICLY-TRADED SECURITIES INVESTMENTS

	V_990EOYPTSpost2013 <- "//Return/ReturnData/IRS990/InvestmentsPubTradedSecGrp/EOYAmt"
	V_990EOYPTSpre2013  <- "//Return/ReturnData/IRS990/InvestmentsPubTradedSecurities/EOY"
	investments.public.end.xpath <- paste( V_990EOYPTSpost2013, V_990EOYPTSpre2013, sep="|" )
	INVESTPUBENDYEAR <- xml_text( xml_find_all( doc, investments.public.end.xpath ) ) 



	## BEGINNING OF YEAR OTHER SECURITIES INVESTMENTS

	V_990BOYOSIpost2013 <- "//Return/ReturnData/IRS990/InvestmentsOtherSecuritiesGrp/BOYAmt"
	V_990BOYOSIpre2013  <- "//Return/ReturnData/IRS990/InvestmentsOtherSecurities/BOY"
	investments.other.beg.xpath <- paste( V_990BOYOSIpost2013, V_990BOYOSIpre2013, sep="|" )
	INVESTOTHBEGYEAR <- xml_text( xml_find_all( doc, investments.other.beg.xpath ) ) 



	## END OF YEAR OTHER SECURITIES INVESTMENTS

	V_990EOYOSIpost2013 <- "//Return/ReturnData/IRS990/InvestmentsOtherSecuritiesGrp/EOYAmt"
	V_990EOYOSIpre2013  <- "//Return/ReturnData/IRS990/InvestmentsOtherSecurities/EOY"
	investments.other.end.xpath <- paste( V_990EOYOSIpost2013, V_990EOYOSIpre2013, sep="|" )
	INVESTOTHENDYEAR <- xml_text( xml_find_all( doc, investments.other.end.xpath ) ) 



	## BEGINNING OF YEAR PROGRAM-RELATED INVESTMENTS

	V_990BOYPRIpost2013 <- "//Return/ReturnData/IRS990/InvestmentsProgramRelatedGrp/BOYAmt"
	V_990BOYPRIpre2013  <- "//Return/ReturnData/IRS990/InvestmentsProgramRelated/BOY"
	investments.prog.beg.xpath <- paste( V_990BOYPRIpost2013, V_990BOYPRIpre2013, sep="|" )
	INVESTPRGBEGYEAR <- xml_text( xml_find_all( doc, investments.prog.beg.xpath ) ) 



	## END OF YEAR PROGRAM-RELATED INVESTMENTS

	V_990EOYPRIpost2013 <- "//Return/ReturnData/IRS990/InvestmentsOtherSecuritiesGrp/EOYAmt"
	V_990EOYPRIpre2013  <- "//Return/ReturnData/IRS990/InvestmentsOtherSecurities/EOY"
	investments.prog.end.xpath <- paste( V_990EOYPRIpost2013, V_990EOYPRIpre2013, sep="|" )
	INVESTPRGENDYEAR <- xml_text( xml_find_all( doc, investments.prog.end.xpath ) ) 



	## BEGINNING OF YEAR INTANGIBLE ASSETS

	V_990BOYIApost2013 <- "//Return/ReturnData/IRS990/IntangibleAssetsGrp/BOYAmt"
	V_990BOYIApre2013  <- "//Return/ReturnData/IRS990/IntangibleAssets/BOY"
	intangible.assets.beg.xpath <- paste( V_990BOYIApost2013, V_990BOYIApre2013, sep="|" )
	INTANASSETSBEGYEAR <- xml_text( xml_find_all( doc, intangible.assets.beg.xpath ) ) 



	## END OF YEAR INTANGIBLE ASSETS

	V_990EOYIApost2013 <- "//Return/ReturnData/IRS990/IntangibleAssetsGrp/EOYAmt"
	V_990EOYIApre2013  <- "//Return/ReturnData/IRS990/IntangibleAssets/EOY"
	intangible.assets.end.xpath <- paste( V_990EOYIApost2013, V_990EOYIApre2013, sep="|" )
	INTANASSETSENDYEAR <- xml_text( xml_find_all( doc, intangible.assets.end.xpath ) ) 



	## BEGINNING OF YEAR TOTAL ASSETS FROM BALANCE SHEET
	## Should equal TOTALASSETSBEGYEAR

	V_990BOYBSTApost2013 <- "//Return/ReturnData/IRS990/TotalAssetsGrp/BOYAmt"
	V_990BOYBSTApre2013  <- "//Return/ReturnData/IRS990/TotalAssets/BOY"
	totalassets.balsheet.beg.xpath <- paste( V_990BOYBSTApost2013, V_990BOYBSTApre2013, sep="|" )
	TABALSHEETBEGYEAR <- xml_text( xml_find_all( doc, totalassets.balsheet.beg.xpath ) ) 



	## END OF YEAR TOTAL ASSETS FROM BALANCE SHEET
	## Should equal TOTALASSETSENDYEAR

	V_990EOYBSTApost2013 <- "//Return/ReturnData/IRS990/TotalAssetsGrp/EOYAmt"
	V_990EOYBSTApre2013  <- "//Return/ReturnData/IRS990/TotalAssets/EOY"
	totalassets.balsheet.end.xpath <- paste( V_990EOYBSTApost2013, V_990EOYBSTApre2013, sep="|" )
	TABALSHEETENDYEAR <- xml_text( xml_find_all( doc, totalassets.balsheet.end.xpath ) ) 



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART X - LIABILITIES
	#####   PC-specific Values

	## BEGINNING OF YEAR ACCOUNTS PAYABLE AND ACCRUED EXPENSES

	V_990BOYAPpost2013 <- "//Return/ReturnData/IRS990/AccountsPayableAccrExpnssGrp/BOYAmt"
	V_990BOYAPpre2013  <- "//Return/ReturnData/IRS990/AccountsPayableAccruedExpenses/BOY"
	accts.payable.beg.xpath <- paste( V_990BOYAPpost2013, V_990BOYAPpre2013, sep="|" )
	ACCTPAYBEGYEAR <- xml_text( xml_find_all( doc, accts.payable.beg.xpath ) ) 



	## END OF YEAR ACCOUNTS PAYABLE AND ACCRUED EXPENSES

	V_990EOYAPpost2013 <- "//Return/ReturnData/IRS990/AccountsPayableAccrExpnssGrp/EOYAmt"
	V_990EOYAPpre2013  <- "//Return/ReturnData/IRS990/AccountsPayableAccruedExpenses/EOY"
	accts.payable.end.xpath <- paste( V_990EOYAPpost2013, V_990EOYAPpre2013, sep="|" )
	ACCTPAYENDYEAR <- xml_text( xml_find_all( doc, accts.payable.end.xpath ) )



	## BEGINNING OF YEAR GRANTS PAYABLE

	V_990BOYGPpost2013 <- "//Return/ReturnData/IRS990/GrantsPayableGrp/BOYAmt"
	V_990BOYGPpre2013  <- "//Return/ReturnData/IRS990/GrantsPayable/BOY"
	grants.payable.beg.xpath <- paste( V_990BOYGPpost2013, V_990BOYGPpre2013, sep="|" )
	GRANTSPAYBEGYEAR <- xml_text( xml_find_all( doc, grants.payable.beg.xpath ) ) 



	## END OF YEAR GRANTS PAYABLE

	V_990EOYGPpost2013 <- "//Return/ReturnData/IRS990/GrantsPayableGrp/EOYAmt"
	V_990EOYGPpre2013  <- "//Return/ReturnData/IRS990/GrantsPayable/EOY"
	grants.payable.end.xpath <- paste( V_990EOYGPpost2013, V_990EOYGPpre2013, sep="|" )
	GRANTSPAYENDYEAR <- xml_text( xml_find_all( doc, grants.payable.end.xpath ) )



	## BEGINNING OF YEAR DEFERRED REVENUE

	V_990BOYDRpost2013 <- "//Return/ReturnData/IRS990/DeferredRevenueGrp/BOYAmt"
	V_990BOYDRpre2013  <- "//Return/ReturnData/IRS990/DeferredRevenue/BOY"
	deferred.rev.beg.xpath <- paste( V_990BOYDRpost2013, V_990BOYDRpre2013, sep="|" )
	DEFREVBEGYEAR <- xml_text( xml_find_all( doc, deferred.rev.beg.xpath ) ) 



	## END OF YEAR DEFERRED REVENUE

	V_990EOYDRpost2013 <- "//Return/ReturnData/IRS990/DeferredRevenueGrp/EOYAmt"
	V_990EOYDRpre2013  <- "//Return/ReturnData/IRS990/DeferredRevenue/EOY"
	deferred.rev.end.xpath <- paste( V_990EOYDRpost2013, V_990EOYDRpre2013, sep="|" )
	DEFREVENDYEAR <- xml_text( xml_find_all( doc, deferred.rev.end.xpath ) )



	## BEGINNING OF YEAR TAX-EXEMPT BOND LIABILITIES

	V_990BOYBLpost2013 <- "//Return/ReturnData/IRS990/TaxExemptBondLiabilitiesGrp/BOYAmt"
	V_990BOYBLpre2013  <- "//Return/ReturnData/IRS990/TaxExemptBondLiabilities/BOY"
	bond.liab.beg.xpath <- paste( V_990BOYBLpost2013, V_990BOYBLpre2013, sep="|" )
	BONDBEGYEAR <- xml_text( xml_find_all( doc, bond.liab.beg.xpath ) ) 



	## END OF YEAR TAX-EXEMPT BOND LIABILITIES

	V_990EOYBLpost2013 <- "//Return/ReturnData/IRS990/TaxExemptBondLiabilitiesGrp/EOYAmt"
	V_990EOYBLpre2013  <- "//Return/ReturnData/IRS990/TaxExemptBondLiabilities/EOY"
	bond.liab.end.xpath <- paste( V_990EOYBLpost2013, V_990EOYBLpre2013, sep="|" )
	BONDENDYEAR <- xml_text( xml_find_all( doc, bond.liab.end.xpath ) )



	## BEGINNING OF YEAR ESCROW ACCOUNT LIABILITIES

	V_990BOYELpost2013 <- "//Return/ReturnData/IRS990/EscrowAccountLiabilityGrp/BOYAmt"
	V_990BOYELpre2013  <- "//Return/ReturnData/IRS990/EscrowAccountLiability/BOY"
	escrow.liab.beg.xpath <- paste( V_990BOYELpost2013, V_990BOYELpre2013, sep="|" )
	ESCROWBEGYEAR <- xml_text( xml_find_all( doc, escrow.liab.beg.xpath ) ) 



	## END OF YEAR ESCROW ACCOUNT LIABILITIES

	V_990EOYELpost2013 <- "//Return/ReturnData/IRS990/EscrowAccountLiabilityGrp/EOYAmt"
	V_990EOYELpre2013  <- "//Return/ReturnData/IRS990/EscrowAccountLiability/EOY"
	escrow.liab.end.xpath <- paste( V_990EOYELpost2013, V_990EOYELpre2013, sep="|" )
	ESCROWENDYEAR <- xml_text( xml_find_all( doc, escrow.liab.end.xpath ) )



	## BEGINNING OF YEAR LOANS TO OFFICERS
	## Confirm that this is the appropriate Xpath

	V_990BOYLTOpost2013 <- "//Return/ReturnData/IRS990/LoansFromOfficersDirectorsGrp/BOYAmt"
	V_990BOYLTOpre2013  <- "//Return/ReturnData/IRS990/LoansFromOfficersDirectors/BOY"
	loans.to.officers.beg.xpath <- paste( V_990BOYLTOpost2013, V_990BOYLTOpre2013, sep="|" )
	LOANSTOOFFBEGYEAR <- xml_text( xml_find_all( doc, loans.to.officers.beg.xpath ) ) 



	## END OF YEAR LOANS TO OFFICERS
	## Confirm that this is the appropriate Xpath

	V_990EOYLTOpost2013 <- "//Return/ReturnData/IRS990/LoansFromOfficersDirectorsGrp/EOYAmt"
	V_990EOYLTOpre2013  <- "//Return/ReturnData/IRS990/LoansFromOfficersDirectors/EOY"
	loans.to.officers.end.xpath <- paste( V_990EOYLTOpost2013, V_990EOYLTOpre2013, sep="|" )
	LOANSTOOFFENDYEAR <- xml_text( xml_find_all( doc, loans.to.officers.end.xpath ) )



	## BEGINNING OF YEAR SECURED MORTGAGES

	V_990BOYSMpost2013 <- "//Return/ReturnData/IRS990/MortgNotesPyblScrdInvstPropGrp/BOYAmt"
	V_990BOYSMpre2013  <- "//Return/ReturnData/IRS990/MortNotesPyblSecuredInvestProp/BOY"
	mortgage.beg.xpath <- paste( V_990BOYSMpost2013, V_990BOYSMpre2013, sep="|" )
	MORTGAGEBEGYEAR <- xml_text( xml_find_all( doc, mortgage.beg.xpath ) ) 



	## END OF YEAR SECURED MORTGAGES

	V_990EOYSMpost2013 <- "//Return/ReturnData/IRS990/MortgNotesPyblScrdInvstPropGrp/EOYAmt"
	V_990EOYSMpre2013  <- "//Return/ReturnData/IRS990/MortNotesPyblSecuredInvestProp/EOY"
	mortgage.end.xpath <- paste( V_990EOYSMpost2013, V_990EOYSMpre2013, sep="|" )
	MORTGAGEENDYEAR <- xml_text( xml_find_all( doc, mortgage.end.xpath ) )



	## BEGINNING OF YEAR UNSECURED NOTES

	V_990BOYUNpost2013 <- "//Return/ReturnData/IRS990/UnsecuredNotesLoansPayableGrp/BOYAmt"
	V_990BOYUNpre2013  <- "//Return/ReturnData/IRS990/UnsecuredNotesLoansPayable/BOY"
	unsec.notes.beg.xpath <- paste( V_990BOYUNpost2013, V_990BOYUNpre2013, sep="|" )
	UNSECNOTESBEGYEAR <- xml_text( xml_find_all( doc, unsec.notes.beg.xpath ) ) 



	## END OF YEAR UNSECURED NOTES

	V_990EOYUNpost2013 <- "//Return/ReturnData/IRS990/UnsecuredNotesLoansPayableGrp/EOYAmt"
	V_990EOYUNpre2013  <- "//Return/ReturnData/IRS990/UnsecuredNotesLoansPayable/EOY"
	unsec.notes.end.xpath <- paste( V_990EOYUNpost2013, V_990EOYUNpre2013, sep="|" )
	UNSECNOTESENDYEAR <- xml_text( xml_find_all( doc, unsec.notes.end.xpath ) )



	## BEGINNING OF YEAR OTHER LIABILITIES

	V_990BOYOLpost2013 <- "//Return/ReturnData/IRS990/OtherLiabilitiesGrp/BOYAmt"
	V_990BOYOLpre2013  <- "//Return/ReturnData/IRS990/OtherLiabilities/BOY"
	other.liab.beg.xpath <- paste( V_990BOYOLpost2013, V_990BOYOLpre2013, sep="|" )
	OTHERLIABBEGYEAR <- xml_text( xml_find_all( doc, other.liab.beg.xpath ) ) 



	## END OF YEAR OTHER LIABILITIES

	V_990EOYOLpost2013 <- "//Return/ReturnData/IRS990/OtherLiabilitiesGrp/EOYAmt"
	V_990EOYOLpre2013  <- "//Return/ReturnData/IRS990/OtherLiabilities/EOY"
	other.liab.end.xpath <- paste( V_990EOYOLpost2013, V_990EOYOLpre2013, sep="|" )
	OTHERLIABENDYEAR <- xml_text( xml_find_all( doc, other.liab.end.xpath ) )



	## BEGINNING OF YEAR TOTAL LIABILITIES FROM BALANCE SHEET
	## Should equal TOTALLIABBEGYEAR

	V_990BOYBSTLpost2013 <- "//Return/ReturnData/IRS990/TotalLiabilitiesGrp/BOYAmt"
	V_990BOYBSTLpre2013  <- "//Return/ReturnData/IRS990/TotalLiabilities/BOY"
	totalliab.balsheet.beg.xpath <- paste( V_990BOYBSTLpost2013, V_990BOYBSTLpre2013, sep="|" )
	TLBALSHEETBEGYEAR <- xml_text( xml_find_all( doc, totalliab.balsheet.beg.xpath ) ) 



	## END OF YEAR TOTAL LIABILITIES FROM BALANCE SHEET
	## Should equal TOTALLIABENDYEAR

	V_990EOYBSTLpost2013 <- "//Return/ReturnData/IRS990/TotalLiabilitiesGrp/EOYAmt"
	V_990EOYBSTLpre2013  <- "//Return/ReturnData/IRS990/TotalLiabilities/EOY"
	totalliab.balsheet.end.xpath <- paste( V_990EOYBSTLpost2013, V_990EOYBSTLpre2013, sep="|" )
	TLBALSHEETENDYEAR <- xml_text( xml_find_all( doc, totalliab.balsheet.end.xpath ) ) 



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART X - NET ASSETS OR FUND BALANCES
	#####   PC-specific Values

	## ORGANIZATION FOLLOWS SFAS 117 (checkbox)

	V_990SFASYpost2013 <- "//Return/ReturnData/IRS990/OrganizationFollowsSFAS117Ind"
	V_990SFASYpre2013  <- "//Return/ReturnData/IRS990/FollowSFAS117"
	sfas.yes.xpath <- paste( V_990SFASYpost2013, V_990SFASYpre2013, sep="|" )
	ORGSFAS117 <- xml_text( xml_find_all( doc, sfas.yes.xpath ) ) 



	## ORGANIZATION DOES NOT FOLLOWS SFAS 117 (checkbox)

	V_990SFASYpost2013 <- "//Return/ReturnData/IRS990/OrgDoesNotFollowSFAS117Ind"
	V_990SFASYpre2013  <- "//Return/ReturnData/IRS990/DoNotFollowSFAS117"
	sfas.no.xpath <- paste( V_990SFASYpost2013, V_990SFASYpre2013, sep="|" )
	ORGNOTSFAS117 <- xml_text( xml_find_all( doc, sfas.no.xpath ) )



	## BEGINNING OF YEAR UNRESTRICTED NET ASSETS

	V_990BOYUApost2013 <- "//Return/ReturnData/IRS990/UnrestrictedNetAssetsGrp/BOYAmt"
	V_990BOYUApre2013  <- "//Return/ReturnData/IRS990/UnrestrictedNetAssets/BOY"
	unrest.na.beg.xpath <- paste( V_990BOYUApost2013, V_990BOYUApre2013, sep="|" )
	URESTNABEGYEAR <- xml_text( xml_find_all( doc, unrest.na.beg.xpath ) ) 



	## END OF YEAR UNRESTRICTED NET ASSETS

	V_990EOYUApost2013 <- "//Return/ReturnData/IRS990/UnrestrictedNetAssetsGrp/EOYAmt"
	V_990EOYUApre2013  <- "//Return/ReturnData/IRS990/UnrestrictedNetAssets/EOY"
	unrest.na.end.xpath <- paste( V_990EOYUApost2013, V_990EOYUApre2013, sep="|" )
	URESTNAENDYEAR <- xml_text( xml_find_all( doc, unrest.na.end.xpath ) )



	## BEGINNING OF YEAR TEMPORARILY RESTRICTED NET ASSETS

	V_990BOYTRApost2013 <- "//Return/ReturnData/IRS990/TemporarilyRstrNetAssetsGrp/BOYAmt"
	V_990BOYTRApre2013  <- "//Return/ReturnData/IRS990/TemporarilyRestrictedNetAssets/BOY"
	temp.rest.na.beg.xpath <- paste( V_990BOYTRApost2013, V_990BOYTRApre2013, sep="|" )
	TRESTNABEGYEAR <- xml_text( xml_find_all( doc, temp.rest.na.beg.xpath ) ) 



	## END OF YEAR TEMPORARILY RESTRICTED NET ASSETS

	V_990EOYTRApost2013 <- "//Return/ReturnData/IRS990/TemporarilyRstrNetAssetsGrp/EOYAmt"
	V_990EOYTRApre2013  <- "//Return/ReturnData/IRS990/TemporarilyRestrictedNetAssets/EOY"
	temp.rest.na.end.xpath <- paste( V_990EOYTRApost2013, V_990EOYTRApre2013, sep="|" )
	TRESTNAENDYEAR  <- xml_text( xml_find_all( doc, temp.rest.na.end.xpath ) )



	## BEGINNING OF YEAR PERMANENTLY RESTRICTED NET ASSETS

	V_990BOYPRApost2013 <- "//Return/ReturnData/IRS990/PermanentlyRstrNetAssetsGrp/BOYAmt"
	V_990BOYPRApre2013  <- "//Return/ReturnData/IRS990/PermanentlyRestrictedNetAssets/BOY"
	perm.rest.na.beg.xpath <- paste( V_990BOYPRApost2013, V_990BOYPRApre2013, sep="|" )
	PRESTNABEGYEAR <- xml_text( xml_find_all( doc, perm.rest.na.beg.xpath ) ) 



	## END OF YEAR PERMANENTLY RESTRICTED NET ASSETS

	V_990EOYPRApost2013 <- "//Return/ReturnData/IRS990/PermanentlyRstrNetAssetsGrp/EOYAmt"
	V_990EOYPRApre2013  <- "//Return/ReturnData/IRS990/PermanentlyRestrictedNetAssets/EOY"
	perm.rest.na.end.xpath <- paste( V_990EOYPRApost2013, V_990EOYPRApre2013, sep="|" )
	PRESTNAENDYEAR  <- xml_text( xml_find_all( doc, perm.rest.na.end.xpath ) )



	## BEGINNING OF YEAR CAPITAL STOCK

	V_990BOYSTOCKpost2013 <- "//Return/ReturnData/IRS990/CapStkTrPrinCurrentFundsGrp/BOYAmt"
	V_990BOYSTOCKpre2013  <- "//Return/ReturnData/IRS990/CapStckTrstPrinCurrentFunds/BOY"
	stock.beg.xpath <- paste( V_990BOYSTOCKpost2013, V_990BOYSTOCKpre2013, sep="|" )
	STOCKBEGYEAR <- xml_text( xml_find_all( doc, stock.beg.xpath ) ) 



	## END OF YEAR CAPITAL STOCK

	V_990EOYSTOCKpost2013 <- "//Return/ReturnData/IRS990/CapStkTrPrinCurrentFundsGrp/EOYAmt"
	V_990EOYSTOCKpre2013  <- "//Return/ReturnData/IRS990/CapStckTrstPrinCurrentFunds/EOY"
	stock.end.xpath <- paste( V_990EOYSTOCKpost2013, V_990EOYSTOCKpre2013, sep="|" )
	STOCKENDYEAR  <- xml_text( xml_find_all( doc, stock.end.xpath ) )



	## BEGINNING OF YEAR PAID-IN SURPLUS

	V_990BOYPISpost2013 <- "//Return/ReturnData/IRS990/PdInCapSrplsLandBldgEqpFundGrp/BOYAmt"
	V_990BOYPISpre2013  <- "//Return/ReturnData/IRS990/PaidInCapSrplsLandBldgEqpFund/BOY"
	surplus.beg.xpath <- paste( V_990BOYPISpost2013, V_990BOYPISpre2013, sep="|" )
	SURPLUSBEGYEAR <- xml_text( xml_find_all( doc, surplus.beg.xpath ) ) 



	## END OF YEAR PAID-IN SURPLUS

	V_990EOYPISpost2013 <- "//Return/ReturnData/IRS990/PdInCapSrplsLandBldgEqpFundGrp/EOYAmt"
	V_990EOYPISpre2013  <- "//Return/ReturnData/IRS990/PaidInCapSrplsLandBldgEqpFund/EOY"
	surplus.end.xpath <- paste( V_990EOYPISpost2013, V_990EOYPISpre2013, sep="|" )
	SURPLUSENDYEAR  <- xml_text( xml_find_all( doc, surplus.end.xpath ) )



	## BEGINNING OF YEAR RETAINED EARNINGS

	V_990BOYREpost2013 <- "//Return/ReturnData/IRS990/RtnEarnEndowmentIncmOthFndsGrp/BOYAmt"
	V_990BOYREpre2013  <- "//Return/ReturnData/IRS990/RetainedEarningsEndowmentEtc/BOY"
	earnings.beg.xpath <- paste( V_990BOYREpost2013, V_990BOYREpre2013, sep="|" )
	EARNINGSBEGYEAR <- xml_text( xml_find_all( doc, earnings.beg.xpath ) ) 



	## END OF YEAR RETAINED EARNINGS

	V_990EOYREpost2013 <- "//Return/ReturnData/IRS990/RtnEarnEndowmentIncmOthFndsGrp/EOYAmt"
	V_990EOYREpre2013  <- "//Return/ReturnData/IRS990/RetainedEarningsEndowmentEtc/EOY"
	earnings.end.xpath <- paste( V_990EOYREpost2013, V_990EOYREpre2013, sep="|" )
	EARNINGSENDYEAR  <- xml_text( xml_find_all( doc, earnings.end.xpath ) )



	## BEGINNING OF YEAR TOTAL NET ASSETS AND FUND BALANCES

	V_990BOYTNApost2013 <- "//Return/ReturnData/IRS990/TotalNetAssetsFundBalanceGrp/BOYAmt"
	V_990BOYTNApre2013  <- "//Return/ReturnData/IRS990/TotalNetAssetsFundBalances/BOY"
	total.na.beg.xpath <- paste( V_990BOYTNApost2013, V_990BOYTNApre2013, sep="|" )
	TOTNETASSETSBEGYEAR <- xml_text( xml_find_all( doc, total.na.beg.xpath ) ) 



	## END OF YEAR TOTAL NET ASSETS AND FUND BALANCES

	V_990EOYTNApost2013 <- "//Return/ReturnData/IRS990/TotalNetAssetsFundBalanceGrp/EOYAmt"
	V_990EOYTNApre2013  <- "//Return/ReturnData/IRS990/TotalNetAssetsFundBalances/EOY"
	total.na.end.xpath <- paste( V_990EOYTNApost2013, V_990EOYTNApre2013, sep="|" )
	TOTNETASSETSENDYEAR  <- xml_text( xml_find_all( doc, total.na.end.xpath ) )



	## BEGINNING OF YEAR TOTAL LIABILITIES AND NET ASSETS/FUND BALANCES

	V_990BOYTLANApost2013 <- "//Return/ReturnData/IRS990/TotLiabNetAssetsFundBalanceGrp/BOYAmt"
	V_990BOYTLANApre2013  <- "//Return/ReturnData/IRS990/TotalLiabNetAssetsFundBalances/BOY"
	total.liab.na.beg.xpath <- paste( V_990BOYTLANApost2013, V_990BOYTLANApre2013, sep="|" )
	TOTLIABNABEGYEAR <- xml_text( xml_find_all( doc, total.liab.na.beg.xpath ) ) 



	## END OF YEAR TOTAL LIABILITIES AND NET ASSETS/FUND BALANCES

	V_990EOYTLANApost2013 <- "//Return/ReturnData/IRS990/TotLiabNetAssetsFundBalanceGrp/EOYAmt"
	V_990EOYTLANApre2013  <- "//Return/ReturnData/IRS990/TotalLiabNetAssetsFundBalances/EOY"
	total.liab.na.end.xpath <- paste( V_990EOYTLANApost2013, V_990EOYTLANApre2013, sep="|" )
	TOTLIABNAENDYEAR  <- xml_text( xml_find_all( doc, total.liab.na.end.xpath ) )



	#------------------------------------------------------------------------------------------------------------------------
	###  BIND VARIABLES TOGETHER

	namedList <- function(...){
		      names <- as.list(substitute(list(...)))[-1L]
		      result <- list(...)
		      names(result) <- names
		      result[sapply(result, function(x){length(x)==0})] <- NA
		      result[sapply(result, is.null)] <- NA
		      result
		  }


	var.list <- namedList( #HEADER
			       URL, NAME, EIN, DBA, EXEMPT4947A1, EXEMPT501C, EXEMPT501CNUM, EXEMPT501C3, 
			       EXEMPT527, FORMORGASSOC, FORMORGCORP, FORMORGTRUST, FORMORGOTHER, FORMYEAR, 
			       DOMICILE, WEBSITE, ADDRESS, CITY, STATE, ZIP, TAXFORM, TAXPREP, FISYR, 
			       STYEAR, ENDYEAR, GROSSRECEIPTS, GROUPRETURN, GROUPEXEMPTNUM, ACCTACCRUAL, 
			       ACCTCASH, ACCTOTHER, 
			       #PART I 
			       VOTINGMEMBERS, INDVOTINGMEMBERS, TOTEMPLOYEE, TOTVOLUNTEERS, TOTUBI, NETUBI,
			       CONTRIBPRIOR, CONTRIBCURRENT, PSRPRIOR, PSRCURRENT, INVINCPRIOR, INVINCCURRENT, 
			       OTHERREVPRIOR, OTHERREVCURRENT, TOTALREVPRIOR, TOTALREVCURRENT, MEMBERDUES, 
			       GROSSSALESOTHER, SALESCOSTOTHER, NETSALESOTHER, GROSSINCGAMING, 
			       GROSSINCFNDEVENTS, GAMINGEXP, FNDEVENTSEXP, EXPGAMINGFNDEVENTS, 
			       NETGAMINGFNDEVENTS, GAMINGNET, FNDEVENTSNET, GROSSSALESINV, SALESCOSTINV, 
			       NETSALESINV, GRANTSPAIDPRIOR, GRANTSPAIDCURRENT, MEMBERBENPRIOR, 
			       MEMBERBENCURRENT, SALARIESPRIOR, SALARIESCURRENT, PROFUNDFEESPRIOR, 
			       PROFUNDFEESCURRENT, TOTFUNDEXP, FEESMGMT, FEESLEGAL, FEESACCT, FEESLOBBY,
			       FEESPROFND, FEESINVMGMT, FEESOTHER, PROFEESINDEP, OCCUPANCY, OFFICEEXP, 
			       OTHEREXPPRIOR, OTHEREXPCURRENT, TOTALEXPPRIOR, TOTALEXPCURRENT,
			       REVLESSEXPPRIOR, REVLESSEXPCURRENT, TOTALASSETSBEGYEAR, TOTALASSETSENDYEAR,
			       TOTALLIABBEGYEAR, TOTALLIABENDYEAR, NETASSETSBEGYEAR, OTHERASSETSCHANGES, 
			       NETASSETSENDYEAR, 
			       #PART II / X
			       CASHBEGYEAR, CASHENDYEAR, SAVINVBEGYEAR, SAVINVENDYEAR, 
			       CASHINVBEGYEAR, CASHINVENDYEAR, LANDBLDEQUIPCOST, LANDBLDEQUIPDEP, 
			       LANDBEGYEAR, LANDENDYEAR, OTHERASSETSBEGYEAR, OTHERASSETSENDYEAR, 
			       PLEDGEGRANTBEGYEAR, PLEDGEGRANTENDYEAR, ACCTRECBEGYEAR, ACCTRECENDYEAR,
			       LOANSFROMOFFBEGYEAR, LOANSFROMOFFENDYEAR, LOANSDQPBEGYEAR, LOANSDQPENDYEAR,
			       LOANSNOTESBEGYEAR, LOANSNOTESENDYEAR, INVENTORYBEGYEAR, INVENTORYENDYEAR,
			       PREEXPBEGYEAR, PREEXPENDYEAR, INVESTPUBBEGYEAR, INVESTPUBENDYEAR, 
			       INVESTOTHBEGYEAR, INVESTOTHENDYEAR, INVESTPRGBEGYEAR, INVESTPRGENDYEAR, 
			       INTANASSETSBEGYEAR, INTANASSETSENDYEAR, TABALSHEETBEGYEAR, TABALSHEETENDYEAR,
			       ACCTPAYBEGYEAR, ACCTPAYENDYEAR, GRANTSPAYBEGYEAR, GRANTSPAYENDYEAR, 
			       DEFREVBEGYEAR, DEFREVENDYEAR, BONDBEGYEAR, BONDENDYEAR, ESCROWBEGYEAR, 
			       ESCROWENDYEAR, LOANSTOOFFBEGYEAR, LOANSTOOFFENDYEAR, MORTGAGEBEGYEAR, 
			       MORTGAGEENDYEAR, UNSECNOTESBEGYEAR, UNSECNOTESENDYEAR, OTHERLIABBEGYEAR, 
			       OTHERLIABENDYEAR, TLBALSHEETBEGYEAR, TLBALSHEETENDYEAR, ORGSFAS117, 
			       ORGNOTSFAS117, URESTNABEGYEAR, URESTNAENDYEAR, TRESTNABEGYEAR, 
			       TRESTNAENDYEAR, PRESTNABEGYEAR, PRESTNAENDYEAR, STOCKBEGYEAR, STOCKENDYEAR, 
			       SURPLUSBEGYEAR, SURPLUSENDYEAR, EARNINGSBEGYEAR, EARNINGSENDYEAR,
			       TOTNETASSETSBEGYEAR, TOTNETASSETSENDYEAR, TOTLIABNABEGYEAR, TOTLIABNAENDYEAR, 
			       TOTALPROGSERVEXP,
			       #PART III
			       TOTALPROGSERVEXP
			      )
	# variables that are functions:
	## EXPGAMINGFNDEVENTS: PC values are sum of GAMINGEXP and FNDEVENTSEXP
	## NETGAMINGFNDEVENTS: PC values are sum of GAMINGNET and FNDEVENTSNET
	## PROFEESINDEP: PC values are sum of FEESMGMT, FEESLEGAL, FEESACCT, FEESLOBBY,
	##                                    FEESPROFND, FEESINVMGMT, FEESOTHER
	## CASHINVBEGYEAR: PC values are sum of CASHBEGYEAR and SAVINVBEGYEAR
	## CASHINVENDYEAR: PC values are sum of CASHENDYEAR and SAVINVENDYEAR


	return( var.list )




}

