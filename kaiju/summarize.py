#!/usr/bin/env python3
import sys
import polars as pl



def read_kaiju_polars(file):
  kaiju_cols = {
    'classified':pl.Utf8,
    'seqid':pl.Utf8,
    'taxon_id':pl.Utf8,
    'V1':None,
    'V2':None,
    'V3':None,
    'V4':None
  }

  columns = [i for i,v in enumerate(kaiju_cols.values()) if v is not None]
  new_columns = [k for k,v in kaiju_cols.items() if v is not None]
  dtypes = {k:v for k,v in kaiju_cols.items() if v is not None}
  x = pl.read_csv(file,has_header=False, sep='\t',columns=columns,new_columns=new_columns,dtypes=dtypes)
  x_tally = (
    x
    .lazy()
    .groupby(['classified','taxon_id'])
    .agg([pl.count('taxon_id').alias('reads')])
  ).collect()

  data = x_tally.to_pandas()

  return(data)

if __name__ == "__main__":
    if len(sys.argv) == 1:
        print("USAGE: summarize.py raw_kaiju sumamrize_kaiju_output")
        sys.exit()
    data = read_kaiju_polars(sys.argv[1])
    data.to_csv(sys.argv[2])
