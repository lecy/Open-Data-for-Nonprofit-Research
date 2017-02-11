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



# load the functions to scrape data



# grab the basic nonprofit info - name, ein, address, etc.

     source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Build_IRS990_E-Filer_Datasets/BUILD_EFILER_DATABASE.R")

      one.npo <- scrapeXML( doc, url )



# add your custom module

      fix( scrapeXML )



# test to ensure data is collected as expected

      names( one.npo )

      options(tibble.width = Inf)
      
      print( one.npo )  # view results
