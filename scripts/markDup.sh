#!/bin/bash
#$ -cwd
#$ -j y
#$ -l h_data=16000M,h_rt=1:00:00,highp
#  Notify at beginning and end of job
#$ -m n
#$ -r n
#$ -o logs/markDup.sh.$TASK_ID
#$ -t 1-60

gatk="${PWD}/gatk-4.1.4.1/gatk"

bamdir=$(awk 'NR == 1' inbam_dir.txt)
bamfilename=$(awk 'NR == 1' inbam_file_name.txt)
parentdir=$(awk 'NR == 1' out_dir.txt)

sample=$( awk "NR == $SGE_TASK_ID" samples.txt )
inbam="${bamdir}/${sample}/${bamfilename}"

outdir="${parentdir}/bams/${sample}/"
mkdir -p $outdir
outbam="${outdir}/dedup.bam"
outmetrics="${outdir}/dup_metrics.txt"

$gatk --java-options "-Xmx16G" \
    MarkDuplicates \
	-I=$inbam \
	-O=$outbam \
	-M=$outmetrics
