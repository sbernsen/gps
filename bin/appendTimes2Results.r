#!/usr/bin/env Rscript

## Add times to the results using the meta data table 

## define filenames 
fn.rov <- "ROVER/MetaTable.csv" 
fn.res <- "RESULTS/ResultsEdit.csv" 

## Load the data 
rov <- read.csv(fn.rov) 
res <- read.csv(fn.res) 

rov.fn <- rov$Filename 
res.fn <- res$Filename 

## the time that we will use is the start time of recording. to use
## end time change 'Start_Time' to 'End_Time'
time.st <- rov$Start_Time 

n <- length(res.fn) 
appTime <- rep(NA, n) 

for(i in 1:n) 
{
  ind <- which(rov.fn == res.fn[i]) 
  appTime[i] <- as.character(time.st[ind])

}


## Add the time to the 3rd column between Filename and latitude 
n <- dim(res)[2] 
cn <- colnames(res) 

res.new <- cbind(res[,1:2], appTime, res[3:n])
cn <- c(cn[1:2], "Time", cn[3:n])

colnames(res.new) <- cn

write.csv(res.new, fn.res, quote = F, row.names = F) 
