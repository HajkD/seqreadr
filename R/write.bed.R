#' @title Write BED files to hard drive
#' @description Write a \code{\link{data.frame}} fulfilling the BED file format to
#' your hard drive.
#' @param bed.data a \code{\link{data.frame}} fulfilling the BED file format.
#' @param file.name name of the BED file.
#' @author Hajk-Georg Drost
#' @examples 
#' 
#' bed.file <- system.file("bed_example.bed", package = "seqreadr")
#'  
#' # read BED file  
#' test.bed <- read.bed(bed.file)
#' # write BED file to the hard drive
#' write.bed(test.bed)
#' @export

write.bed <- function(bed.data, file.name = "file.bed"){
  
  write.table(bed.data,file.name,col.names = FALSE, row.names = FALSE, quote = FALSE)
  
}