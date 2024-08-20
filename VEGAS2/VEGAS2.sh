# VEGAS2 Pathway analysis job script

#!/bin/bash
#$ -l h_vmem=300G           # Request 300GB of virtual memory for the job to handle large data processing
#$ -l highmem               # Specify that the job requires high memory nodes
#$ -cwd                     # Set the working directory to the directory from which the job was submitted
#$ -j y                     # Merge standard error and standard output streams into a single file
#$ -l h_rt=120:0:0          # Set the maximum run time to 120 hours
#$ -N vegas_path            # Name the job "vegas_path"
#$ -m beas                  # Send email notifications at the beginning, end, and if the job is aborted

vdir=/data/scratch/bt23755/vegas/vegas2  # Set the directory where VEGAS2 software and related files are located

cd /data/scratch/bt23755/vegas/          # Change to the directory where the input files are located

module add perl                       # Load Perl module required by VEGAS2
module add R/4.2.2                    # Load R version 4.2.2
module add plink/1.9-170906           # Load PLINK version 1.9 

## Run VEGAS2 for all individuals
$vdir/vegas2v2 -P -geneandp all_fbat_bf_for_vegas.txt \ # Specifying the gene input file
-geneandpath $vdir/biosystems20160324.vegas2pathSYM \ # Path to the VEGAS2 pathway definitions file
-glist $vdir/glist-hg19 \ # Specify the gene list file required by VEGAS2
-out all_vegas_pathway # Set the output file prefix 

## Repeat for males
$vdir/vegas2v2 -P -geneandp males_fbat_bf_for_vegas.txt \
-geneandpath $vdir/biosystems20160324.vegas2pathSYM \
-glist $vdir/glist-hg19 \
-out males_vegas_pathway

## Repeat for females
$vdir/vegas2v2 -P -geneandp females_fbat_bf_for_vegas.txt \
-geneandpath $vdir/biosystems20160324.vegas2pathSYM \
-glist $vdir/glist-hg19 \
-out females_vegas_pathway
