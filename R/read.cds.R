#' @title Read the CDS of a given organism
#' @description This function reads an organism specific CDS stored in a defined file format.
#' @param file a character string specifying the path to the file storing the CDS.
#' @param format a character string specifying the file format used to store the CDS, e.g. "fasta", "fatsq".
#' @param delete_corrupt a logical value indicating whether corrupt base triplets should be removed from the input \code{file}.
#' @param ... additional arguments that are used by the \code{\link[Biostrings]{readDNAStringSet}} function.
#' @author Hajk-Georg Drost
#' @details The \code{read.cds} function takes a string specifying the path to the cds file
#' of interest as first argument.
#'
#' It is possible to read in different proteome file standards such as \emph{fasta} or \emph{fastq}.
#'
#' CDS stored in fasta files can be downloaded from http://www.ensembl.org/info/data/ftp/index.html.
#'
#' @examples \dontrun{
#' # reading a cds file stored in fasta format
#' Ath.cds <- read.cds(system.file('seqs/ortho_thal_cds.fasta', package = 'orthologr'),
#'                     format = "fasta")
#' }
#'
#' @return A data.table storing the gene id in the first column and the corresponding
#' sequence as string in the second column.
#' @export

read.cds <- function(file, format, delete_corrupt = TRUE, ...){
  
  if(!is.element(format,c("fasta","fastq")))
    stop("Please choose a file format that is supported by this function.")
  
  
  geneids <- seqs <- NULL
  
  tryCatch({
    
    cds_file <- Biostrings::readDNAStringSet(filepath = file, format = format, ...)
    
    cds_names <- as.vector(unlist(sapply(cds_file@ranges@NAMES, function(x){return(strsplit(x, " ")[[1]][1])})))
    
    cds.dt <- data.table::data.table(geneids = cds_names ,
                                     seqs = tolower(as.character(cds_file)))
    
    
    data.table::setkey(cds.dt, geneids)
    
    mod3 <- function(x) { return((nchar(x) %% 3) == 0) }
    
    all_triplets <- cds.dt[ , mod3(seqs)]
    
    
  }, error = function(e){ stop("File ",file, " could not be read properly.","\n",
                               "Please make sure that ",file," contains only CDS sequences and is in ",format," format.")}
  )
  
  if(!all(all_triplets)){
    
    if(delete_corrupt)
      return(cds.dt[-which(!all_triplets) , list(geneids, seqs)])
    
    if(!delete_corrupt)
      return(cds.dt)
    
  } else {
    
    return(cds.dt)
  }
  
  
}