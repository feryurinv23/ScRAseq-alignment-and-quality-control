#!/usr/bin/env bash
set -euo pipefail

FASTQ_DIR="$HOME/Documentos/FastQ yuri"
GENOME_DIR="$HOME/Documentos/star_index_GRCh38_NCBI_GCF_000001405.40"
WL="$HOME/Documentos/10x_whitelist/3M-february-2018.txt"

OUT_DIR="$HOME/Documentos/starsolo_out"
TMP_BASE="$HOME/Documentos/star_tmp"

THREADS=20

ulimit -n 65535 || true
mkdir -p "$OUT_DIR" "$TMP_BASE"

for R1 in "$FASTQ_DIR"/*_1.fastq.gz; do
  SAMPLE=$(basename "$R1" _1.fastq.gz)
  R2="$FASTQ_DIR/${SAMPLE}_2.fastq.gz"

  # pula se não existir par
  [[ -f "$R2" ]] || { echo "PULANDO $SAMPLE: sem R2 ($R2)"; continue; }

  echo ">>> $SAMPLE"

  rm -rf "$TMP_BASE/$SAMPLE"
  mkdir -p "$OUT_DIR/$SAMPLE"

  STAR --runThreadN "$THREADS" \
    --genomeDir "$GENOME_DIR" \
    --readFilesIn "$R2" "$R1" \
    --readFilesCommand zcat \
    --outFileNamePrefix "$OUT_DIR/$SAMPLE/${SAMPLE}." \
    --outTmpDir "$TMP_BASE/$SAMPLE" \
    --soloType CB_UMI_Simple \
    --soloCBstart 1 --soloCBlen 16 \
    --soloUMIstart 17 --soloUMIlen 10 \
    --soloCBwhitelist "$WL" \
    --soloFeatures Gene \
    --outSAMtype None
done

