FROM continuumio/miniconda3

# set work dir
WORKDIR /app

# install conda packages
RUN conda create -y -n run_dbcan python=3.8 dbcan=4.1.4 -c conda-forge -c bioconda && conda clean -ya

# add run_dbcan environment to path
RUN echo "source activate run_dbcan" > ~/.bashrc
ENV PATH /opt/conda/envs/run_dbcan/bin:$PATH

# download and make the databases
RUN test -d db || mkdir db
RUN cd db \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/fam-substrate-mapping-08012023.tsv && mv fam-substrate-mapping-08012023.tsv fam-substrate-mapping.tsv \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/PUL.faa && makeblastdb -in PUL.faa -dbtype prot \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/dbCAN-PUL_12-12-2023.xlsx && mv dbCAN-PUL_12-12-2023.xlsx dbCAN-PUL.xlsx \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/dbCAN-PUL.tar.gz && tar xvf dbCAN-PUL.tar.gz && rm dbCAN-PUL.tar.gz \
    && wget https://bcb.unl.edu/dbCAN2/download/Databases/dbCAN_sub.hmm && hmmpress dbCAN_sub.hmm \
    && wget https://bcb.unl.edu/dbCAN2/download/Databases/V12/CAZyDB.07262023.fa && mv CAZyDB.07262023.fa CAZyDB.fa  && diamond makedb --in CAZyDB.fa -d CAZy \
    && wget https://bcb.unl.edu/dbCAN2/download/Databases/V12/dbCAN-HMMdb-V12.txt && mv dbCAN-HMMdb-V12.txt dbCAN.txt && hmmpress dbCAN.txt \
    && wget https://bcb.unl.edu/dbCAN2/download/Databases/V12/tcdb.fa && diamond makedb --in tcdb.fa -d tcdb \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/V12/tf-1.hmm && hmmpress tf-1.hmm \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/V12/tf-2.hmm && hmmpress tf-2.hmm \
    && wget https://bcb.unl.edu/dbCAN2/download/Databases/V12/stp.hmm && hmmpress stp.hmm \
    && cd ../ && wget http://bcb.unl.edu/dbCAN2/download/Samples/EscheriaColiK12MG1655.fna \
    && wget http://bcb.unl.edu/dbCAN2/download/Samples/EscheriaColiK12MG1655.faa \
    && wget http://bcb.unl.edu/dbCAN2/download/Samples/EscheriaColiK12MG1655.gff

ENTRYPOINT ["run_dbcan"]

CMD [ "run_dbcan -h" ]