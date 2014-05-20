
## ----knitrsetup, include=FALSE, cache=FALSE------------------------------
library("knitr")
opts_chunk$set(width=40, tidy.opts=list(width.cutoff=45), tidy=FALSE,
               fig.path=file.path("figures", "ims/"),
               fig.align="center", fig.height=4.25, comment=NA, prompt=FALSE)


## ----setup, echo=TRUE, eval=FALSE----------------------------------------
## install.packages(c("MALDIquant", "MALDIquantForeign", "devtools"))
## library("devtools")
## install_github("sgibb/MALDIquantExamples")


## ----loadpackages, echo=FALSE--------------------------------------------
suppressPackageStartupMessages(library("MALDIquant"))
suppressPackageStartupMessages(library("MALDIquantForeign"))


## ----packages------------------------------------------------------------
library("MALDIquant")
library("MALDIquantForeign")

library("MALDIquantExamples")


## ----import--------------------------------------------------------------
spectra <- import("http://www.maldi-msi.org/download/imzml/s043_processed.zip",
                  verbose=FALSE)


## ----plotimage-----------------------------------------------------------
plotImsSlice(spectra, range=c(156.95, 157.45), main="urinary bladder")


## ----sessioninfo, echo=FALSE, results="asis"-----------------------------
toLatex(sessionInfo(), locale=FALSE)


