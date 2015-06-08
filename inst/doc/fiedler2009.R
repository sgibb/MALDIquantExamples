## ----knitrsetup, include=FALSE, cache=FALSE------------------------------
library("knitr")
opts_chunk$set(width=40, tidy.opts=list(width.cutoff=45), tidy=FALSE,
               fig.path=file.path("figures", "fiedler2009/"),
               fig.align="center", fig.height=4.25, comment=NA, prompt=FALSE)

## ----setup, echo=TRUE, eval=FALSE----------------------------------------
#  install.packages(c("MALDIquant", "MALDIquantForeign",
#                     "sda", "crossval", "devtools"))
#  library("devtools")
#  install_github("sgibb/MALDIquantExamples")

## ----loadpackages, echo=FALSE--------------------------------------------
suppressPackageStartupMessages(library("MALDIquantExamples"))
suppressPackageStartupMessages(library("xtable"))

## ----packages------------------------------------------------------------
## the main MALDIquant package
library("MALDIquant")
## the import/export routines for MALDIquant
library("MALDIquantForeign")

## example data
library("MALDIquantExamples")

## ----import--------------------------------------------------------------
## import the spectra
spectra <- import(getPathFiedler2009()["spectra"],
                  verbose=FALSE)

## import metadata
spectra.info <- read.table(getPathFiedler2009()["info"],
                           sep=",", header=TRUE)

## ----reduce--------------------------------------------------------------
isHeidelberg <- spectra.info$location == "heidelberg"

spectra <- spectra[isHeidelberg]
spectra.info <- spectra.info[isHeidelberg,]

## ----qc------------------------------------------------------------------
table(sapply(spectra, length))
any(sapply(spectra, isEmpty))
all(sapply(spectra, isRegular))

## ----trim----------------------------------------------------------------
spectra <- trim(spectra)

## ----plotseed, echo=FALSE------------------------------------------------
set.seed(123)

## ----plot----------------------------------------------------------------
idx <- sample(length(spectra), size=2)
plot(spectra[[idx[1]]])
plot(spectra[[idx[2]]])

## ----vs------------------------------------------------------------------
spectra <- transformIntensity(spectra, method="sqrt")

## ----sm------------------------------------------------------------------
spectra <- smoothIntensity(spectra, method="SavitzkyGolay",
                           halfWindowSize=20)

## ----be------------------------------------------------------------------
baseline <- estimateBaseline(spectra[[1]], method="SNIP",
                             iterations=150)
plot(spectra[[1]])
lines(baseline, col="red", lwd=2)

## ----bc------------------------------------------------------------------
spectra <- removeBaseline(spectra, method="SNIP",
                          iterations=150)
plot(spectra[[1]])

## ----cb------------------------------------------------------------------
spectra <- calibrateIntensity(spectra, method="TIC")

## ----pa------------------------------------------------------------------
spectra <- alignSpectra(spectra)

## ----avg-----------------------------------------------------------------
avgSpectra <-
  averageMassSpectra(spectra, labels=spectra.info$patientID)
avgSpectra.info <-
  spectra.info[!duplicated(spectra.info$patientID), ]

## ----noise---------------------------------------------------------------
noise <- estimateNoise(avgSpectra[[1]])
plot(avgSpectra[[1]], xlim=c(4000, 5000), ylim=c(0, 0.002))
lines(noise, col="red")                     # SNR == 1
lines(noise[, 1], 2*noise[, 2], col="blue") # SNR == 2

## ----pd------------------------------------------------------------------
peaks <- detectPeaks(avgSpectra, SNR=2, halfWindowSize=20)

## ----pdp-----------------------------------------------------------------
plot(avgSpectra[[1]], xlim=c(4000, 5000), ylim=c(0, 0.002))
points(peaks[[1]], col="red", pch=4)

## ----pb------------------------------------------------------------------
peaks <- binPeaks(peaks)

## ----pf------------------------------------------------------------------
peaks <- filterPeaks(peaks, minFrequency=c(0.5, 0.5),
                     labels=avgSpectra.info$health,
                     mergeWhitelists=TRUE)

## ----fm------------------------------------------------------------------
featureMatrix <- intensityMatrix(peaks, avgSpectra)
rownames(featureMatrix) <- avgSpectra.info$patientID

## ----dda-----------------------------------------------------------------
library("sda")
Xtrain <- featureMatrix
Ytrain <- avgSpectra.info$health
ddar <- sda.ranking(Xtrain=featureMatrix, L=Ytrain, fdr=FALSE,
                    diagonal=TRUE)

## ----ddaresults, echo=FALSE, results="asis"------------------------------
xtable(ddar[1:10, ], booktabs=TRUE)

## ----hclust--------------------------------------------------------------
distanceMatrix <- dist(featureMatrix, method="euclidean")

hClust <- hclust(distanceMatrix, method="complete")

plot(hClust, hang=-1)

## ----hclustfs------------------------------------------------------------
top <- ddar[1:2, "idx"]

distanceMatrixTop <- dist(featureMatrix[, top],
                          method="euclidean")

hClustTop <- hclust(distanceMatrixTop, method="complete")

plot(hClustTop, hang=-1)

## ----cv------------------------------------------------------------------
library("crossval")
# create a prediction function for the cross validation
predfun.dda <- function(Xtrain, Ytrain, Xtest, Ytest,
                        negative) {
  dda.fit <- sda(Xtrain, Ytrain, diagonal=TRUE, verbose=FALSE)
  ynew <- predict(dda.fit, Xtest, verbose=FALSE)$class
  return(confusionMatrix(Ytest, ynew, negative=negative))
}

# set seed to get reproducible results
set.seed(1234)

cv.out <- crossval(predfun.dda,
                   X=featureMatrix[, top],
                   Y=avgSpectra.info$health,
                   K=10, B=20,
                   negative="control",
                   verbose=FALSE)
diagnosticErrors(cv.out$stat)

## ----sessioninfo, echo=FALSE, results="asis"-----------------------------
toLatex(sessionInfo(), locale=FALSE)

