#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=16000M,h_rt=4:00:00
#$ -M malvarez@mail
#  Notify at beginning and end of job
#$ -m n
#$ -r n
#$ -o reorder.sh.log.$TASK_ID
#$ -t 1-4

# Have to give the same ordering of chromosomes as given by the hg19 reference sorted karyotypically
# Found in this file /u/project/pajukant/malvarez/data/broad_gatk_bundle/hg19/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf

java="/u/local/apps/java/jre1.8.0_77/bin/java"
picard="../picard.jar"

bamdir=../../data/processed/adi_bl_varcall_bams/

ref="/u/project/pajukant/malvarez/data/hg19/chromosomes/hg19.ucsc.fa"
# sample=$( cat ../../data/ref/mex_adi_samples.txt | awk "NR == $SGE_TASK_ID" - )
sample=$( awk "NR == $SGE_TASK_ID" samples2do.txt )
inbam="${bamdir}/${sample}/${sample}_Aligned.sortedByCoord.out.RG.dedup.bam"
outbam="${bamdir}/${sample}/${sample}_Aligned.out.RG.dedup.sort_karyo.bam"

mkdir -p ${bamdir}/${sample}/

$java -jar ../picard.jar ReorderSam \
	INPUT=$inbam \
	OUTPUT=$outbam \
	REFERENCE=$ref \
	ALLOW_INCOMPLETE_DICT_CONCORDANCE=true
