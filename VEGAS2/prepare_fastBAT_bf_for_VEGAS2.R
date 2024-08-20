# R script to convert Bonferroni corrected fastBAT results in VEGAS2 format

# Convert all individuals fastBAT significant results to VEGAS2 format
all <- read.table("/data/scratch/bt23755/all_fbat_bf.txt", header = TRUE)  # Load the Bonferroni-corrected fastBAT results for all individuals
all_veg <- all[all$pval_bf <= 0.05, c("Gene", "pval_bf")]  # Filter for significant results (p-value <= 0.05) and select columns "Gene" and "pval_bf"
write.table(all_veg, file = "/data/scratch/bt23755/all_fbat_bf_for_vegas.txt", sep = "\t", row.names = FALSE, quote = FALSE, col.names = FALSE)  # Save the results in VEGAS2 format (no column names)

# Repeat for males
males <- read.table("/data/scratch/bt23755/males_fbat_bf.txt", header = TRUE)  
males_veg <- males[males$pval_bf <= 0.05, c("Gene", "pval_bf")]  
write.table(males_veg, file = "/data/scratch/bt23755/males_fbat_bf_for_vegas.txt", sep = "\t", row.names = FALSE, quote = FALSE, col.names = FALSE)  
# Repeat for females
females <- read.table("/data/scratch/bt23755/females_fbat_bf.txt", header = TRUE)  
females_veg <- females[females$pval_bf <= 0.05, c("Gene", "pval_bf")]  
write.table(females_veg, file = "/data/scratch/bt23755/females_fbat_bf_for_vegas.txt", sep = "\t", row.names = FALSE, quote = FALSE, col.names = FALSE) 
