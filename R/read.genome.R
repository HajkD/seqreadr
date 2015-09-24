#' @title Read the genome of a given organism
#' @description This function reads an organism specific genome stored in a defined file format.
#' @param file a character string specifying the path to the file storing the genome.
#' @param format a character string specifying the file format used to store the genome, e.g. "fasta", "fastq".
#' @param ... additional arguments that are used by the \code{\link[Biostrings]{readDNAStringSet}} function.
#' @author Hajk-Georg Drost and Sarah Scharfenberg
#' @details The \code{read.genome} function takes a string specifying the path to the genome file
#' of interest as first argument.
#'
#' It is possible to read in different genome file standards such as \emph{fasta} or \emph{fastq}.
#' Genomes stored in fasta files can be downloaded from http://ensemblgenomes.org/info/genomes.
#'
#' @examples \dontrun{
#' # reading a genome stored in a fasta file
#' Ath.genome <- read.genome(system.file('seqs/ortho_thal_cds.fasta', package = 'orthologr'),
#'                            format = "fasta")
#' }
#'
#' @return A data.table storing the gene id in the first column and the corresponding
#' sequence as string in the second column.
#' @export

read.genome <- function(file, format, ...){
  
  if(!is.element(format,c("fasta","fastq")))
    stop("Please choose a file format that is supported by this function.")
  
  geneids <- seqs <- NULL
  
  if(format == "fasta"){
    
    tryCatch({
      
      genome <- Biostrings::readDNAStringSet(filepath = file, format = format, ...)
      genome_names <- as.vector(unlist(sapply(genome@ranges@NAMES, function(x){return(strsplit(x, " ")[[1]][1])})))
      genome.dt <- data.table::data.table(geneids = genome_names,
                                          seqs = toupper(as.character(genome)))
      
      data.table::setkey(genome.dt,geneids)
      
    }, error = function(e){ stop(paste0("File ",file, " could not be read properly. \n",
                                        "Please make sure that ",file," contains only DNA sequences and is in ",format," format."))}
    )
  }
  
  return(genome.dt)
}
