
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
docker run --rm kraken2tmp python3 combine_kreports.py -h
