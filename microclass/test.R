library(microclass)
args <- commandArgs(trailingOnly = TRUE)
ASVs <- Biostrings::readDNAStringSet(args[1])
seqs <- as.character(ASVs, use.names=TRUE)
seqs_tab <- taxMachine(sequence=seqs, model.on.disk="tax.model", verbose=TRUE)

write.table(seqs_tab, file=args[2])
print("done")