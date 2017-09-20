## Pair the rover file with the corresponding base station file
wd <- readLines("~/parentDirectory.txt") 
setwd(wd) 


library(lubridate)
library(purrr)

## The base station files are in a directory named BASE
base.md <- paste(wd, "/BASE/MetaTable.csv", sep = "")  

# ## There may be multiple rover files but they will be in a directory ROVER*
#rover.dir <- dir(wd, pattern = "ROVER", include.dirs = T) 
rover.fn <- paste(wd, "/ROVER/MetaTable.csv", sep = "") 


## Each folder has a MetaTable.csv file that has
##	Filename, Start_Time, End_Time, Antenna_Height, Start_Epoch, End_Epoch
##

base.md <- read.csv(base.md)


#for(i in 1:nR)
#{
  rover.md <- read.csv(rover.fn) 


  nf <- dim(rover.md)[1]
  base.match <- matrix(NA, nf, 1)

  base.md.st <- strptime(base.md$Start_Time, "%Y-%m-%d %T")
  base.md.et <- strptime(base.md$End_Time, "%Y-%m-%d %T") 
  rover.md.st <- strptime(rover.md$Start_Time, "%Y-%m-%d %T")
  rover.md.et <- strptime(rover.md$End_Time, "%Y-%m-%d %T")
  
  for(j in 1:nf) 
  {
      
    L <- rover.md.st[j] <= base.md.et
    LL <- rover.md.et[j] >= base.md.st 
    
    L <- as.logical(L*LL)
    
    #dt <- cbind( difftime(base.md.st, rover.md.st[j]), difftime(base.md.et, rover.md.et[j]) ) 
    #dist.dt <- sqrt( rowSums( dt^2) )
    #base.fn <- base.md$Filename[dist.dt == min(dist.dt)]
    base.fn <- base.md$Filename[L]
    
    if(!is_empty(base.fn))
    {
      base.match[j] <- as.character(base.fn)
    }
  }


  colnames(base.match) <- "Base_File"
  base.match <- data.frame(base.match) 

  rover.md <- cbind( rover.md, base.match)

  write.csv(rover.md, rover.fn, quote = F, row.names = F)
#}


## Make a csv for the dgpsProcess.bsh to get the respective files for the rnx2rtkp CUI
base.nav <- paste( substr(rover.md$Base_File, 1, nchar(as.matrix(rover.md$Base_File) )-1), "n", sep = "") 
filePaths <- cbind(as.matrix(rover.md$Filename), as.matrix(rover.md$Base_File), base.nav )
colnames(filePaths) <- rep("", 3) 
filePaths <- data.frame(filePaths) 

#write.table(filePaths, "RoverBaseNav.csv", quote = F, row.names = F, col.names = F, sep = " ")
write.table(filePaths, "RoverBaseNav.csv", quote = F, row.names = F, col.names = F, sep = ",")
