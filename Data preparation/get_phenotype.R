#R script to sum up the ICD10 code diagnoses of each individual and prepare the phenotype file required for the GWAS

# Load the R data object file containing the dataset
load("/data/SBBS-FreydinLab/ukbb/studies/distropy/data/dsets/icd10_2_18052023.Robj")

# Calculate the sum of values across each row, excluding the first column and assign it to a new column called 'Phenotype'
icd10.2$Phenotype <- rowSums(icd10.2[, -1])

# Create a new data frame with columns for FID, IID, and the calculated Phenotype
final_df <- data.frame(FID = icd10.2$id, IID = icd10.2$id, Phenotype = icd10.2$Phenotype)

# Create a histogram of the Phenotype values and save it as a PNG file
png("histogram.png")
hist(icd10.2$Phenotype, main = "Histogram of Phenotype", xlab = "Phenotype Values", ylab = "Frequency")
dev.off()

# Replace Phenotype values greater than 60 with NA
final_df$Phenotype[final_df$Phenotype > 60] <- NA

# Save the updated data frame 
write.table(final_df, file = "/data/scratch/bt23755/phenotype.txt", sep = "\t", row.names = FALSE, quote = FALSE)
