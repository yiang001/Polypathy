# GWAS job script for X chromosome using gcta

#!/bin/bash 
#$ -pe smp 5                        # Request 5 cores for parallel processing
#$ -l h_vmem=10G                    # Request 10GB of virtual memory per core
#$ -l highmem                       # Request access to high-memory nodes
#$ -cwd                            # Run the job in the current working directory
#$ -N GWAS_X                        # Name the job "GWAS_X"
#$ -l h_rt=72:0:0                   # Set a maximum runtime of 72 hours
#$ -j y                             # Merge standard error and standard output into one file
#$ -m beas                          # Send email notifications on job begin, end, and abortion

# Define file paths for input files
phenotype_file="/data/scratch/bt23755/phenotype.txt"   # Path to phenotype data
covariate_file="/data/scratch/bt23755/gsex.txt"        # Path to covariate data (genetic sex)
qcovariate_file="/data/scratch/bt23755/pc_age.txt"     # Path to quantitative covariates (PCs and age)
grm="/data/SBBS-FreydinLab/ukbb/genet/plink/grm/ea/ea_sp_grm" # Path to Genetic Relationship Matrix (GRM)
sample_file="/data/SBBS-FreydinLab/ukbb/genet/ukb22828_c22_b0_v3_s487164.sample" # Path to sample file

# GWAS for all samples (excluding X chromosome)
# Run the GWAS for autosomes with the specified parameters and save the model
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta --fastGWA-mlm \
--grm-sparse $grm \
--pheno $phenotype_file \
--out polypathy_gwas/polypathy_all_X \
--maf 0.001 \
--geno 0.02 \
--info 0.7 \
--covar $covariate_file \
--qcovar $qcovariate_file \
--model-only \ # only the model should be estimated without fitting the phenotype data
--sample $sample_file \
--bgen /data/SBBS-FreydinLab/ukbb/genet/bgen/ukb22828_c22_b0_v3.bgen \
--keep /data/SBBS-FreydinLab/ukbb/genet/ukb22828_cX_b0_v3_s486511.sample \
--thread-num ${NSLOTS}

# GWAS for the X chromosome
# Load the model obtained from the autosomal GWAS and apply it to the X chromosome data
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta \
 --bgen /data/SBBS-FreydinLab/ukbb/genet/bgen/ukb22828_cX_b0_v3.bgen \
--sample /data/SBBS-FreydinLab/ukbb/genet/ukb22828_cX_b0_v3_s486511.sample \
--load-model polypathy_gwas/polypathy_all_X.fastGWA \
--maf 0.001 --geno 0.02 --info 0.7 \
--out polypathy_gwas/polypathy_all_23 \
--thread-num ${NSLOTS}

# GWAS for males only (excluding X chromosome)
# Run the GWAS for autosomes with the specified parameters for males only
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta --fastGWA-mlm \
--grm-sparse $grm \
--pheno $phenotype_file \
--out polypathy_gwas/polypathy_males_X \
--maf 0.001 \
--geno 0.02 \
--info 0.7 \
--qcovar $qcovariate_file \
--model-only \
--sample $sample_file \
--bgen /data/SBBS-FreydinLab/ukbb/genet/bgen/ukb22828_c22_b0_v3.bgen \
--keep /data/SBBS-FreydinLab/ukbb/genet/ukb22828_cX_b0_v3_s486511.sample \
--remove /data/scratch/bt23755/females.txt \ # exclude females by specifying file containing female IDs
--thread-num $NSLOTS

# GWAS for the X chromosome in males
# Load the model from the males' autosomal GWAS and applpy it to the X chromosome data
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta \
--bgen /data/SBBS-FreydinLab/ukbb/genet/bgen/ukb22828_cX_b0_v3.bgen \
--sample /data/SBBS-FreydinLab/ukbb/genet/ukb22828_cX_b0_v3_s486511.sample \
--load-model polypathy_gwas/polypathy_males_X.fastGWA \
--maf 0.001 --geno 0.02 --info 0.7 \
--out polypathy_gwas/polypathy_males_23 \
--thread-num ${NSLOTS}

# GWAS for females only (excluding X chromosome)
# Run the GWAS for autosomes with the specified parameters for females only
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta --fastGWA-mlm \
--grm-sparse $grm \
--pheno $phenotype_file \
--out polypathy_gwas/polypathy_females_X \
--maf 0.001 \
--geno 0.02 \
--info 0.7 \
--qcovar $qcovariate_file \
--model-only \
--sample $sample_file \
--bgen /data/SBBS-FreydinLab/ukbb/genet/bgen/ukb22828_c22_b0_v3.bgen \
--keep /data/SBBS-FreydinLab/ukbb/genet/ukb22828_cX_b0_v3_s486511.sample \
--remove /data/scratch/bt23755/males.txt \ # exclude males by specifying file containing male IDs
--thread-num ${NSLOTS}

# GWAS for the X chromosome in females
# Load the model from the females' autosomal GWAS and applpy it to the X chromosome data
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta \
--bgen /data/SBBS-FreydinLab/ukbb/genet/bgen/ukb22828_cX_b0_v3.bgen \
--sample /data/SBBS-FreydinLab/ukbb/genet/ukb22828_cX_b0_v3_s486511.sample \
--load-model polypathy_gwas/polypathy_females_X.fastGWA \
--maf 0.001 --geno 0.02 --info 0.7 \
--out polypathy_gwas/polypathy_females_23 \
--thread-num ${NSLOTS}
