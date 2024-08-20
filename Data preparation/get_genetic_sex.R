# R scripts to get the genetic sex of each individual and prepare 2 files based on this information; one that only contains the female IDs and one that only contrains the male IDs

# Load the R data object file containing the dataset
load("/data/SBBS-FreydinLab/ukbb/studies/distropy/data/incom.Robj")

# Extract the IDs for males and females from the 'incom' dataset
# - 'males' contains IDs where the gender/sex is "Male"
# - 'females' contains IDs where the gender/sex is "Female"
males <- incom$f.eid[incom$f.22001.0.0 == "Male"]
females <- incom$f.eid[incom$f.22001.0.0 == "Female"]

# Remove any NA values from the 'males' and 'females' vectors
males <- males[!is.na(males)]
females <- females[!is.na(females)]

# Create data frames for males and females with FID and IID columns
males_df <- data.frame(FID = males, IID = males)  # Data frame for males
females_df <- data.frame(FID = females, IID = females)  # Data frame for females

# Save the dataframes to tab-separated text files
write.table(males_df, file = "/data/scratch/bt23755/males.txt", sep = "\t", row.names = FALSE, quote = FALSE)
write.table(females_df, file = "/data/scratch/bt23755/females.txt", sep = "\t", row.names = FALSE, quote = FALSE)
