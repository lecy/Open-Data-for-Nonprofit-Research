# Script to Build E-Filer Core Database for Posting on Dataverse



library( jsonlite )
library( R.utils )


### CREATE A DIRECTORY FOR THE DATA

getwd()

dir.create( "IRS Nonprofit Data" )

setwd( "./IRS Nonprofit Data" )




# CREATE A DATA FRAME OF ELECTRONIC FILERS FROM IRS JSON FILES

dat1 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2011.json")[[1]]
dat2 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2012.json")[[1]]
dat3 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2013.json")[[1]]
dat4 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2014.json")[[1]]
dat5 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2015.json")[[1]]
dat6 <- fromJSON("https://s3.amazonaws.com/irs-form-990/index_2016.json")[[1]]

data.ef <- rbind( dat1, dat2, dat3, dat4, dat5, dat6 )

nrow( data.ef )  # 1,753,129




# REFORMAT FILING DATE FROM YYYY-MM TO YYYY

# Tax Period represents the end of the nonprofit's accounting year
# The tax filing year is always the previous year, unless the accounting year ends in December

year <- as.numeric( substr( data.ef$TaxPeriod, 1, 4 ) )
month <- substr( data.ef$TaxPeriod, 5, 6 )

data.ef$FilingYear <- year - 1
data.ef$FilingYear[ month == "12" ] <- year[ month == "12" ]


table( data.ef$FormType, data.ef$FilingYear, useNA="ifany" )

#           2009   2010   2011   2012   2013   2014   2015
#   990    33360 123107 159539 179675 198615 215764  73233
#   990EZ  15500  63253  82066  93769 104425 114822  60967
#   990PF   2352  25275  34597  39936  45870  52617  34387




# SOURCE THE BUILD FUNCTIONS

source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Build_IRS990_E-Filer_Datasets/BUILD_EFILER_DATABASE.R")

# BUILD FILE SYNTAX
# 
# cd <- buildCore( index=these.npos, years=2014:2015, form.type=c("990","990EZ") )





###########   BUILD 2015 DATA   ###############

year <- 2015

dd <- data.ef[ data.ef$FilingYear == year , ]

nrow( dd )  # 

# build in 100 small increments and save to file

breaks <- round( seq( from = 0, to = nrow(dd), length.out = 100 ), 0 )

for( i in 1:99 )
{
   loop <- formatC( i, width = 3, format = "d", flag = "0" )
   print( paste( "Loop-", loop, ": ", format(Sys.time(), "%b %d %X"), sep="" ) )
   d.sub <- dd[ (breaks[i]+1):( breaks[i+1] ) , ]
   try( {
        cd <- buildCore( index=d.sub, years=year, form.type=c("990","990EZ") )
        saveRDS( cd, paste( year, "DATA-", loop, "-", (breaks[i]+1), "-to-", breaks[i+1], ".rds", sep="" ) )
       } )

}

savehistory( file=paste( year, "-build.Rhistory", sep="" ) )




###########   BUILD 2014 DATA   ###############

year <- 2014

dd <- data.ef[ data.ef$FilingYear == year , ]

nrow( dd )  # 

# build in 100 small increments and save to file

breaks <- round( seq( from = 0, to = nrow(dd), length.out = 100 ), 0 )

for( i in 1:99 )
{
   loop <- formatC( i, width = 3, format = "d", flag = "0" )
   print( paste( "Loop-", loop, ": ", format(Sys.time(), "%b %d %X"), sep="" ) )
   d.sub <- dd[ (breaks[i]+1):( breaks[i+1] ) , ]
   try( {
        cd <- buildCore( index=d.sub, years=year, form.type=c("990","990EZ") )
        saveRDS( cd, paste( year, "DATA-", loop, "-", (breaks[i]+1), "-to-", breaks[i+1], ".rds", sep="" ) )
       } )

}

savehistory( file=paste( year, "-build.Rhistory", sep="" ) )






###########   BUILD 2013 DATASET   ###############

year <- 2013

dd <- data.ef[ data.ef$FilingYear == year , ]

nrow( dd )  # 335,934

# build in 100 small increments and save to file

breaks <- round( seq( from = 0, to = nrow(dd), length.out = 100 ), 0 )

for( i in 1:99 )
{
   loop <- formatC( i, width = 3, format = "d", flag = "0" )
   print( paste( "Loop-", loop, ": ", format(Sys.time(), "%b %d %X"), sep="" ) )
   d.sub <- dd[ (breaks[i]+1):( breaks[i+1] ) , ]
   try( {
        cd <- buildCore( index=d.sub, years=year, form.type=c("990","990EZ") )
        saveRDS( cd, paste( year, "DATA-", loop, "-", (breaks[i]+1), "-to-", breaks[i+1], ".rds", sep="" ) )
       } )

}

savehistory( file=paste( year, "-build.Rhistory", sep="" ) )





###########   BUILD 2012 DATASET   ###############

year <- 2012

dd <- data.ef[ data.ef$FilingYear == year , ]

nrow( dd )  # 

# build in 100 small increments and save to file

breaks <- round( seq( from = 0, to = nrow(dd), length.out = 100 ), 0 )

for( i in 1:99 )
{
   loop <- formatC( i, width = 3, format = "d", flag = "0" )
   print( paste( "Loop-", loop, ": ", format(Sys.time(), "%b %d %X"), sep="" ) )
   d.sub <- dd[ (breaks[i]+1):( breaks[i+1] ) , ]
   try( {
        cd <- buildCore( index=d.sub, years=year, form.type=c("990","990EZ") )
        saveRDS( cd, paste( year, "DATA-", loop, "-", (breaks[i]+1), "-to-", breaks[i+1], ".rds", sep="" ) )
       } )

}

savehistory( file=paste( year, "-build.Rhistory", sep="" ) )




###########   BUILD 2011 DATASET   ###############

year <- 2011

dd <- data.ef[ data.ef$FilingYear == year , ]

nrow( dd )  # 

# build in 100 small increments and save to file

breaks <- round( seq( from = 0, to = nrow(dd), length.out = 100 ), 0 )

for( i in 1:99 )
{
   loop <- formatC( i, width = 3, format = "d", flag = "0" )
   print( paste( "Loop-", loop, ": ", format(Sys.time(), "%b %d %X"), sep="" ) )
   d.sub <- dd[ (breaks[i]+1):( breaks[i+1] ) , ]
   try( {
        cd <- buildCore( index=d.sub, years=year, form.type=c("990","990EZ") )
        saveRDS( cd, paste( year, "DATA-", loop, "-", (breaks[i]+1), "-to-", breaks[i+1], ".rds", sep="" ) )
       } )

}

savehistory( file=paste( year, "-build.Rhistory", sep="" ) )



###########   BUILD 2010 DATASET   ###############

year <- 2010

dd <- data.ef[ data.ef$FilingYear == year , ]

nrow( dd )  # 

# build in 100 small increments and save to file

breaks <- round( seq( from = 0, to = nrow(dd), length.out = 100 ), 0 )

for( i in 1:99 )
{
   loop <- formatC( i, width = 3, format = "d", flag = "0" )
   print( paste( "Loop-", loop, ": ", format(Sys.time(), "%b %d %X"), sep="" ) )
   d.sub <- dd[ (breaks[i]+1):( breaks[i+1] ) , ]
   try( {
        cd <- buildCore( index=d.sub, years=year, form.type=c("990","990EZ") )
        saveRDS( cd, paste( year, "DATA-", loop, "-", (breaks[i]+1), "-to-", breaks[i+1], ".rds", sep="" ) )
       } )

}

savehistory( file=paste( year, "-build.Rhistory", sep="" ) )



###########   BUILD 2009 DATASET   ###############

year <- 2009

dd <- data.ef[ data.ef$FilingYear == year , ]

nrow( dd )  # 

# build in 100 small increments and save to file

breaks <- round( seq( from = 0, to = nrow(dd), length.out = 100 ), 0 )

for( i in 1:99 )
{
   loop <- formatC( i, width = 3, format = "d", flag = "0" )
   print( paste( "Loop-", loop, ": ", format(Sys.time(), "%b %d %X"), sep="" ) )
   d.sub <- dd[ (breaks[i]+1):( breaks[i+1] ) , ]
   try( {
        cd <- buildCore( index=d.sub, years=year, form.type=c("990","990EZ") )
        saveRDS( cd, paste( year, "DATA-", loop, "-", (breaks[i]+1), "-to-", breaks[i+1], ".rds", sep="" ) )
       } )

}

savehistory( file=paste( year, "-build.Rhistory", sep="" ) )


