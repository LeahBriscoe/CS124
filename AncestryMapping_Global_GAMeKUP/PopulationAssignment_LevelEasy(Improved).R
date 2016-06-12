ptm <- proc.time()
setwd("Data/Easy")

#Read in Data
df <- read.table("example2_genotypes.txt", header = TRUE)
pop <- read.table("example2_populations.txt", header = FALSE,row.names = 1)
#Genotpe Tag Output Example for comparison
tags <- read.table("example2_population_tags.txt", header = FALSE,row.names = 1)

# Get mode
getmode <- function(v) {
  numbers_present <- c(0,1) # Only interested in most common 1 or 0, not 2 (hetero)
  numbers_present[which.max(tabulate(match(v, numbers_present)))]
}
#Define parameters
num_snps <- nrow(df)
num_individuals <- nrow(pop)
num_populations <- max(pop)

#Empty matrix for haplotypes for each population
haplo <- matrix(0,nrow = num_snps, ncol = num_populations)

#Tagged with population ID
df_tagged <- cbind(t(df),pop)
#Unknown individuals
unknown_pre <- df_tagged[ which(df_tagged$V2 == -1),]
unknown_pre$V2 <- NULL
unknowns <- data.frame(t(unknown_pre))
#Population Identity of All
pop_output <- pop

for (i in 1:num_populations){
  temp <- subset(df_tagged,df_tagged$V2 == i)
  temp$V2 <- NULL
  haplo[,i] <- t(apply(temp,2,getmode))
}
#Assign population assignments to unknowns
for (i in 1:ncol(unknowns)){
  cor_test <- cor(unknowns[,i],haplo)
  which.max(cor_test)
  name <- colnames(unknowns)[i]
  pop_output[name,]<-which.max(cor_test)
}

# Export data
write.table(pop_output, col.names = FALSE, quote = FALSE, file = "output_population_tags.txt")
runtime <- proc.time() - ptm
print("runtime")
print(runtime)

