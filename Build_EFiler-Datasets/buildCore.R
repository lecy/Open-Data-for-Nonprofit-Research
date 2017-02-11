# FUNCTION TO BUILD THE CORE DATASET
# 
# Arguments: 
#    ein - character vector of nonprofits to sample
#    years - vector of which years to collect
#    form.type - which type of data to collect
#    modules - what sections of data to build
#    index - database of all electronic filers provided by the IRS


buildCore <- function( eins=NULL, index=NULL, years, form.type=c("990","990EZ"), modules="all" )
{
  
  library( dplyr )
  library( xml2 )
  # library( R.utils )
  
  
  # LOAD ALL REQUIRED FUNCTIONS
  
  source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper_Functions/buildIndex.R")
  source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper_Functions/scrapeXML.R")
  source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper_Functions/getBasicInfo.R")
  # source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper%20Functions/getRevExp.R")
  # source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper%20Functions/getMission.R")
  
  
  # BUILD NECESSARY RESOURCES
  
  if( is.null(index) ) { index <- buildIndex() }
  
  if( is.null(eins) ) { eins <- unique( index$EIN ) }
  
  if( modules == "all" ) { modules <- c("basic") }    # { modules <- c("basic","revexp","mission"...) }
  
  
  
  # SUBSET INDEX FILE BY SPECIFIED YEARS AND FORMS
  
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
     one.npo <- scrapeXML( url=these[i], form.type=form.type, modules=modules )
     
     if( ! is.null(one.npo) )
     {
       core <- bind_rows( core, one.npo )
     }
  }
  
  # need to clean up variable types
  
  return( core )

}
