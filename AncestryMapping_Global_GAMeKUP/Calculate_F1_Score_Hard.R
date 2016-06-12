setwd("Data/Hard")
pop_output <- read.table("output_hard_population_tags.txt", header = FALSE,row.names = 1)
tags <- read.table("example0_population_tags.txt", header = FALSE,row.names = 1)

num_populations_predicted <- max(pop_output)
num_populations <- max(tags)
num_populations


# Reassign group numbers based on individual identities in each group
assign_record <- data.frame()

for (i in 1:num_populations){
  temp <- subset(tags,tags$V2 == i)
  lowest_mismatch <- 1000 # arbitrarily high number
  reassign_population_number <- 1
  
  for (j in 1:num_populations_predicted){
    mismatch <- length(setdiff(row.names(temp),row.names(subset(pop_output,pop_output$V2 == j))))
    if (mismatch < lowest_mismatch){
      lowest_mismatch <- mismatch
      reassign_population_number <- j
    }
  }
  # Reassign based on group with most individuals in common in other dataset
  temp[,1] <- reassign_population_number
  assign_record <- rbind(assign_record, temp)
}
rownames(assign_record)
new_tags <- data.frame(assign_record[order(row.names(assign_record)),])
rownames(new_tags) <- rownames(assign_record)[order(rownames(assign_record))]
tags <- new_tags

#Record F1 scoes for all populations
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