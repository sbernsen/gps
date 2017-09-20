## Append the meta data to a csv file
##
## The csv file will have the header values of 
## 	FILENAME, START_TIME, END_TIME, ANTENNA_HEIGHT, START_EPOCH, END_EPOCH

## Define files 
meta <- "meta.txt" 
meta.tbl <- "MetaTable.csv"

con <- file(meta, open="r")
meta.data <- readLines(con)


meta.tms <- meta.data[ substr(meta.data, 1, 8) == "filename" ]
meta.tms <- c(meta.tms, meta.data[ substr(meta.data, 1, 5) == "start" ] )
meta.tms <- c(meta.tms, meta.data[ substr(meta.data, 1, 5) == "final" ] )
meta.tms <- c(meta.tms, meta.data[ substr(meta.data, 1, 14) == "antenna height" ] )

## the format will be YYYY-MM-DD HH:MM:SS.SSSS which is 24 characters long but
## all values start on n=25 so we can just take that value 
n <- nchar(meta.tms)
meta.tms <- substr(meta.tms, 26, n)

meta.tms <- c(meta.tms, as.numeric(as.POSIXct(meta.tms[2:3]) ) )

## Close the meta textfile connection 
close(con) 

## Open the meta table and append the values to the bottom 
d <- read.csv(meta.tbl) 
cn <- colnames(d) 

meta.tms <- matrix(meta.tms, 1, length(meta.tms) )
data.frame(meta.tms)
colnames(meta.tms) <- cn

d <- rbind(d, meta.tms)
colnames(d) <- cn

write.csv(d, meta.tbl, quote=F, row.names = F)