# R script to determine the significant results of VEGAS2 pathway analysis based on empirical p value

# Load all pathway analysis results for all individuals
all <- read.table("/data/scratch/bt23755/vegas/all_vegas_pathway.out", header = TRUE)     

# Identify significant pathways with empirical p-value ≤ 0.05
all$empiricalP < 0.05
# Extract significant pathways along with relevant information
all_sig <- all[all$empiricalP <= 0.05, c("Pathway", "nGenesMapped", "nGenesUsed", "nSamples", "empiricalP", "Genes")]
# Sort significant pathways by empirical p-value in ascending order
all_sig <- all_sig[order(all_sig$empiricalP), ]

# Save the significant pathways for all individuals to a file
write.table(all_sig, file = "/data/scratch/bt23755/all_vegas_path_bf.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for females
females <- read.table("/data/scratch/bt23755/vegas/females_vegas_pathway.out", header = TRUE)     
females$empiricalP < 0.05
females_sig <- females[females$empiricalP <= 0.05, c("Pathway", "nGenesMapped", "nGenesUsed", "nSamples", "empiricalP", "Genes")]
females_sig <- females_sig[order(females_sig$empiricalP), ]
write.table(females_sig, file = "/data/scratch/bt23755/females_vegas_path_bf.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for males
males <- read.table("/data/scratch/bt23755/vegas/males_vegas_pathway.out", header = TRUE)     
males$empiricalP < 0.05
males_sig <- males[males$empiricalP <= 0.05, c("Pathway", "nGenesMapped", "nGenesUsed", "nSamples", "empiricalP", "Genes")]
males_sig <- males_sig[order(males_sig$empiricalP), ]
write.table(males_sig, file = "/data/scratch/bt23755/males_vegas_path_bf.txt", sep = "\t", row.names = FALSE, quote = FALSE)
