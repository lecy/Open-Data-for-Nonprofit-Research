# FUNCTION TO COLLECT HEADER MODULE
#
# Argument:  doc = xml document
#
# Return Value:  doca frame


getBasicInfo <- function( doc )
{

        # FROM NCCS CORE - HEADER DATA
	EIN  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/EIN" ) )
	FISYR <- xml_text( xml_find_all( doc, "/Return/ReturnHeader/TaxYr" ) ) 
	NAME <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/BusinessName/BusinessNameLine1Txt" ) )
	STATE  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/USAddress/StateAbbreviationCd" ) )
	ADDRESS <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/USAddress/AddressLine1Txt" ) )
	CITY  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/USAddress/CityNm" ) )
	ZIP  <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/Filer/USAddress/ZIPCd" ) )
	STYEAR  <- xml_text( xml_find_all( doc, "/Return/ReturnHeader/TaxPeriodBeginDt" ) )
	TAXPER <- xml_text( xml_find_all( doc, "/Return/ReturnHeader/TaxPeriodEndDt"  ) )

	# EXTRA FIELDS ADDED
	TAXPREP <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/BusinessOfficerGrp/DiscussWithPaidPreparerInd" ) ) 
	FORM <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/ReturnTypeCd" ) ) 

	# BASIC INFO
	GROSSRECEIPTS <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/GrossReceiptsAmt" ) ) 
	GROUPRETURN <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/GroupReturnForAffiliatesInd" ) ) 
	TAXEXMSTATUS <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/Organization501c3Ind" ) ) 
	TYPEOFORG <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/TypeOfOrganizationCorpInd" ) ) 
	FORMYEAR <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/FormationYr" ) ) 
	DOMICILE <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/LegalDomicileStateCd" ) ) 
	WEBSITE <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/WebsiteAddressTxt" ) ) 

	# FROM PART I - ACTIVITIES AND GOVERNANCE 
	VOTINGMEMBERS <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/VotingMembersGoverningBodyCnt" ) )  
	INDVOTINGMEMBERS <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/VotingMembersIndependentCnt" ) ) 
	TOTEMPLOYEE <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/TotalEmployeeCnt" ) ) 
	TOTVOLUNTEERS <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/TotalVolunteersCnt" ) ) 
	TOTUBI <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/TotalGrossUBIAmt" ) ) 
	NETUBI <- xml_text( xml_find_all( doc, "/Return/ReturnData/IRS990/NetUnrelatedBusTxblIncmAmt" ) ) 


	# namedList <- function(...){
	#     names <- as.list(substitute(list(...)))[-1L]
	#     result <- list(...)
	#     names(result) <- names
	#     result[sapply(result, function(x){length(x)==0})] <- NA
	#     result[sapply(result, is.null)] <- NA
	#     result
	# }
	

	
        
        
	header.list <- namedList( EIN, FISYR, NAME, STATE, ADDRESS, CITY, ZIP, STYEAR, TAXPER, TAXPREP, FORM,
	                          GROSSRECEIPTS, GROUPRETURN, TAXEXMSTATUS, TYPEOFORG, FORMYEAR, DOMICILE, WEBSITE,  
	                          VOTINGMEMBERS, INDVOTINGMEMBERS, TOTEMPLOYEE, TOTVOLUNTEERS, TOTUBI, NETUBI  )

        header.df <- as.data.frame( header.list, stringsAsFactors=F )
        
        return( header.df )


}

