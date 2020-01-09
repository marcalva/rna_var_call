#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=16000M,h_rt=3:00:00
#$ -M malvarez@mail
#  Notify at beginning and end of job
#$ -m n
#$ -r n
#$ -o varflt.sh.log.$TASK_ID
# #$ -t 1-184

. /u/local/Modules/default/init/modules.sh
module load java

for SGE_TASK_ID in $( seq 1 184 ); do

sample=$( cat ../../data/ref/mex_adi_samples.txt | awk "NR == $SGE_TASK_ID" - )
bamdir=../../data/processed/adi_bl_varcall_bams/
vcfdir="../../data/processed/adi_bl_varcall_vcfs/"

ref="/u/project/pajukant/malvarez/data/hg19/chromosomes/hg19.ucsc.fa"
known="/u/project/pajukant/malvarez/data/broad_gatk_bundle/hg19/dbsnp_138.hg19.vcf"
invcf="${vcfdir}/${sample}/${sample}.gatk.vcf"
out="${vcfdir}/${sample}/${sample}.gatk.flt.vcf"

mkdir -p ${vcfdir}/${sample}/

java -jar /u/local/apps/gatk/3.8.0/GenomeAnalysisTK.jar \
	-R $ref \
	-T VariantFiltration \
	-V $invcf \
	-window 35 \
	-cluster 3 \
	-filterName FS \
	-filter "FS > 30.0" \
	-filterName QD \
	-filter "QD < 2.0" \
	-o $out

done
