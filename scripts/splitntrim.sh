#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=16000M,h_rt=4:00:00
#$ -M malvarez@mail
#  Notify at beginning and end of job
#$ -m n
#$ -r n
#$ -o splitntrim.sh.log.$TASK_ID
#$ -t 1-184

. /u/local/Modules/default/init/modules.sh
module load java

java="/u/local/apps/java/jre1.8.0_77/bin/java"
picard="../picard.jar"

bamdir=../../data/processed/adi_bl_varcall_bams/
sample=$( cat ../../data/ref/mex_adi_samples.txt | awk "NR == $SGE_TASK_ID" - )

ref="/u/project/pajukant/malvarez/data/hg19/chromosomes/hg19.ucsc.fa"
inbam="${bamdir}/${sample}/${sample}_Aligned.out.RG.dedup.sort_karyo.bam"
outbam="${bamdir}/${sample}/${sample}_Aligned.out.RG.dedup.sort_karyo.splitntrim.bam"

# Index BAM first
java -jar $picard BuildBamIndex \
	I=$inbam

# I use the -U ALLOW_SEQ_DICT_INCOMPATIBILITY because of a bug stated in the GATK:
# https://software.broadinstitute.org/gatk/documentation/article?id=1328
# Need -U ALL to have ALLOW_N_CIGAR_READS and ALLOW_SEQ_DICT_INCOMPATIBILITY
# Will only use for this
java -jar /u/local/apps/gatk/3.8.0/GenomeAnalysisTK.jar \
	-T SplitNCigarReads \
	-R $ref \
	-I $inbam \
	-o $outbam \
	-rf ReassignOneMappingQuality \
	-RMQF 255 \
	-RMQT 60 \
	-U ALLOW_N_CIGAR_READS
#	-U ALL
#	-U ALLOW_N_CIGAR_READS \
#	-U ALLOW_SEQ_DICT_INCOMPATIBILITY

