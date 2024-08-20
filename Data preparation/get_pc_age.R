# R script to get the continuous covariates (10 PCs and age)

# Load the R data object file containing the dataset
load("/data/SBBS-FreydinLab/ukbb/studies/distropy/data/incom.Robj")

# Create a new data frame 'total_df' with specific columns from the 'incom' dataset

total_df <- data.frame(
  FID = incom[,1],                     # Family ID (FID)
  IID = incom[,1],                     # Individual ID (IID)
  age = incom[,"f.21022.0.0"],         # Age
  pc1 = incom[,"f.22009.0.1"],         # Principal Component 1
  pc2 = incom[,"f.22009.0.2"],         # Principal Component 2
  pc3 = incom[,"f.22009.0.3"],         # Principal Component 3
  pc4 = incom[,"f.22009.0.4"],         # Principal Component 4
  pc5 = incom[,"f.22009.0.5"],         # Principal Component 5
  pc6 = incom[,"f.22009.0.6"],         # Principal Component 6
  pc7 = incom[,"f.22009.0.7"],         # Principal Component 7
  pc8 = incom[,"f.22009.0.8"],         # Principal Component 8
  pc9 = incom[,"f.22009.0.9"],         # Principal Component 9
  pc10 = incom[,"f.22009.0.10"]        # Principal Component 10
)

# Save the 'total_df' data frame to a tab-separated text file
write.table(total_df, file="/data/scratch/bt23755/pc_age.txt", sep = "\t", row.names = FALSE, quote = FALSE)
