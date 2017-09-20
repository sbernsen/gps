##

wdRes <- getwd()
pattern <- "*.RESULTS.txt"
fn <- dir(wdRes, pattern)
sfn <- "ResultsRaw.csv"
sfn2 <- "ResultsEdit.csv"
hfn <- "HeaderFields.csv"

Filename <- substr(fn, 1, ( nchar(fn)-nchar(pattern)+1 ) )

n <- length(fn)
D <- character(n)
for(i in 1:n)
{
  d <- readLines(fn[i])
  m <- length(d) 
  D[i] <- d[m]
  
}

ind <- which( substr(d, 1, 7) == "%  GPST" )
headerFields <- d[ind]
write.table(headerFields, hfn, row.names = F, col.names = F, quote = F)

D <- cbind(Filename, D) 
D <- data.frame(D)
colnames(D) <- c("", "")
write.table(D, sfn, row.names = F, col.names = F, sep = " ", quote=F)


D <- read.table(sfn)
H <- read.table(hfn)

## The first value is a comment character
H <- H[-1] 

rmcols <- c(-1, -5, -6, -13, -14)
H <- H[rmcols]

rmcols <- c(-2, -3, -7, -8, -15, -16) 
D <- D[,rmcols] 

H <- c("Filename", as.matrix(H) ) 

colnames(D) <- H
write.csv(D, sfn2, quote=F, row.names = F)
