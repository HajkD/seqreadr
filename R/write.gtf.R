#' @title Write GTF files to hard drive
#' @description Write a \code{\link{data.frame}} fulfilling the GTF file format to
#' your hard drive.
#' @param gtf.data a \code{\link{data.frame}} fulfilling the GTF file format.
#' @param file.name name of the GTF file.
#' @author Hajk-Georg Drost
#' @examples 
#' 
#' example.gtf <- system.file("example.gtf", package = "seqreadr")
#'  
#' # read GTF file  
#' test.gtf <- read.gtf(example.gtf)
#' # write GTF file to the hard drive
#' write.gtf(test.gtf)
#' @export

write.gtf <- function(gtf.data, file.name = "file.gtf"){
  
  write.table(gtf.data,file.name,col.names = FALSE, row.names = FALSE, quote = FALSE)
  
}