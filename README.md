# seqreadr

Read Biological Sequences with R.

## Tutorials

Use Cases for each Sequence File Format:

* [FastA]()
* [FastQ]()
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

