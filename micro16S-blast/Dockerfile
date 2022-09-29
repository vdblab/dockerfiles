ARG VERSION

FROM ncbi/blast:${VERSION}
WORKDIR /db

RUN apt-get update && apt-get install --no-install-recommends -y wget
RUN wget -c ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz \
    && tar -zxvf taxdump.tar.gz \
    && mkdir -p /root/.taxonkit/ \
    && mv names.dmp nodes.dmp delnodes.dmp merged.dmp /root/.taxonkit/ \
    && rm taxdump.tar.gz
RUN wget https://ftp.ncbi.nlm.nih.gov/blast/db/16S_ribosomal_RNA.tar.gz \
    && tar -zxvf 16S_ribosomal_RNA.tar.gz \
    && blastdbcmd -db ./16S_ribosomal_RNA -outfmt "%a %T" -entry "all" > acc_taxid \
    && rm 16S_ribosomal_RNA.tar.gz
RUN wget https://github.com/shenwei356/taxonkit/releases/download/v0.10.1/taxonkit_linux_amd64.tar.gz \
    && tar -xzf taxonkit_linux_amd64.tar.gz \
    && mv taxonkit /usr/local/bin/ \
    && rm taxonkit_linux_amd64.tar.gz
RUN head acc_taxid \
    && cut -f 2 -d" " acc_taxid \
    | taxonkit lineage \
    | awk '$2!=""' \
    | taxonkit reformat -P \
    | cut -f 3 \
    | paste acc_taxid - > bacteria_and_archea.16SrRNA.id_and_taxonomy_v2.txt
