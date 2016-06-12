
setwd("Data/Easy")
pop_output <- read.table("output_population_tags.txt", header = FALSE,row.names = 1)
tags <- read.table("example2_population_tags.txt", header = FALSE,row.names = 1)
num_populations <- max(tags)

F1_scores_across <- vector(mode = 'numeric',length = num_populations)
num_relevant <- tabulate(tags[,1])
num_retrieved <- tabulate(pop_output[,1])
num_retrieved_and_relevant <- vector(mode = 'numeric',length = num_populations)
for (i in 1:nrow(tags)){
  if (tags[i,] == pop_output[i,]) 
    num_retrieved_and_relevant[tags[i,]] <- num_retrieved_and_relevant[tags[i,]]+1
}
#Calculate F1 separately for each population
for (i in 1:length(F1_scores_across)){
  precision <- (num_retrieved_and_relevant[i])/num_retrieved[i]
  recall <- (num_retrieved_and_relevant[i])/num_relevant[i]
  F1_scores_across[i] <- (2*precision*recall)/(precision + recall)
}
F1 <- mean(F1_scores_across)
print("The F1 Score is")
print(F1)