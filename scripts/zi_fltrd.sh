#!/bin/bash

# Zip and index the filtered VCF variant calls
bgzip=../tabix/bgzip
tabix=../tabix/tabix
vcfdir="../../data/processed/adi_bl_varcall_vcfs/"
for sample in $( cat ../../data/ref/mex_adi_samples.txt ); do
	echo $sample
	$bgzip -f ${vcfdir}/${sample}/${sample}.gatk.flt.vcf
	$tabix -fp vcf ${vcfdir}/${sample}/${sample}.gatk.flt.vcf.gz
done
