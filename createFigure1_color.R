## 06 July 2013

## This is a MALDIquant example file. It is released into public domain with the
## right to use it for any purpose but without any warranty.

## stop on warnings
options(warn=2)

## constants
## 2-column figure could be 178mm: 178mm/25.4 ~ 7 inch
prefix <- "."
pdfWidth <- 7
pdfHeight <- pdfWidth*0.35


## load necessary libraries
library("MALDIquant")

## load example spectra
data("fiedler2009subset", package="MALDIquant")

## some preprocessing

## sqrt transform (for variance stabilization)
tSpectra <- transformIntensity(fiedler2009subset, sqrt)

## simple 5 point moving average for smoothing spectra
tSpectra <- transformIntensity(tSpectra, movingAverage, halfWindowSize=2)

## remove baseline
rbSpectra <- removeBaseline(tSpectra)

## calibrate intensity values by "total ion current"
cbSpectra <- standardizeTotalIonCurrent(rbSpectra)

## run peak detection
peaks <- detectPeaks(cbSpectra, SNR=5)

### warping
reference <- referencePeaks(peaks)
warpingFunctions <- determineWarpingFunctions(peaks, reference=reference, tolerance=0.001)

## warp spectra
warpedSpectra <- warpMassSpectra(cbSpectra, warpingFunctions)
## warp peaks
warpedPeaks <- warpMassPeaks(peaks, warpingFunctions)

## merge technical replicates
mergedSpectra <- mergeMassSpectra(warpedSpectra, rep(1:8, each=2))

binnedPeaks <- binPeaks(warpedPeaks)
mergedPeaks <- mergeMassPeaks(binnedPeaks, rep(1:8, each=2))

## helper function to mark plots as LETTERS[1:4]
labelPlot <- function(char, cex=1.5) {
    usr <- par("usr")
    text(x=usr[2]-(cex*strwidth(char)),
         y=usr[4]-(cex*strheight(char)),
         labels=char, cex=cex)
}

## draw to pdf file
pdf(file=file.path(prefix, "figure1.pdf"), height=pdfHeight, width=pdfWidth)

par(mfrow=c(2, 3))
par(cex=0.4)
par(yaxt="n")
par(mar=c(2.5, 1, 1, 1)) # bottom, left, top, right

xlim <- c(1e3, 1e4)
## select 1 spectra for plot A/B
AB <- 14

## first row
## plot A
plot(fiedler2009subset[[AB]], lwd=0.25, sub="", main="", ylab="", xlab="",
     xlim=xlim)
lines(estimateBaseline(fiedler2009subset[[AB]]), lwd=0.75, col=2)
labelPlot("A")

## plot B
plot(cbSpectra[[AB]], lwd=0.25, sub="", main="", ylab="", xlab="", xlim=xlim)
points(peaks[[AB]], pch=4, lwd=0.25, col=4)
labelPlot("B")

## plot C
par(yaxt="s")
par(mar=c(2.5, 2, 1, 1)) # bottom, left, top, right
determineWarpingFunctions(peaks[[10]], reference=reference,
                          tolerance=0.001, plot=TRUE,
                          ylim=c(-2, 4), lwd=0.5,
                          xlab="", ylab="", main="", sub="")
labelPlot("C")

## second row
par(mar=c(4, 1, 1, 1)) # bottom, left, top, right
par(yaxt="n")

## select 4 spectra for plot D/E
DE <- c(2, 10, 14, 16)
## limits for plot D/E
xlimDE <- c(4180, 4240)
ylimDE <- c(0, 4e-4)
## line types
lty <- c(1, 4, 2, 6)

## plot D
plot(cbSpectra[[1]], xlim=xlimDE, ylim=ylimDE, type="n",
     main="", xlab="", ylab="")
labelPlot("D")

for (i in seq(along=DE)) {
    lines(peaks[[DE[i]]], lty=lty[i], lwd=0.5, col=i)
    lines(cbSpectra[[DE[i]]], lty=lty[i], lwd=0.5, col=i)
}

## plot E
plot(cbSpectra[[1]], xlim=xlimDE, ylim=ylimDE, type="n",
     main="", xlab="", ylab="")
labelPlot("E")

for (i in seq(along=DE)) {
    lines(warpedPeaks[[DE[i]]], lty=lty[i], lwd=0.5, col=i)
    lines(warpedSpectra[[DE[i]]], lty=lty[i], lwd=0.5, col=i)
}

## plot F
F <- 7
plot(mergedSpectra[[F]], lwd=0.25, sub="", main="", ylab="", xlab="",
     xlim=xlim, ylim=c(0, (max(intensity(mergedSpectra[[F]]))*1.05)))
labelPlot("F")
points(mergedPeaks[[F]], lwd=0.25, pch=4, col=4)
## label highest peaks
top <- intensity(mergedPeaks[[F]]) %in%
            sort(intensity(mergedPeaks[[F]]), decreasing=TRUE)[1:10]
labelPeaks(mergedPeaks[[F]], index=top, underline=TRUE, cex=0.8, lwd=0.25)

dev.off()

## EOF

