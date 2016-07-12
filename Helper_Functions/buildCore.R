# FUNCTION TO BUILD THE CORE DATASET
# 
# Arguments: 
#    ein - character vector of nonprofits to sample
#    years - vector of which years to collect
#    form.type - which type of data to collect
#    modules - what sections of data to build
#    index - database of all electronic filers provided by the IRS


buildCore <- function( eins, years, form.type="990", modules="all", index=NULL )
{
  
  library( dplyr )
  library( xml2 )
  # library( R.utils )
  
  source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper_Functions/scrapeXML.R")
  
  if( is.null(index) ) { index <- buildIndex() }
  
  # subset index
  
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
     one.npo <- scrapeXML( these[i], form.type, modules )
     
     if( ! is.null(one.npo) )
     {
       core <- bind_rows( core, one.npo )
     }
  }
  
  # need to clean up variable types
  
  return( core )

}
