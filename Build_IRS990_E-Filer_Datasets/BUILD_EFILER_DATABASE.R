




#-------------------------------------------------------------------------------------




# FUNCTION TO BUILD THE CORE DATASET
# 
# Arguments: 
#    ein - character vector of nonprofits to sample
#    years - vector of which years to collect
#    form.type - which type of data to collect
#    index - database of all electronic filers provided by the IRS


buildCore <- function( eins=NULL, index=NULL, years, form.type=c("990","990EZ") )
{
  
  library( dplyr )
  library( xml2 ) 
  
  # BUILD NECESSARY RESOURCES
  
  if( is.null(index) ) { index <- buildIndex() }
  
  if( is.null(eins) ) { eins <- unique( index$EIN ) }
  
  
  
  # SUBSET INDEX FILE BY SPECIFIED YEARS AND FORMS
  # Return list of URLS to scrape
  
  these <- index[ index$EIN %in% eins & index$FilingYear %in% years & index$FormType %in% form.type , "URL" ]
  
  
  
  
  
  # NEED THIS TO BUILD CONSISTENT DATA.FRAMES WHEN VARIABLES ARE NOT PRESENT
  # http://stackoverflow.com/questions/16951080/can-list-objects-be-created-in-r-that-name-themselves-based-on-input-object-name
  namedList <- function(...){
      names <- as.list(substitute(list(...)))[-1L]
      result <- list(...)
      names(result) <- names
      result[sapply(result, function(x){length(x)==0})] <- NA
      result[sapply(result, is.null)] <- NA
      result
  }
  
  core <- NULL
  
  for( i in 1:length(these) )
  {
     one.npo <- scrapeXML( url=these[i], form.type=form.type )
     
     if( ! is.null(one.npo) )
     {
       core <- bind_rows( core, one.npo )
     }
  }
  
  # need to clean up variable types
  
  return( core )

}





#-------------------------------------------------------------------------------------


buildIndex <- function( )
{


	library( jsonlite )
	library( R.utils )


	### CREATE A DIRECTORY FOR YOUR DATA

	#  dir.create( "IRS Nonprofit Data" )

	# setwd( "./IRS Nonprofit Data" )


	### DOWNLOAD FILES AND UNZIP
        #
	# electronic.filers <- "https://s3.amazonaws.com/irs-form-990/index.json.gz"
        #
	# download.file( url=electronic.filers, "electronic.json.gz" )
        #
	# gunzip("electronic.json.gz", remove=TRUE )  
        #
        #
	# CREATE A DATA FRAME OF ELECTRONIC FILERS FROM IRS JSON FILES
        #
	# data.ef <- fromJSON( txt="electronic.json" )[[1]]

	# nrow( data.ef )


	dat1 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2011.json")[[1]]
	dat2 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2012.json")[[1]]
	dat3 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2013.json")[[1]]
	dat4 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2014.json")[[1]]
	dat5 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2015.json")[[1]]
	dat6 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2016.json")[[1]]
	
	data.ef <- rbind( dat1, dat2, dat3, dat4, dat5, dat6 )

	# REFORMAT DATE FROM YYYY-MM TO YYYY

	# Tax Period represents the end of the nonprofit's accounting year
	# The tax filing year is always the previous year, unless the accounting year ends in December
	
        year <- as.numeric( substr( data.ef$TaxPeriod, 1, 4 ) )
	month <- substr( data.ef$TaxPeriod, 5, 6 )

	data.ef$FilingYear <- year - 1
	data.ef$FilingYear[ month == "12" ] <- year[ month == "12" ]


	return( data.ef )



}




#-------------------------------------------------------------------------------------


# FUNCTION TO COLLECT DATA FROM XML DOCS ON AWS
#
# Arguments:
#   url - link to a nonprofits xml page
#   form.type - check to ensure data is from the correct form in case of poor data in index file
#
# Return Value:
#   one-row data frame containing elements from one nonprofit




scrapeXML <- function( url, form.type )
{

    
    # print( url )



    doc <- read_xml( url )
    xml_ns_strip( doc )
    
    
    # check to ensure it is the proper form type
    FORM <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/*[contains( name(), 'ReturnType')]" ) )
    if( length(FORM) == 0 ){ FORM <- "NOT REPORTED ON 990" }
    if( is.null(FORM) ){ FORM <- "NOT REPORTED ON 990" }
    if( ! FORM %in% form.type ) 
    { 
       cat( paste( "Organization is not the correct return type;", "\n",
                    "Desired: ", form.type, "; Actual Type: ", FORM, "\n",
                    url, "\n \n", sep="" ) )
    
       return(NULL)
       
    }
    

  #------------------------------------------------------------------------------------------------------------------------
  # TO FACILITATE PRODUCTION RULES
    
    zeroPC <- function( var )
    { 
      if( FORMTYPE=="990" )
      {
         if( length(var) == 0 ){ return("0") }
         if( is.na(var) ){ return("0") }
      }
      return( var )
    }
    
    zeroEZ <- function( var )
    { 
      if( FORMTYPE=="990EZ" )
      {
        if( length(var) == 0 ){ return("0") }
        if( is.na(var) ){ return("0") }
      }
      return( var )
    }
    
    zeroALL <- function( var )
    {
      if( length(var) == 0 ){ return("0") }
      if( is.na(var)  ){ return("0") }
      return( var )
    }
    
	#------------------------------------------------------------------------------------------------------------------------
	#### FROM NCCS CORE - HEADER DATA
	#### Fields here are same for forms of same year (990 & 990EZ post-2013; 990 & 990EZ pre-2013)

	## EIN
	#### EIN field is the same for all forms

	EIN  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/EIN" ) )



	## NAME

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

	V_990FYRpost2013 <- "//Return/ReturnHeader/TaxYr"
	V_990FYRpre2013  <- "//Return/ReturnHeader/TaxYear"
	fiscal.year.xpath <- paste( V_990FYRpost2013, V_990FYRpre2013, sep="|" )
	FISYR <- xml_text( xml_find_all( doc, fiscal.year.xpath ) )



	## STATE

	V_990STATEpost2013 <- "//Return/ReturnHeader/Filer/USAddress/StateAbbreviationCd"
	V_990STATEpre2013  <- "//Return/ReturnHeader/Filer/USAddress/State"
	state.xpath <- paste( V_990STATEpost2013, V_990STATEpre2013, sep="|" )
	STATE <- xml_text( xml_find_all( doc, state.xpath ) )



	## ADDRESS

	V_990ADDRpost2013 <- "//Return/ReturnHeader/Filer/USAddress/AddressLine1Txt"
	V_990ADDRpre2013  <- "//Return/ReturnHeader/Filer/USAddress/AddressLine1"
	address.xpath <- paste( V_990ADDRpost2013, V_990ADDRpre2013, sep="|" )
	ADDRESS <- xml_text( xml_find_all( doc, address.xpath ) )



	## CITY

	V_990CITYpost2013 <- "//Return/ReturnHeader/Filer/USAddress/CityNm"
	V_990CITYpre2013  <- "//Return/ReturnHeader/Filer/USAddress/City"
	city.xpath <- paste( V_990CITYpost2013, V_990CITYpre2013, sep="|" )
	CITY <- xml_text( xml_find_all( doc, city.xpath ) )



	## ZIP CODE

	V_990ZIPpost2013 <- "//Return/ReturnHeader/Filer/USAddress/ZIPCd"
	V_990ZIPpre2013  <- "//Return/ReturnHeader/Filer/USAddress/ZIPCode"
	zip.xpath <- paste( V_990ZIPpost2013, V_990ZIPpre2013, sep="|" )
	ZIP <- xml_text( xml_find_all( doc, zip.xpath ) )



	## START OF YEAR

	V_990SYpost2013 <- "//Return/ReturnHeader/TaxPeriodBeginDt"
	V_990SYpre2013  <- "//Return/ReturnHeader/TaxPeriodBeginDate"
	start.year.xpath <- paste( V_990SYpost2013, V_990SYpre2013, sep="|" )
	STYEAR <- xml_text( xml_find_all( doc, start.year.xpath ) )



	## END OF YEAR

	V_990EYpost2013 <- "//Return/ReturnHeader/TaxPeriodEndDt"
	V_990EYpre2013  <- "//Return/ReturnHeader/TaxPeriodEndDate"
	end.year.xpath <- paste( V_990EYpost2013, V_990EYpre2013, sep="|" )
	ENDYEAR <- xml_text( xml_find_all( doc, end.year.xpath ) )



	## TAX PREPARER

	V_990TPpost2013 <- "//Return/ReturnHeader/PreparerPersonGrp/PreparerPersonNm"
	V_990TPpre2013  <- "//Return/ReturnHeader/Preparer/Name"
	tax.prep.xpath <- paste( V_990TPpost2013, V_990TPpre2013, sep="|" )
	TAXPREP <- xml_text( xml_find_all( doc, tax.prep.xpath ) )



	## TYPE OF TAX FORM

	V_990TFpost2013 <- "//Return/ReturnHeader/ReturnTypeCd"
	V_990TFpre2013  <- "//Return/ReturnHeader/ReturnType"
	tax.form.xpath <- paste( V_990TFpost2013, V_990TFpre2013, sep="|" )
	FORMTYPE <- xml_text( xml_find_all( doc, tax.form.xpath ) )



	#------------------------------------------------------------------------------------------------------------------------
	##### BASIC INFO

	## GROSS RECEIPTS

	V_990GRCpost2013 <- "//Return/ReturnData/IRS990/GrossReceiptsAmt"
	V_990GRCpre2013  <- "//Return/ReturnData/IRS990/GrossReceipts"
	V_990GRC.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GrossReceiptsAmt"
	V_990GRC.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GrossReceipts"
	greceipts.xpath <- paste( V_990GRCpost2013, V_990GRCpre2013, V_990GRC.EZpost2013, V_990GRC.EZpre2013, sep="|" )
	GROSSRECEIPTS <- xml_text( xml_find_all( doc, greceipts.xpath ) ) 
	GROSSRECEIPTS <- zeroALL( GROSSRECEIPTS )


	## GROUP RETURNS  

	V_990GRTpost2013 <- "//Return/ReturnData/IRS990/GroupReturnForAffiliatesInd"
	V_990GRTpre2013  <- "//Return/ReturnData/IRS990/GroupReturnForAffiliates"
	greturn.xpath <- paste( V_990GRTpost2013, V_990GRTpre2013, sep="|" )
	GROUPRETURN <- xml_text( xml_find_all( doc, greturn.xpath ) ) 



	## GROUP EXEMPTION NUMBER

	V_990GENpost2013 <- "//Return/ReturnData/IRS990/GroupExemptionNum"
	V_990GENpre2013  <- "//Return/ReturnData/IRS990/GroupExemptionNumber"
	V_990GEN.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GroupExemptionNum"
	V_990GEN.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GroupExemptionNumber"
	gexempt.number.xpath <- paste( V_990GENpost2013, V_990GENpre2013, V_990GEN.EZpost2013, V_990GEN.EZpre2013, sep="|" )
	GROUPEXEMPTNUM <- xml_text( xml_find_all( doc, gexempt.number.xpath ) ) 



	## FORM YEAR

	V_990FORMYRpost2013 <- "//Return/ReturnData/IRS990/FormationYr"
	V_990FORMYRpre2013  <- "//Return/ReturnData/IRS990/YearFormation"
	form.year.xpath <- paste( V_990FORMYRpost2013, V_990FORMYRpre2013, sep="|" )
	FORMYEAR <- xml_text( xml_find_all( doc, form.year.xpath ) ) 



	## STATE OF LEGAL DOMICILE

	V_990DOMpost2013 <- "//Return/ReturnData/IRS990/LegalDomicileStateCd"
	V_990DOMpre2013  <- "//Return/ReturnData/IRS990/StateLegalDomicile"
	domicile.xpath <- paste( V_990DOMpost2013, V_990DOMpre2013, sep="|" )
	DOMICILE <- xml_text( xml_find_all( doc, domicile.xpath ) ) 
        DOMICILE <- paste( DOMICILE, collapse=" " )


	## WEBSITE

	V_990WEBpost2013 <- "//Return/ReturnData/IRS990/WebsiteAddressTxt"
	V_990WEBpre2013  <- "//Return/ReturnData/IRS990/WebSite"
	V_990WEB.EZpost2013 <- "//Return/ReturnData/IRS990EZ/WebsiteAddressTxt"
	V_990WEB.EZpre2013  <- "//Return/ReturnData/IRS990EZ/WebSite"
	website.xpath <- paste( V_990WEBpost2013, V_990WEBpre2013, V_990WEB.EZpost2013, V_990WEB.EZpre2013, sep="|" )
	WEBSITE <- xml_text( xml_find_all( doc, website.xpath ) ) 



	## URL

	URL <- url



	## FORM OF ORGANIZATION: represent the 4 possible values, broken out then collapsed
	## EZ Values are extrapolated from 990s

	## ORGANIZATION IS ASSOCATION

	V_990FOApost2013 <- "//Return/ReturnData/IRS990/TypeOfOrganizationAssocInd"
	V_990FOApre2013  <- "//Return/ReturnData/IRS990/TypeOfOrganizationAssociation"
	V_990FOA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/TypeOfOrganizationAssocInd"
	V_990FOA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TypeOfOrganizationAssociation"
	type.org.assoc.xpath <- paste( V_990FOApost2013, V_990FOApre2013, V_990FOA.EZpost2013, V_990FOA.EZpre2013, sep="|" )
	FORMORGASSOC <- xml_text( xml_find_all( doc, type.org.assoc.xpath ) ) 

	FORMORGASSOC[ length( FORMORGASSOC ) == 0]  <- NA
	if( is.na( FORMORGASSOC ) == FALSE ) { FORMORGASSOC <- "Association" }



	## ORGANIZATION IS CORPORATION

	V_990FOCpost2013 <- "//Return/ReturnData/IRS990/TypeOfOrganizationCorpInd"
	V_990FOCpre2013  <- "//Return/ReturnData/IRS990/TypeOfOrganizationCorporation"
	V_990FOC.EZpost2013 <- "//Return/ReturnData/IRS990EZ/TypeOfOrganizationCorpInd"
	V_990FOC.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TypeOfOrganizationCorporation"
	type.org.corp.xpath <- paste( V_990FOCpost2013, V_990FOCpre2013, V_990FOC.EZpost2013, V_990FOC.EZpre2013, sep="|" )
	FORMORGCORP <- xml_text( xml_find_all( doc, type.org.corp.xpath ) ) 

	FORMORGCORP[ length( FORMORGCORP ) == 0]  <- NA
	if( is.na( FORMORGCORP ) == FALSE ) { FORMORGCORP <- "Corporation" }



	## ORGANIZATION IS TRUST

	V_990FOTpost2013 <- "//Return/ReturnData/IRS990/TypeOfOrganizationTrustInd"
	V_990FOTpre2013  <- "//Return/ReturnData/IRS990/TypeOfOrganizationTrust"
	V_990FOT.EZpost2013 <- "//Return/ReturnData/IRS990EZ/TypeOfOrganizationTrustInd"
	V_990FOT.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TypeOfOrganizationTrust"
	type.org.trust.xpath <- paste( V_990FOTpost2013, V_990FOTpre2013, V_990FOT.EZpost2013, V_990FOT.EZpre2013, sep="|" )
	FORMORGTRUST <- xml_text( xml_find_all( doc, type.org.trust.xpath ) ) 

	FORMORGTRUST[ length( FORMORGTRUST ) == 0]  <- NA
	if( is.na( FORMORGTRUST ) == FALSE ) { FORMORGTRUST <- "Trust" }



	## ORGANIZATION IS OTHER (CHECK BOX)

	V_990FOOpost2013 <- "//Return/ReturnData/IRS990/TypeOfOrganizationOtherInd"
	V_990FOOpre2013  <- "//Return/ReturnData/IRS990/TypeOfOrganizationOther"
	V_990FOO.EZpost2013 <- "//Return/ReturnData/IRS990EZ/TypeOfOrganizationOtherInd"
	V_990FOO.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TypeOfOrganizationOther"
	type.org.other.xpath <- paste( V_990FOOpost2013, V_990FOOpre2013, V_990FOO.EZpost2013, V_990FOO.EZpre2013, sep="|" )
	FORMORGOTHER <- xml_text( xml_find_all( doc, type.org.other.xpath ) ) 

	FORMORGOTHER[ length( FORMORGOTHER ) == 0]  <- NA
	if( is.na( FORMORGOTHER ) == FALSE ) { FORMORGOTHER <- "" }



	## WRITTEN-IN DESCRIPTION OF ORGANIZATION:OTHER

	V_990FOWpost2013 <- "//Return/ReturnData/IRS990/OtherOrganizationDsc"
	V_990FOWpre2013  <- "//Return/ReturnData/IRS990/TypeOfOrgOtherDescription"
	V_990FOW.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherOrganizationDsc"
	V_990FOW.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TypeOfOrgOtherDescription"
	type.org.written.xpath <- paste( V_990FOWpost2013, V_990FOWpre2013, V_990FOW.EZpost2013, V_990FOW.EZpre2013, sep="|" )
	FORMORGOTHERDESC <- xml_text( xml_find_all( doc, type.org.written.xpath ) ) 



	## FORM OF ORGANIZATION (COLLAPSED)

	FORMORG <- gsub( "NA", "", paste( FORMORGASSOC, FORMORGCORP, FORMORGTRUST, FORMORGOTHER, FORMORGOTHERDESC, sep="" ) )
	FORMORG[ FORMORG  == "" ] <- NA



	##  ACCOUNTING METHODS: represent the 3 possible values, broken out then collapsed
	## ACCRUAL ACCOUNTING METHOD

	V_990AMApost2013 <- "//Return/ReturnData/IRS990/MethodOfAccountingAccrualInd"
	V_990AMApre2013  <- "//Return/ReturnData/IRS990/MethodOfAccountingAccrual"
	V_990AMA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingAccrualInd"
	V_990AMA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingAccrual"
	accounting.accrual.xpath <- paste( V_990AMApost2013, V_990AMApre2013, V_990AMA.EZpost2013, V_990AMA.EZpre2013, sep="|" )
	ACCTACCRUAL <- xml_text( xml_find_all( doc, accounting.accrual.xpath ) ) 

	ACCTACCRUAL[ length( ACCTACCRUAL ) == 0]  <- NA
	if( is.na( ACCTACCRUAL ) == FALSE ) { ACCTACCRUAL <- "Accrual" }



	## CASH ACCOUNTING METHOD

	V_990AMCpost2013 <- "//Return/ReturnData/IRS990/MethodOfAccountingCashInd"
	V_990AMCpre2013  <- "//Return/ReturnData/IRS990/MethodOfAccountingCash"
	V_990AMC.EZpost2013 <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingCashInd"
	V_990AMC.EZpre2013  <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingCash"
	accounting.cash.xpath <- paste( V_990AMCpost2013, V_990AMCpre2013, V_990AMC.EZpost2013, V_990AMC.EZpre2013, sep="|" )
	ACCTCASH <- xml_text( xml_find_all( doc, accounting.cash.xpath ) ) 

	ACCTCASH[ length( ACCTCASH ) == 0]  <- NA
	if( is.na(  ACCTCASH ) == FALSE ) {  ACCTCASH <- "Cash" }



	## OTHER ACCOUNTING METHOD
	## Should return a string, not an "X" indicating checkbox

	V_990AMOpost2013 <- "//Return/ReturnData/IRS990/MethodOfAccountingOtherInd/@methodOfAccountingOtherDesc"
	V_990AMOpre2013  <- "//Return/ReturnData/IRS990/MethodOfAccountingOther/@note"
	V_990AMO.EZpost2013 <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingOtherDesc"
	V_990AMO.EZpre2013  <- "//Return/ReturnData/IRS990EZ/MethodOfAccountingOther"
	accounting.other.xpath <- paste( V_990AMOpost2013, V_990AMOpre2013, V_990AMO.EZpost2013, V_990AMO.EZpre2013, sep="|" )
	ACCTOTHER <- xml_text( xml_find_all( doc, accounting.other.xpath ) ) 

	ACCTOTHER[ length( ACCTOTHER ) == 0]  <- NA



	## ACCOUNTING METHOD (COLLAPSED)

	ACCTMETHOD <- gsub( "NA", "", paste( ACCTACCRUAL, ACCTCASH, ACCTOTHER, sep="" ) )
	ACCTMETHOD[ ACCTMETHOD  == "" ] <- NA



	##   TAX EXEMPT STATUS: represent the 5 possible values, broken out then collapsed
	## EXEMPT STATUS 4947(a)(1)

	V_990.4947post2013 <- "//Return/ReturnData/IRS990/Organization4947a1NotPFInd"
	V_990.4947pre2013  <- "//Return/ReturnData/IRS990/Organization4947a1"
	V_990.4947.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Organization4947a1NotPFInd"
	V_990.4947.EZpre2013  <- "//Return/ReturnData/IRS990EZ/Organization4947a1"
	exempt.4947.xpath <- paste( V_990.4947post2013, V_990.4947pre2013, V_990.4947.EZpost2013, V_990.4947.EZpre2013, sep="|" )
	EXEMPT4947A1 <- xml_text( xml_find_all( doc, exempt.4947.xpath ) ) 

	EXEMPT4947A1[ length( EXEMPT4947A1 ) == 0]  <- NA
	if( is.na( EXEMPT4947A1 ) == FALSE) { EXEMPT4947A1 <- "4947a1" }



	## EXEMPT STATUS 501(c)(other than 3)

	V_990.501Cpost2013 <- "//Return/ReturnData/IRS990/Organization501cInd"
	V_990.501Cpre2013  <- "//Return/ReturnData/IRS990/Organization501c"
	V_990.501C.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Organization501cInd"
	V_990.501C.EZpre2013  <- "//Return/ReturnData/IRS990EZ/Organization501c"
	exempt.501c.xpath <- paste( V_990.501Cpost2013, V_990.501Cpre2013, V_990.501C.EZpost2013, V_990.501C.EZpre2013, sep="|" )
	EXEMPT501C <- xml_text( xml_find_all( doc, exempt.501c.xpath ) ) 

	EXEMPT501C[ length( EXEMPT501C ) == 0]  <- NA
	if( is.na( EXEMPT501C ) == FALSE ) { EXEMPT501C <- "501c" }



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

	EXEMPT501C3[ length( EXEMPT501C3 ) == 0]  <- NA
	if( is.na( EXEMPT501C3 ) == FALSE ) { EXEMPT501C3 <- "501c3" }



	## EXEMPT STATUS 527

	V_990.527post2013 <- "//Return/ReturnData/IRS990/Organization527Ind"
	V_990.527pre2013  <- "//Return/ReturnData/IRS990/Organization527"
	V_990.527.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Organization527Ind"
	V_990.527.EZpre2013  <- "//Return/ReturnData/IRS990EZ/Organization527"
	exempt.527.xpath <- paste( V_990.527post2013, V_990.527pre2013, V_990.527.EZpost2013, V_990.527.EZpre2013, sep="|" )
	EXEMPT527 <- xml_text( xml_find_all( doc, exempt.527.xpath ) ) 

	EXEMPT527[ length( EXEMPT527 ) == 0]  <- NA
	if( is.na( EXEMPT527 ) == FALSE ) { EXEMPT527 <- "527" }



	## EXEMPT STATUS COLLAPSED

	EXEMPTSTATUS <- gsub( "NA", "", paste( EXEMPT4947A1, EXEMPT501C, EXEMPT501CNUM, EXEMPT501C3, EXEMPT527, sep="" ) )
	EXEMPTSTATUS[ EXEMPTSTATUS  == "" ] <- NA



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART I - ACTIVITIES AND GOVERNANCE 

	## MISSION

	V_990Mpost2013 <- "//Return/ReturnData/IRS990/ActivityOrMissionDesc"
	V_990Mpre2013 <- "//Return/ReturnData/IRS990/ActivityOrMissionDescription"
	V_990M.EZpost2013 <- "//Return/ReturnData/IRS990EZ/PrimaryExemptPurposeTxt"
	V_990M.EZpre2013 <- "//Return/ReturnData/IRS990EZ/PrimaryExemptPurpose"
	mission.xpath <- paste( V_990Mpost2013, V_990Mpre2013, V_990M.EZpost2013, V_990M.EZpre2013, sep="|" )
	MISSION <- xml_text( xml_find_all( doc, mission.xpath ) ) 



	## DISCONTINUED OPERATIONS OR DISPOSAL OF >25% ASSETS
	## Double-check this xpath

	V_990DOpost2013 <- "//Return/ReturnData/IRS990/ContractTerminationInd"
	V_990DOpre2013 <- "//Return/ReturnData/IRS990/TerminationOrContraction"
	discontinued.ops.xpath <- paste( V_990DOpost2013, V_990DOpre2013, sep="|" )
	DISCOPS <- xml_text( xml_find_all( doc, discontinued.ops.xpath ) ) 



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
	TOTUBI <- zeroPC( TOTUBI )



	## NET UBI

	V_990NUpost2013 <- "//Return/ReturnData/IRS990/NetUnrelatedBusTxblIncmAmt"
	V_990NUpre2013  <- "//Return/ReturnData/IRS990/NetUnrelatedBusinessTxblIncome"
	net.ubi.xpath <- paste( V_990NUpost2013, V_990NUpre2013, sep="|" )
	NETUBI <- xml_text( xml_find_all( doc, net.ubi.xpath ) )
  NETUBI <- zeroPC( NETUBI )


  
	#------------------------------------------------------------------------------------------------------------------------
	#####  PART I - REVENUES 
	## The 990-PC forms split columns in this area into Current Year and Prior Year, the 990-EZs do not. 990-EZ data
	## in this section only maps to current year values unless indicated otherwise.

	## PRIOR YEAR CONTRIBUTIONS

	V_990PCpost2013 <- "//Return/ReturnData/IRS990/ContributionsGrantsPriorYear"
	V_990PCpre2013  <- "//Return/ReturnData/IRS990/PYContributionsGrantsAmt"
	contrib.prior.xpath <- paste( V_990PCpost2013, V_990PCpre2013, sep="|" )
	CONTRIBPRIOR <- xml_text( xml_find_all( doc, contrib.prior.xpath ) ) 
	CONTRIBPRIOR <- zeroPC( CONTRIBPRIOR )


	## CURRENT YEAR CONTRIBUTIONS

	V_990CCpost2013 <- "//Return/ReturnData/IRS990/CYContributionsGrantsAmt"
	V_990CCpre2013  <- "//Return/ReturnData/IRS990/ContributionsGrantsCurrentYear"
	V_990CC.EZpost2013 <- "//Return/ReturnData/IRS990EZ/ContributionsGiftsGrantsEtc"
	V_990CC.EZpre2013  <- "//Return/ReturnData/IRS990EZ/ContributionsGiftsGrantsEtcAmt"
	contrib.current.xpath <- paste( V_990CCpost2013, V_990CCpre2013, V_990CC.EZpost2013, V_990CC.EZpre2013, sep="|" )
	CONTRIBCURRENT <- xml_text( xml_find_all( doc, contrib.current.xpath ) ) 
	CONTRIBCURRENT <- zeroALL( CONTRIBCURRENT )


	## PRIOR YEAR PROGRAM SERVICE REVENUE

	V_990PPSRpost2013 <- "//Return/ReturnData/IRS990/PYProgramServiceRevenueAmt"
	V_990PPSRpre2013  <- "//Return/ReturnData/IRS990/ProgramServiceRevenuePriorYear"
	psr.prior.xpath <- paste( V_990PPSRpost2013, V_990PPSRpre2013, sep="|" )
	PSRPRIOR <- xml_text( xml_find_all( doc, psr.prior.xpath ) ) 
	PSRPRIOR <- zeroPC( PSRPRIOR )

	## CURRENT YEAR PROGRAM SERVICE REVENUE

	V_990CPSRpost2013 <- "//Return/ReturnData/IRS990/CYProgramServiceRevenueAmt"
	V_990CPSRpre2013  <- "//Return/ReturnData/IRS990/ProgramServiceRevenueCY"
	V_990CPSR.EZpost2013 <- "//Return/ReturnData/IRS990EZ/ProgramServiceRevenueAmt"
	V_990CPSR.EZpre2013  <- "//Return/ReturnData/IRS990EZ/ProgramServiceRevenue"
	psr.current.xpath <- paste( V_990CPSRpost2013, V_990CPSRpre2013, V_990CPSR.EZpost2013, V_990CPSR.EZpre2013, sep="|" )
	PSRCURRENT <- xml_text( xml_find_all( doc, psr.current.xpath ) )  
	PSRCURRENT <- zeroALL( PSRCURRENT )


	## PRIOR YEAR INVESTMENT INCOME

	V_990PIVpost2013 <- "//Return/ReturnData/IRS990/PYInvestmentIncomeAmt"
	V_990PIVpre2013  <- "//Return/ReturnData/IRS990/InvestmentIncomePriorYear"
	invest.income.prior.xpath <- paste( V_990PIVpost2013, V_990PIVpre2013, sep="|" )
	INVINCPRIOR <- xml_text( xml_find_all( doc, invest.income.prior.xpath ) )  
	INVINCPRIOR <- zeroPC( INVINCPRIOR )


	## CURRENT YEAR INVESTMENT INCOME

	V_990CIVpost2013 <- "//Return/ReturnData/IRS990/CYInvestmentIncomeAmt"
	V_990CIVpre2013  <- "//Return/ReturnData/IRS990/InvestmentIncomeCurrentYear"
	V_990CIV.EZpost2013 <- "//Return/ReturnData/IRS990EZ/InvestmentIncomeAmt"
	V_990CIV.EZpre2013  <- "//Return/ReturnData/IRS990EZ/InvestmentIncome"
	invest.income.current.xpath <- paste( V_990CIVpost2013, V_990CIVpre2013, V_990CIV.EZpost2013, V_990CIV.EZpre2013, sep="|" )
	INVINCCURRENT <- xml_text( xml_find_all( doc, invest.income.current.xpath ) )  
	INVINCCURRENT <- zeroALL( INVINCCURRENT )


	## PRIOR YEAR OTHER REVENUE

	V_990PORpost2013 <- "//Return/ReturnData/IRS990/PYOtherRevenueAmt"
	V_990PORpre2013  <- "//Return/ReturnData/IRS990/OtherRevenuePriorYear"
	other.rev.prior.xpath <- paste( V_990PORpost2013, V_990PORpre2013, sep="|" )
	OTHERREVPRIOR <- xml_text( xml_find_all( doc, other.rev.prior.xpath ) )  
	OTHERREVPRIOR <- zeroPC( OTHERREVPRIOR )


	## CURRENT YEAR OTHER REVENUE

	V_990CORpost2013 <- "//Return/ReturnData/IRS990/CYOtherRevenueAmt"
	V_990CORpre2013  <- "//Return/ReturnData/IRS990/OtherRevenueCurrentYear"
	V_990CR.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherRevenueTotalAmt"
	V_990CR.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OtherRevenueTotal"
	other.rev.current.xpath <- paste( V_990CORpost2013, V_990CORpre2013, V_990CR.EZpost2013, V_990CR.EZpre2013, sep="|" )
	OTHERREVCURRENT <- xml_text( xml_find_all( doc, other.rev.current.xpath ) )  
	OTHERREVCURRENT <- zeroALL( OTHERREVCURRENT )



	## PRIOR YEAR TOTAL REVENUE

	V_990PTRpost2013 <- "//Return/ReturnData/IRS990/PYTotalRevenueAmt"
	V_990PTRpre2013  <- "//Return/ReturnData/IRS990/TotalRevenuePriorYear"
	total.rev.prior.xpath <- paste( V_990PTRpost2013, V_990PTRpre2013, sep="|" )
	TOTALREVPRIOR <- xml_text( xml_find_all( doc, total.rev.prior.xpath ) )  
	TOTALREVPRIOR <- zeroPC( TOTALREVPRIOR )


	## CURRENT YEAR TOTAL REVENUE

	V_990CTRpost2013 <- "//Return/ReturnData/IRS990/CYTotalRevenueAmt"
	V_990CTRpre2013  <- "//Return/ReturnData/IRS990/TotalRevenueCurrentYear"
	V_990CTR.EZpost2013 <- "//Return/ReturnData/IRS990EZ/TotalRevenueAmt"
	V_990CTR.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TotalRevenue"
	total.rev.current.xpath <- paste( V_990CTRpost2013, V_990CTRpre2013, V_990CTR.EZpost2013, V_990CTR.EZpre2013, sep="|" )
	TOTALREVCURRENT <- xml_text( xml_find_all( doc, total.rev.current.xpath ) )  
	TOTALREVCURRENT <- zeroALL( TOTALREVCURRENT )

	

	#------------------------------------------------------------------------------------------------------------------------
	#####  PART I - REVENUES (990EZ-specific fields)
	## Some of the paths here are on the 990 PC but in different areas. They are included here to help
	## with mapping across forms. Some of the PC fields here roll up to map to 1 EZ field.

	## MEMBERSHIP DUES

	V_990MBRDpost2013 <- "//Return/ReturnData/IRS990/MembershipDuesAmt"
	V_990MBRDpre2013  <- "//Return/ReturnData/IRS990/MembershipDues"
	V_990MBRD.EZpost2013 <- "//Return/ReturnData/IRS990EZ/MembershipDuesAmt"
	V_990MBRD.EZpre2013  <- "//Return/ReturnData/IRS990EZ/MembershipDues"
	member.dues.xpath <- paste( V_990MBRDpost2013, V_990MBRDpre2013, V_990MBRD.EZpost2013, V_990MBRD.EZpre2013, sep="|" )
	MEMBERDUES <- xml_text( xml_find_all( doc, member.dues.xpath ) )  
	MEMBERDUES <- zeroALL( MEMBERDUES )


	## GROSS SALES OF NON-INVENTORY ASSETS

	V_990GSNApost2013 <- "//Return/ReturnData/IRS990/GrossAmountSalesAssetsGrp/OtherAmt"
	V_990GSNApre2013  <- "//Return/ReturnData/IRS990/GrossAmountSalesAssets/Other"
	V_990GSNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SaleOfAssetsGrossAmt"
	V_990GSNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GrossAmountFromSaleOfAssets"
	grosssales.nonasset.xpath <- paste( V_990GSNApost2013, V_990GSNApre2013, V_990GSNA.EZpost2013, V_990GSNA.EZpre2013, sep="|" )
	GROSSSALESOTHER <- xml_text( xml_find_all( doc, grosssales.nonasset.xpath ) )  
	GROSSSALESOTHER <- zeroALL( GROSSSALESOTHER )


	## COST AND SALES EXPENSES FROM NON-INVENTORY ASSET SALES

	V_990TSNApost2013 <- "//Return/ReturnData/IRS990/LessCostOthBasisSalesExpnssGrp/OtherAmt"
	V_990TSNApre2013  <- "//Return/ReturnData/IRS990/LessCostOthBasisSalesExpenses/Other"
	V_990TSNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/CostOrOtherBasisExpenseSaleAmt"
	V_990TSNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/CostOtherBasisAndSalesExpenses"
	totalsales.nonasset.xpath <- paste( V_990TSNApost2013, V_990TSNApre2013, V_990TSNA.EZpost2013, V_990TSNA.EZpre2013, sep="|" )
	SALESCOSTOTHER <- xml_text( xml_find_all( doc, totalsales.nonasset.xpath ) )  
	SALESCOSTOTHER <- zeroALL( SALESCOSTOTHER )


	## NET SALES OF NON-INVENTORY ASSETS
	## includes securities for the PC forms

	V_990NSNApost2013 <- "//Return/ReturnData/IRS990/NetGainOrLossInvestmentsGrp/TotalRevenueColumnAmt"
	V_990NSNApre2013  <- "//Return/ReturnData/IRS990/NetGainOrLossInvestments/TotalRevenueColumn"
	V_990NSNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GainOrLossFromSaleOfAssetsAmt"
	V_990NSNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GainOrLossFromSaleOfAssets"
	netsales.nonassets.xpath <- paste( V_990NSNApost2013, V_990NSNApre2013, V_990NSNA.EZpost2013, V_990NSNA.EZpre2013, sep="|" )
	NETSALESOTHER <- xml_text( xml_find_all( doc, netsales.nonassets.xpath ) )  
	NETSALESOTHER <- zeroALL( NETSALESOTHER )


	## GROSS INCOME FROM GAMING

	V_990GIGpost2013 <- "//Return/ReturnData/IRS990/GamingGrossIncomeAmt"
	V_990GIGpre2013  <- "//Return/ReturnData/IRS990/GrossIncomeGaming"
	V_990GIG.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GamingGrossIncomeAmt"
	V_990GIG.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GamingGrossIncome"
	grossinc.gaming.xpath <- paste( V_990GIGpost2013, V_990GIGpre2013, V_990GIG.EZpost2013, V_990GIG.EZpre2013, sep="|" )
	GROSSINCGAMING <- xml_text( xml_find_all( doc, grossinc.gaming.xpath ) )  
	GROSSINCGAMING <- zeroALL( GROSSINCGAMING )


	## GROSS INCOME FROM FUNDRAISING EVENTS

	V_990GIFpost2013 <- "//Return/ReturnData/IRS990/FundraisingGrossIncomeAmt"
	V_990GIFpre2013  <- "//Return/ReturnData/IRS990/GrossIncomeFundraisingEvents"
	V_990GIF.EZpost2013 <- "//Return/ReturnData/IRS990EZ/FundraisingGrossIncomeAmt"
	V_990GIF.EZpre2013  <- "//Return/ReturnData/IRS990EZ/FundraisingGrossIncome"
	grossinc.fundrs.xpath <- paste( V_990GIFpost2013, V_990GIFpre2013, V_990GIF.EZpost2013, V_990GIF.EZpre2013, sep="|" )
	GROSSINCFNDEVENTS <- xml_text( xml_find_all( doc, grossinc.fundrs.xpath ) )  
	GROSSINCFNDEVENTS <- zeroALL( GROSSINCFNDEVENTS )


	## EXPENSES FROM GAMING EVENTS
	## PC only

	V_990gamexppost2013 <- "//Return/ReturnData/IRS990/GamingDirectExpensesAmt"
	V_990gamexppre2013 <- "//Return/ReturnData/IRS990/GamingDirectExpenses"
	gaming.exp.xpath <- paste( V_990gamexppost2013, V_990gamexppre2013, sep="|" )
	GAMINGEXP <- xml_text( xml_find_all( doc, gaming.exp.xpath ) )  

	GAMINGEXP[ length( GAMINGEXP ) == 0 ]  <- NA
	GAMINGEXP <- zeroPC( GAMINGEXP )


	## EXPENSES FROM FUNDRAISING EVENTS
	## PC only

	V_990fndexppost2013 <- "//Return/ReturnData/IRS990/FundraisingDirectExpensesAmt"
	V_990fndexppre2013 <- "//Return/ReturnData/IRS990/FundraisingDirectExpenses"
	fnd.events.exp.xpath <- paste( V_990fndexppost2013, V_990fndexppre2013, sep="|" )
	FNDEVENTSEXP <- xml_text( xml_find_all( doc, fnd.events.exp.xpath ) )  

	FNDEVENTSEXP[ length( FNDEVENTSEXP ) == 0]  <- NA
	FNDEVENTSEXP <- zeroPC( FNDEVENTSEXP )


	## EXPENSES FROM GAMING AND FUNDRAISING EVENTS

	if( FORMTYPE == "990EZ" ){
	  V_990EGF.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SpecialEventsDirectExpensesAmt"
	  V_990EGF.EZpre2013  <- "//Return/ReturnData/IRS990EZ/SpecialEventsDirectExpenses"
	  exp.gaming.fundrs.xpath <- paste( V_990EGF.EZpost2013, V_990EGF.EZpre2013, sep="|" )
	  EXPGAMINGFNDEVENTS <- xml_text( xml_find_all( doc, exp.gaming.fundrs.xpath ) )
	} else if( FORMTYPE == "990" ){
	  EXPGAMINGFNDEVENTS <- sum( as.numeric( GAMINGEXP ), as.numeric( FNDEVENTSEXP ), na.rm=T )
	}
	EXPGAMINGFNDEVENTS <- as.character( EXPGAMINGFNDEVENTS )
	EXPGAMINGFNDEVENTS <- zeroALL( EXPGAMINGFNDEVENTS )


	## NET GAIN OR LOSS FROM GAMING EVENTS
	## PC only

	V_990totrevgampost2013 <- "//Return/ReturnData/IRS990/NetIncomeFromGamingGrp/TotalRevenueColumnAmt"
	V_990totrevgampre2013 <- "//Return/ReturnData/IRS990/NetIncomeFromGaming/TotalRevenueColumn"
	gaming.net.xpath <- paste( V_990totrevgampost2013, V_990totrevgampre2013, sep="|" )
	GAMINGNET <- xml_text( xml_find_all( doc, gaming.net.xpath ) )  

	GAMINGNET[ length( GAMINGNET ) == 0]  <- NA
	GAMINGNET <- zeroPC( GAMINGNET )


	## NET GAIN OR LOSS FROM FUNDRAISING EVENTS
	## PC only

	V_990totrevfndpost2013 <- "//Return/ReturnData/IRS990/NetIncmFromFundraisingEvtGrp/TotalRevenueColumnAmt"
	V_990totrevfndpre2013 <- "//Return/ReturnData/IRS990/NetIncomeFromFundraisingEvents/TotalRevenueColumn"
	fnd.events.net.xpath <- paste( V_990totrevfndpost2013, V_990totrevfndpre2013, sep="|" )
	FNDEVENTSNET <- xml_text( xml_find_all( doc, fnd.events.net.xpath ) )  

	FNDEVENTSNET[ length( FNDEVENTSNET ) == 0]  <- NA
	FNDEVENTSNET <- zeroPC( FNDEVENTSNET )


	## NET DIFFERENCE FOR GAMING AND FUNDRAISING EVENTS

	if( FORMTYPE == "990EZ" ){
	  V_990NGF.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SpecialEventsNetIncomeLossAmt"
	  V_990NGF.EZpre2013  <- "//Return/ReturnData/IRS990EZ/SpecialEventsNetIncomeLoss"
	  net.gaming.fundrs.xpath <- paste( V_990NGF.EZpost2013, V_990NGF.EZpre2013, sep="|" )
	  NETGAMINGFNDEVENTS <- xml_text( xml_find_all( doc, net.gaming.fundrs.xpath ) )  
	} else if( FORMTYPE == "990" ){
	  NETGAMINGFNDEVENTS <- sum( as.numeric( GAMINGNET ), as.numeric( FNDEVENTSNET ), na.rm=T ) 
	}
	NETGAMINGFNDEVENTS <- as.character( NETGAMINGFNDEVENTS )
	NETGAMINGFNDEVENTS <- zeroALL( NETGAMINGFNDEVENTS )


	## GROSS SALES OF INVENTORY ASSETS

	V_990GSIpost2013 <- "//Return/ReturnData/IRS990/GrossSalesOfInventoryAmt"
	V_990GSIpre2013  <- "//Return/ReturnData/IRS990/GrossSalesOfInventory"
	V_990GSI.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GrossSalesOfInventoryAmt"
	V_990GSI.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GrossSalesOfInventory"
	gross.salesinv.xpath <- paste( V_990GSIpost2013, V_990GSIpre2013, V_990GSI.EZpost2013, V_990GSI.EZpre2013, sep="|" )
	GROSSSALESINV <- xml_text( xml_find_all( doc, gross.salesinv.xpath ) )  
	GROSSSALESINV <- zeroALL( GROSSSALESINV )


	## COST OF GOODS SOLD

	V_990CSIpost2013 <- "//Return/ReturnData/IRS990/CostOfGoodsSoldAmt"
	V_990CSIpre2013  <- "//Return/ReturnData/IRS990/CostOfGoodsSold"
	V_990CSI.EZpost2013 <- "//Return/ReturnData/IRS990EZ/CostOfGoodsSoldAmt"
	V_990CSI.EZpre2013  <- "//Return/ReturnData/IRS990EZ/CostOfGoodsSold"
	cost.salesinv.xpath <- paste( V_990CSIpost2013, V_990CSIpre2013, V_990CSI.EZpost2013, V_990CSI.EZpre2013, sep="|" )
	SALESCOSTINV <- xml_text( xml_find_all( doc, cost.salesinv.xpath ) )  
	SALESCOSTINV <- zeroALL( SALESCOSTINV )


	## NET DIFFERENCE OF SALES MINUS COST OF GOODS

	V_990NSIpost2013 <- "//Return/ReturnData/IRS990/NetIncomeOrLossGrp/TotalRevenueColumnAmt"
	V_990NSIpre2013  <- "//Return/ReturnData/IRS990/NetIncomeOrLoss/TotalRevenueColumn"
	V_990NSI.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GrossProfitLossSlsOfInvntryAmt"
	V_990NSI.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GroProfitLossSalesOfInventory"
	net.salesinv.xpath <- paste( V_990NSIpost2013, V_990NSIpre2013, V_990NSI.EZpost2013, V_990NSI.EZpre2013, sep="|" )
	NETSALESINV <- xml_text( xml_find_all( doc, net.salesinv.xpath ) )  
	NETSALESINV <- zeroALL( NETSALESINV )


	
	#------------------------------------------------------------------------------------------------------------------------
	#####  PART I - EXPENSES
	## The 990-PC forms split columns in this area into Current Year and Prior Year, the 990-EZs do not. 990-EZ data
	## in this section only maps to current year values unless indicated otherwise.

	## PRIOR YEAR GRANTS PAID

	V_990PGPpost2013 <- "//Return/ReturnData/IRS990/PYGrantsAndSimilarPaidAmt"
	V_990PGPpre2013  <- "//Return/ReturnData/IRS990/GrantsAndSimilarAmntsPriorYear"
	grants.paid.prior.xpath <- paste( V_990PGPpost2013, V_990PGPpre2013, sep="|" )
	GRANTSPAIDPRIOR <- xml_text( xml_find_all( doc, grants.paid.prior.xpath ) ) 
	GRANTSPAIDPRIOR <- zeroPC( GRANTSPAIDPRIOR )


	## CURRENT YEAR GRANTS PAID

	V_990CGPpost2013 <- "//Return/ReturnData/IRS990/CYGrantsAndSimilarPaidAmt"
	V_990CGPpre2013  <- "//Return/ReturnData/IRS990/GrantsAndSimilarAmntsCY"
	V_990CGP.EZpost2013 <- "//Return/ReturnData/IRS990EZ/GrantsAndSimilarAmountsPaidAmt"
	V_990CGP.EZpre2013  <- "//Return/ReturnData/IRS990EZ/GrantsAndSimilarAmountsPaid"
	grants.paid.current.xpath <- paste( V_990CGPpost2013, V_990CGPpre2013, V_990CGP.EZpost2013, V_990CGP.EZpre2013, sep="|" )
	GRANTSPAIDCURRENT <- xml_text( xml_find_all( doc, grants.paid.current.xpath ) ) 
	GRANTSPAIDCURRENT <- zeroALL( GRANTSPAIDCURRENT )


	## PRIOR YEAR BENEFITS PAID TO OR FOR MEMBERS 

	V_990PBPpost2013 <- "//Return/ReturnData/IRS990/PYBenefitsPaidToMembersAmt"
	V_990PBPpre2013  <- "//Return/ReturnData/IRS990/BenefitsPaidToMembersPriorYear"
	benefits.paid.prior.xpath <- paste( V_990PGPpost2013, V_990PGPpre2013, sep="|" )
	MEMBERBENPRIOR <- xml_text( xml_find_all( doc, benefits.paid.prior.xpath ) ) 
	MEMBERBENPRIOR <- zeroPC( MEMBERBENPRIOR )


	## CURRENT YEAR BENEFITS PAID TO OR FOR MEMBERS 

	V_990CBPpost2013 <- "//Return/ReturnData/IRS990/CYBenefitsPaidToMembersAmt"
	V_990CBPpre2013  <- "//Return/ReturnData/IRS990/BenefitsPaidToMembersCY"
	V_990CBP.EZpost2013 <- "//Return/ReturnData/IRS990EZ/BenefitsPaidToOrForMembersAmt"
	V_990CBP.EZpre2013  <- "//Return/ReturnData/IRS990EZ/BenefitsPaidToOrForMembers"
	benefits.paid.current.xpath <- paste( V_990CBPpost2013, V_990CBPpre2013, V_990CBP.EZpost2013, V_990CBP.EZpre2013, sep="|" )
	MEMBERBENCURRENT <- xml_text( xml_find_all( doc, benefits.paid.current.xpath ) ) 
	MEMBERBENCURRENT <- zeroALL( MEMBERBENCURRENT )


	## PRIOR YEAR SALARIES PAID

	V_990PSPpost2013 <- "//Return/ReturnData/IRS990/PYSalariesCompEmpBnftPaidAmt"
	V_990PSPpre2013  <- "//Return/ReturnData/IRS990/SalariesEtcPriorYear"
	salaries.prior.xpath <- paste( V_990PSPpre2013, V_990PSPpost2013, sep="|" )
	SALARIESPRIOR <- xml_text( xml_find_all( doc, salaries.prior.xpath ) ) 
	SALARIESPRIOR <- zeroPC( SALARIESPRIOR )


	## CURRENT YEAR SALARIES PAID

	V_990CSPpost2013 <- "//Return/ReturnData/IRS990/CYSalariesCompEmpBnftPaidAmt"
	V_990CSPpre2013  <- "//Return/ReturnData/IRS990/SalariesEtcCurrentYear"
	V_990CSP.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SalariesOtherCompEmplBnftAmt"
	V_990CSP.EZpre2013  <- "//Return/ReturnData/IRS990EZ/SalariesOtherCompEmplBenefits"
	salaries.current.xpath <- paste( V_990CSPpost2013, V_990CSPpre2013, V_990CSP.EZpost2013, V_990CSP.EZpre2013, sep="|" )
	SALARIESCURRENT <- xml_text( xml_find_all( doc, salaries.current.xpath ) ) 
	SALARIESCURRENT <- zeroALL( SALARIESCURRENT )


	## PRIOR YEAR PROFESSIONAL FUNDRAISING FEES

	V_990PFFpost2013 <- "//Return/ReturnData/IRS990/PYTotalProfFndrsngExpnsAmt"
	V_990PFFpre2013  <- "//Return/ReturnData/IRS990/TotalProfFundrsngExpPriorYear"
	profund.fees.prior.xpath <- paste( V_990PFFpre2013, V_990PFFpost2013, sep="|" )
	PROFUNDFEESPRIOR <- xml_text( xml_find_all( doc, profund.fees.prior.xpath ) ) 
	PROFUNDFEESPRIOR <- zeroPC( PROFUNDFEESPRIOR )


	## CURRENT YEAR PROFESSIONAL FUNDRAISING FEES

	V_990CFFpost2013 <- "//Return/ReturnData/IRS990/CYTotalProfFndrsngExpnsAmt"
	V_990CFFpre2013  <- "//Return/ReturnData/IRS990/TotalProfFundrsngExpCY"
	profund.fees.current.xpath <- paste( V_990CFFpost2013, V_990CFFpre2013, sep="|" )
	PROFUNDFEESCURRENT <- xml_text( xml_find_all( doc, profund.fees.current.xpath ) ) 
	PROFUNDFEESCURRENT <- zeroPC( PROFUNDFEESCURRENT )


	## TOTAL FUNDRAISING EXPENSES

	V_990TFFpost2013 <- "//Return/ReturnData/IRS990/CYTotalFundraisingExpenseAmt"
	V_990TFFpre2013  <- "//Return/ReturnData/IRS990/TotalFundrsngExpCurrentYear"
	totexp.fundrs.xpath <- paste( V_990TFFpost2013, V_990TFFpre2013, sep="|" )
	TOTFUNDEXP <- xml_text( xml_find_all( doc, totexp.fundrs.xpath ) ) 
	TOTFUNDEXP <- zeroPC( TOTFUNDEXP )
	

	##   FEES FOR SERVICES are broken out on PC and consolidated in EZ. 
	## This section consolidates the PC values

	## FEES FOR SERVICES: MANAGEMENT

	V_990F4S.mgmt.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesManagementGrp/TotalAmt"
	V_990F4S.mgmt.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesManagement/Total"
	fees.mgmt.xpath <- paste( V_990F4S.mgmt.post2013, V_990F4S.mgmt.pre2013, sep="|" )
	FEESMGMT <- xml_text( xml_find_all( doc, fees.mgmt.xpath ) ) 

	FEESMGMT[ length( FEESMGMT ) == 0]  <- NA
	FEESMGMT <- zeroPC( FEESMGMT )


	## FEES FOR SERVICES: LEGAL

	V_990F4S.legal.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesLegalGrp/TotalAmt"  
	V_990F4S.legal.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesLegal/Total"
	fees.legal.xpath <- paste( V_990F4S.legal.post2013, V_990F4S.legal.pre2013, sep="|" )
	FEESLEGAL <- xml_text( xml_find_all( doc, fees.legal.xpath ) ) 

	FEESLEGAL[ length( FEESLEGAL ) == 0]  <- NA
	FEESLEGAL <- zeroPC( FEESLEGAL )


	## FEES FOR SERVICES: ACCOUNTING

	V_990F4S.accting.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesAccountingGrp/TotalAmt"
	V_990F4S.accting.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesAccounting/Total"
	fees.acct.xpath <- paste( V_990F4S.accting.post2013, V_990F4S.accting.pre2013, sep="|" )
	FEESACCT <- xml_text( xml_find_all( doc, fees.acct.xpath ) ) 

	FEESACCT[ length( FEESACCT ) == 0]  <- NA
	FEESACCT <- zeroPC( FEESACCT )


	## FEES FOR SERVICES: LOBBYING

	V_990F4S.lobbying.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesLobbyingGrp/TotalAmt"
	V_990F4S.lobbying.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesLobbying/Total"
	fees.lobby.xpath <- paste( V_990F4S.lobbying.post2013, V_990F4S.lobbying.pre2013, sep="|" )
	FEESLOBBY <- xml_text( xml_find_all( doc, fees.lobby.xpath ) ) 

	FEESLOBBY[ length( FEESLOBBY ) == 0]  <- NA
	FEESLOBBY <- zeroPC( FEESLOBBY )


	## FEES FOR SERVICES: PROFESSIONAL FUNDRAISING
	## Should equal PROFUNDFEESCURRENT

	V_990F4S.profundserv.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesProfFundraising/TotalAmt"
	V_990F4S.profundserv.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesProfFundraising/Total"
	fees.profund.xpath <- paste( V_990F4S.profundserv.post2013, V_990F4S.profundserv.pre2013, sep="|" )
	FEESPROFND <- xml_text( xml_find_all( doc, fees.profund.xpath ) ) 

	FEESPROFND[ length( FEESPROFND ) == 0]  <- NA
	FEESPROFND <- zeroPC( FEESPROFND )


	## FEES FOR SERVICES: INVESTMENT MANAGEMENT

	V_990F4S.invmgmt.post2013 <- "//Return/ReturnData/IRS990/FeesForSrvcInvstMgmntFeesGrp/TotalAmt"
	V_990F4S.invmgmt.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesInvstMgmntFees/Total"
	fees.invmgmt.xpath <- paste( V_990F4S.invmgmt.post2013, V_990F4S.invmgmt.pre2013, sep="|" )
	FEESINVMGMT <- xml_text( xml_find_all( doc, fees.invmgmt.xpath ) ) 

	FEESINVMGMT[ length( FEESINVMGMT ) == 0]  <- NA
	FEESINVMGMT <- zeroPC( FEESINVMGMT )


	## FEES FOR SERVICES: OTHER

	V_990F4S.other.post2013 <- "//Return/ReturnData/IRS990/FeesForServicesOtherGrp/TotalAmt"
	V_990F4S.other.pre2013 <- "//Return/ReturnData/IRS990/FeesForServicesOther/Total"
	fees.other.xpath <- paste( V_990F4S.other.post2013, V_990F4S.other.pre2013, sep="|" )
	FEESOTHER <- xml_text( xml_find_all( doc, fees.other.xpath ) ) 

	FEESOTHER[ length( FEESOTHER ) == 0]  <- NA
	FEESOTHER <- zeroPC( FEESOTHER )


	## PRO. FEES AND OTHERS TO INDEPENDENT CONTRACTORS   

	V_990PFID.EZpost2013 <- "//Return/ReturnData/IRS990EZ/FeesAndOtherPymtToIndCntrctAmt"
	V_990PFID.EZpre2013  <- "//Return/ReturnData/IRS990EZ/FeesAndOthPymtToIndContractors"
	profees.indep.contractors.xpath <- paste( V_990PFID.EZpost2013, V_990PFID.EZpre2013, sep="|" )

	PROFEESINDEP <- sum( as.numeric( FEESMGMT ), as.numeric( FEESLEGAL ), as.numeric( FEESACCT ), 
			     as.numeric( FEESLOBBY ), as.numeric( FEESPROFND ), as.numeric( FEESINVMGMT ), 
			     as.numeric( FEESOTHER ), na.rm=T ) 
	if( is.na(FEESMGMT) == TRUE & is.na(FEESLEGAL) == TRUE & is.na(FEESACCT) == TRUE 
	    & is.na(FEESLOBBY) == TRUE & is.na(FEESPROFND) == TRUE & is.na(FEESINVMGMT) == TRUE 
	    & is.na(FEESOTHER) == TRUE )
	{
	  PROFEESINDEP <- as.numeric( xml_text( xml_find_all( doc, profees.indep.contractors.xpath ) ) ) 
	}
	PROFEESINDEP <- as.character( PROFEESINDEP )
	PROFEESINDEP <- zeroALL( PROFEESINDEP )
  

	## OCCUPANCY

	V_990RENTpost2013 <- "//Return/ReturnData/IRS990/OccupancyGrp/TotalAmt"
	V_990RENTpre2013  <- "//Return/ReturnData/IRS990/Occupancy/Total"
	V_990RENT.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OccupancyRentUtltsAndMaintAmt"
	V_990RENT.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OccupancyRentUtilitiesAndMaint"
	occupancy.xpath <- paste( V_990RENTpost2013, V_990RENTpre2013, V_990RENT.EZpost2013, V_990RENT.EZpre2013, sep="|" )
	OCCUPANCY <- xml_text( xml_find_all( doc, occupancy.xpath ) ) 
  OCCUPANCY <- zeroALL( OCCUPANCY )


	## OFFICE EXPENSES

	V_990EXPOFpost2013 <- "//Return/ReturnData/IRS990/OfficeExpensesGrp/TotalAmt"
	V_990EXPOFpre2013  <- "//Return/ReturnData/IRS990/OfficeExpenses/Total"
	V_990EXPOF.EZpost2013 <- "//Return/ReturnData/IRS990EZ/PrintingPublicationsPostageAmt"
	V_990EXPOF.EZpre2013  <- "//Return/ReturnData/IRS990EZ/PrintingPublicationsPostage"
	exp.office.xpath <- paste( V_990EXPOFpost2013, V_990EXPOFpre2013, V_990EXPOF.EZpost2013, V_990EXPOF.EZpre2013, sep="|" )
	OFFICEEXP <- xml_text( xml_find_all( doc, exp.office.xpath ) ) 
  OFFICEEXP <- zeroALL( OFFICEEXP )


	## PRIOR YEAR OTHER EXPENSES

	V_990POEpost2013 <- "//Return/ReturnData/IRS990/PYOtherExpensesAmt"
	V_990POEpre2013  <- "//Return/ReturnData/IRS990/OtherExpensePriorYear"
	other.exp.prior.xpath <- paste( V_990POEpost2013, V_990POEpre2013, sep="|" )
	OTHEREXPPRIOR <- xml_text( xml_find_all( doc, other.exp.prior.xpath ) ) 
	OTHEREXPPRIOR <- zeroPC( OTHEREXPPRIOR )


	## CURRENT YEAR CURRENT EXPENSES

	V_990COEpost2013 <- "//Return/ReturnData/IRS990/CYOtherExpensesAmt"
	V_990COEpre2013  <- "//Return/ReturnData/IRS990/OtherExpensesCurrentYear"
	V_990COE.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherExpensesTotalAmt"
	V_990COE.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OtherExpensesTotal"
	other.exp.current.xpath <- paste( V_990COEpost2013, V_990COEpre2013, V_990COE.EZpost2013, V_990COE.EZpre2013, sep="|" )
	OTHEREXPCURRENT <- xml_text( xml_find_all( doc, other.exp.current.xpath ) ) 
	OTHEREXPCURRENT <- zeroALL( OTHEREXPCURRENT )


	## PRIOR YEAR TOTAL EXPENSES

	V_990PTEpost2013 <- "//Return/ReturnData/IRS990/PYTotalExpensesAmt"
	V_990PTEpre2013  <- "//Return/ReturnData/IRS990/TotalExpensesPriorYear"
	total.exp.prior.xpath <- paste( V_990PTEpost2013, V_990PTEpre2013, sep="|" )
	TOTALEXPPRIOR <- xml_text( xml_find_all( doc, total.exp.prior.xpath ) ) 
	TOTALEXPPRIOR <- zeroPC( TOTALEXPPRIOR )


	## CURRENT YEAR TOTAL EXPENSES

	V_990CTEpost2013 <- "//Return/ReturnData/IRS990/CYTotalExpensesAmt"
	V_990CTEpre2013  <- "//Return/ReturnData/IRS990/TotalExpensesCurrentYear"
	V_990CTE.EZpost2013 <- "//Return/ReturnData/IRS990EZ/TotalExpensesAmt"
	V_990CTE.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TotalExpenses"
	total.exp.current.xpath <- paste( V_990CTEpost2013, V_990CTEpre2013, V_990CTE.EZpost2013, V_990CTE.EZpre2013, sep="|" )
	TOTALEXPCURRENT <- xml_text( xml_find_all( doc, total.exp.current.xpath ) ) 
	TOTALEXPCURRENT <- zeroALL( TOTALEXPCURRENT )


	## PRIOR YEAR REVENUES LESS EXPENSES

	V_990PRLEpost2013 <- "//Return/ReturnData/IRS990/PYRevenuesLessExpensesAmt"
	V_990PRLEpre2013  <- "//Return/ReturnData/IRS990/RevenuesLessExpensesPriorYear"
	rev.less.exp.prior.xpath <- paste( V_990PRLEpost2013, V_990PRLEpre2013, sep="|" )
	REVLESSEXPPRIOR <- xml_text( xml_find_all( doc, rev.less.exp.prior.xpath ) ) 
	REVLESSEXPPRIOR <- zeroPC( REVLESSEXPPRIOR )


	## CURRENT YEAR REVENUES LESS EXPENSES

	V_990CRLEpost2013 <- "//Return/ReturnData/IRS990/CYRevenuesLessExpensesAmt"
	V_990CRLEpre2013  <- "//Return/ReturnData/IRS990/RevenuesLessExpensesCY"
	V_990CRLE.EZpost2013 <- "//Return/ReturnData/IRS990EZ/ExcessOrDeficitForYearAmt"
	V_990CRLE.EZpre2013  <- "//Return/ReturnData/IRS990EZ/ExcessOrDeficitForYear"
	rev.less.exp.current.xpath <- paste( V_990CRLEpost2013, V_990CRLEpre2013, V_990CRLE.EZpost2013, V_990CRLE.EZpre2013, sep="|" )
	REVLESSEXPCURRENT <- xml_text( xml_find_all( doc, rev.less.exp.current.xpath ) ) 
	REVLESSEXPCURRENT <- zeroALL( REVLESSEXPCURRENT )

	

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
	TOTALASSETSBEGYEAR <- zeroALL( TOTALASSETSBEGYEAR )


	## END OF YEAR TOTAL ASSETS

	V_990EOYTApost2013 <- "//Return/ReturnData/IRS990/TotalAssetsEOYAmt"
	V_990EOYTApre2013  <- "//Return/ReturnData/IRS990/TotalAssetsEOY"
	V_990EOYTA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/Form990TotalAssetsGrp/EOYAmt"
	V_990EOYTA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TotalAssets/EOY"
	total.assets.end.xpath <- paste( V_990EOYTApost2013, V_990EOYTApre2013, V_990EOYTA.EZpost2013, V_990EOYTA.EZpre2013, sep="|" )
	TOTALASSETSENDYEAR <- xml_text( xml_find_all( doc, total.assets.end.xpath ) ) 
	TOTALASSETSENDYEAR <- zeroALL( TOTALASSETSENDYEAR )


	## BEGINNING OF YEAR TOTAL LIABILITIES

	V_990BOYTLpost2013 <- "//Return/ReturnData/IRS990/TotalLiabilitiesBOYAmt"
	V_990BOYTLpre2013  <- "//Return/ReturnData/IRS990/TotalLiabilitiesBOY"
	V_990BOYTL.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SumOfTotalLiabilitiesGrp/BOYAmt"
	V_990BOYTL.EZpre2013  <- "//Return/ReturnData/IRS990EZ/SumOfTotalLiabilities/BOY"
	total.liab.beg.xpath <- paste( V_990BOYTLpost2013, V_990BOYTLpre2013, V_990BOYTL.EZpost2013, V_990BOYTL.EZpre2013, sep="|" )
	TOTALLIABBEGYEAR <- xml_text( xml_find_all( doc, total.liab.beg.xpath ) ) 
	TOTALLIABBEGYEAR <- zeroALL( TOTALLIABBEGYEAR )


	## END OF YEAR TOTAL LIABILITIES

	V_990EOYTLpost2013 <- "//Return/ReturnData/IRS990/TotalLiabilitiesEOYAmt"
	V_990EOYTLpre2013  <- "//Return/ReturnData/IRS990/TotalLiabilitiesEOY"
	V_990EOYTL.EZpost2013 <- "//Return/ReturnData/IRS990EZ/SumOfTotalLiabilitiesGrp/EOYAmt"
	V_990EOYTL.EZpre2013  <- "//Return/ReturnData/IRS990EZ/SumOfTotalLiabilities/EOY"
	total.liab.end.xpath <- paste( V_990EOYTLpost2013, V_990EOYTLpre2013, V_990EOYTL.EZpost2013, V_990EOYTL.EZpre2013, sep="|" )
	TOTALLIABENDYEAR <- xml_text( xml_find_all( doc, total.liab.end.xpath ) ) 
	TOTALLIABENDYEAR <- zeroALL( TOTALLIABENDYEAR )


	## BEGINNING OF YEAR NET ASSETS

	V_990BOYNApost2013 <- "//Return/ReturnData/IRS990/NetAssetsOrFundBalancesBOYAmt"
	V_990BOYNApre2013  <- "//Return/ReturnData/IRS990/NetAssetsOrFundBalancesBOY"
	V_990BOYNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/NetAssetsOrFundBalancesGrp/BOYAmt"
	V_990BOYNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/NetAssetsOrFundBalances/BOY"
	net.assets.beg.xpath <- paste( V_990BOYNApost2013, V_990BOYNApre2013, V_990BOYNA.EZpost2013, V_990BOYNA.EZpre2013, sep="|" )
	NETASSETSBEGYEAR <- xml_text( xml_find_all( doc, net.assets.beg.xpath ) ) 
	NETASSETSBEGYEAR <- zeroALL( NETASSETSBEGYEAR )


	## OTHER CHANGES IN NET ASSETS

	V_990NAOC.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherChangesInNetAssetsAmt"
	V_990NAOC.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OtherChangesInNetAssets"
	net.assets.other.changes.xpath <- paste( V_990NAOC.EZpre2013, sep="|" )
	OTHERASSETSCHANGES <- xml_text( xml_find_all( doc, net.assets.other.changes.xpath ) )  
	OTHERASSETSCHANGES <- zeroEZ( OTHERASSETSCHANGES )


	## END OF YEAR NET ASSETS

	V_990EOYNApost2013 <- "//Return/ReturnData/IRS990/NetAssetsOrFundBalancesEOYAmt"
	V_990EOYNApre2013  <- "//Return/ReturnData/IRS990/NetAssetsOrFundBalancesEOY"
	V_990EOYNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/NetAssetsOrFundBalancesGrp/EOYAmt"
	V_990EOYNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/NetAssetsOrFundBalances/EOY"
	net.assets.end.xpath <- paste( V_990EOYNApost2013, V_990EOYNApre2013, V_990EOYNA.EZpost2013, V_990EOYNA.EZpre2013, sep="|" )
	NETASSETSENDYEAR <- xml_text( xml_find_all( doc, net.assets.end.xpath ) ) 
	NETASSETSENDYEAR <- zeroALL( NETASSETSENDYEAR )


	
	#------------------------------------------------------------------------------------------------------------------------
	#####  PART II(EZ) / X (PC) - BALANCE SHEET
	##   Organized to capture the values present on both PC and EZ first, then PC-specific values after

	## BEGINNING OF YEAR CASH

	V_990BOYCpost2013 <- "//Return/ReturnData/IRS990/CashNonInterestBearingGrp/BOYAmt"
	V_990BOYCpre2013  <- "//Return/ReturnData/IRS990/CashNonInterestBearing/BOY"
	cash.beg.xpath <- paste( V_990BOYCpost2013, V_990BOYCpre2013, sep="|" )
	CASHBEGYEAR <- xml_text( xml_find_all( doc, cash.beg.xpath ) ) 

	CASHBEGYEAR[ length( CASHBEGYEAR ) == 0]  <- NA
	CASHBEGYEAR <- zeroPC( CASHBEGYEAR )


	## END OF YEAR CASH

	V_990EOYCpost2013 <- "//Return/ReturnData/IRS990/CashNonInterestBearingGrp/EOYAmt"
	V_990EOYCpre2013  <- "//Return/ReturnData/IRS990/CashNonInterestBearing/EOY"
	cash.end.xpath <- paste( V_990EOYCpost2013, V_990EOYCpre2013, sep="|" )
	CASHENDYEAR <- xml_text( xml_find_all( doc, cash.end.xpath ) ) 

	CASHENDYEAR[ length( CASHENDYEAR ) == 0]  <- NA
	CASHENDYEAR <- zeroPC( CASHENDYEAR )


	## BEGINNING OF YEAR SAVINGS AND TEMPORARY INVESTMENTS

	V_990BOYSIpost2013 <- "//Return/ReturnData/IRS990/SavingsAndTempCashInvstGrp/BOYAmt"
	V_990BOYSIpre2013  <- "//Return/ReturnData/IRS990/SavingsAndTempCashInvestments/BOY"
	sav.tempinv.beg.xpath <- paste( V_990BOYSIpost2013, V_990BOYSIpre2013, sep="|" )
	SAVINVBEGYEAR <- xml_text( xml_find_all( doc, sav.tempinv.beg.xpath ) ) 

	SAVINVBEGYEAR[ length( SAVINVBEGYEAR ) == 0]  <- NA
	SAVINVBEGYEAR <- zeroPC( SAVINVBEGYEAR )


	## END OF YEAR SAVINGS AND TEMPORARY INVESTMENTS

	V_990EOYSIpost2013 <- "//Return/ReturnData/IRS990/SavingsAndTempCashInvstGrp/EOYAmt"
	V_990EOYSIpre2013  <- "//Return/ReturnData/IRS990/SavingsAndTempCashInvestments/EOY"
	sav.tempinv.end.xpath <- paste( V_990EOYSIpost2013, V_990EOYSIpre2013, sep="|" )
	SAVINVENDYEAR <- xml_text( xml_find_all( doc, sav.tempinv.end.xpath ) )

	SAVINVENDYEAR[ length( SAVINVENDYEAR ) == 0]  <- NA
	SAVINVENDYEAR <- zeroPC( SAVINVENDYEAR )


	## BEGINNING OF YEAR CASH, SAVINGS, AND INVESTMENTS
	if( FORMTYPE == "990EZ" ){
	  V_990BOYCSI.EZpost2013 <- "//Return/ReturnData/IRS990EZ/CashSavingsAndInvestmentsGrp/BOYAmt"
	  V_990BOYCSI.EZpre2013  <- "//Return/ReturnData/IRS990EZ/CashSavingsAndInvestments/BOY"
	  cash.inv.beg.xpath <- paste( V_990BOYCSI.EZpost2013, V_990BOYCSI.EZpre2013, sep="|" )
	  CASHINVBEGYEAR <- xml_text( xml_find_all( doc, cash.inv.beg.xpath ) ) 
	} else if( FORMTYPE == "990" ){
	  CASHINVBEGYEAR <- sum( as.numeric( CASHBEGYEAR ), as.numeric( SAVINVBEGYEAR ), na.rm=T ) 
	}
	CASHINVBEGYEAR <- as.character( CASHINVBEGYEAR )
  CASHINVBEGYEAR <- zeroALL( CASHINVBEGYEAR )


	## END OF YEAR CASH, SAVINGS, AND INVESTMENTS
	if( FORMTYPE == "990EZ" ){
	  V_990EOYNA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/CashSavingsAndInvestmentsGrp/EOYAmt"
	  V_990EOYNA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/CashSavingsAndInvestments/EOY"
	  cash.inv.end.xpath <- paste( V_990EOYNA.EZpost2013, V_990EOYNA.EZpre2013, sep="|" )
	  CASHINVENDYEAR <- xml_text( xml_find_all( doc, cash.inv.end.xpath ) ) 
	} else if( FORMTYPE == "990" ){
	  CASHINVENDYEAR <- sum( as.numeric( CASHENDYEAR ), as.numeric( SAVINVENDYEAR ), na.rm=T )
	}
	CASHINVENDYEAR <- as.character( CASHINVENDYEAR )
  CASHINVENDYEAR <- zeroALL( CASHINVENDYEAR )


	## COST OF LAND, BUILDINGS, AND EQUIPMENT

	V_990CLBEpost2013 <- "//Return/ReturnData/IRS990/LandBldgEquipCostOrOtherBssAmt"
	V_990CLBEpre2013  <- "//Return/ReturnData/IRS990/LandBuildingsEquipmentBasis"
	lbe.cost.xpath <- paste( V_990CLBEpost2013, V_990CLBEpre2013, sep="|" )
	LANDBLDEQUIPCOST <- xml_text( xml_find_all( doc, lbe.cost.xpath ) ) 
	LANDBLDEQUIPCOST <- zeroPC( LANDBLDEQUIPCOST )


	## DEPRECIATION OF LAND, BUILDINGS, AND EQUIPMENT

	V_990DLBEpost2013 <- "//Return/ReturnData/IRS990/LandBldgEquipAccumDeprecAmt"
	V_990DLBEpre2013  <- "//Return/ReturnData/IRS990/LandBldgEquipmentAccumDeprec"
	lbe.depreciation.xpath <- paste( V_990DLBEpost2013, V_990DLBEpre2013, sep="|" )
	LANDBLDEQUIPDEP <- xml_text( xml_find_all( doc, lbe.depreciation.xpath ) )
	LANDBLDEQUIPDEP <- zeroPC( LANDBLDEQUIPDEP )


	## BEGINNING OF YEAR LAND AND BUILDINGS (AND EQUIPMENT FOR 990-PC ONLY)

	V_990BOYLBpost2013 <- "//Return/ReturnData/IRS990/LandBldgEquipBasisNetGrp/BOYAmt"
	V_990BOYLBpre2013  <- "//Return/ReturnData/IRS990/LandBuildingsEquipmentBasisNet/BOY"
	V_990BOYLB.EZpost2013 <- "//Return/ReturnData/IRS990EZ/LandAndBuildingsGrp/BOYAmt"
	V_990BOYLB.EZpre2013  <- "//Return/ReturnData/IRS990EZ/LandAndBuildings/BOY"
	land.buildings.beg.xpath <- paste( V_990BOYLBpost2013, V_990BOYLBpre2013, V_990BOYLB.EZpost2013, V_990BOYLB.EZpre2013, sep="|" )
	LANDBEGYEAR <- xml_text( xml_find_all( doc, land.buildings.beg.xpath ) ) 
	LANDBEGYEAR <- zeroALL( LANDBEGYEAR )


	## END OF YEAR LAND AND BUILDINGS (AND EQUIPMENT FOR 990-PC ONLY)

	V_990EOYLBpost2013 <- "//Return/ReturnData/IRS990/LandBldgEquipBasisNetGrp/EOYAmt"
	V_990EOYLBpre2013  <- "//Return/ReturnData/IRS990/LandBuildingsEquipmentBasisNet/EOY"
	V_990EOYLB.EZpost2013 <- "//Return/ReturnData/IRS990EZ/LandAndBuildingsGrp/EOYAmt"
	V_990EOYLB.EZpre2013  <- "//Return/ReturnData/IRS990EZ/LandAndBuildings/EOY"
	land.buildings.end.xpath <- paste( V_990EOYLBpost2013, V_990EOYLBpre2013, V_990EOYLB.EZpost2013, V_990EOYLB.EZpre2013, sep="|" )
	LANDENDYEAR <- xml_text( xml_find_all( doc, land.buildings.end.xpath ) ) 
	LANDENDYEAR <- zeroALL( LANDENDYEAR )


	## BEGINNING OF YEAR OTHER ASSETS

	V_990BOYOApost2013 <- "//Return/ReturnData/IRS990/OtherAssetsTotalGrp/BOYAmt"
	V_990BOYOApre2013  <- "//Return/ReturnData/IRS990/OtherAssetsTotal/BOY"
	V_990BOYOA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherAssetsTotalDetail/BOYAmt"
	V_990BOYOA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OtherAssetsTotal/BOY"
	other.assets.beg.xpath <- paste( V_990BOYOApost2013, V_990BOYOApre2013, V_990BOYOA.EZpost2013, sep="|" )
	OTHERASSETSBEGYEAR <- xml_text( xml_find_all( doc, other.assets.beg.xpath ) ) 
	OTHERASSETSBEGYEAR <- zeroALL( OTHERASSETSBEGYEAR )


	## END OF YEAR OTHER ASSETS 

	V_990EOYOApost2013 <- "//Return/ReturnData/IRS990/OtherAssetsTotalGrp/EOYAmt"
	V_990EOYOApre2013  <- "//Return/ReturnData/IRS990/OtherAssetsTotal/EOY"
	V_990EOYOA.EZpost2013 <- "//Return/ReturnData/IRS990EZ/OtherAssetsTotalDetail/EOYAmt"
	V_990EOYOA.EZpre2013  <- "//Return/ReturnData/IRS990EZ/OtherAssetsTotal/EOY"
	other.assets.end.xpath <- paste( V_990EOYOApost2013, V_990EOYOApre2013, V_990EOYOA.EZpost2013, V_990EOYOA.EZpre2013, sep="|" )
	OTHERASSETSENDYEAR <- xml_text( xml_find_all( doc, other.assets.end.xpath ) ) 
	OTHERASSETSENDYEAR <- zeroALL( OTHERASSETSENDYEAR )


	
	#------------------------------------------------------------------------------------------------------------------------
	####  PART III - STATEMENT OF PROGRAM SERVICE ACCOMPLISHMENTS

	## TOTAL PROGRAM SERVICE EXPENSES

	V_990TPSEpost2013 <- "//Return/ReturnData/IRS990/TotalProgramServiceExpensesAmt"
	V_990TPSEpre2013  <- "//Return/ReturnData/IRS990/TotalProgramServiceExpense"
	V_990TPSE.EZpost2013 <- "//Return/ReturnData/IRS990EZ/TotalProgramServiceExpensesAmt"
	V_990TPSE.EZpre2013  <- "//Return/ReturnData/IRS990EZ/TotalProgramServiceExpenses"
	total.psr.exp.xpath <- paste( V_990TPSEpost2013, V_990TPSEpre2013, V_990TPSE.EZpost2013, V_990TPSE.EZpre2013, sep="|" )
	TOTALPROGSERVEXP <- xml_text( xml_find_all( doc, total.psr.exp.xpath ) ) 
	TOTALPROGSERVEXP <- zeroALL( TOTALPROGSERVEXP )


	
	#------------------------------------------------------------------------------------------------------------------------
	####  PART IV - CHECKLIST OF REQUIRED SCHEDULES

	## LOBBYING ACTIVITIES

	V_990Lpost2013 <- "//Return/ReturnData/IRS990/LobbyingActivitiesInd"
	V_990Lpre2013  <- "//Return/ReturnData/IRS990/LobbyingActivities"
	V_990L.EZpost2013 <- "//Return/ReturnData/IRS990EZ/LobbyingActivitiesInd"
	V_990L.EZpre2013  <- "//Return/ReturnData/IRS990EZ/EngageInLobbyingActivities"
	lobbying.xpath <- paste( V_990Lpost2013, V_990Lpre2013, V_990L.EZpost2013, V_990L.EZpre2013, sep="|" )
	LOBBYING <- xml_text( xml_find_all( doc, lobbying.xpath ) )
	
	
	
	## FOREIGN REVENUE OR EXPENSES OR $10K, OR FOREIGN INVESTMENTS OVER $100K
	
	V_990FRpost2013 <- "//Return/ReturnData/IRS990/ForeignActivitiesInd"
	V_990FRpre2013  <- "//Return/ReturnData/IRS990/ForeignActivities"
	foreign.rev.xpath <- paste( V_990FRpost2013, V_990FRpre2013, sep="|" )
	FOREIGNREV <- xml_text( xml_find_all( doc, foreign.rev.xpath ) )
	


	#------------------------------------------------------------------------------------------------------------------------
	####  PART VI - GOVERNMENT, MANAGEMENT, AND DISCLOSURE
	####  PC ONLY

	## PART VI RESPONSE IN SCHEDULE O
	## The 2013 update added an "Ind" on the tail of these xpaths, which looks 
	## like an additional roman numeral, and can be visually confusing.
	## For example, 2012: Info...PartIX   Same path in 2013: Info...PartIXInd

	V_990VMGpost2013 <- "//Return/ReturnData/IRS990/InfoInScheduleOPartVIInd"
	V_990VMGpre2013  <- "//Return/ReturnData/IRS990/InfoInScheduleOPartVI"
	schedO.partvi.xpath <- paste( V_990VMGpost2013, V_990VMGpre2013, sep="|" )
	SCHEDOPARTVI <- xml_text( xml_find_all( doc, schedO.partvi.xpath ) )



	#### SECTION A. GOVERNING BODY AND MANAGEMENT

	## NUMBER OF VOTING MEMBERS IN GOVERNING BODY
	## Should be equal to VOTINGMEMBERS

	V_990VMGpost2013 <- "//Return/ReturnData/IRS990/GoverningBodyVotingMembersCnt"
	V_990VMGpre2013  <- "//Return/ReturnData/IRS990/NbrVotingGoverningBodyMembers"
	voting.mem.governing.xpath <- paste( V_990VMGpost2013, V_990VMGpre2013, sep="|" )
	VMGOVERNING <- xml_text( xml_find_all( doc, voting.mem.governing.xpath ) )



	## NUMBER OF INDEPENDENT VOTING MEMBERS IN GOVERNING BODY
	## Should be equal to INDVOTINGMEMBERS

	V_990IVMGpost2013 <- "//Return/ReturnData/IRS990/IndependentVotingMemberCnt"
	V_990IVMGpre2013  <- "//Return/ReturnData/IRS990/NumberIndependentVotingMembers"
	voting.indep.governing.xpath <- paste( V_990IVMGpost2013, V_990IVMGpre2013, sep="|" )
	IVMGOVERNING <- xml_text( xml_find_all( doc, voting.indep.governing.xpath ) )



	## DID ANY OFFICERS ETC. HAVE RELATIONSHIPS WITH OTHER OFFICERS ETC.

	V_990RWOpost2013 <- "//Return/ReturnData/IRS990/FamilyOrBusinessRlnInd"
	V_990RWOpre2013  <- "//Return/ReturnData/IRS990/FamilyOrBusinessRelationship"
	rel.with.officers.xpath <- paste( V_990RWOpost2013, V_990RWOpre2013, sep="|" )
	OFFICERREL <- xml_text( xml_find_all( doc, rel.with.officers.xpath ) )



	## WERE MANAGEMENT DUTIES DELEGATED TO A MANAGEMENT COMPANY OR OTHER PERSON

	V_990MDpost2013 <- "//Return/ReturnData/IRS990/DelegationOfMgmtDutiesInd"
	V_990MDpre2013  <- "//Return/ReturnData/IRS990/DelegationOfManagementDuties"
	mgmt.delegated.xpath <- paste( V_990MDpost2013, V_990MDpost2013, sep="|" )
	MGMTDEL <- xml_text( xml_find_all( doc, mgmt.delegated.xpath ) )



	## ANY CHANGES IN GOVERNANCE DOCUMENTS SINCE PRIOR 990 WAS FILED

	V_990CGDpost2013 <- "//Return/ReturnData/IRS990/ChangeToOrgDocumentsInd"
	V_990CGDpre2013  <- "//Return/ReturnData/IRS990/ChangesToOrganizingDocs"
	changes.gov.docs.xpath <- paste( V_990CGDpost2013, V_990CGDpre2013, sep="|" )
	CHANGESGOVDOCS <- xml_text( xml_find_all( doc, changes.gov.docs.xpath ) )  



	## ANY SIGNIFICANT DIVERSION OF ORGANIZATION ASSETS

	V_990DOApost2013 <- "//Return/ReturnData/IRS990/MaterialDiversionOrMisuseInd"
	V_990DOApre2013  <- "//Return/ReturnData/IRS990/MaterialDiversionOrMisuse"
	diversion.org.assets.xpath <- paste( V_990DOApost2013, V_990DOApre2013, sep="|" )
	DIVASSETS <- xml_text( xml_find_all( doc, diversion.org.assets.xpath ) )  



	## DID ORGANIZATION HAVE MEMBERS OR STOCKHOLDERS

	V_990MSpost2013 <- "//Return/ReturnData/IRS990/MembersOrStockholdersInd"
	V_990MSpre2013  <- "//Return/ReturnData/IRS990/MembersOrStockholders"
	org.members.stakeholders.xpath <- paste( V_990MSpost2013, V_990MSpre2013, sep="|" )
	STOCKMEMBER <- xml_text( xml_find_all( doc, org.members.stakeholders.xpath ) )   



	## DID ORGANIZATION HAVE MEMBERS ETC. WHO COULD CHOOSE GOVERNING BODY MEMBERS

	V_990MCGBpost2013 <- "//Return/ReturnData/IRS990/ElectionOfBoardMembersInd"
	V_990MCGBpre2013  <- "//Return/ReturnData/IRS990/ElectionOfBoardMembers"
	members.choose.govbody.xpath <- paste( V_990MCGBpost2013, V_990MCGBpre2013, sep="|" )
	MEMBERCHOOSE <- xml_text( xml_find_all( doc, members.choose.govbody.xpath ) )    



	## ARE ANY GOVERNANCE DECISIONS RESTRICTED TO PEOPLE OUTSIDE GOVERNING BODY

	V_990GBRDpost2013 <- "//Return/ReturnData/IRS990/DecisionsSubjectToApprovaInd"
	V_990GBRDpre2013  <- "//Return/ReturnData/IRS990/DecisionsSubjectToApproval"
	restricted.decisions.xpath <- paste( V_990GBRDpost2013, V_990GBRDpre2013, sep="|" )
	GOVBODYDECISION <- xml_text( xml_find_all( doc, restricted.decisions.xpath ) )    



	## WERE GOVERNANCE MEETINGS DOCUMENTED

	V_990GMDpost2013 <- "//Return/ReturnData/IRS990/MinutesOfGoverningBodyInd"
	V_990GMDpre2013  <- "//Return/ReturnData/IRS990/MinutesOfGoverningBody"
	gov.mtng.documented.xpath <- paste( V_990GMDpost2013, V_990GMDpre2013, sep="|" )
	GOVBODYDOCU <- xml_text( xml_find_all( doc, gov.mtng.documented.xpath ) )  



	## WERE COMMITEE MEETINGS DOCUMENTED

	V_990CMDpost2013 <- "//Return/ReturnData/IRS990/MinutesOfCommitteesInd"
	V_990CMDpre2013  <- "//Return/ReturnData/IRS990/MinutesOfCommittees"
	committee.mtng.documented.xpath <- paste( V_990CMDpost2013, V_990CMDpre2013, sep="|" )
	COMMITTEEDOCU <- xml_text( xml_find_all( doc, committee.mtng.documented.xpath ) )  



	## ANY OFFICERS NOT REACHABLE AT ORGANIZATION'S MAILING ADDRESS

	V_990NRMApost2013 <- "//Return/ReturnData/IRS990/OfficerMailingAddressInd"
	V_990NRMApre2013  <- "//Return/ReturnData/IRS990/OfficerMailingAddress"
	not.reachable.mailing.xpath <- paste( V_990NRMApost2013, V_990NRMApre2013, sep="|" )
	NOTREACH <- xml_text( xml_find_all( doc, not.reachable.mailing.xpath ) )   



	## CONFLICT OF INTEREST POLICY

	V_990COIPpost2013 <- "//Return/ReturnData/IRS990/ConflictOfInterestPolicyInd"
	V_990COIPpre2013  <- "//Return/ReturnData/IRS990/ConflictOfInterestPolicy"
	coi.policy.xpath <- paste( V_990COIPpost2013, V_990COIPpre2013, sep="|" )
	COIPOLICY <- xml_text( xml_find_all( doc, coi.policy.xpath ) )     



	## CONFLICT OF INTEREST ANNUAL DISCLOSURE REQUIREMENT FOR OFFICERS ETC.

	V_990COIDpost2013 <- "//Return/ReturnData/IRS990/AnnualDisclosureCoveredPrsnInd"
	V_990COIDpre2013  <- "//Return/ReturnData/IRS990/AnnualDisclosureCoveredPersons"
	coi.disclosure.xpath <- paste( V_990COIDpost2013, V_990COIDpre2013, sep="|" )
	COIDISCLOSE <- xml_text( xml_find_all( doc, coi.disclosure.xpath ) )      



	## CONFLICT OF INTEREST MONITORING BY THE ORGANIZATION

	V_990COIMpost2013 <- "//Return/ReturnData/IRS990/RegularMonitoringEnfrcInd"
	V_990COIMpre2013  <- "//Return/ReturnData/IRS990/RegularMonitoringEnforcement"
	coi.monitor.xpath <- paste( V_990COIMpost2013, V_990COIMpre2013, sep="|" )
	COIMONITOR <- xml_text( xml_find_all( doc, coi.monitor.xpath ) )    



	## WHISTLEBLOWER POLICY

	V_990WBPpost2013 <- "//Return/ReturnData/IRS990/WhistleblowerPolicyInd"
	V_990WBPpre2013  <- "//Return/ReturnData/IRS990/WhistleblowerPolicy"
	wb.policy.xpath <- paste( V_990WBPpost2013, V_990WBPpre2013, sep="|" )
	WBPOLICY <- xml_text( xml_find_all( doc, wb.policy.xpath ) )   



	## STATES THIS 990 MUST BE FILED WITH

	V_990SMFWpost2013 <- "//Return/ReturnData/IRS990/StatesWhereCopyOfReturnIsFldCd"
	V_990SMFWpre2013  <- "//Return/ReturnData/IRS990/StatesWhereCopyOfReturnIsFiled"
	V_990SMFW.EZpost2013 <- "//Return/ReturnData/IRS990EZ/StatesWhereCopyOfReturnIsFldCd"
	V_990SMFW.EZpre2013  <- "//Return/ReturnData/IRS990EZ/StatesWhereCopyOfReturnIsFiled"
	states.must.file.xpath <- paste( V_990SMFWpost2013, V_990SMFWpre2013, V_990SMFW.EZpost2013, V_990SMFW.EZpre2013, sep="|" )
	FILINGSTATES <- xml_text( xml_find_all( doc, states.must.file.xpath ) )     
        FILINGSTATES <- paste( FILINGSTATES, collapse=" " )


	## PUBLIC AVAILABILITY: represent the 4 possible values, broken out then collapsed

	## PUBLICLY AVAILABLE THROUGH OWN WEBSITE

	V_990PAOWpost2013 <- "//Return/ReturnData/IRS990/OwnWebsiteInd"
	V_990PAOWpre2013  <- "//Return/ReturnData/IRS990/OwnWebsite"
	public.web.self.xpath <- paste( V_990PAOWpost2013, V_990PAOWpre2013, sep="|" )
	PUBLICWEBSELF <- xml_text( xml_find_all( doc, public.web.self.xpath ) )

	PUBLICWEBSELF[ length( PUBLICWEBSELF ) == 0] <- NA
	if( is.na( PUBLICWEBSELF ) == FALSE ) { PUBLICWEBSELF <- "Own Website" }



	## PUBLICLY AVAILABLE THROUGH ANOTHER'S WEBSITE

	V_990PAAWpost2013 <- "//Return/ReturnData/IRS990/OtherWebsiteInd"
	V_990PAAWpre2013  <- "//Return/ReturnData/IRS990/OtherWebsite"
	public.web.other.xpath <- paste( V_990PAAWpost2013, V_990PAAWpre2013, sep="|" )
	PUBLICWEBOTHER <- xml_text( xml_find_all( doc, public.web.other.xpath ) ) 

	PUBLICWEBOTHER[ length( PUBLICWEBOTHER ) == 0] <- NA
	if( is.na( PUBLICWEBOTHER ) == FALSE ) { PUBLICWEBOTHER <- "Another's Website" }



	## PUBLICLY AVAILABLE UPON REQUEST

	V_990PAURpost2013 <- "//Return/ReturnData/IRS990/UponRequestInd"
	V_990PAURpre2013  <- "//Return/ReturnData/IRS990/UponRequest"
	public.request.xpath <- paste( V_990PAURpost2013, V_990PAURpre2013, sep="|" )
	PUBLICREQUEST <- xml_text( xml_find_all( doc, public.request.xpath ) ) 

	PUBLICREQUEST[ length( PUBLICREQUEST ) == 0] <- NA
	if( is.na( PUBLICREQUEST ) == FALSE ) { PUBLICREQUEST <- "Upon Request" }



	## PUBLICLY AVAILABLE THROUGH ANOTHER METHOD

	V_990PAOMpost2013 <- "//Return/ReturnData/IRS990/OtherInd"
	V_990PAOMpre2013  <- "//Return/ReturnData/IRS990/OtherExplainInSchO"
	public.other.xpath <- paste( V_990PAOMpost2013, V_990PAOMpre2013, sep="|" )
	PUBLICOTHER <- xml_text( xml_find_all( doc, public.other.xpath ) ) 

	PUBLICOTHER[ length( PUBLICOTHER ) == 0] <- NA
	if( is.na( PUBLICOTHER ) == FALSE ) { PUBLICOTHER <- "Other-In Schedule O" }



	## PUBLICLY AVAILABLE METHOD (Collapsed)
	## The output should be comma-delimited to represent the non-exclusive nature of the checkboxes

	PUBLICSHARE <- gsub( "NA", "", paste( PUBLICWEBSELF, PUBLICWEBOTHER, PUBLICREQUEST, PUBLICOTHER, sep="," ) )
	PUBLICSHARE[ PUBLICSHARE  == ",,," ] <- NA


	## PERSON WITH ORGANIZATION'S BOOKS: NAME

	V_990OBMpost2013 <- "//Return/ReturnData/IRS990/BooksInCareOfDetail/PersonNm"
	V_990OBMWpre2013  <- "//Return/ReturnData/IRS990/TheBooksAreInCareOf/NamePerson"
	org.books.name.xpath <- paste( V_990OBMpost2013, V_990OBMWpre2013, sep="|" )
	ORGBOOKNAME <- xml_text( xml_find_all( doc, org.books.name.xpath ) )    



	## PERSON WITH ORGANIZATION'S BOOKS: PHONE NUMBER

	V_990OBPpost2013 <- "//Return/ReturnData/IRS990/BooksInCareOfDetail/PhoneNum"
	V_990OBPpre2013  <- "//Return/ReturnData/IRS990/TheBooksAreInCareOf/TelephoneNumber"
	org.books.phone.xpath <- paste( V_990OBPpost2013, V_990OBPpre2013, sep="|" )
	ORGBOOKPHONE <- xml_text( xml_find_all( doc, org.books.phone.xpath ) )    



	## PERSON WITH ORGANIZATION'S BOOKS: ADDRESS

	V_990OBApost2013 <- "//Return/ReturnData/IRS990/BooksInCareOfDetail/USAddress/AddressLine1Txt"
	V_990OBApre2013  <- "//Return/ReturnData/IRS990/TheBooksAreInCareOf/AddressUS/AddressLine1"
	org.books.address.xpath <- paste( V_990OBApost2013, V_990OBApre2013, sep="|" )
	ORGBOOKADDRESS <- xml_text( xml_find_all( doc, org.books.address.xpath ) )    



	## PERSON WITH ORGANIZATION'S BOOKS: CITY

	V_990OBCpost2013 <- "//Return/ReturnData/IRS990/BooksInCareOfDetail/USAddress/CityNm"
	V_990OBCpre2013  <- "//Return/ReturnData/IRS990/TheBooksAreInCareOf/AddressUS/City"
	org.books.city.xpath <- paste( V_990OBCpost2013, V_990OBCpre2013, sep="|" )
	ORGBOOKCITY <- xml_text( xml_find_all( doc, org.books.city.xpath ) )    



	## PERSON WITH ORGANIZATION'S BOOKS: STATE

	V_990OBSpost2013 <- "//Return/ReturnData/IRS990/BooksInCareOfDetail/USAddress/StateAbbreviationCd"
	V_990OBSpre2013  <- "//Return/ReturnData/IRS990/TheBooksAreInCareOf/AddressUS/State"
	org.books.state.xpath <- paste( V_990OBSpost2013, V_990OBSpre2013, sep="|" )
	ORGBOOKSTATE <- xml_text( xml_find_all( doc, org.books.state.xpath ) )    



	## PERSON WITH ORGANIZATION'S BOOKS: ZIP

	V_990OBZpost2013 <- "//Return/ReturnData/IRS990/BooksInCareOfDetail/USAddress/ZIPCd"
	V_990OBZpre2013  <- "//Return/ReturnData/IRS990/TheBooksAreInCareOf/AddressUS/ZIPCode"
	org.books.zip.xpath <- paste( V_990OBZpost2013, V_990OBZpre2013, sep="|" )
	ORGBOOKZIP <- xml_text( xml_find_all( doc, org.books.zip.xpath ) )



	#------------------------------------------------------------------------------------------------------------------------
	#####  PART X - ASSETS
	##   PC-specific Values

	## BEGINNING OF YEAR PLEDGES AND GRANTS

	V_990BOYPGpost2013 <- "//Return/ReturnData/IRS990/PledgesAndGrantsReceivableGrp/BOYAmt"
	V_990BOYPGpre2013  <- "//Return/ReturnData/IRS990/PledgesAndGrantsReceivable/BOY"
	pledges.grants.beg.xpath <- paste( V_990BOYPGpost2013, V_990BOYPGpre2013, sep="|" )
	PLEDGEGRANTBEGYEAR <- xml_text( xml_find_all( doc, pledges.grants.beg.xpath ) ) 
	PLEDGEGRANTBEGYEAR <- zeroPC( PLEDGEGRANTBEGYEAR )


	## END OF YEAR PLEDGES AND GRANTS

	V_990EOYPGpost2013 <- "//Return/ReturnData/IRS990/PledgesAndGrantsReceivableGrp/EOYAmt"
	V_990EOYPGpre2013  <- "//Return/ReturnData/IRS990/PledgesAndGrantsReceivable/EOY"
	pledges.grants.end.xpath <- paste( V_990EOYPGpost2013, V_990EOYPGpre2013, sep="|" )
	PLEDGEGRANTENDYEAR <- xml_text( xml_find_all( doc, pledges.grants.end.xpath ) ) 
	PLEDGEGRANTENDYEAR <- zeroPC( PLEDGEGRANTENDYEAR )


	## BEGINNING OF YEAR ACCOUNTS RECEIVABLE

	V_990BOYAROpost2013 <- "//Return/ReturnData/IRS990/AccountsReceivableGrp/BOYAmt"
	V_990BOYAROpre2013  <- "//Return/ReturnData/IRS990/AccountsReceivable/BOY"
	accts.receivable.beg.xpath <- paste( V_990BOYAROpost2013, V_990BOYAROpre2013, sep="|" )
	ACCTRECBEGYEAR <- xml_text( xml_find_all( doc, accts.receivable.beg.xpath ) ) 
	ACCTRECBEGYEAR <- zeroPC( ACCTRECBEGYEAR )


	## END OF YEAR ACCOUNTS RECEIVABLE

	V_990EOYAROpost2013 <- "//Return/ReturnData/IRS990/AccountsReceivableGrp/EOYAmt"
	V_990EOYAROpre2013  <- "//Return/ReturnData/IRS990/AccountsReceivable/EOY"
	accts.receivable.end.xpath <- paste( V_990EOYAROpost2013, V_990EOYAROpre2013, sep="|" )
	ACCTRECENDYEAR <- xml_text( xml_find_all( doc, accts.receivable.end.xpath ) ) 
	ACCTRECENDYEAR <- zeroPC( ACCTRECENDYEAR )


	## BEGINNING OF YEAR LOANS FROM OFFICERS
	## Confirm that this is the appropriate xpath - switch with Xpath in Loans to Officers?

	V_990BOYLFOpost2013 <- "//Return/ReturnData/IRS990/ReceivablesFromOfficersEtcGrp/BOYAmt"
	V_990BOYLFOpre2013  <- "//Return/ReturnData/IRS990/ReceivablesFromOfficersEtc/BOY"
	loans.from.officers.beg.xpath <- paste( V_990BOYLFOpost2013, V_990BOYLFOpre2013, sep="|" )
	LOANSFROMOFFBEGYEAR <- xml_text( xml_find_all( doc, loans.from.officers.beg.xpath ) ) 
	LOANSFROMOFFBEGYEAR <- zeroPC( LOANSFROMOFFBEGYEAR )


	## END OF YEAR LOANS FROM OFFICERS
	## Confirm that this is the appropriate xpath - switch with Xpath in Loans to Officers?

	V_990EOYLFOpost2013 <- "//Return/ReturnData/IRS990/ReceivablesFromOfficersEtcGrp/EOYAmt"
	V_990EOYLFOpre2013  <- "//Return/ReturnData/IRS990/ReceivablesFromOfficersEtc/EOY"
	loans.from.officers.end.xpath <- paste( V_990EOYLFOpost2013, V_990EOYLFOpre2013, sep="|" )
	LOANSFROMOFFENDYEAR <- xml_text( xml_find_all( doc, loans.from.officers.end.xpath ) ) 
	LOANSFROMOFFENDYEAR <- zeroPC( LOANSFROMOFFENDYEAR )


	## BEGINNING OF YEAR LOANS FROM DISQUALIFIED PERSONS

	V_990BOYLDQpost2013 <- "//Return/ReturnData/IRS990/RcvblFromDisqualifiedPrsnGrp/BOYAmt"
	V_990BOYLDQpre2013  <- "//Return/ReturnData/IRS990/ReceivablesFromDisqualPersons/BOY"
	loans.disqual.persons.beg.xpath <- paste( V_990BOYLDQpost2013, V_990BOYLDQpre2013, sep="|" )
	LOANSDQPBEGYEAR <- xml_text( xml_find_all( doc, loans.disqual.persons.beg.xpath ) ) 
	LOANSDQPBEGYEAR <- zeroPC( LOANSDQPBEGYEAR )


	## END OF YEAR LOANS FROM DISQUALIFIED PERSONS

	V_990EOYLDQpost2013 <- "//Return/ReturnData/IRS990/RcvblFromDisqualifiedPrsnGrp/EOYAmt"
	V_990EOYLDQpre2013  <- "//Return/ReturnData/IRS990/ReceivablesFromDisqualPersons/EOY"
	loans.disqual.persons.end.xpath <- paste( V_990EOYLDQpost2013, V_990EOYLDQpre2013, sep="|" )
	LOANSDQPENDYEAR <- xml_text( xml_find_all( doc, loans.disqual.persons.end.xpath ) ) 
	LOANSDQPENDYEAR <- zeroPC( LOANSDQPENDYEAR )


	## BEGINNING OF YEAR NET NOTES AND LOANS RECEIVABLE

	V_990BOYNNLpost2013 <- "//Return/ReturnData/IRS990/OthNotesLoansReceivableNetGrp/BOYAmt"
	V_990BOYNNLpre2013  <- "//Return/ReturnData/IRS990/OtherNotesLoansReceivableNet/BOY"
	net.notes.beg.xpath <- paste( V_990BOYNNLpost2013, V_990BOYNNLpre2013, sep="|" )
	LOANSNOTESBEGYEAR <- xml_text( xml_find_all( doc, net.notes.beg.xpath ) ) 
	LOANSNOTESBEGYEAR <- zeroPC( LOANSNOTESBEGYEAR )


	## END OF YEAR NET NOTES AND LOANS RECEIVABLE

	V_990EOYNNLpost2013 <- "//Return/ReturnData/IRS990/OthNotesLoansReceivableNetGrp/EOYAmt"
	V_990EOYNNLpre2013  <- "//Return/ReturnData/IRS990/OtherNotesLoansReceivableNet/EOY"
	net.notes.end.xpath <- paste( V_990EOYNNLpost2013, V_990EOYNNLpre2013, sep="|" )
	LOANSNOTESENDYEAR <- xml_text( xml_find_all( doc, net.notes.end.xpath ) ) 
	LOANSNOTESENDYEAR <- zeroPC( LOANSNOTESENDYEAR )


	## BEGINNING OF YEAR INVENTORIES FOR SALE OR USE

	V_990BOYISUpost2013 <- "//Return/ReturnData/IRS990/InventoriesForSaleOrUseGrp/BOYAmt"
	V_990BOYISUpre2013  <- "//Return/ReturnData/IRS990/InventoriesForSaleOrUse/BOY"
	inventory.beg.xpath <- paste( V_990BOYISUpost2013, V_990BOYISUpre2013, sep="|" )
	INVENTORYBEGYEAR <- xml_text( xml_find_all( doc, inventory.beg.xpath ) ) 
	INVENTORYBEGYEAR <- zeroPC( INVENTORYBEGYEAR )


	## END OF YEAR INVENTORIES FOR SALE OR USE

	V_990EOYISUpost2013 <- "//Return/ReturnData/IRS990/InventoriesForSaleOrUseGrp/EOYAmt"
	V_990EOYISUpre2013  <- "//Return/ReturnData/IRS990/InventoriesForSaleOrUse/EOY"
	inventory.end.xpath <- paste( V_990EOYISUpost2013, V_990EOYISUpre2013, sep="|" )
	INVENTORYENDYEAR <- xml_text( xml_find_all( doc, inventory.end.xpath ) ) 
	INVENTORYENDYEAR <- zeroPC( INVENTORYENDYEAR )


	## BEGINNING OF YEAR PREPAID EXPENSES

	V_990BOYPPEpost2013 <- "//Return/ReturnData/IRS990/PrepaidExpensesDefrdChargesGrp/BOYAmt"
	V_990BOYPPEpre2013  <- "//Return/ReturnData/IRS990/PrepaidExpensesDeferredCharges/BOY"
	prepaid.expenses.beg.xpath <- paste( V_990BOYPPEpost2013, V_990BOYPPEpre2013, sep="|" )
	PREEXPBEGYEAR <- xml_text( xml_find_all( doc, prepaid.expenses.beg.xpath ) ) 
	PREEXPBEGYEAR <- zeroPC( PREEXPBEGYEAR )


	## END OF YEAR PREPAID EXPENSES

	V_990EOYPPEpost2013 <- "//Return/ReturnData/IRS990/PrepaidExpensesDefrdChargesGrp/EOYAmt"
	V_990EOYPPEpre2013  <- "//Return/ReturnData/IRS990/PrepaidExpensesDeferredCharges/EOY"
	prepaid.expenses.end.xpath <- paste( V_990EOYPPEpost2013, V_990EOYPPEpre2013, sep="|" )
	PREEXPENDYEAR <- xml_text( xml_find_all( doc, prepaid.expenses.end.xpath ) ) 
	PREEXPENDYEAR <- zeroPC( PREEXPENDYEAR )


	## BEGINNING OF YEAR PUBLICLY-TRADED SECURITIES

	V_990BOYPTSpost2013 <- "//Return/ReturnData/IRS990/InvestmentsPubTradedSecGrp/BOYAmt"
	V_990BOYPTSpre2013  <- "//Return/ReturnData/IRS990/InvestmentsPubTradedSecurities/BOY"
	investments.public.beg.xpath <- paste( V_990BOYPTSpost2013, V_990BOYPTSpre2013, sep="|" )
	INVESTPUBBEGYEAR <- xml_text( xml_find_all( doc, investments.public.beg.xpath ) ) 
	INVESTPUBBEGYEAR <- zeroPC( INVESTPUBBEGYEAR )


	## END OF YEAR PUBLICLY-TRADED SECURITIES INVESTMENTS

	V_990EOYPTSpost2013 <- "//Return/ReturnData/IRS990/InvestmentsPubTradedSecGrp/EOYAmt"
	V_990EOYPTSpre2013  <- "//Return/ReturnData/IRS990/InvestmentsPubTradedSecurities/EOY"
	investments.public.end.xpath <- paste( V_990EOYPTSpost2013, V_990EOYPTSpre2013, sep="|" )
	INVESTPUBENDYEAR <- xml_text( xml_find_all( doc, investments.public.end.xpath ) ) 
	INVESTPUBENDYEAR <- zeroPC( INVESTPUBENDYEAR )


	## BEGINNING OF YEAR OTHER SECURITIES INVESTMENTS

	V_990BOYOSIpost2013 <- "//Return/ReturnData/IRS990/InvestmentsOtherSecuritiesGrp/BOYAmt"
	V_990BOYOSIpre2013  <- "//Return/ReturnData/IRS990/InvestmentsOtherSecurities/BOY"
	investments.other.beg.xpath <- paste( V_990BOYOSIpost2013, V_990BOYOSIpre2013, sep="|" )
	INVESTOTHBEGYEAR <- xml_text( xml_find_all( doc, investments.other.beg.xpath ) ) 
	INVESTOTHBEGYEAR <- zeroPC( INVESTOTHBEGYEAR )


	## END OF YEAR OTHER SECURITIES INVESTMENTS

	V_990EOYOSIpost2013 <- "//Return/ReturnData/IRS990/InvestmentsOtherSecuritiesGrp/EOYAmt"
	V_990EOYOSIpre2013  <- "//Return/ReturnData/IRS990/InvestmentsOtherSecurities/EOY"
	investments.other.end.xpath <- paste( V_990EOYOSIpost2013, V_990EOYOSIpre2013, sep="|" )
	INVESTOTHENDYEAR <- xml_text( xml_find_all( doc, investments.other.end.xpath ) ) 
	INVESTOTHENDYEAR <- zeroPC( INVESTOTHENDYEAR )


	## BEGINNING OF YEAR PROGRAM-RELATED INVESTMENTS

	V_990BOYPRIpost2013 <- "//Return/ReturnData/IRS990/InvestmentsProgramRelatedGrp/BOYAmt"
	V_990BOYPRIpre2013  <- "//Return/ReturnData/IRS990/InvestmentsProgramRelated/BOY"
	investments.prog.beg.xpath <- paste( V_990BOYPRIpost2013, V_990BOYPRIpre2013, sep="|" )
	INVESTPRGBEGYEAR <- xml_text( xml_find_all( doc, investments.prog.beg.xpath ) ) 
	INVESTPRGBEGYEAR <- zeroPC( INVESTPRGBEGYEAR )


	## END OF YEAR PROGRAM-RELATED INVESTMENTS

	V_990EOYPRIpost2013 <- "//Return/ReturnData/IRS990/InvestmentsOtherSecuritiesGrp/EOYAmt"
	V_990EOYPRIpre2013  <- "//Return/ReturnData/IRS990/InvestmentsOtherSecurities/EOY"
	investments.prog.end.xpath <- paste( V_990EOYPRIpost2013, V_990EOYPRIpre2013, sep="|" )
	INVESTPRGENDYEAR <- xml_text( xml_find_all( doc, investments.prog.end.xpath ) ) 
	INVESTPRGENDYEAR <- zeroPC( INVESTPRGENDYEAR )


	## BEGINNING OF YEAR INTANGIBLE ASSETS

	V_990BOYIApost2013 <- "//Return/ReturnData/IRS990/IntangibleAssetsGrp/BOYAmt"
	V_990BOYIApre2013  <- "//Return/ReturnData/IRS990/IntangibleAssets/BOY"
	intangible.assets.beg.xpath <- paste( V_990BOYIApost2013, V_990BOYIApre2013, sep="|" )
	INTANASSETSBEGYEAR <- xml_text( xml_find_all( doc, intangible.assets.beg.xpath ) ) 
	INTANASSETSBEGYEAR <- zeroPC( INTANASSETSBEGYEAR )


	## END OF YEAR INTANGIBLE ASSETS

	V_990EOYIApost2013 <- "//Return/ReturnData/IRS990/IntangibleAssetsGrp/EOYAmt"
	V_990EOYIApre2013  <- "//Return/ReturnData/IRS990/IntangibleAssets/EOY"
	intangible.assets.end.xpath <- paste( V_990EOYIApost2013, V_990EOYIApre2013, sep="|" )
	INTANASSETSENDYEAR <- xml_text( xml_find_all( doc, intangible.assets.end.xpath ) ) 
	INTANASSETSENDYEAR <- zeroPC( INTANASSETSENDYEAR )


	## BEGINNING OF YEAR TOTAL ASSETS FROM BALANCE SHEET
	## Should equal TOTALASSETSBEGYEAR

	V_990BOYBSTApost2013 <- "//Return/ReturnData/IRS990/TotalAssetsGrp/BOYAmt"
	V_990BOYBSTApre2013  <- "//Return/ReturnData/IRS990/TotalAssets/BOY"
	totalassets.balsheet.beg.xpath <- paste( V_990BOYBSTApost2013, V_990BOYBSTApre2013, sep="|" )
	TABALSHEETBEGYEAR <- xml_text( xml_find_all( doc, totalassets.balsheet.beg.xpath ) ) 
	TABALSHEETBEGYEAR <- zeroPC( TABALSHEETBEGYEAR )


	## END OF YEAR TOTAL ASSETS FROM BALANCE SHEET
	## Should equal TOTALASSETSENDYEAR

	V_990EOYBSTApost2013 <- "//Return/ReturnData/IRS990/TotalAssetsGrp/EOYAmt"
	V_990EOYBSTApre2013  <- "//Return/ReturnData/IRS990/TotalAssets/EOY"
	totalassets.balsheet.end.xpath <- paste( V_990EOYBSTApost2013, V_990EOYBSTApre2013, sep="|" )
	TABALSHEETENDYEAR <- xml_text( xml_find_all( doc, totalassets.balsheet.end.xpath ) ) 
	TABALSHEETENDYEAR <- zeroPC( TABALSHEETENDYEAR )

	

	#------------------------------------------------------------------------------------------------------------------------
	#####  PART X - LIABILITIES
	#####   PC-specific Values

	## BEGINNING OF YEAR ACCOUNTS PAYABLE AND ACCRUED EXPENSES

	V_990BOYAPpost2013 <- "//Return/ReturnData/IRS990/AccountsPayableAccrExpnssGrp/BOYAmt"
	V_990BOYAPpre2013  <- "//Return/ReturnData/IRS990/AccountsPayableAccruedExpenses/BOY"
	accts.payable.beg.xpath <- paste( V_990BOYAPpost2013, V_990BOYAPpre2013, sep="|" )
	ACCTPAYBEGYEAR <- xml_text( xml_find_all( doc, accts.payable.beg.xpath ) ) 
	ACCTPAYBEGYEAR <- zeroPC( ACCTPAYBEGYEAR )


	## END OF YEAR ACCOUNTS PAYABLE AND ACCRUED EXPENSES

	V_990EOYAPpost2013 <- "//Return/ReturnData/IRS990/AccountsPayableAccrExpnssGrp/EOYAmt"
	V_990EOYAPpre2013  <- "//Return/ReturnData/IRS990/AccountsPayableAccruedExpenses/EOY"
	accts.payable.end.xpath <- paste( V_990EOYAPpost2013, V_990EOYAPpre2013, sep="|" )
	ACCTPAYENDYEAR <- xml_text( xml_find_all( doc, accts.payable.end.xpath ) )
	ACCTPAYENDYEAR <- zeroPC( ACCTPAYENDYEAR )


	## BEGINNING OF YEAR GRANTS PAYABLE

	V_990BOYGPpost2013 <- "//Return/ReturnData/IRS990/GrantsPayableGrp/BOYAmt"
	V_990BOYGPpre2013  <- "//Return/ReturnData/IRS990/GrantsPayable/BOY"
	grants.payable.beg.xpath <- paste( V_990BOYGPpost2013, V_990BOYGPpre2013, sep="|" )
	GRANTSPAYBEGYEAR <- xml_text( xml_find_all( doc, grants.payable.beg.xpath ) ) 
	GRANTSPAYBEGYEAR <- zeroPC( GRANTSPAYBEGYEAR )


	## END OF YEAR GRANTS PAYABLE

	V_990EOYGPpost2013 <- "//Return/ReturnData/IRS990/GrantsPayableGrp/EOYAmt"
	V_990EOYGPpre2013  <- "//Return/ReturnData/IRS990/GrantsPayable/EOY"
	grants.payable.end.xpath <- paste( V_990EOYGPpost2013, V_990EOYGPpre2013, sep="|" )
	GRANTSPAYENDYEAR <- xml_text( xml_find_all( doc, grants.payable.end.xpath ) )
	GRANTSPAYENDYEAR <- zeroPC( GRANTSPAYENDYEAR )


	## BEGINNING OF YEAR DEFERRED REVENUE

	V_990BOYDRpost2013 <- "//Return/ReturnData/IRS990/DeferredRevenueGrp/BOYAmt"
	V_990BOYDRpre2013  <- "//Return/ReturnData/IRS990/DeferredRevenue/BOY"
	deferred.rev.beg.xpath <- paste( V_990BOYDRpost2013, V_990BOYDRpre2013, sep="|" )
	DEFREVBEGYEAR <- xml_text( xml_find_all( doc, deferred.rev.beg.xpath ) ) 
	DEFREVBEGYEAR <- zeroPC( DEFREVBEGYEAR )


	## END OF YEAR DEFERRED REVENUE

	V_990EOYDRpost2013 <- "//Return/ReturnData/IRS990/DeferredRevenueGrp/EOYAmt"
	V_990EOYDRpre2013  <- "//Return/ReturnData/IRS990/DeferredRevenue/EOY"
	deferred.rev.end.xpath <- paste( V_990EOYDRpost2013, V_990EOYDRpre2013, sep="|" )
	DEFREVENDYEAR <- xml_text( xml_find_all( doc, deferred.rev.end.xpath ) )
	DEFREVENDYEAR <- zeroPC( DEFREVENDYEAR )


	## BEGINNING OF YEAR TAX-EXEMPT BOND LIABILITIES

	V_990BOYBLpost2013 <- "//Return/ReturnData/IRS990/TaxExemptBondLiabilitiesGrp/BOYAmt"
	V_990BOYBLpre2013  <- "//Return/ReturnData/IRS990/TaxExemptBondLiabilities/BOY"
	bond.liab.beg.xpath <- paste( V_990BOYBLpost2013, V_990BOYBLpre2013, sep="|" )
	BONDBEGYEAR <- xml_text( xml_find_all( doc, bond.liab.beg.xpath ) ) 
	BONDBEGYEAR <- zeroPC( BONDBEGYEAR )


	## END OF YEAR TAX-EXEMPT BOND LIABILITIES

	V_990EOYBLpost2013 <- "//Return/ReturnData/IRS990/TaxExemptBondLiabilitiesGrp/EOYAmt"
	V_990EOYBLpre2013  <- "//Return/ReturnData/IRS990/TaxExemptBondLiabilities/EOY"
	bond.liab.end.xpath <- paste( V_990EOYBLpost2013, V_990EOYBLpre2013, sep="|" )
	BONDENDYEAR <- xml_text( xml_find_all( doc, bond.liab.end.xpath ) )
	BONDENDYEAR <- zeroPC( BONDENDYEAR )


	## BEGINNING OF YEAR ESCROW ACCOUNT LIABILITIES

	V_990BOYELpost2013 <- "//Return/ReturnData/IRS990/EscrowAccountLiabilityGrp/BOYAmt"
	V_990BOYELpre2013  <- "//Return/ReturnData/IRS990/EscrowAccountLiability/BOY"
	escrow.liab.beg.xpath <- paste( V_990BOYELpost2013, V_990BOYELpre2013, sep="|" )
	ESCROWBEGYEAR <- xml_text( xml_find_all( doc, escrow.liab.beg.xpath ) ) 
	ESCROWBEGYEAR <- zeroPC( ESCROWBEGYEAR )


	## END OF YEAR ESCROW ACCOUNT LIABILITIES

	V_990EOYELpost2013 <- "//Return/ReturnData/IRS990/EscrowAccountLiabilityGrp/EOYAmt"
	V_990EOYELpre2013  <- "//Return/ReturnData/IRS990/EscrowAccountLiability/EOY"
	escrow.liab.end.xpath <- paste( V_990EOYELpost2013, V_990EOYELpre2013, sep="|" )
	ESCROWENDYEAR <- xml_text( xml_find_all( doc, escrow.liab.end.xpath ) )
	ESCROWENDYEAR <- zeroPC( ESCROWENDYEAR )


	## BEGINNING OF YEAR LOANS TO OFFICERS
	## Confirm that this is the appropriate xpath - switch with xpath in Loans from Officers?

	V_990BOYLTOpost2013 <- "//Return/ReturnData/IRS990/LoansFromOfficersDirectorsGrp/BOYAmt"
	V_990BOYLTOpre2013  <- "//Return/ReturnData/IRS990/LoansFromOfficersDirectors/BOY"
	loans.to.officers.beg.xpath <- paste( V_990BOYLTOpost2013, V_990BOYLTOpre2013, sep="|" )
	LOANSTOOFFBEGYEAR <- xml_text( xml_find_all( doc, loans.to.officers.beg.xpath ) ) 
	LOANSTOOFFBEGYEAR <- zeroPC( LOANSTOOFFBEGYEAR )


	## END OF YEAR LOANS TO OFFICERS
	## Confirm that this is the appropriate xpath - switch with Xpath in Loans from Officers?

	V_990EOYLTOpost2013 <- "//Return/ReturnData/IRS990/LoansFromOfficersDirectorsGrp/EOYAmt"
	V_990EOYLTOpre2013  <- "//Return/ReturnData/IRS990/LoansFromOfficersDirectors/EOY"
	loans.to.officers.end.xpath <- paste( V_990EOYLTOpost2013, V_990EOYLTOpre2013, sep="|" )
	LOANSTOOFFENDYEAR <- xml_text( xml_find_all( doc, loans.to.officers.end.xpath ) )
	LOANSTOOFFENDYEAR <- zeroPC( LOANSTOOFFENDYEAR )


	## BEGINNING OF YEAR SECURED MORTGAGES

	V_990BOYSMpost2013 <- "//Return/ReturnData/IRS990/MortgNotesPyblScrdInvstPropGrp/BOYAmt"
	V_990BOYSMpre2013  <- "//Return/ReturnData/IRS990/MortNotesPyblSecuredInvestProp/BOY"
	mortgage.beg.xpath <- paste( V_990BOYSMpost2013, V_990BOYSMpre2013, sep="|" )
	MORTGAGEBEGYEAR <- xml_text( xml_find_all( doc, mortgage.beg.xpath ) ) 
	MORTGAGEBEGYEAR <- zeroPC( MORTGAGEBEGYEAR )


	## END OF YEAR SECURED MORTGAGES

	V_990EOYSMpost2013 <- "//Return/ReturnData/IRS990/MortgNotesPyblScrdInvstPropGrp/EOYAmt"
	V_990EOYSMpre2013  <- "//Return/ReturnData/IRS990/MortNotesPyblSecuredInvestProp/EOY"
	mortgage.end.xpath <- paste( V_990EOYSMpost2013, V_990EOYSMpre2013, sep="|" )
	MORTGAGEENDYEAR <- xml_text( xml_find_all( doc, mortgage.end.xpath ) )
	MORTGAGEENDYEAR <- zeroPC( MORTGAGEENDYEAR )


	## BEGINNING OF YEAR UNSECURED NOTES

	V_990BOYUNpost2013 <- "//Return/ReturnData/IRS990/UnsecuredNotesLoansPayableGrp/BOYAmt"
	V_990BOYUNpre2013  <- "//Return/ReturnData/IRS990/UnsecuredNotesLoansPayable/BOY"
	unsec.notes.beg.xpath <- paste( V_990BOYUNpost2013, V_990BOYUNpre2013, sep="|" )
	UNSECNOTESBEGYEAR <- xml_text( xml_find_all( doc, unsec.notes.beg.xpath ) ) 
	UNSECNOTESBEGYEAR <- zeroPC( UNSECNOTESBEGYEAR )


	## END OF YEAR UNSECURED NOTES

	V_990EOYUNpost2013 <- "//Return/ReturnData/IRS990/UnsecuredNotesLoansPayableGrp/EOYAmt"
	V_990EOYUNpre2013  <- "//Return/ReturnData/IRS990/UnsecuredNotesLoansPayable/EOY"
	unsec.notes.end.xpath <- paste( V_990EOYUNpost2013, V_990EOYUNpre2013, sep="|" )
	UNSECNOTESENDYEAR <- xml_text( xml_find_all( doc, unsec.notes.end.xpath ) )
	UNSECNOTESENDYEAR <- zeroPC( UNSECNOTESENDYEAR )


	## BEGINNING OF YEAR OTHER LIABILITIES

	V_990BOYOLpost2013 <- "//Return/ReturnData/IRS990/OtherLiabilitiesGrp/BOYAmt"
	V_990BOYOLpre2013  <- "//Return/ReturnData/IRS990/OtherLiabilities/BOY"
	other.liab.beg.xpath <- paste( V_990BOYOLpost2013, V_990BOYOLpre2013, sep="|" )
	OTHERLIABBEGYEAR <- xml_text( xml_find_all( doc, other.liab.beg.xpath ) ) 
	OTHERLIABBEGYEAR <- zeroPC( OTHERLIABBEGYEAR )


	## END OF YEAR OTHER LIABILITIES

	V_990EOYOLpost2013 <- "//Return/ReturnData/IRS990/OtherLiabilitiesGrp/EOYAmt"
	V_990EOYOLpre2013  <- "//Return/ReturnData/IRS990/OtherLiabilities/EOY"
	other.liab.end.xpath <- paste( V_990EOYOLpost2013, V_990EOYOLpre2013, sep="|" )
	OTHERLIABENDYEAR <- xml_text( xml_find_all( doc, other.liab.end.xpath ) )
	OTHERLIABENDYEAR <- zeroPC( OTHERLIABENDYEAR )


	## BEGINNING OF YEAR TOTAL LIABILITIES FROM BALANCE SHEET
	## Should equal TOTALLIABBEGYEAR

	V_990BOYBSTLpost2013 <- "//Return/ReturnData/IRS990/TotalLiabilitiesGrp/BOYAmt"
	V_990BOYBSTLpre2013  <- "//Return/ReturnData/IRS990/TotalLiabilities/BOY"
	totalliab.balsheet.beg.xpath <- paste( V_990BOYBSTLpost2013, V_990BOYBSTLpre2013, sep="|" )
	TLBALSHEETBEGYEAR <- xml_text( xml_find_all( doc, totalliab.balsheet.beg.xpath ) ) 
	TLBALSHEETBEGYEAR <- zeroPC( TLBALSHEETBEGYEAR )


	## END OF YEAR TOTAL LIABILITIES FROM BALANCE SHEET
	## Should equal TOTALLIABENDYEAR

	V_990EOYBSTLpost2013 <- "//Return/ReturnData/IRS990/TotalLiabilitiesGrp/EOYAmt"
	V_990EOYBSTLpre2013  <- "//Return/ReturnData/IRS990/TotalLiabilities/EOY"
	totalliab.balsheet.end.xpath <- paste( V_990EOYBSTLpost2013, V_990EOYBSTLpre2013, sep="|" )
	TLBALSHEETENDYEAR <- xml_text( xml_find_all( doc, totalliab.balsheet.end.xpath ) ) 
	TLBALSHEETENDYEAR <- zeroPC( TLBALSHEETENDYEAR )


	
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
	URESTNABEGYEAR <- zeroPC( URESTNABEGYEAR )


	## END OF YEAR UNRESTRICTED NET ASSETS

	V_990EOYUApost2013 <- "//Return/ReturnData/IRS990/UnrestrictedNetAssetsGrp/EOYAmt"
	V_990EOYUApre2013  <- "//Return/ReturnData/IRS990/UnrestrictedNetAssets/EOY"
	unrest.na.end.xpath <- paste( V_990EOYUApost2013, V_990EOYUApre2013, sep="|" )
	URESTNAENDYEAR <- xml_text( xml_find_all( doc, unrest.na.end.xpath ) )
	URESTNAENDYEAR <- zeroPC( URESTNAENDYEAR )


	## BEGINNING OF YEAR TEMPORARILY RESTRICTED NET ASSETS

	V_990BOYTRApost2013 <- "//Return/ReturnData/IRS990/TemporarilyRstrNetAssetsGrp/BOYAmt"
	V_990BOYTRApre2013  <- "//Return/ReturnData/IRS990/TemporarilyRestrictedNetAssets/BOY"
	temp.rest.na.beg.xpath <- paste( V_990BOYTRApost2013, V_990BOYTRApre2013, sep="|" )
	TRESTNABEGYEAR <- xml_text( xml_find_all( doc, temp.rest.na.beg.xpath ) ) 
	TRESTNABEGYEAR <- zeroPC( TRESTNABEGYEAR )


	## END OF YEAR TEMPORARILY RESTRICTED NET ASSETS

	V_990EOYTRApost2013 <- "//Return/ReturnData/IRS990/TemporarilyRstrNetAssetsGrp/EOYAmt"
	V_990EOYTRApre2013  <- "//Return/ReturnData/IRS990/TemporarilyRestrictedNetAssets/EOY"
	temp.rest.na.end.xpath <- paste( V_990EOYTRApost2013, V_990EOYTRApre2013, sep="|" )
	TRESTNAENDYEAR  <- xml_text( xml_find_all( doc, temp.rest.na.end.xpath ) )
	TRESTNAENDYEAR <- zeroPC( TRESTNAENDYEAR )


	## BEGINNING OF YEAR PERMANENTLY RESTRICTED NET ASSETS

	V_990BOYPRApost2013 <- "//Return/ReturnData/IRS990/PermanentlyRstrNetAssetsGrp/BOYAmt"
	V_990BOYPRApre2013  <- "//Return/ReturnData/IRS990/PermanentlyRestrictedNetAssets/BOY"
	perm.rest.na.beg.xpath <- paste( V_990BOYPRApost2013, V_990BOYPRApre2013, sep="|" )
	PRESTNABEGYEAR <- xml_text( xml_find_all( doc, perm.rest.na.beg.xpath ) ) 
	PRESTNABEGYEAR <- zeroPC( PRESTNABEGYEAR )


	## END OF YEAR PERMANENTLY RESTRICTED NET ASSETS

	V_990EOYPRApost2013 <- "//Return/ReturnData/IRS990/PermanentlyRstrNetAssetsGrp/EOYAmt"
	V_990EOYPRApre2013  <- "//Return/ReturnData/IRS990/PermanentlyRestrictedNetAssets/EOY"
	perm.rest.na.end.xpath <- paste( V_990EOYPRApost2013, V_990EOYPRApre2013, sep="|" )
	PRESTNAENDYEAR  <- xml_text( xml_find_all( doc, perm.rest.na.end.xpath ) )
	PRESTNAENDYEAR <- zeroPC( PRESTNAENDYEAR )


	## BEGINNING OF YEAR CAPITAL STOCK

	V_990BOYSTOCKpost2013 <- "//Return/ReturnData/IRS990/CapStkTrPrinCurrentFundsGrp/BOYAmt"
	V_990BOYSTOCKpre2013  <- "//Return/ReturnData/IRS990/CapStckTrstPrinCurrentFunds/BOY"
	stock.beg.xpath <- paste( V_990BOYSTOCKpost2013, V_990BOYSTOCKpre2013, sep="|" )
	STOCKBEGYEAR <- xml_text( xml_find_all( doc, stock.beg.xpath ) ) 
	STOCKBEGYEAR <- zeroPC( STOCKBEGYEAR )


	## END OF YEAR CAPITAL STOCK

	V_990EOYSTOCKpost2013 <- "//Return/ReturnData/IRS990/CapStkTrPrinCurrentFundsGrp/EOYAmt"
	V_990EOYSTOCKpre2013  <- "//Return/ReturnData/IRS990/CapStckTrstPrinCurrentFunds/EOY"
	stock.end.xpath <- paste( V_990EOYSTOCKpost2013, V_990EOYSTOCKpre2013, sep="|" )
	STOCKENDYEAR  <- xml_text( xml_find_all( doc, stock.end.xpath ) )
	STOCKENDYEAR <- zeroPC( STOCKENDYEAR )


	## BEGINNING OF YEAR PAID-IN SURPLUS

	V_990BOYPISpost2013 <- "//Return/ReturnData/IRS990/PdInCapSrplsLandBldgEqpFundGrp/BOYAmt"
	V_990BOYPISpre2013  <- "//Return/ReturnData/IRS990/PaidInCapSrplsLandBldgEqpFund/BOY"
	surplus.beg.xpath <- paste( V_990BOYPISpost2013, V_990BOYPISpre2013, sep="|" )
	SURPLUSBEGYEAR <- xml_text( xml_find_all( doc, surplus.beg.xpath ) ) 
	SURPLUSBEGYEAR <- zeroPC( SURPLUSBEGYEAR )


	## END OF YEAR PAID-IN SURPLUS

	V_990EOYPISpost2013 <- "//Return/ReturnData/IRS990/PdInCapSrplsLandBldgEqpFundGrp/EOYAmt"
	V_990EOYPISpre2013  <- "//Return/ReturnData/IRS990/PaidInCapSrplsLandBldgEqpFund/EOY"
	surplus.end.xpath <- paste( V_990EOYPISpost2013, V_990EOYPISpre2013, sep="|" )
	SURPLUSENDYEAR  <- xml_text( xml_find_all( doc, surplus.end.xpath ) )
	SURPLUSENDYEAR <- zeroPC( SURPLUSENDYEAR )


	## BEGINNING OF YEAR RETAINED EARNINGS

	V_990BOYREpost2013 <- "//Return/ReturnData/IRS990/RtnEarnEndowmentIncmOthFndsGrp/BOYAmt"
	V_990BOYREpre2013  <- "//Return/ReturnData/IRS990/RetainedEarningsEndowmentEtc/BOY"
	earnings.beg.xpath <- paste( V_990BOYREpost2013, V_990BOYREpre2013, sep="|" )
	EARNINGSBEGYEAR <- xml_text( xml_find_all( doc, earnings.beg.xpath ) ) 
	EARNINGSBEGYEAR <- zeroPC( EARNINGSBEGYEAR )


	## END OF YEAR RETAINED EARNINGS

	V_990EOYREpost2013 <- "//Return/ReturnData/IRS990/RtnEarnEndowmentIncmOthFndsGrp/EOYAmt"
	V_990EOYREpre2013 <- "//Return/ReturnData/IRS990/RetainedEarningsEndowmentEtc/EOY"
	earnings.end.xpath <- paste( V_990EOYREpost2013, V_990EOYREpre2013, sep="|" )
	EARNINGSENDYEAR <- xml_text( xml_find_all( doc, earnings.end.xpath ) )
	EARNINGSENDYEAR <- zeroPC( EARNINGSENDYEAR )


	## BEGINNING OF YEAR TOTAL NET ASSETS AND FUND BALANCES

	V_990BOYTNApost2013 <- "//Return/ReturnData/IRS990/TotalNetAssetsFundBalanceGrp/BOYAmt"
	V_990BOYTNApre2013 <- "//Return/ReturnData/IRS990/TotalNetAssetsFundBalances/BOY"
	total.na.beg.xpath <- paste( V_990BOYTNApost2013, V_990BOYTNApre2013, sep="|" )
	TOTNETASSETSBEGYEAR <- xml_text( xml_find_all( doc, total.na.beg.xpath ) ) 
	TOTNETASSETSBEGYEAR <- zeroPC( TOTNETASSETSBEGYEAR )


	## END OF YEAR TOTAL NET ASSETS AND FUND BALANCES

	V_990EOYTNApost2013 <- "//Return/ReturnData/IRS990/TotalNetAssetsFundBalanceGrp/EOYAmt"
	V_990EOYTNApre2013 <- "//Return/ReturnData/IRS990/TotalNetAssetsFundBalances/EOY"
	total.na.end.xpath <- paste( V_990EOYTNApost2013, V_990EOYTNApre2013, sep="|" )
	TOTNETASSETSENDYEAR <- xml_text( xml_find_all( doc, total.na.end.xpath ) )
	TOTNETASSETSENDYEAR <- zeroPC( TOTNETASSETSENDYEAR )


	## BEGINNING OF YEAR TOTAL LIABILITIES AND NET ASSETS/FUND BALANCES

	V_990BOYTLANApost2013 <- "//Return/ReturnData/IRS990/TotLiabNetAssetsFundBalanceGrp/BOYAmt"
	V_990BOYTLANApre2013  <- "//Return/ReturnData/IRS990/TotalLiabNetAssetsFundBalances/BOY"
	total.liab.na.beg.xpath <- paste( V_990BOYTLANApost2013, V_990BOYTLANApre2013, sep="|" )
	TOTLIABNABEGYEAR <- xml_text( xml_find_all( doc, total.liab.na.beg.xpath ) ) 
	TOTLIABNABEGYEAR <- zeroPC( TOTLIABNABEGYEAR )


	## END OF YEAR TOTAL LIABILITIES AND NET ASSETS/FUND BALANCES

	V_990EOYTLANApost2013 <- "//Return/ReturnData/IRS990/TotLiabNetAssetsFundBalanceGrp/EOYAmt"
	V_990EOYTLANApre2013  <- "//Return/ReturnData/IRS990/TotalLiabNetAssetsFundBalances/EOY"
	total.liab.na.end.xpath <- paste( V_990EOYTLANApost2013, V_990EOYTLANApre2013, sep="|" )
	TOTLIABNAENDYEAR <- xml_text( xml_find_all( doc, total.liab.na.end.xpath ) )
	TOTLIABNAENDYEAR <- zeroPC( TOTLIABNAENDYEAR )
	
	
	
	#------------------------------------------------------------------------------------------------------------------------
	#####  LIST OF SCHEDULES
	

	## SCHEDULE A FILED
	
	SCHEDA <- grepl( "IRS990ScheduleA", doc )
	
	
	
	## SCHEDULE B FILED
	
	SCHEDB <- grepl( "IRS990ScheduleB", doc )
	
	
	
	## SCHEDULE C FILED
	
	SCHEDC <- grepl( "IRS990ScheduleC", doc )
	
	
	
	## SCHEDULE D FILED
	
	SCHEDD <- grepl( "IRS990ScheduleD", doc )
	
	
	
	## SCHEDULE E FILED
	
	SCHEDE <- grepl( "IRS990ScheduleE", doc )
	
	
	
	## SCHEDULE F FILED
	
	SCHEDF <- grepl( "IRS990ScheduleF", doc )
	
	
	
	## SCHEDULE G FILED
	
	SCHEDG <- grepl( "IRS990ScheduleG", doc )
	
	
	
	## SCHEDULE H FILED
	
	SCHEDH <- grepl( "IRS990ScheduleH", doc )
	
	
	
	## SCHEDULE I FILED
	
	SCHEDI <- grepl( "IRS990ScheduleI", doc )
	
	
	
	## SCHEDULE J FILED
	
	SCHEDJ <- grepl( "IRS990ScheduleJ", doc )
	
	
	
	## SCHEDULE K FILED
	
	SCHEDK <- grepl( "IRS990ScheduleK", doc )
	
	
	
	## SCHEDULE L FILED
	
	SCHEDL <- grepl( "IRS990ScheduleL", doc )
	
	
	
	## SCHEDULE M FILED
	
	SCHEDM <- grepl( "IRS990ScheduleM", doc )
	
	
	
	## SCHEDULE N FILED
	
	SCHEDN <- grepl( "IRS990ScheduleN", doc )
	
	
	
	## SCHEDULE O FILED
	
	SCHEDO <- grepl( "IRS990ScheduleO", doc )
	

		
	## SCHEDULE R FILED
	
	SCHEDR <- grepl( "IRS990ScheduleR", doc )

	

	#------------------------------------------------------------------------------------------------------------------------
	#####  SCHEDULE C
	## The xpaths are the same for PC and EZ


	## PUBLIC OPINION/GRASS ROOTS LOBBYING EXPENSES OF FILING ORGANIZATION

	V_990POLFpost2013 <- "//Return/ReturnData/IRS990ScheduleC/TotalGrassrootsLobbyingGrp/FilingOrganizationsTotalAmt"
	V_990POLFpre2013  <- "//Return/ReturnData/IRS990ScheduleC/TotalGrassrootsLobbying/FilingOrganizationsTotals"
	lobbying.pubopinion.filing.xpath <- paste( V_990POLFpost2013, V_990POLFpre2013, sep="|" )
	LOBPOFILING  <- xml_text( xml_find_all( doc, lobbying.pubopinion.filing.xpath ) )
	LOBPOFILING  <- zeroALL( LOBPOFILING )


	## PUBLIC OPINION/GRASS ROOTS LOBBYING EXPENSES OF AFFILIATED GROUP

	V_990POLApost2013 <- "//Return/ReturnData/IRS990ScheduleC/TotalGrassrootsLobbyingGrp/AffiliatedGroupTotalAmt"
	V_990POLApre2013  <- "//Return/ReturnData/IRS990ScheduleC/TotalGrassrootsLobbying/AffiliatedGroupTotals"
	lobbying.pubopinion.affiliated.xpath <- paste( V_990POLApost2013, V_990POLApre2013, sep="|" )
	LOBPOAFFIL  <- xml_text( xml_find_all( doc, lobbying.pubopinion.affiliated.xpath ) )
	LOBPOAFFIL  <- zeroALL( LOBPOAFFIL )


	## LEGISLATIVE BODY/DIRECT LOBBYING EXPENSES OF FILING ORGANIZATION

	V_990LBLFpost2013 <- "//Return/ReturnData/IRS990ScheduleC/TotalDirectLobbyingGrp/FilingOrganizationsTotalAmt"
	V_990LBLFpre2013  <- "//Return/ReturnData/IRS990ScheduleC/TotalDirectLobbying/FilingOrganizationsTotals"
	lobbying.legislative.filing.xpath <- paste( V_990LBLFpost2013, V_990LBLFpre2013, sep="|" )
	LOBLBFILING  <- xml_text( xml_find_all( doc, lobbying.legislative.filing.xpath ) )
	LOBLBFILING  <- zeroALL( LOBLBFILING )


	## LEGISTLATIVE BODY/DIRECT LOBBYING EXPENSES OF AFFILIATED GROUP

	V_990LBLApost2013 <- "//Return/ReturnData/IRS990ScheduleC/TotalDirectLobbyingGrp/AffiliatedGroupTotalAmt"
	V_990LBLApre2013  <- "//Return/ReturnData/IRS990ScheduleC/TotalDirectLobbying/AffiliatedGroupTotals"
	lobbying.legislative.affiliated.xpath <- paste( V_990LBLApost2013, V_990LBLApre2013, sep="|" )
	LOBLBAFFIL  <- xml_text( xml_find_all( doc, lobbying.legislative.affiliated.xpath ) )
	LOBLBAFFIL  <- zeroALL( LOBLBAFFIL )


	## TOTAL LOBBYING EXPENSES OF FILING ORGANIZATION

	V_990TLXFpost2013 <- "//Return/ReturnData/IRS990ScheduleC/TotalLobbyingExpendGrp/FilingOrganizationsTotalAmt"
	V_990TLXFpre2013  <- "//Return/ReturnData/IRS990ScheduleC/TotalLobbyingExpenditures/FilingOrganizationsTotals"
	lobbying.totalexp.filing.xpath <- paste( V_990TLXFpost2013, V_990TLXFpre2013, sep="|" )
	TOTLOBEXPFILING  <- xml_text( xml_find_all( doc, lobbying.totalexp.filing.xpath ) )
	TOTLOBEXPFILING  <- zeroALL( TOTLOBEXPFILING )


	## TOTAL LOBBYING EXPENSES OF AFFILIATED GROUP

	V_990TLXApost2013 <- "//Return/ReturnData/IRS990ScheduleC/TotalLobbyingExpendGrp/AffiliatedGroupTotalAmt"
	V_990TLXApre2013  <- "//Return/ReturnData/IRS990ScheduleC/TotalLobbyingExpenditures/AffiliatedGroupTotals"
	lobbying.totalexp.affiliated.xpath <- paste( V_990TLXApost2013, V_990TLXApre2013, sep="|" )
	TOTLOBEXPAFFIL  <- xml_text( xml_find_all( doc, lobbying.totalexp.affiliated.xpath ) )
	TOTLOBEXPAFFIL  <- zeroALL( TOTLOBEXPAFFIL )


	## OTHER EXEMPT EXPENSES OF FILING ORGANIZATION

	V_990.OXFpost2013 <- "//Return/ReturnData/IRS990ScheduleC/OtherExemptPurposeExpendGrp/FilingOrganizationsTotalAmt"
	V_990.OXFpre2013  <- "//Return/ReturnData/IRS990ScheduleC/OtherExemptPurposeExpenditures/FilingOrganizationsTotals"
	lobbying.otherexemptexp.filing.xpath <- paste( V_990.OXFpost2013, V_990.OXFpre2013, sep="|" )
	OTHEREXEMPTFILING  <- xml_text( xml_find_all( doc, lobbying.otherexemptexp.filing.xpath ) )
	OTHEREXEMPTFILING  <- zeroALL( OTHEREXEMPTFILING )


	## OTHER EXEMPT EXPENSES OF AFFILIATED GROUP

	V_990.OXApost2013 <- "//Return/ReturnData/IRS990ScheduleC/OtherExemptPurposeExpendGrp/AffiliatedGroupTotalAmt"
	V_990.OXApre2013  <- "//Return/ReturnData/IRS990ScheduleC/OtherExemptPurposeExpenditures/AffiliatedGroupTotals"
	lobbying.otherexemptexp.affiliated.xpath <- paste( V_990.OXApost2013, V_990.OXApre2013, sep="|" )
	OTHEREXEMPTAFFIL  <- xml_text( xml_find_all( doc, lobbying.otherexemptexp.affiliated.xpath ) )
	OTHEREXEMPTAFFIL  <- zeroALL( OTHEREXEMPTAFFIL )


	## TOTAL EXEMPT EXPENSES OF FILING ORGANIZATION

	V_990TEEFpost2013 <- "//Return/ReturnData/IRS990ScheduleC/TotalExemptPurposeExpendGrp/FilingOrganizationsTotalAmt"
	V_990TEEFpre2013  <- "//Return/ReturnData/IRS990ScheduleC/TotalExemptPurposeExpenditures/FilingOrganizationsTotals"
	lobbying.totexempt.filing.xpath <- paste( V_990TEEFpost2013, V_990TEEFpre2013, sep="|" )
	TOTEXEMPTFILING  <- xml_text( xml_find_all( doc, lobbying.totexempt.filing.xpath ) )
	TOTEXEMPTFILING  <- zeroALL( TOTEXEMPTFILING )


	## TOTAL EXEMPT EXPENSES OF AFFILIATED GROUP

	V_990TEEApost2013 <- "//Return/ReturnData/IRS990ScheduleC/TotalExemptPurposeExpendGrp/AffiliatedGroupTotalAmt"
	V_990TEEApre2013  <- "//Return/ReturnData/IRS990ScheduleC/TotalExemptPurposeExpenditures/AffiliatedGroupTotals"
	lobbying.totexempt.affiliated.xpath <- paste( V_990TEEApost2013, V_990TEEApre2013, sep="|" )
	TOTEXEMPTAFFIL  <- xml_text( xml_find_all( doc, lobbying.totexempt.affiliated.xpath ) )
	TOTEXEMPTAFFIL  <- zeroALL( TOTEXEMPTAFFIL )


	## LOBBYING NONTAXABLE AMOUNT OF FILING ORGANIZATION

	V_990LNTFpost2013 <- "//Return/ReturnData/IRS990ScheduleC/LobbyingNontaxableAmountGrp/FilingOrganizationsTotalAmt"
	V_990LNTFpre2013  <- "//Return/ReturnData/IRS990ScheduleC/LobbyingNontaxableAmount/FilingOrganizationsTotals"
	lobbying.nontax.filing.xpath <- paste( V_990LNTFpost2013, V_990LNTFpre2013, sep="|" )
	LOBNTFILING  <- xml_text( xml_find_all( doc, lobbying.nontax.filing.xpath ) )
	LOBNTFILING  <- zeroALL( LOBNTFILING )


	## LOBBYING NONTAXABLE AMOUNT OF AFFILIATED GROUP

	V_990LNTApost2013 <- "//Return/ReturnData/IRS990ScheduleC/LobbyingNontaxableAmountGrp/AffiliatedGroupTotalAmt"
	V_990LNTApre2013  <- "//Return/ReturnData/IRS990ScheduleC/LobbyingNontaxableAmount/AffiliatedGroupTotals"
	lobbying.nontax.affil.xpath <- paste( V_990LNTApost2013, V_990LNTApre2013, sep="|" )
	LOBNTAFFIL  <- xml_text( xml_find_all( doc, lobbying.nontax.affil.xpath ) )
	LOBNTAFFIL  <- zeroALL( LOBNTAFFIL )


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


	var.list <- namedList( # HEADER
			       EIN, NAME, DBA, FISYR, STATE, ADDRESS, CITY, ZIP, STYEAR, ENDYEAR, 
			       TAXPREP, FORMTYPE,
			       # BASIC INFO
			       GROSSRECEIPTS, GROUPRETURN, GROUPEXEMPTNUM, FORMYEAR, DOMICILE, 
			       WEBSITE, URL,
			       ## Collapse values for FORMORG
			       FORMORGASSOC, FORMORGCORP, FORMORGTRUST, FORMORGOTHER, 
			       FORMORGOTHERDESC, FORMORG, 
			       ## Collapse values for ACCTMETHOD
			       ACCTACCRUAL, ACCTCASH, ACCTOTHER, ACCTMETHOD, 
			       ## Collapse values for EXEMPTSTATUS
			       EXEMPT4947A1, EXEMPT501C, EXEMPT501CNUM, EXEMPT501C3, 
			       EXEMPT527, EXEMPTSTATUS,
			       # PART I 
			       MISSION, DISCOPS, VOTINGMEMBERS, INDVOTINGMEMBERS, TOTEMPLOYEE, 
			       TOTVOLUNTEERS, TOTUBI, NETUBI, CONTRIBPRIOR, CONTRIBCURRENT, 
			       PSRPRIOR, PSRCURRENT, INVINCPRIOR, INVINCCURRENT, OTHERREVPRIOR, 
			       OTHERREVCURRENT, TOTALREVPRIOR, TOTALREVCURRENT, MEMBERDUES, 
			       GROSSSALESOTHER, SALESCOSTOTHER, NETSALESOTHER, GROSSINCGAMING, 
			       GROSSINCFNDEVENTS, 
			       ## Sum PC values for EXPGAMINGFNDEVENTS
			       GAMINGEXP, FNDEVENTSEXP, EXPGAMINGFNDEVENTS, 
			       ## Sum PC values for NETGAMINGFNDEVENTS
			       GAMINGNET, FNDEVENTSNET, NETGAMINGFNDEVENTS, GROSSSALESINV, 
			       SALESCOSTINV, NETSALESINV, GRANTSPAIDPRIOR, GRANTSPAIDCURRENT, 
			       MEMBERBENPRIOR, MEMBERBENCURRENT, SALARIESPRIOR, SALARIESCURRENT, 
			       PROFUNDFEESPRIOR, PROFUNDFEESCURRENT, TOTFUNDEXP, 
			       ## Sum PC values for PROFEESINDEP
			       FEESMGMT, FEESLEGAL, FEESACCT, FEESLOBBY,FEESPROFND, FEESINVMGMT, 
			       FEESOTHER, PROFEESINDEP, 
			       OCCUPANCY, OFFICEEXP, OTHEREXPPRIOR, OTHEREXPCURRENT, 
			       TOTALEXPPRIOR, TOTALEXPCURRENT, REVLESSEXPPRIOR, REVLESSEXPCURRENT, 
			       TOTALASSETSBEGYEAR, TOTALASSETSENDYEAR, TOTALLIABBEGYEAR, 
			       TOTALLIABENDYEAR, NETASSETSBEGYEAR, OTHERASSETSCHANGES, 
			       NETASSETSENDYEAR, 
			       # PART II (EZ) / X (PC)
			       ## Sum PC values for CASHINVBEGYEAR and CASHINVENDYEAR
			       CASHBEGYEAR, CASHENDYEAR, SAVINVBEGYEAR, SAVINVENDYEAR, 
			       CASHINVBEGYEAR, CASHINVENDYEAR, 
			       LANDBLDEQUIPCOST, LANDBLDEQUIPDEP, LANDBEGYEAR, LANDENDYEAR, 
			       OTHERASSETSBEGYEAR, OTHERASSETSENDYEAR,
			       # PART III
			       TOTALPROGSERVEXP,
			       # PART IV
			       LOBBYING, FOREIGNREV,
			       # PART VI
			       SCHEDOPARTVI, VMGOVERNING, IVMGOVERNING, OFFICERREL, MGMTDEL,
			       CHANGESGOVDOCS, DIVASSETS, STOCKMEMBER, MEMBERCHOOSE, 
			       GOVBODYDECISION, GOVBODYDOCU, COMMITTEEDOCU, NOTREACH,
			       COIPOLICY, COIDISCLOSE, COIMONITOR, WBPOLICY, FILINGSTATES,
			       ## Collapse values for PUBLICSHARE
			       PUBLICWEBSELF, PUBLICWEBOTHER, PUBLICREQUEST, PUBLICOTHER, 
			       PUBLICSHARE,
			       ORGBOOKNAME, ORGBOOKPHONE, ORGBOOKADDRESS, ORGBOOKCITY, 
			       ORGBOOKSTATE, ORGBOOKZIP,
			       # PART X
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
			       # LIST OF SCHEDULES
			       SCHEDA, SCHEDB, SCHEDC, SCHEDD, SCHEDE, SCHEDF, SCHEDG, SCHEDH, 
			       SCHEDI, SCHEDJ, SCHEDK, SCHEDL, SCHEDM, SCHEDN, SCHEDO, SCHEDR,
			       # SCHEDULE C
			       LOBPOFILING, LOBPOAFFIL, LOBLBFILING, LOBLBAFFIL, TOTLOBEXPFILING, 
			       TOTLOBEXPAFFIL, OTHEREXEMPTFILING, OTHEREXEMPTAFFIL, TOTEXEMPTFILING,
			       TOTEXEMPTAFFIL, LOBNTFILING, LOBNTAFFIL 
			      )

	# variables that are functions:
	## FORMORG: Collapses values of FORMORGASSOC, FORMORGCORP, FORMORGTRUST, FORMORGOTHER, FORMORGOTHERDESC
	## ACCTMETHOD: Collapses values of ACCTACCRUAL, ACCTCASH, ACCTOTHER
	## EXEMPTSTATUS: Collapses values of EXEMPT4947A1, EXEMPT501C, EXEMPT501CNUM, EXEMPT501C3, EXEMPT527
	## EXPGAMINGFNDEVENTS: PC values are sum of GAMINGEXP and FNDEVENTSEXP
	## NETGAMINGFNDEVENTS: PC values are sum of GAMINGNET and FNDEVENTSNET
	## PROFEESINDEP: PC values are sum of FEESMGMT, FEESLEGAL, FEESACCT, FEESLOBBY,
	##                                    FEESPROFND, FEESINVMGMT, FEESOTHER
	## CASHINVBEGYEAR: PC values are sum of CASHBEGYEAR and SAVINVBEGYEAR
	## CASHINVENDYEAR: PC values are sum of CASHENDYEAR and SAVINVENDYEAR
	## PUBLICSHARE: Collapses values of PUBLICWEBSELF, PUBLICWEBOTHER, PUBLICREQUEST, PUBLICOTHER  

        # print( var.list ) # if you need to debug uncomment here
        
	return( var.list )





    # return( xml.df )


}



