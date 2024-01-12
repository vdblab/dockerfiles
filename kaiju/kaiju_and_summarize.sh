#/bin/bash
set -u
# USAGE: kaiju_and_summarize.sh nodes index.fmi reads_1.fq reads_2.fq kaiju_summarize.out
kaiju -v -t $1 -f $2 -z 32 -i $3 -j $4 -o tmp.kaiju.out

summarize.py tmp.kaiju.out $5

rm tmp.kaiju.out
