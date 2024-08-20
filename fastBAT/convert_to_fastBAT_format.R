# R script to convert the merged GWAS output files to fastBAT format

# Read the merged GWAS results for all individuals
all_merged <- read.table("/data/scratch/bt23755/all_merged.txt", header = TRUE)

# Rearrange and rename columns to match FASTBAT requirements
all_merged_2 <- data.frame(
  SNP = all_merged$SNP,      # SNP identifier
  A1 = all_merged$A1,        # Effect allele
  A2 = all_merged$A2,        # Alternative allele
  FREQ = all_merged$AF1,     # Allele frequency of the effect allele
  BETA = all_merged$BETA,    # Effect size (beta)
  SE = all_merged$SE,        # Standard error of the effect size
  P = all_merged$P,          # P-value of the association
  N = all_merged$N           # Sample size
)

# Save the converted data to a new file 
write.table(all_merged_2, file = "/data/scratch/bt23755/all_merged_for_fastbat.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for males
males_merged <- read.table("/data/scratch/bt23755/males_merged.txt", header = TRUE)
males_merged_2 <- data.frame(
  SNP = males_merged$SNP,    # SNP identifier
  A1 = males_merged$A1,      # Effect allele
  A2 = males_merged$A2,      # Alternative allele
  FREQ = males_merged$AF1,   # Allele frequency of the effect allele
  BETA = males_merged$BETA,  # Effect size (beta)
  SE = males_merged$SE,      # Standard error of the effect size
  P = males_merged$P,        # P-value of the association
  N = males_merged$N         # Sample size
)
write.table(males_merged_2, file = "/data/scratch/bt23755/males_merged_for_fastbat.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for females
females_merged <- read.table("/data/scratch/bt23755/females_merged.txt", header = TRUE)
females_merged_2 <- data.frame(
  SNP = females_merged$SNP,  # SNP identifier
  A1 = females_merged$A1,    # Effect allele
  A2 = females_merged$A2,    # Alternative allele
  FREQ = females_merged$AF1, # Allele frequency of the effect allele
  BETA = females_merged$BETA,# Effect size (beta)
  SE = females_merged$SE,    # Standard error of the effect size
  P = females_merged$P,      # P-value of the association
  N = females_merged$N       # Sample size
)
write.table(females_merged_2, file = "/data/scratch/bt23755/females_merged_for_fastbat.txt", sep = "\t", row.names = FALSE, quote = FALSE)
