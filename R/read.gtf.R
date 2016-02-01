#' @title Reading GTF (General Transfer Format) Files
#' @description This function reads a standard GTF file and stores it as data.frame object.
#' @param gtf.file path to the input GTF file.
#' @param trackline is a trackline included in the GTF file passed to \code{gtf.file}. If yes,
#' then the first line is skipped.
#' @param sep separator for GTF file columns. Default for a standard GTF file format is \code{sep = "\t"}.
#' @details 
#' The GTF (General Transfer Format) specification allows to share sequence information in a standardized manner. The attributes column must be processed separately due to the lack of
#'  a clear specification. 
#' @author Hajk-Georg Drost
#' @examples 
#' # location of the example gtf file
#' example.gtf <- system.file("example.gtf", package = "seqreadr")
#' 
#' # reading example gtf file
#' ex.gtf.df <- read.gtf(gtf.file = example.gtf)
#' 
#' # having a look at the output
#' ex.gtf.df
#' @references http://www.ensembl.org/info/website/upload/gff.html
#' @export
     
read.gtf <- function(gtf.file, trackline = FALSE, sep = "\t"){
  
  # read gtf file content
  gtf.input <- readr::read_delim(gtf.file,delim = sep, col_names = FALSE, comment = "#" )
  
  if (!trackline){
    gtf.input <- readr::read_delim(gtf.file,delim = sep, col_names = FALSE, comment = "#" )
  } else {
    gtf.input <- readr::read_delim(gtf.file,delim = sep, col_names = FALSE, comment = "#", skip = 1)
  }
  
  # name standardized columns
  gffNames <- c("seqname","source","feature",
                "start","end","score","strand",
                "frame","attribute")
   names(gtf.input)[1:ncol(gtf.input)] <- gffNames[1:ncol(gtf.input)]
   
   if (ncol(gtf.input) > 9)
     stop ("The gff file format can not store more than 9 columns!")
   
  return(gtf.input)
}
