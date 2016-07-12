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

    
    source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper_Functions/getBasicInfo.R")
    # source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper%20Functions/getRevExp.R")
    # source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper%20Functions/getMission.R")
    
    
    # url <- "https://s3.amazonaws.com/irs-form-990/201541349349307794_public.xml"
    doc <- read_xml( url )
    xml_ns_strip( doc )
    
    
    # check to ensure it is the proper form type
    FORM <- xml_text( xml_find_all( doc, "//Return/ReturnHeader/ReturnTypeCd" ) )
    if( ! FORM %in% form.type ) 
    { 
       print( paste( "Organization is not the correct return type;", "\n",
                     "Desired: ", form.type, "; Actual Type: ", FORM, "\n",
                     url, sep="" ) )
    
       return(NULL)
       
    }
    
    
    
    # SET MODULES TO COLLECT
    if( modules == "all" & FORM == "990" )
    {
        modules <- c("basic","revexp","mission")
    }
    
    

    
    # always include basic info?

      xml.df <- getBasicInfo( doc )


#      xml.df <- NULL  
#
#     if( "basic" %in% modules  & FORM == "990" )
#     {
#        header.df <- getBasicInfo( doc )
#        if( is.null(xml.df) )
#        { xml.df <- header.df }
#        else{ xml.df <- cbind(xml.df,header.df) } 
#    }
#    
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