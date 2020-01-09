#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=16000M,h_rt=1:00:00,highp
#$ -M malvarez@mail
#  Notify at beginning and end of job
#$ -m n
#$ -r n
#$ -o /dev/null
#$ -t 25-184

cd ../

gatk="${PWD}/gatk-4.1.4.1/gatk"

bamdir=$(awk 'NR == 1' bamdir.txt)
sample_map=$(awk 'NR == 1' sample_file.txt)
bamfilename=$(awk 'NR == 1' bam_file_name.txt)
parentdir=$(awk 'NR == 1' out_dir.txt)

sample=$( awk "NR == $SGE_TASK_ID" $sample_map )
inbam="${bamdir}/${sample}/${bamfilename}"

outdir="${parentdir}/bams/${sample}/"
mkdir -p $outdir
outbam="${outdir}/dedup.bam"
outmetrics="${outdir}/dup_metrics.txt"

$gatk MarkDuplicates \
	-I=$inbam \
	-O=$outbam \
	-M=$outmetrics
