# GAMe KUP: Global Ancestry Mapping in Known and Unknown Populations
(Final Project for CS 124: Computational Genetics)
Contains R code and data files

## Files
### PopulationAssignment_LevelEasy.R 
Takes sampled individuals from the known populations and all individuals in known populations to create a correlation matrix. Populations are selected based on correlations that exceed the cutoff.  

### PopulationAssignment_LevelEasy(Improved).R 
Similar method to the easy script, but uses only haplotypes for correlation matrix.

### PopulationAssignment_LevelHard.R 
Clusters populations by k-means clustering. 

### PopulationAssignment_LevelHard(Improved).R 
Principal components analysis is used to determine optimal number of clusters, then k-means is used for the clustering step. 

### Calculate_F1_Score_easy.R 
Script calculates F1 score by comparing answer file to output file from PopulationAssignment_LevelEasy.R. The output file displays a list of individuals assigned to numbers that indicate known populations. 

### Calculate_F1_Score_hard.R 
Because we are clustering the individuals into unknown populations, we cannot compare our solution to the actual solution without identifying which populations in our solution correspond to the populations in the actual solution. Converts answer file to individuals assignments that match the output file from PopulationAssignment_LevelHard.R.

## Progress Timeline:
[Start] 
Search HapMap and 1000 Genomes Project for examples of populations that have been studied 
Progress: 5% Completion

Practice working with genotype data efficient downloading of data into R
Progress: 10% Completion

Try simple haplotype phasing 
Progress: 15% Progress

Use correlation matrix to make predictions on easy data
Progress: 50% Progress 

Testing accuracy measure: F1 score. 
100% Complete
[Finish]
