##
# 
# wd <- readLines("~/parentDirectory.txt") 
# wd <- paste(wd, "/RESULTS", sep = "") 
# 
# setwd(wd) 

fn <- "ResultsEdit.csv" 

## Read the data
D <- read.csv(fn) 


## Assign the lat/long data into vectors to plot 
x <- D$longitude.deg.
y <- D$latitude.deg.

cn <- colnames(D)

if( as.logical(sum(as.numeric(cn == "ID") ) ) )
{
  namebank <- as.character(D$ID)
  ## if ID is already determined then it will be the first column
  D <- D[,-1]
  cn <- cn[-1]
}else
{
  namebank <- rep("NA", length(x) )
}

plot(x, y )
text(x, y, labels=namebank, cex= 0.7, pos=3)

## Ask the user if we need to assign 
N <- readline(prompt="Number of points to pick?")
N <- as.numeric(N)
while(N!=0)
{
  pts <- identify(x, y, n=N)  
  id <- readline(prompt="What is the name of this point?")
  namebank[pts] <- id
  plot(x, y)
  text(x, y, labels=namebank, cex= 0.7, pos=3)
  N <- readline(prompt="Number of points to pick?")
  N <- as.numeric(N)

}


cn <- c("ID", cn)
D <- cbind(namebank, D)
colnames(D) <- cn
write.csv(D, fn, row.names = F, quote = F)
