# seqreadr

__Read Biological Sequences with R.__

### Motivation:

Several (standardized) file formats have been published and are actively used
to store, exchange, and analyze biological sequences. The `seqreadr` package
aims to provide read/write functions to work with this variety of sequence file formats.

To avoid re-inventing the wheel the `seqreadr` package relies on existing interface functions implemented in a variety of R packages. However, additional functionality for
sequence quality control is provided by the functions implemented in `seqreadr`.
Furthermore, `seqreadr` aims to provide a complete collection of sequence file formats and is based on a unifying terminology and nomenclature to avoid learning different package styles etc.


## Tutorials

Use Cases for each Sequence File Format:

* [FastA/FastQ](https://github.com/HajkD/seqreadr/blob/master/vignettes/FastA.Rmd)
* [BAM]()
* [SAM]()
* [GFF/GTF]()
* [BED/Big Bed]()
* [PSL]()
* [Pairwise Interaction File Format]()
* [Variation File Format]()
* [WIG File Format]()

## NEWS

The current status of the package as well as a detailed history of the functionality of each version of `seqreadr` can be found in the [NEWS](NEWS.md) section.

## Installation

```r
# install developer version of seqreadr
library(devtools)
install_github("HajkD/seqreadr", build_vignettes = TRUE, dependencies = TRUE)
```

## Discussions and Bug Reports

I would be very happy to learn more about potential improvements of the concepts and functions provided in this package.

Furthermore, in case you find some bugs or need additional (more flexible) functionality of parts of this package, please let me know:

https://github.com/HajkD/seqreadr/issues

## Based on the following packages

* [Biostrings](http://bioconductor.org/packages/release/bioc/html/Biostrings.html)
* [refGenome](https://cran.r-project.org/web/packages/refGenome/index.html)
* [GenomicRanges](http://bioconductor.org/packages/release/bioc/html/GenomicRanges.html)

## Input functions implemented in `seqreadr` 

### FastA/FastQ File Formats

* `read.genome()`: Read the genome of a given organism (DNA)
* `read.proteome()`: Read the proteome of a given organism (Protein)
* `read.cds()`: Read the CDS of a given organism (DNA)

### GFF/GTF File Formats

* `read.gff()`: 




