# R script to convert the merged GWAS output files to the CTG-VL format in order to run genetic correlations

# Read the merged GWAS results for all individuals
all_merged <- read.table("/data/scratch/bt23755/all_merged.txt", header = TRUE)
# Create a new data frame with columns formatted for CTG-VL
all_merged_new <- data.frame(
  CHR = all_merged$CHR,    # Chromosome number
  BP = all_merged$POS,     # Base Pair position
  SNP = all_merged$SNP,    # SNP identifier
  A1 = all_merged$A1,      # Allele 1
  A2 = all_merged$A2,      # Allele 2
  FREQ = all_merged$AF1,   # Allele frequency for A1
  BETA = all_merged$BETA,  # Effect size (Beta)
  SE = all_merged$SE,      # Standard error
  P = all_merged$P,        # P-value
  N = all_merged$N         # Sample size
)
# Save the converted data to a new file for CTG-VL format
write.table(all_merged_new, file = "/data/scratch/bt23755/all_merged_for_ctg.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for males
males_merged <- read.table("/data/scratch/bt23755/males_merged.txt", header = TRUE)
males_merged_new <- data.frame(
  CHR = males_merged$CHR,
  BP = males_merged$POS,
  SNP = males_merged$SNP,
  A1 = males_merged$A1,
  A2 = males_merged$A2,
  FREQ = males_merged$AF1,
  BETA = males_merged$BETA,
  SE = males_merged$SE,
  P = males_merged$P,
  N = males_merged$N
)
write.table(males_merged_new, file = "/data/scratch/bt23755/males_merged_for_ctg.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for females
females_merged <- read.table("/data/scratch/bt23755/females_merged.txt", header = TRUE)
females_merged_new <- data.frame(
  CHR = females_merged$CHR,
  BP = females_merged$POS,
  SNP = females_merged$SNP,
  A1 = females_merged$A1,
  A2 = females_merged$A2,
  FREQ = females_merged$AF1,
  BETA = females_merged$BETA,
  SE = females_merged$SE,
  P = females_merged$P,
  N = females_merged$N
)
write.table(females_merged_new, file = "/data/scratch/bt23755/females_merged_for_ctg.txt", sep = "\t", row.names = FALSE, quote = FALSE)
