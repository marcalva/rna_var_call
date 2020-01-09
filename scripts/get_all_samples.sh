#!/bin/bash
bamdir=$(awk 'NR == 1' inbam_dir.txt)
ls -F ${bamdir} | sed 's|/||' > samples.txt
