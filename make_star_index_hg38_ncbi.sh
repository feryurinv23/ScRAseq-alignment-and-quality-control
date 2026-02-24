cd ~/Documentos

GENOME_DIR=~/Documentos/star_index_GRCh38_NCBI_GCF_000001405.40
REF=~/Documentos/ncbi_dataset_human_GFT/ncbi_dataset/data/GCF_000001405.40
FASTA=$REF/GCF_000001405.40_GRCh38.p14_genomic.fna
GTF=$REF/genomic.gtf

mkdir -p "$GENOME_DIR"

STAR --runMode genomeGenerate \
  --runThreadN 25 \
  --genomeDir "$GENOME_DIR" \
  --genomeFastaFiles "$FASTA" \
  --sjdbGTFfile "$GTF" \
  --sjdbOverhang 99

