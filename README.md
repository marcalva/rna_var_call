
# Variant calling pipeline from RNA-seq data

Download the GATK and reference files

Specify the samples that you want to call variants from. Place them in 
one column in the file `samples.txt`. To
specify all the samples in the BAM directory, run:

```bash
bash scripts/get_all_samples.sh
```

This lists all folder names in the BAM directory into the `samples.txt` 
file.

Mark duplicates from BAM file.

```bash
scripts/markDup.sh
```

