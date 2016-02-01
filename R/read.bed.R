#' @title Read BED files
#' @description Function to read files in BED file format.
#' @param bed.file path to the BED file.
#' @param trackline is a trackline included in the BED file passed to \code{bed.file}. If yes,
#' then the first line is skipped.
#' @param sep column delimiter.
#' @author Hajk-Georg Drost
#' @examples 
#' bed.file <- system.file("bed_example.bed", package = "seqreadr")
#'  
#' # read BED file  
#' test.bed <- read.bed(bed.file)
#' # look at the BED file
#' test.bed
#' @references http://www.ensembl.org/info/website/upload/bed.html
#' @export
         
read.bed <- function(bed.file, trackline = FALSE, sep = "\t"){
  
  if (!trackline){
    bed <- readr::read_delim(bed.file,delim = sep, col_names = FALSE)
  } else {
    bed <- readr::read_delim(bed.file,delim = sep, col_names = FALSE, skip = 1)
  }
    
  
  colNameSpecifications <- c("chrom","chromStart","chromEnd","name","score","strand",
                             "thickStart","thickEnd","itemRgb","blockCount","blockSize",
                             "blockStarts")
  
  colnames(bed)[1:ncol(bed)] <- colNameSpecifications[1:ncol(bed)]
  
  if (ncol(bed) > 12)
    stop ("The BED file format only allows 12 columns: chromosome | start | end | ... .")
    
  return(bed)
}