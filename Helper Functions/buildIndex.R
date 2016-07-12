library( jsonlite )
library( R.utils )


### CREATE A DIRECTORY FOR YOUR DATA

getwd()

dir.create( "IRS Nonprofit Data" )

setwd( "./IRS Nonprofit Data" )


### DOWNLOAD FILES AND UNZIP

electronic.filers <- "https://s3.amazonaws.com/irs-form-990/index.json.gz"

download.file( url=electronic.filers, "electronic.json.gz" )

gunzip("electronic.json.gz", remove=TRUE )  


# CREATE A DATA FRAME OF ELECTRONIC FILERS FROM IRS JSON FILES

data.ef <- fromJSON( txt="electronic.json" )[[1]]

nrow( data.ef )




# REFORMAT DATE FROM YYYY-MM TO YYYY

data.ef$FilingYear <- substr( data.ef$TaxPeriod, 1, 4 )




# DROP UNRELIABLE YEARS

# table( data.ef$FilingYear ) # note that some records are nonsensical

data.ef <- data.ef[ data.ef$FilingYear > 2009 & data.ef$FilingYear < 2016 , ]

# table( data.ef$FilingYear, useNA="ifany" )

# nrow( data.ef )




# EXCLUDE DATA THAT IS NOT AVAILABLE IN ELECTRONIC FORMAT

# table( data.ef$IsElectronic, data.ef$IsAvailable )

data.ef <- data.ef[ data.ef$IsAvailable == TRUE , ]

# nrow( data.ef )