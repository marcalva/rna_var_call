#!/bin/bash
. /u/local/Modules/default/init/modules.sh

bcftools="../bcftools-1.6/bcftools"
tabix="../tabix/tabix"
samplelist="../../data/ref/mex_adi_samples.txt"
mergefile="mergelist.txt"
mergeout="../../data/processed/adi_bl_varcall_vcfs/MexAdiBl.gatk.flt.vcf.gz"
touch $mergefile
for s in $( cat $samplelist ); do
	echo ../../data/processed/adi_bl_varcall_vcfs/${s}/${s}.gatk.flt.vcf.gz
done > $mergefile
$bcftools merge \
	-0 \
	-i AC:sum,AF:avg,AN:sum \
	-l $mergefile \
	-m none \
	-Oz > $mergeout
rm $mergefile
$tabix -fp vcf $mergeout
