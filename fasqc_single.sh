#!/usr/bin/env bash
set -euo pipefail

FASTQ_DIR="$HOME/Documentos/FastQ yuri"
QC_DIR="$HOME/Documentos/fastqc_out"
THREADS=12

mkdir -p "$QC_DIR"

# FastQC nos FASTQs (R1 e R2)
fastqc -t "$THREADS" -o "$QC_DIR" "$FASTQ_DIR"/*.fastq.gz

# MultiQC pra juntar tudo em um relatório
multiqc -o "$QC_DIR" "$QC_DIR"


for f in ~/Documentos/starsolo_out/*/*.Log.final.out; do
  s=$(basename "$f" .Log.final.out)
  uniq=$(awk -F'|' '/Uniquely mapped reads %/ {gsub(/^[ \t]+|[ \t]+$/,"",$2); print $2}' "$f")
  multi=$(awk -F'|' '/% of reads mapped to multiple loci/ {gsub(/^[ \t]+|[ \t]+$/,"",$2); print $2}' "$f")
  echo -e "$s\t$uniq\t$multi"
done | column -t | sort



