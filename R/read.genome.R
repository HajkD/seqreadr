#' @title Read the genome of a given organism
#' @description Read an organism specific genome stored in fasta/fastq file format.
#' @param file a character string specifying the path to the file storing the genome.
#' @param format a character string specifying the file format used to store the genome, e.g. \code{format = "fasta"} or \code{format = "fastq"}.
#' @param ... additional arguments that are used by the \code{\link[Biostrings]{readDNAStringSet}} function.
#' @author Hajk-Georg Drost
#' @details The \code{read.genome} function takes a string specifying the path to the genome file
#' of interest as first argument.
#'
#' Genomes stored in fasta files can be downloaded from http://ensemblgenomes.org/info/genomes.
#'
#' @examples 
#' # reading a genome stored in a fasta file
#' Ath.genome <- read.genome(system.file('seqs/ortho_thal_cds.fasta', package = 'seqreadr'),
#'                            format = "fasta")
#'
#' dplyr::glimpse(Ath.genome)
#'
#' @return A \code{\link{data.frame}} storing the \code{gene id} in the first column, the corresponding sequence as string in the second column, and the sequence length in the third column.
#' @export

read.genome <- function(file, format, ...){
  
  if(!is.element(format,c("fasta","fastq")))
    stop("Please choose a file format that is supported by this function.")
  
  geneids <- seqs <- NULL
  
  if(format == "fasta"){
    
    tryCatch({
      
      genome <- Biostrings::readDNAStringSet(filepath = file, format = format, ...)
      genome_names <- as.vector(unlist(sapply(genome@ranges@NAMES, function(x){return(strsplit(x, " ")[[1]][1])})))
      
      genome.df <- dplyr::data_frame(geneids = genome_names,
                                     seqs = toupper(as.character(genome)))
      
      genome.df <- dplyr::mutate(genome.df, seqLen = stringr::str_length(seqs))
      
    }, error = function(e){ stop(paste0("File ",file, " could not be read properly. \n",
                                        "Please make sure that ",file," contains only DNA sequences and is in ",format," format."), call. = FALSE)}
    )
  }
  
  return(genome.df)
}
