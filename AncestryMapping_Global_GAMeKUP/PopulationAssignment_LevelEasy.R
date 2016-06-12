ptm <- proc.time()
setwd("Data/Easy")

#Read in Data
df <- read.table("example2_genotypes.txt", header = TRUE)
pop <- read.table("example2_populations.txt", header = FALSE,row.names = 1)
#Genotpe Tag Output Example for comparison
#tags <- read.table("example2_population_tags.txt", header = FALSE,row.names = 1)

#Define parameters
num_snps <- nrow(df)
num_individuals <- nrow(pop)
num_populations <- max(pop)

#Tagged with population ID
df_tagged <- cbind(t(df),pop)
#Unknown individuals
unknown_pre <- df_tagged[ which(df_tagged$V2 == -1),]
unknown_pre$V2 <- NULL
unknowns <- data.frame(t(unknown_pre))
#Population Identity of All
pop_output <- pop

local_max_cor <- vector(mode = 'numeric',length = num_populations)
sampled_data <- df_tagged[sample( which(df_tagged$V2 == 4), round(0.2*length(which(df_tagged$V2 == 4)))), ]
sampled_data$V2 <- NULL
sampled_data_t <- data.frame(t(sampled_data))
cor_test <- cor(unknowns[,2],sampled_data_t)
local_max_cor[2] <- max(cor_test)
local_max_cor <- do.call(data.frame,lapply(local_max_cor, function(x) replace(x, is.infinite(x),NA)))
which.max(local_max_cor)
as.list(c(1,2,3))
#Assign population assignments to unknowns
for (i in 1:ncol(unknowns)){
  local_max_cor <- vector(mode = 'numeric',length = num_populations)
  for (j in 1:num_populations){
    sampled_data <- df_tagged[sample( which(df_tagged$V2 == j), round(0.1*length(which(df_tagged$V2 == j)))), ]
    sampled_data$V2 <- NULL
    sampled_data_t <- data.frame(t(sampled_data))
    cor_test <- cor(unknowns[,i],sampled_data_t)
    cor_test[is.infinite(cor_test)] <- 0 
    #cor_test <- do.call(data.frame,lapply(cor_test, function(x) replace(x, is.infinite(x),0)))
    local_max_cor[j] <- max(cor_test)
  }
  name <- colnames(unknowns)[i]
  #is.na(local_max_cor) <- sapply(local_max_cor, is.infinite)
  #local_max_cor <- do.call(data.frame,lapply(local_max_cor, function(x) replace(x, is.infinite(x),0)))
  pop_output[name,]<-which.max(local_max_cor)
}
# Export data
write.table(pop_output, col.names = FALSE, quote = FALSE, file = "output_population_tags.txt")
runtime <- proc.time() - ptm
print("runtime")
print(runtime)
?proc.time()
