# Biobakery Profiler Containers

The compatibility of various versions of the tools and databases used in a Metaphlan/Humann microbiome profiling pipeline have a complicated dependency network.
The tags of these images will be tagged with the metaphlan version, `--`, humann version

## Humann v4 alpha

- Metaphlan Version:  4.0.6
- Metaphlan Database: vOct22_CHOCOPhlAnSGB_202403
- Utility Database: https://g-227ca.190ebd.75bc.data.globus.org/humann_data/full_mapping_v4_alpha.tar.gz
- Protein Database: http://huttenhower.sph.harvard.edu/humann_data/uniprot/uniref_ec_filtered/uniref90_annotated_v4_alpha_ec_filtered.tar.gz
- Nucleotide database: http://huttenhower.sph.harvard.edu/humann_data/chocophlan/chocophlan_EC_FILTERED.v4_alpha.tar.gz

## Humann 3.9 2023

- Metaphlan Version:  4.1.0
- Metaphlan Database: mpa_vJun23_CHOCOPhlAnSGB_202403
- Utility Database: https://g-227ca.190ebd.75bc.data.globus.org/humann_data/full_mapping_v201901b.tar.gz
- Protein Database: http://huttenhower.sph.harvard.edu/humann_data/uniprot/uniref_annotated/uniref90_annotated_v201901b_full.tar.gz
- Nucleotide database: http://huttenhower.sph.harvard.edu/humann_data/chocophlan/full_chocophlan.v201901_v31.tar.gz
- Demo Nucleotide database: http://huttenhower.sph.harvard.edu/humann_data/chocophlan/DEMO_chocophlan.v201901_v31.tar.gz

## Humann 3.6 2021

- Metaphlan Version: 4.0.5
- Metaphlan Database: vJan21_CHOCOPhlAnSGB_202103
- Utility Database: https://g-227ca.190ebd.75bc.data.globus.org/humann_data/full_mapping_v201901b.tar.gz
- Protein Database  uniref90
- Nucleotide database:  v201901_v31/


## Customizations

-  We add threading to indexing in 3.6 and 3.9.  See `diff biobakery-profiler/nucleotide_3.6.py ../path/to/humann/humann/search/nucleotide.py
-  We add env-based config for all versions.  patches created by `diff  humann/config.py humann/tmp.py > ~/GitHub/dockerfiles/biobakery-profiler/config_4.0.0a.patch`
