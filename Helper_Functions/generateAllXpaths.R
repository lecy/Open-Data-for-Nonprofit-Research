


library( xml2 )
library( dplyr )



# EXAMPLE ORGANIZATIONS FROM EACH PERIOD


V_990_2014 <- "https://s3.amazonaws.com/irs-form-990/201543089349301829_public.xml"

V_990_2012 <- "https://s3.amazonaws.com/irs-form-990/201322949349300907_public.xml"

V_990EZ_2014 <- "https://s3.amazonaws.com/irs-form-990/201513089349200226_public.xml"

V_990EZ_2012 <- "https://s3.amazonaws.com/irs-form-990/201313549349200311_public.xml"





# GENERATE ALL XPATHS: V 990 2014
doc <- read_xml( V_990_2014 )
xml_ns_strip( doc )
doc %>% xml_find_all( '//*') %>% xml_path()



# GENERATE ALL XPATHS: V 990 2012
doc <- read_xml( V_990_2012 )
xml_ns_strip( doc )
doc %>% xml_find_all( '//*') %>% xml_path()



# GENERATE ALL XPATHS: V 990EZ 2014
doc <- read_xml( V_990EZ_2014 )
xml_ns_strip( doc )
doc %>% xml_find_all( '//*') %>% xml_path()



# GENERATE ALL XPATHS: V 990EZ 2012
doc <- read_xml( V_990EZ_2012 )
xml_ns_strip( doc )
doc %>% xml_find_all( '//*') %>% xml_path()




# GENERATE VARIABLE NAMES INSTEAD OF XPATHS
# doc %>% xml_find_all( '//*') %>% xml_name()
