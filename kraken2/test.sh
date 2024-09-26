
#
if $(docker image ls   | grep -q kraken2tmp ) ;
then
    echo "image present"
else
    docker build -t kraken2tmp kraken2/
fi

docker run --rm kraken2tmp kraken2-build --help
docker run --rm kraken2tmp kraken2 --help
docker run --rm kraken2tmp bracken-build -h
for i in combine_kreports.py alpha_diversity.py extract_kraken_reads.py ; do
    docker run --rm kraken2tmp $i -h
done
