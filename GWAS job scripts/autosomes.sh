# GWAS job script for autosomes using gcta

#!/bin/bash
#$ -pe smp 5                        # Request 5 cores for parallel processing
#$ -l h_vmem=10G                    # Request 10GB of virtual memory per core
#$ -l highmem                       # Request access to high memory nodes
#$ -cwd                             # Run the job in the current working directory
#$ -N GWAS_autosomes                # Name the job "GWAS_autosomes"
#$ -l h_rt=72:0:0                   # Set a maximum runtime of 72 hours
#$ -t 1-22                          # Specify that this is a range job to run over tasks 1 through 22
#$ -j y                             # Merge standard error and standard output into one file
#$ -m beas                          # Send email on begin, end, and abortion of job

# Define file paths for input files
phenotype_file="/data/scratch/bt23755/phenotype.txt"   # Path to phenotype data
covariate_file="/data/scratch/bt23755/gsex.txt"        # Path to categorical covariate data (genetic sex)
qcovariate_file="/data/scratch/bt23755/pc_age.txt"     # Path to quantitative covariates (PCs and age)
grm="/data/SBBS-FreydinLab/ukbb/genet/plink/grm/ea/ea_sp_grm" # Path to Genetic Relationship Matrix (GRM)
sample_file="/data/SBBS-FreydinLab/ukbb/genet/ukb22828_c22_b0_v3_s487164.sample" # Path to sample file

# All samples
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta --fastGWA-mlm \ # Specify the type of GWAS to run
--grm-sparse $grm \ # Use the specified Genetic Relationship Matrix
--pheno $phenotype_file \ # Provide the phenotype data
--out polypathy_gwas/polypathy_all_${SGE_TASK_ID} \ # Specify the output file prefix for results, with ${SGE_TASK_ID} representing the current autosome being analyzed.
--maf 0.001 \ # Set the minor allele frequency threshold
--geno 0.02 \ # Set the missing genotype rate threshold
--info 0.7 \ # Set the information score threshold for variant inclusion
--covar $covariate_file \ # Provide the covariate file
--qcovar $qcovariate_file \ # Provide the quantitative covariate file
--sample $sample_file \ # Specify the sample file
--bgen /data/SBBS-FreydinLab/ukbb/genet/bgen/ukb22828_c${SGE_TASK_ID}_b0_v3.bgen \ # Path to the BGEN file for the current autosome
--thread-num ${NSLOTS} # Use the number of cores allocated to the job

# Males only
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta --fastGWA-mlm \
--grm-sparse $grm \
--pheno $phenotype_file \
--out polypathy_gwas/polypathy_males_${SGE_TASK_ID} \
--keep /data/scratch/bt23755/males.txt \
--maf 0.001 \
--geno 0.02 \
--info 0.7 \
--qcovar $qcovariate_file \
--sample $sample_file \
--bgen /data/SBBS-FreydinLab/ukbb/genet/bgen/ukb22828_c${SGE_TASK_ID}_b0_v3.bgen \
--thread-num ${NSLOTS}

# Females only
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta --fastGWA-mlm \
--grm-sparse $grm \
--pheno $phenotype_file \
--out polypathy_gwas/polypathy_females_${SGE_TASK_ID} \
--keep /data/scratch/bt23755/females.txt \
--maf 0.001 \
--geno 0.02 \
--info 0.7 \
--qcovar $qcovariate_file \
--sample $sample_file \
--bgen /data/SBBS-FreydinLab/ukbb/genet/bgen/ukb22828_c${SGE_TASK_ID}_b0_v3.bgen \
--thread-num ${NSLOTS}
