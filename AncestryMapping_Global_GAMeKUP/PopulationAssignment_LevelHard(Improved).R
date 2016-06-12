ptm <- proc.time()
setwd("Data/Hard")

#Read in Data
df <- read.table("example0_genotypes.txt", header = TRUE)
#Transpose for Kmeans
df <- data.frame(t(df))

# Use PCA to select number of clusters
pc <- princomp(df)
plot(pc, main = "PCA")
plot(pc, type='l',main = "PCA")
runtime <- proc.time() - ptm
# Look at plots and select x-axis value with a y-value at the bottom of "elbow" in plot
ptm2 <- proc.time()
user_chosen_number_of_clusters <- 8
# Use K means to do the actual clustering
fit <- kmeans(df, user_chosen_number_of_clusters)
#aggregate(df,by=list(fit$cluster),FUN=mean)
df_2 <- data.frame(df, fit$cluster)

pop_output <- data.frame(df_2[,ncol(df_2)])
row.names(pop_output) <- row.names(df_2)

# Export data
write.table(pop_output, col.names = FALSE, quote = FALSE, file = "output_hard_population_tags.txt")
runtime2 <- proc.time() - ptm2
print("runtime")
print(runtime + runtime2)




