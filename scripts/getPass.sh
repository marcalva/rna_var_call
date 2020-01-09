#!/bin/bash

bcftools="../bcftools-1.6/bcftools"
tabix="../tabix/tabix"

$bcftools view -f PASS -Oz ../../data/processed/muscle_gatk_varcalls/Muscle2017.fltd.snps.indels.vcf.gz \
	> ../../data/processed/muscle_gatk_varcalls/Muscle2017.fltd.snps.indels.pass.vcf.gz

$tabix -fp vcf ../../data/processed/muscle_gatk_varcalls/Muscle2017.fltd.snps.indels.pass.vcf.gz
