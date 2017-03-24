###########   BUILD 2013 DATA   ###############

year <- 2013

dd <- data.ef[ data.ef$FilingYear == year , ]

nrow( dd )  # 

# build in 100 small increments and save to file

breaks <- round( seq( from = 0, to = nrow(dd), length.out = 100 ), 0 )

file.name <- paste( year, "-build.txt", sep="" )
zz <- file( file.name, open = "wt")
sink( zz, split=T )
sink( zz, type = "message", append=TRUE )


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


sink(type = "message")
sink() # close sink
close(zz)
file.show( file.name )


savehistory( file=paste( year, "-build.Rhistory", sep="" ) )


