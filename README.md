
# Variant calling pipeline from RNA-seq data

Download the GATK and reference files


## Specify input files

Specify the output directory for the log files in `log_dir.txt`. Then the 
script re-writes the files in `scripts` so that the log output of the 
SGE tasks will end up there

Specify the bam directory that contains the sample folders with the 
BAM alignments into `inbam_dir.txt`

Specify the input BAM file names in `inbam_file_name.txt`

Specify the output directory in `out_dir.txt`.

Specify the samples that you want to call variants from. Place them in 
one column in the file `samples.txt`. To
specify all the samples in the BAM directory, run:

```bash
bash scripts/get_all_samples.sh
```

This lists all folder names in the BAM directory into the `samples.txt` 
file.

## Pipeline

Mark duplicates from BAM file.

```bash
scripts/markDup.sh
```

