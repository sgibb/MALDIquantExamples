## 03 March 2013

## This is a MALDIquantForeign example file. It is released into public
## domain with the right to use it for any purpose but without any warranty.

## This example file demonstrate the import of different datasets
## using MALDIquantForeign.


## load MALDIquant and MALDIquantForeign library
library("MALDIquant")
library("MALDIquantForeign")


## import local files

## get MALDIquantForeign example directory
exampleDirectory <- system.file(file.path("tests", "data"),
                                package="MALDIquantForeign")

## import CSV files
s <- import(file.path(exampleDirectory, "csv1.csv"))

## import mzML
s <- import(file.path(exampleDirectory, "tiny1.mzML1.1.mzML"))

## import mzXML
s <- import(file.path(exampleDirectory, "tiny1.mzXML3.0.mzXML"))

## import files in zip archives (e.g. CSV files)
s <- import(file.path(exampleDirectory, "compressed", "csv.zip"))

## import Bruker *flex fid files
## get readBrukerFlexData example directory
exampleDirectory <- system.file("Examples", package="readBrukerFlexData")
s <- import(file.path(exampleDirectory, "2010_05_19_Gibb_C8_A1"), verbose=TRUE)


## import remote files

## import Ciphergen XML files published in
## Tan, Chuen Seng, et al. "Finding regions of significance in SELDI
## measurements for identifying protein biomarkers." Bioinformatics 22.12
## (2006): 1515-1523.
s <- import("http://www.meb.ki.se/~yudpaw/papers/spikein_xml.zip", verbose=TRUE)

