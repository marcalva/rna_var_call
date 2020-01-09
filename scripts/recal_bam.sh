#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=16000M,h_rt=9:00:00
#$ -M malvarez@mail
#  Notify at beginning and end of job
#$ -m n
#$ -r n
#$ -o recal_bam.sh.log.$TASK_ID
#$ -t 1-184

. /u/local/Modules/default/init/modules.sh
module load java

sample=$( cat ../../data/ref/mex_adi_samples.txt | awk "NR == $SGE_TASK_ID" - )
bamdir=../../data/processed/adi_bl_varcall_bams/

ref="/u/project/pajukant/malvarez/data/hg19/chromosomes/hg19.ucsc.fa"
known="/u/project/pajukant/malvarez/data/broad_gatk_bundle/hg19/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf"
inbam="${bamdir}/${sample}/${sample}_Aligned.out.RG.dedup.sort_karyo.splitntrim.bam"
bqsr="${bamdir}/${sample}/${sample}_Aligned.out.RG.dedup.sort_karyo.splitntrim.recal_table"
outbam="${bamdir}/${sample}/${sample}_Aligned.out.RG.dedup.sort_karyo.splitntrim.recal.bam"

java -jar /u/local/apps/gatk/3.8.0/GenomeAnalysisTK.jar \
	-I $inbam \
	-R $ref \
	-T PrintReads \
	-o $outbam \
	-BQSR $bqsr \
	-U ALLOW_SEQ_DICT_INCOMPATIBILITY
