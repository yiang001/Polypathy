# Job script to run fastBAT

#!/bin/bash 
#$ -pe smp 5                 # Request 5 CPU cores for parallel processing
#$ -l h_vmem=10G             # Request 10GB of virtual memory per CPU core
#$ -l highmem                 # Request high memory nodes
#$ -cwd                       # Run the job from the current working directory
#$ -t 1-23                    # Create an array job with tasks from 1 to 23 (for each chromosome)
#$ -N fastbat                 # Job name
#$ -l h_rt=12:0:0             # Request 12 hours of runtime
#$ -j y                       # Merge standard output and error output into a single file
#$ -m beas                    # Send email when the job begins, ends, or is aborted

# Run fastBAT for all individuals
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta \
--bfile /data/SBBS-FreydinLab/ukbb/genet/plink/ref/ea/ukbb.25k.ea.chr${SGE_TASK_ID}  \ # Input PLINK binary files for the current chromosome
--fastBAT /data/scratch/bt23755/all_merged_for_fastbat.txt \ # Input file in fastBAT format for all individuals
--fastBAT-gene-list gene_list.txt  \ # List of genes to include in the analysis
--out fastbat_all/all_fbat_${SGE_TASK_ID} \ # Output file prefix for all individuals
--maf 0.01 \ # Minimum allele frequency filter
--chr ${SGE_TASK_ID} \ # Chromosome number (set by the job array task ID)
--thread-num ${NSLOTS} # Number of threads to use for parallel processing

# Repeat for males
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta \
--bfile /data/SBBS-FreydinLab/ukbb/genet/plink/ref/ea/ukbb.25k.ea.chr${SGE_TASK_ID}  \ 
--fastBAT /data/scratch/bt23755/males_merged_for_fastbat.txt \ 
--fastBAT-gene-list gene_list.txt  \ 
--out fastbat_males/males_fbat_${SGE_TASK_ID} \ 
--maf 0.01 \ 
--chr ${SGE_TASK_ID} \ 
--thread-num ${NSLOTS} 

# Repeat for females
/data/SBBS-FreydinLab/tools/gcta-1.94.1-linux-kernel-3-x86_64/gcta \
--bfile /data/SBBS-FreydinLab/ukbb/genet/plink/ref/ea/ukbb.25k.ea.chr${SGE_TASK_ID}  \ 
--fastBAT /data/scratch/bt23755/females_merged_for_fastbat.txt \ 
--fastBAT-gene-list gene_list.txt \
--out fastbat_females/females_fbat_${SGE_TASK_ID} \ 
--maf 0.01 \ 
--chr ${SGE_TASK_ID} \ 
--thread-num ${NSLOTS} 
