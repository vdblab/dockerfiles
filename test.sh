#! /bin/bash
set -eux
set -o pipefail

image=$1
base="${image%:*}"
tag="${image#*:}"
docker build -t $image  $base/

case $base in

  bowtie2 )
      docker run --rm $image pigz -h
      docker run --rm $image bowtie2 -h
      docker run --rm $image samtools
      docker run --rm $image bedtools -h

      ;;
  taxumap )
      docker run --rm $image run_taxumap.py -h
      ;;
  *)
      echo "Invalid option. Exiting"
      ;;
esac
