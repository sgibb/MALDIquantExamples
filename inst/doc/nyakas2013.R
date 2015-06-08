## ----knitrsetup, include=FALSE, cache=FALSE------------------------------
library("knitr")
opts_chunk$set(width=40, tidy.opts=list(width.cutoff=45), tidy=FALSE,
               fig.path=file.path("figures", "nyakas2013/"),
               fig.align="center", fig.height=4.25, comment=NA, prompt=FALSE)

## ----setup, echo=TRUE, eval=FALSE----------------------------------------
#  install.packages(c("MALDIquant", "MALDIquantForeign",
#                     "devtools"))
#  library("devtools")
#  install_github("sgibb/MALDIquantExamples")

## ----loadpackages, echo=FALSE--------------------------------------------
suppressPackageStartupMessages(library("MALDIquantExamples"))

## ----packages------------------------------------------------------------
## the main MALDIquant package
library("MALDIquant")
## the import/export routines for MALDIquant
library("MALDIquantForeign")

## example data
library("MALDIquantExamples")

## ----import--------------------------------------------------------------
## import the spectra
spectra <- import(getPathNyakas2013(), verbose=FALSE)

## ----preprocessing-------------------------------------------------------
spectra <- transformIntensity(spectra, method="sqrt")
spectra <- smoothIntensity(spectra, method="SavitzkyGolay",
                           halfWindowSize=10)
spectra <- removeBaseline(spectra, method="SNIP",
                          iterations=10)
spectra <- calibrateIntensity(spectra, method="TIC")

## ----meanspectrum--------------------------------------------------------
meanSpectrum <- averageMassSpectra(spectra)

roi <- detectPeaks(meanSpectrum, SNR=4,
                   halfWindowSize=10)

plot(meanSpectrum, main="Mean Spectrum")
points(roi, col="red")

## ----plotmsihigh---------------------------------------------------------
## find order of peak intensities
o <- order(intensity(roi), decreasing=TRUE)

## plot MSI slice for the highest one
plotMsiSlice(spectra, center=mass(roi)[o[1]], tolerance=0.5)

## ----plotmsimultiple-----------------------------------------------------
plotMsiSlice(spectra, center=mass(roi)[o[2:3]], tolerance=0.5)

## ----plotmsicombine------------------------------------------------------
plotMsiSlice(spectra, center=mass(roi)[o[1:2]], tolerance=0.5,
             combine=TRUE,
             colRamp=list(colorRamp(c("#000000", "#FF00FF")),
                          colorRamp(c("#000000", "#00FF00"))))

## ----msislices-----------------------------------------------------------
slices <- msiSlices(spectra, center=mass(roi), tolerance=0.5)
attributes(slices)

## ----coordinates---------------------------------------------------------
head(coordinates(spectra))
head(coordinates(spectra, adjust=TRUE))

## ----peakim--------------------------------------------------------------
peaks <- detectPeaks(spectra, SNR=3,
                     halfWindowSize=10)
peaks <- binPeaks(peaks)
intMatrix <- intensityMatrix(peaks, spectra)

## ----kmeans--------------------------------------------------------------
km <- kmeans(intMatrix, centers=2)

## ----clustermatrix-------------------------------------------------------
coord <- coordinates(spectra, adjust=TRUE)
maxPixels <- apply(coord, MARGIN=2, FUN=max)
m <- matrix(NA, nrow=maxPixels["x"], ncol=maxPixels["y"])
m[coord] <- km$cluster

## ----plotclusters--------------------------------------------------------
rgbCluster <- function(x) {
  col <- matrix(c(255, 0, 0,
                  0, 255, 0), nrow=2, byrow=TRUE)
  col[x, ]
}
plotMsiSlice(m, colRamp=rgbCluster, scale=FALSE)

## ----sessioninfo, echo=FALSE, results="asis"-----------------------------
toLatex(sessionInfo(), locale=FALSE)

