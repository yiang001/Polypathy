# R script for Bonferroni correction of fastBAT results

# Applying Bonferroni correction to the all individuals 
all_merged <- read.table("/data/scratch/bt23755/all_fbat_merged.txt", header = TRUE)  # Read the merged FASTBAT results for all individuals
all_gene_number <- nrow(all_merged)  # Get the total number of genes (rows) in the dataset
all_merged$pval_bf <- all_merged$Pvalue * all_gene_number  # Apply Bonferroni correction by multiplying the p-value with the number of genes
all_merged$pval_bf <- ifelse(all_merged$pval_bf > 1, 1, all_merged$pval_bf)  # Set corrected p-values greater than 1 to 1 (since p-values cannot exceed 1)
# Save the results with Bonferroni-corrected p-values
write.table(all_merged, file = "/data/scratch/bt23755/all_fbat_bf.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for males
males_merged <- read.table("/data/scratch/bt23755/males_fbat_merged.txt", header = TRUE)  
males_gene_number <- nrow(males_merged)  
males_merged$pval_bf <- males_merged$Pvalue * males_gene_number  
males_merged$pval_bf <- ifelse(males_merged$pval_bf > 1, 1, males_merged$pval_bf) 
write.table(males_merged, file = "/data/scratch/bt23755/males_fbat_bf.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for females
females_merged <- read.table("/data/scratch/bt23755/females_fbat_merged.txt", header = TRUE)  
females_gene_number <- nrow(females_merged)  
females_merged$pval_bf <- females_merged$Pvalue * females_gene_number  
females_merged$pval_bf <- ifelse(females_merged$pval_bf > 1, 1, females_merged$pval_bf)  
write.table(females_merged, file = "/data/scratch/bt23755/females_fbat_bf.txt", sep = "\t", row.names = FALSE, quote = FALSE)
