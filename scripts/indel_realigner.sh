#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=12000M,h_rt=3:00:00
#$ -M malvarez@mail
#  Notify at beginning and end of job
#$ -m n
#$ -r n
#$ -o /dev/null
#$ -t 1-184

. /u/local/Modules/default/init/modules.sh
module load java

SGE_TASK_ID=1
sample=$( cat ../../data/ref/mex_adi_samples.txt | awk "NR == $SGE_TASK_ID" - )
bamdir=../../data/processed/adi_bl_varcall_bams/

ref="/u/project/pajukant/malvarez/data/hg19/chromosomes/hg19.ucsc.ERCC.fa"
intervals="/u/project/pajukant/malvarez/data/bundle/Mills_and_1000G_gold_standard.indels.hg38.mainchr.intervals"
known="/u/project/pajukant/malvarez/data/broad_gatk_bundle/hg19/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf.gz"
inbam="${bamdir}/${sample}/${sample}_Aligned.sortedByCoord.out.RG.dedup.splitntrim.bam"
outbam="${bamdir}/${sample}/${sample}.indel_realigned.bam"
java -jar /u/local/apps/gatk/3.8.0/GenomeAnalysisTK.jar \
	-I $inbam \
	-R $ref \
	-T IndelRealigner \
	-targetIntervals $intervals \
	-o $outbam \
	-known $known \
	-U ALLOW_SEQ_DICT_INCOMPATIBILITY
