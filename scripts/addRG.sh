#!/bin/bash
#$ -cwd
#$ -j y
#$ -o addRG.sh.log.$TASK_ID
#$ -l h_data=16000M,h_rt=1:00:00
#$ -t 1-184
#$ -M malvarez@mail
#  Notify at beginning and end of job
#$ -m n
#$ -r n

sample=$( cat ../../data/ref/mex_adi_samples.txt | awk "NR == $SGE_TASK_ID" - )

bamdir=../../data/bam/
outdir=../../data/processed/adi_bl_varcall_bams/

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

picard="../picard.jar"

inbam="${bamdir}/${sample}/${sample}_Aligned.sortedByCoord.out.bam"
outbam="${outdir}/${sample}/${sample}_Aligned.sortedByCoord.out.RG.bam"

mkdir -p ${outdir}/${sample}

java -jar $picard AddOrReplaceReadGroups \
	I=$inbam \
	O=$outbam \
	RGID=${sample} \
	RGLB=lib${sample} \
	RGPL=illumina \
	RGPU=unit1 \
	RGSM=${sample}
