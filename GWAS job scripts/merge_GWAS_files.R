# R script to merge the GWAS output files into three files(total, males and females)

# Set the directory path where the .fastGWA files are located
directory <- "/data/scratch/bt23755/polypathy_gwas"

# List all files in the directory that match the pattern for total GWAS results
all_files <- list.files(directory, pattern = "^polypathy_all_.*\\.fastGWA$", full.names = TRUE)

# Read all listed .fastGWA files into a list of data frames
all_list <- lapply(all_files, read.table, header = TRUE)
# Combine all data frames in the list into a single data frame
all_merged <- do.call(rbind, all_list)
# Save the merged data frame to a tab-separated file
write.table(all_merged, file = "/data/scratch/bt23755/all_merged.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for males
males_files <- list.files(directory, pattern = "^polypathy_males_.*\\.fastGWA$", full.names = TRUE)
males_list <- lapply(males_files, read.table, header = TRUE)
males_merged <- do.call(rbind, males_list)
write.table(males_merged, file = "/data/scratch/bt23755/males_merged.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for females
females_files <- list.files(directory, pattern = "^polypathy_females_.*\\.fastGWA$", full.names = TRUE)
females_list <- lapply(females_files, read.table, header = TRUE)
females_merged <- do.call(rbind, females_list)
write.table(females_merged, file = "/data/scratch/bt23755/females_merged.txt", sep = "\t", row.names = FALSE, quote = FALSE)
