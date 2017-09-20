##

fn <- "MetaTable.csv" 
d <- read.csv(fn) 

d <- as.matrix(d) 
data.entry(d) 

d <- data.frame(d)
write.csv(d, fn, quote = F, row.names = F)