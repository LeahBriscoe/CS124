ptm <- proc.time()
setwd("Data/Hard")

#Read in Data
df <- read.table("example0_genotypes.txt", header = TRUE)
#Transpose for Kmeans
df <- data.frame(t(df))

wss <- (nrow(df)-1)*sum(apply(df,2,var))
system.time(for (i in 2:15) wss[i] <- sum(kmeans(df, 
                                                 centers=i)$withinss))
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")


#Evaluate appropriate number of clusters
runtime <- proc.time() - ptm
ptm2 <- proc.time()
fit <- kmeans(df, 8)
#aggregate(df,by=list(fit$cluster),FUN=mean)
df_2 <- data.frame(df, fit$cluster)
df_2[,ncol(df_2)]

runtime2 <- proc.time() - ptm2
print("runtime")
print(runtime+runtime2)