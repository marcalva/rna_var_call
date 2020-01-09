#!/bin/bash
#$ -cwd
#$ -j y
#$ -v QQAPP=openmp
#$ -l h_data=16000M,h_rt=4:00:00
#$ -M malvarez@mail
#  Notify at beginning and end of job
#$ -m n
#$ -r n
#$ -o callv.sh.log.$TASK_ID
#$ -t 1-184

. /u/local/Modules/default/init/modules.sh
module load java

sample=$( cat ../../data/ref/mex_adi_samples.txt | awk "NR == $SGE_TASK_ID" - )
bamdir=../../data/processed/adi_bl_varcall_bams/

ref="/u/project/pajukant/malvarez/data/hg19/chromosomes/hg19.ucsc.fa"
known="/u/project/pajukant/malvarez/data/broad_gatk_bundle/hg19/dbsnp_138.hg19.vcf"
inbam="${bamdir}/${sample}/${sample}_Aligned.out.RG.dedup.sort_karyo.splitntrim.recal.bam"

vcfdir="../../data/processed/adi_bl_varcall_vcfs/"
mkdir -p ${vcfdir}/${sample}/

out=${vcfdir}/${sample}/${sample}.gatk.vcf

java -jar /u/local/apps/gatk/3.8.0/GenomeAnalysisTK.jar \
	-R $ref \
	-T HaplotypeCaller \
	-I $inbam \
	--dbsnp $known \
	-stand_call_conf 20.0 \
	-dontUseSoftClippedBases \
	-o $out
