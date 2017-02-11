# TEST THE BUILD OF A NEW MODULE



library( xml2 )
library( dplyr )



# example of all four primary versions of 990 and 990EZs

V_990_2014 <- "https://s3.amazonaws.com/irs-form-990/201543089349301829_public.xml"

V_990_2012 <- "https://s3.amazonaws.com/irs-form-990/201322949349300907_public.xml"

V_990EZ_2014 <- "https://s3.amazonaws.com/irs-form-990/201513089349200226_public.xml"

V_990EZ_2012 <- "https://s3.amazonaws.com/irs-form-990/201313549349200311_public.xml"



# select a version to use

url <- V_990_2014


# read xml data from IRS website and strip namespace

doc <- read_xml( url )
xml_ns_strip( doc )


# grab the basic nonprofit info - name, ein, address, etc.

     source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper_Functions/getBasicInfo.R")

      xml.df <- getBasicInfo( doc, url )



# add your custom module

      # return one row of data from your section
      my.mod.df <- myModCode( doc )
      
      # column bind your section with basic nonprofit info
      xml.df <- cbind( xml.df, my.mod.df ) 



# test to ensure data is collected as expected

      names( xlm.df )

      xml.df  # print results
