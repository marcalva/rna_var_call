#!/bin/bash

bcftools="../bcftools-1.6/bcftools"
vcftools="../vcftools/bin/vcftools"
bgzip="../tabix/bgzip"
tabix="../tabix/tabix"

invcf="../../data/processed/adi_bl_varcall_vcfs/MexAdiBl.gatk.2018-05-07.vcf.gz"
outvcf="../../data/processed/adi_bl_varcall_vcfs/MexAdiBl.gatk.2018-05-07.rename.auto.SNVs.vcf.gz"

for i in $( seq 1 22 ); do
	echo $i | awk '{print "chr"$1" "$1}' -
done > rename.txt

$bcftools view -O z -v snps $invcf chr{1..22} > tmp.vcf.gz
$bcftools annotate --rename-chrs rename.txt -O z tmp.vcf.gz > $outvcf

rm tmp.vcf.gz
rm rename.txt
