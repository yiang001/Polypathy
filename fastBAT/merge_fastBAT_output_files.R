# R script to merge .gene.fastbat files for total, males & females

# Define the directory containing fastBAT results for all individuals
directory <- "/data/scratch/bt23755/fastbat_all"

# List all files matching the pattern "^all_fbat_.*\\.gene.fastbat$" in the directory
all_files <- list.files(directory, pattern = "^all_fbat_.*\\.gene.fastbat$", full.names = TRUE)

# Read each file into a list of data frames
all_list <- lapply(all_files, read.table, header = TRUE)

# Combine all data frames into a single data frame
all_merged <- do.call(rbind, all_list)

# Save the merged data frame to a file
write.table(all_merged, file = "/data/scratch/bt23755/all_fbat_merged.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for females
directory <- "/data/scratch/bt23755/fastbat_females/"
females_files <- list.files(directory, pattern = "^females_fbat_.*\\.gene.fastbat$", full.names = TRUE)
females_list <- lapply(females_files, read.table, header = TRUE)
females_merged <- do.call(rbind, females_list)
write.table(females_merged, file = "/data/scratch/bt23755/females_fbat_merged.txt", sep = "\t", row.names = FALSE, quote = FALSE)

# Repeat for males
directory <- "/data/scratch/bt23755/fastbat_males/"
males_files <- list.files(directory, pattern = "^males_fbat_.*\\.gene.fastbat$", full.names = TRUE)
males_list <- lapply(males_files, read.table, header = TRUE)
males_merged <- do.call(rbind, males_list)
write.table(males_merged, file = "/data/scratch/bt23755/males_fbat_merged.txt", sep = "\t", row.names = FALSE, quote = FALSE)
