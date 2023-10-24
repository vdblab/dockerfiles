# DB utils

This relies on non-public repos.  to build, run the following from the root of the repo:

```bash
VERSION="0.0.0"
git clone https://github.mskcc.org/microbiome/isabl-io/ dbutils/
docker build -t github.mskcc.org/microbiome/isabl_io/dbutils:${VERSION} dbutils/ --progress plain
docker push github.mskcc.org/microbiome/isabl_io/dbutils:0.0.2


```

Notes:
-  you will need to log in to the enterprise container registry.  `docker login github.mskcc.org`
- you also need the PAT to download and use on the cluster with singularity.  Set with export `SINGULARITY_DOCKER_PASSWORD=<GITHUB_TOKEN>`
