# R sript for Bonferroni correction of genetic correlations results

# Load the dataset for all individuals
all <- read.csv("/data/scratch/bt23755/batch_gen_corr_ctgvl/all_ldsc.csv")

# Remove rows with missing values
all_complete <- all[complete.cases(all), ]

# Number of rows (genes) in the dataset
all_gene_number <- nrow(all_complete)
# Apply Bonferroni correction to p-values
all_complete$pval_bf <- all_complete$p * all_gene_number
# Cap p-values at 1 (as p-values cannot exceed 1)
all_complete$pval_bf <- ifelse(all_complete$pval_bf > 1, 1, all_complete$pval_bf)
# Identify significant p-values (p-value ≤ 0.05)
all_complete$pval_bf < 0.05
# Extract significant results with relevant columns
all_sig <- all_complete[all_complete$pval_bf <= 0.05, c("phenotype", "rg", "se", "pval_bf")]
# Sort significant results by Bonferroni-corrected p-value
all_sig <- all_sig[order(all_sig$pval_bf), ]

# Save the significant results to a file
write.table(all_sig, file = "/data/scratch/bt23755/all_ctgvl_bf.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for females
females <- read.csv("/data/scratch/bt23755/batch_gen_corr_ctgvl/females_ldsc.csv")
females_complete <- females[complete.cases(females), ]
females_gene_number <- nrow(females_complete)
females_complete$pval_bf <- females_complete$p * females_gene_number
females_complete$pval_bf <- ifelse(females_complete$pval_bf > 1, 1, females_complete$pval_bf)
females_complete$pval_bf < 0.05
females_sig <- females_complete[females_complete$pval_bf <= 0.05, c("phenotype", "rg", "se", "pval_bf")]
females_sig <- females_sig[order(females_sig$pval_bf), ]
write.table(females_sig, file = "/data/scratch/bt23755/females_ctgvl_bf.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for males
males <- read.csv("/data/scratch/bt23755/batch_gen_corr_ctgvl/males_ldsc.csv")
males_complete <- males[complete.cases(males), ]
males_gene_number <- nrow(males_complete)
males_complete$pval_bf <- males_complete$p * males_gene_number
males_complete$pval_bf <- ifelse(males_complete$pval_bf > 1, 1, males_complete$pval_bf)
males_complete$pval_bf < 0.05
males_sig <- males_complete[males_complete$pval_bf <= 0.05, c("phenotype", "rg", "se", "pval_bf")]
males_sig <- males_sig[order(males_sig$pval_bf), ]
write.table(males_sig, file = "/data/scratch/bt23755/males_ctgvl_bf.txt", sep = "\t", row.names = FALSE, quote = FALSE)
