#' @title Read the proteome of a given organism
#' @description Read an organism specific proteome stored in a fasta/fastq file format.
#' @param file a character string specifying the path to the file storing the proteome.
#' @param format a character string specifying the file format used to store the proteome, e.g. \code{format = "fasta"} or \code{format = "fastq"}.
#' @param ... additional arguments that are used by the \code{\link[Biostrings]{readAAStringSet}} function.
#' @author Hajk-Georg Drost
#' @details This function takes a string specifying the path to the proteome file
#' of interest as first argument.
#'
#' It is possible to read in different proteome file standards such as \emph{fasta} or \emph{fastq}.
#'
#' Proteomes stored in fasta format can be downloaded from http://www.ebi.ac.uk/reference_proteomes.
#'
#' @examples 
#' # reading a proteome stored in a fasta file
#' Ath.proteome <- read.proteome(system.file('seqs/ortho_thal_aa.fasta', package = 'seqreadr'),
#'                                format = "fasta")
#' 
#' dplyr::glimpse(Ath.proteome)
#' 
#' @return 
#' A \code{\link{data.frame}} storing the \code{gene id} in the first column, the corresponding sequence as string in the second column, and the sequence length in the third column.
#' @export

read.proteome <- function(file, format, ...){
  
  if(!is.element(format,c("fasta","fastq")))
    stop("Please choose a file format that is supported by this function.")
  
  geneids <- seqs <- NULL 
  
  tryCatch({
    
    proteome <- Biostrings::readAAStringSet(filepath = file, format = format, ...)
    proteome_names <- as.vector(unlist(sapply(proteome@ranges@NAMES, function(x){return(strsplit(x, " ")[[1]][1])})))
    
    proteome.df <- dplyr::data_frame(geneids = proteome_names,
                                     seqs = toupper(as.character(proteome)))
    
    proteome.df <- dplyr::mutate(proteome.df, seqLen = stringr::str_length(seqs))
    
  }, error = function(e){ stop("File ",file, " could not be read properly.", "\n",
                               "Please make sure that ",file," contains only amino acid sequences and is in ",format," format.", call. = FALSE)}
  )
  
  return(proteome.df)
}
