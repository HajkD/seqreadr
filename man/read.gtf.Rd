% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read.gtf.R
\name{read.gtf}
\alias{read.gtf}
\title{Reading GTF (General Transfer Format) Files}
\usage{
read.gtf(gtf.file, trackline = FALSE, sep = "\\t")
}
\arguments{
\item{gtf.file}{path to the input GTF file.}

\item{trackline}{is a trackline included in the GTF file passed to \code{gtf.file}. If yes,
then the first line is skipped.}

\item{sep}{separator for GTF file columns. Default for a standard GTF file format is \code{sep = "\t"}.}
}
\description{
This function reads a standard GTF file and stores it as data.frame object.
}
\details{
The GTF (General Transfer Format) specification allows to share sequence information in a standardized manner. The attributes column must be processed separately due to the lack of
 a clear specification.
}
\examples{
# location of the example gtf file
example.gtf <- system.file("example.gtf", package = "seqreadr")

# reading example gtf file
ex.gtf.df <- read.gtf(gtf.file = example.gtf)

# having a look at the output
ex.gtf.df
}
\author{
Hajk-Georg Drost
}
\references{
http://www.ensembl.org/info/website/upload/gff.html
}

