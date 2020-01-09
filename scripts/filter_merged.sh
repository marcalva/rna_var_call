#!/bin/bash

bcftools="../bcftools-1.6/bcftools"
vcftools="../vcftools/bin/vcftools"
bgzip="../tabix/bgzip"
tabix="../tabix/tabix"

invcf="../../data/processed/adi_bl_varcall_vcfs/MexAdiBl.gatk.flt.vcf.gz"
outvcf="../../data/processed/adi_bl_varcall_vcfs/MexAdiBl.gatk.2018-05-07.vcf.gz"

$bcftools view -m2 -M2 \
	-g ^miss \
	-q 0.05 -Q 0.95 \
	-O v \
	-i 'AVG(FORMAT/DP) >= 30' \
	$invcf \
	| $vcftools --vcf - --hwe 1e-6 --recode --stdout \
	| $bgzip -c > $outvcf

$tabix -fp vcf $outvcf
