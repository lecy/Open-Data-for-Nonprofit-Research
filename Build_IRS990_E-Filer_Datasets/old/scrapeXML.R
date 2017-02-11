# FUNCTION TO 
#
# Arguments:
#   url - link to a nonprofits xml page
#   form.type - check to ensure data is from the correct form in case of poor data in index file
#   modules - list of all modules to collect
#
# Return Value:
#   one-row data frame containing elements from one nonprofit




scrapeXML <- function( url, form.type, modules )
{

    
    # print( url )
    # url <- "https://s3.amazonaws.com/irs-form-990/201541349349307794_public.xml"
    # url <- paste( "https://s3.amazonaws.com/irs-form-990/", id, "_public.xml", sep="" )
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
    
    
    

    
    # always include basic info

      xml.df <- getBasicInfo( doc, url )


#      xml.df <- NULL  
#
#     if( "basic" %in% modules  & FORM == "990" )
#     {
#        header.df <- getBasicInfo( doc )
#        if( is.null(xml.df) )
#        { xml.df <- header.df }
#        else{ xml.df <- cbind(xml.df,header.df) } 
#    } 
    
    # variables that are functions:
	## EXPGAMINGFNDEVENTS: PC values are sum of GAMINGEXP and FNDEVENTSEXP
	## NETGAMINGFNDEVENTS: PC values are sum of GAMINGNET and FNDEVENTSNET
	## PROFEESINDEP: PC values are sum of FEESMGMT, FEESLEGAL, FEESACCT, FEESLOBBY,
	##                                    FEESPROFND, FEESINVMGMT, FEESOTHER
	## CASHINVBEGYEAR: PC values are sum of CASHBEGYEAR and SAVINVBEGYEAR
	## CASHINVENDYEAR: PC values are sum of CASHENDYEAR and SAVINVENDYEAR
    
    
    
    
    
#    if( "revexp" %in% modules  & FORM == "990" )
#    {
#       rev.exp.df <- getRevExp( doc )
#        if( is.null(xml.df) )
#        { xml.df <- rev.exp.df }
#        else{ xml.df <- cbind(xml.df,rev.exp.df) } 
#    }
#    
#    
#    if( "mission" %in% modules & FORM == "990" )
#    {
#        mission.df <- getMission( doc )
#        if( is.null(xml.df) )
#        { xml.df <- mission.df }
#        else{ xml.df <- cbind(xml.df,mission.df) } 
#    }




    return( xml.df )


}


