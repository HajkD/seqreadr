#' @title Read the CDS of a given organism
#' @description Read an organism specific Coding Sequence (CDS) file stored in fasta or fastq format.
#' In case the input file includes corrupt sequences (= sequences that do not fulfill the triplet criteria) users can specify the \code{delete.corrupt = TRUE} argument
#' to remove corrupt sequences from the input file.
#' @param file a character string specifying the path to the file storing the CDS.
#' @param format a character string specifying the file format used to store the CDS, e.g. "fasta", "fatsq".
#' @param delete.corrupt a logical value indicating whether corrupt base triplets should be removed from the input \code{file}.
#' @param ... additional arguments that are used by the \code{\link[Biostrings]{readDNAStringSet}} function.
#' @author Hajk-Georg Drost
#' @details The \code{read.cds} function takes a string specifying the path to the cds file
#' of interest as first argument.
#'
#' For example, CDS files fulfilling the fasta file format can be downloaded from http://www.ensembl.org/info/data/ftp/index.html.
#' 
#' Alternatively users
#' 
#' 
#' @examples 
#' 
#' ### Example Non-Corrupt File
#' # reading a cds file stored in fasta format
#' Ath.cds <- read.cds(system.file('seqs/ortho_thal_cds.fasta', package = 'seqreadr'),
#'                     format = "fasta")
#'
#' dplyr::glimpse(Ath.cds)
#'
#' ### Example Corrupt File
#' # reading a cds file stored in fasta format
#' Ath.cds <- read.cds(system.file('seqs/ortho_thal_cds_corrupt.fasta', package = 'seqreadr'),
#'                     format         = "fasta",
#'                     delete.corrupt = TRUE)
#'                     
#' dplyr::glimpse(Ath.cds)                   
#'
#' @return A \code{\link{data.frame}} storing the \code{gene id} in the first column,  
#' the corresponding sequence as string in the second column, and the sequence length 
#' in the third column.
#' @export

read.cds <- function(file, format, delete.corrupt = FALSE, ...){
  
  if(!is.element(format,c("fasta","fastq")))
    stop("Please choose a file format that is supported by this function.")
  
  
  geneids <- seqs <- NULL
  
  tryCatch({
    
    cds_file <- Biostrings::readDNAStringSet(filepath = file, format = format, ...)
    
    cds_names <- as.vector(unlist(sapply(cds_file@ranges@NAMES, function(x){return(strsplit(x, " ")[[1]][1])})))
    
    
    cds.df <- dplyr::data_frame(geneids = cds_names ,
                                seqs = tolower(as.character(cds_file)))
    
    
    cds.df <- dplyr::mutate(cds.df, seqLen = stringr::str_length(seqs))
    
    mod3 <- function(x) { return((stringr::str_length(x) %% 3) == 0) }
    cds.df.filtered <- dplyr::filter(cds.df, mod3(seqs) == TRUE)

  }, error = function(e){ stop("File ",file, " could not be read properly.","\n",
                               "Please make sure that ",file," contains only CDS sequences and is in ",format," format.", call. = FALSE)}
  )
  
  if (delete.corrupt){
    
    if ((nrow(cds.df) - nrow(cds.df.filtered)) != 0){
      message("Your input ",format," file included ", nrow(cds.df), " sequences of which ",
              nrow(cds.df) - nrow(cds.df.filtered), " were corrupt. These corrupt sequences were removed from your input file.")
    }
    
    return(cds.df.filtered)
  }
    
  if (!delete.corrupt){
    if ((nrow(cds.df) - nrow(cds.df.filtered)) != 0){
      message("Your input ",format," file included ", nrow(cds.df), " sequences of which ",
              nrow(cds.df) - nrow(cds.df.filtered), " were corrupt. You can gemove the corrupt sequences by specifying the argument: 'delete.corrupt = TRUE'.")
    }
    return (cds.df) 
  }
  
}