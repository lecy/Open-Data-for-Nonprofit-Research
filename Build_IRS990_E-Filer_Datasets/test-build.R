

# INSTALL NECESSARY PACKAGES

pckgs <- c("jsonlite","R.utils","dplyr","xml2")

install.packages( pckgs )




# LOAD THE IRS INDEX FILE FROM 2014

library( jsonlite )

dat14 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2014.json")[[1]]

dat14$FilingYear <- substr( dat14$TaxPeriod, 1, 4 )



# CREATE A SAMPLE OF NONPROFITS

these.npos <- dat14[ dat14$EIN %in% sample( dat14$EIN, 100 ) , ]


# SOURCE THE BUILD FUNCTIONS

source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Build_IRS990_E-Filer_Datasets/BUILD_EFILER_DATABASE.R")


# BUILD TEST FILE

cd <- buildCore( index=these.npos, years=2014:2015, form.type=c("990","990EZ") )

head( cd )


# TO PRINT ALL ON SCREEN:

print.data.frame( cd )


# TO VIEW AS SPREADSHEET:

View( cd )


# TO SAVE TO EXCEL

getwd()  # this is where the file will be saved

write.csv( cd, "IRS-990-EFILERS.csv", row.names=F )
