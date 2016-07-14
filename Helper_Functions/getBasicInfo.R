# FUNCTION TO COLLECT HEADER MODULE
#
# Argument:  doc = xml document
#
# Return Value:  doca frame


getBasicInfo <- function( doc, url )
{
        # *[self:: or self::]
        # FROM NCCS CORE - HEADER DATA
	EIN  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/EIN" ) )
	FISYR <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/*[self::TaxYr or self::TaxYear]" ) ) 
	#NAME <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/BusinessName/BusinessNameLine1Txt" ) )
	NAME <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/Name/BusinessNameLine1|//Return/ReturnHeader/Filer/BusinessName/BusinessNameLine1Txt" ) )
	DBA  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/Name/BusinessNameLine2|//Return/ReturnHeader/Filer/BusinessName/BusinessNameLine2Txt" ) )
	STATE  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/USAddress/*[self::StateAbbreviationCd or self::State]" ) )
	ADDRESS <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/USAddress/*[self::AddressLine1Txt or self::AddressLine1]" ) )
	CITY  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/USAddress/*[self::CityNm or self::City]" ) )
	ZIP  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/USAddress/*[self::ZIPCd or self::ZIPCode]" ) )
	STYEAR  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/*[self::TaxPeriodBeginDt or self::TaxPeriodBeginDate]" ) )  
	ENDYEAR <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/*[self::TaxPeriodEndDt or self::TaxPeriodEndDate]"  ) ) 

	# EXTRA FIELDS ADDED
	TAXPREP <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Officer/AuthorizeThirdParty|//Return/ReturnHeader/BusinessOfficerGrp/DiscussWithPaidPreparerInd" ) )    
	# FORM <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/ReturnTypeCd" ) ) 
	FORM <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/*[self::ReturnType or self::ReturnTypeCd]" ) )


	# BASIC INFO
	GROSSRECEIPTS <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::GrossReceipts or self::GrossReceiptsAmt]" ) ) 
	GROUPRETURN <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::GroupReturnForAffiliates or self::GroupReturnForAffiliatesInd]" ) ) 
	TAXEXMSTATUS <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::Organization501c3 or self::Organization501c3Ind]" ) ) 
	TYPEOFORG <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::TypeOfOrganizationCorporation or self::TypeOfOrganizationCorpInd]" ) ) 
	FORMYEAR <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::YearFormation or self::FormationYr]" ) ) 
	DOMICILE <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::StateLegalDomicile or self::LegalDomicileStateCd]" ) ) 
	WEBSITE <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::WebSite or self::WebsiteAddressTxt]" ) ) 

	# FROM PART I - ACTIVITIES AND GOVERNANCE 
	VOTINGMEMBERS <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::NbrVotingMembersGoverningBody or self::VotingMembersGoverningBodyCnt]" ) )  
	INDVOTINGMEMBERS <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::NbrIndependentVotingMembers or self::VotingMembersIndependentCnt]" ) ) 
	TOTEMPLOYEE <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::TotalNbrEmployees or self::TotalEmployeeCnt]" ) ) 
	TOTVOLUNTEERS <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::TotalNbrVolunteers or self::TotalVolunteersCnt]" ) ) 
	TOTUBI <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::TotalGrossUBI or self::TotalGrossUBIAmt]" ) ) 
	NETUBI <- xml_text( xml_find_all( doc, "//Return/ReturnData/IRS990/*[self::NetUnrelatedBusinessTxblIncome or self::NetUnrelatedBusTxblIncmAmt]" ) ) 
        
        URL <- url

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
	

	
        
        
	header.list <- namedList( EIN, FISYR, NAME, DBA, STATE, ADDRESS, CITY, ZIP, STYEAR, ENDYEAR, TAXPREP, FORM,
	                          GROSSRECEIPTS, GROUPRETURN, TAXEXMSTATUS, TYPEOFORG, FORMYEAR, DOMICILE, WEBSITE,  
	                          VOTINGMEMBERS, INDVOTINGMEMBERS, TOTEMPLOYEE, TOTVOLUNTEERS, TOTUBI, NETUBI, URL  )

        header.df <- as.data.frame( header.list, stringsAsFactors=F )
        
        return( header.df )


}

