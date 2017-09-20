##

fn <- "MetaTable.csv" 
d <- read.csv(fn) 

d <- cbind(as.matrix(d$Filename), as.matrix(d$Antenna_Height) ) 
colnames(d) <- c("", "") 

write.table(d, "FileHeight.csv", row.names = F, quote = F, col.names = F, sep = ",")
