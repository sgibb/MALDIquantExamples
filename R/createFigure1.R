#' This function creates Figure 1 in Gibb and Strimmer 2012.
#'
#' @title Figure 1
#'
#' @references
#' S. Gibb and K. Strimmer. 2012. MALDIquant: a versatile R package for the
#' analysis of mass spectrometry data. Bioinformatics 28: 2270-2271
#'
#' @seealso \code{\link[MALDIquantExamples]{createFigure1Color}}
#'
#' @export
#' @examples
#' \dontrun{
#' library("MALDIquantExamples")
#' pdfWidth <- 7
#' pdfHeight <- pdfWidth*0.35
#'
#' pdf(file="figure1.pdf", height=pdfHeight, width=pdfWidth)
#' createFigure1()
#' dev.off()
#' }

createFigure1 <- function() {
  ## load example spectra
  data("fiedler2009subset", package="MALDIquant")

  ## some preprocessing

  ## sqrt transform (for variance stabilization)
  tSpectra <- transformIntensity(fiedler2009subset, method="sqrt")

  ## simple 5 point moving average for smoothing spectra
  tSpectra <- smoothIntensity(tSpectra, method="MovingAverage",
                              halfWindowSize=2)

  ## remove baseline
  rbSpectra <- removeBaseline(tSpectra)

  ## calibrate intensity values by "total ion current"
  cbSpectra <- calibrateIntensity(rbSpectra, method="TIC")

  ## run peak detection
  peaks <- detectPeaks(cbSpectra, SNR=5)

  ### warping
  reference <- referencePeaks(peaks)
  warpingFunctions <- determineWarpingFunctions(peaks, reference=reference,
                                                tolerance=0.001)

  ## warp spectra
  warpedSpectra <- warpMassSpectra(cbSpectra, warpingFunctions)
  ## warp peaks
  warpedPeaks <- warpMassPeaks(peaks, warpingFunctions)

  ## merge technical replicates
  mergedSpectra <- averageMassSpectra(warpedSpectra, rep(1:8, each=2))

  binnedPeaks <- binPeaks(warpedPeaks)
  mergedPeaks <- mergeMassPeaks(binnedPeaks, rep(1:8, each=2))

  ## helper function to mark plots as LETTERS[1:4]
  labelPlot <- function(char, cex=1.5) {
      usr <- par("usr")
      text(x=usr[2]-(cex*strwidth(char)),
           y=usr[4]-(cex*strheight(char)),
           labels=char, cex=cex)
  }

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
  labelPlot("A")

  ## plot B
  plot(cbSpectra[[AB]], lwd=0.25, sub="", main="", ylab="", xlab="", xlim=xlim)
  points(peaks[[AB]], pch=4, lwd=0.25)
  labelPlot("B")

  ## plot C
  par(yaxt="s")
  par(mar=c(2.5, 2, 1, 1)) # bottom, left, top, right
  determineWarpingFunctions(peaks[[10]], reference=reference,
                            tolerance=0.001, plot=TRUE, plotInteractive=TRUE,
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
  ylimDE <- c(0, 1.9e-3)
  ## line types
  lty <- c(1, 4, 2, 6)

  ## plot D
  plot(cbSpectra[[1]], xlim=xlimDE, ylim=ylimDE, type="n",
       main="", xlab="", ylab="")
  labelPlot("D")

  for (i in seq(along=DE)) {
      lines(peaks[[DE[i]]], lty=lty[i], lwd=0.5)
      lines(cbSpectra[[DE[i]]], lty=lty[i], lwd=0.5)
  }

  ## plot E
  plot(cbSpectra[[1]], xlim=xlimDE, ylim=ylimDE, type="n",
       main="", xlab="", ylab="")
  labelPlot("E")

  for (i in seq(along=DE)) {
      lines(warpedPeaks[[DE[i]]], lty=lty[i], lwd=0.5)
      lines(warpedSpectra[[DE[i]]], lty=lty[i], lwd=0.5)
  }

  ## plot F
  F <- 7
  plot(mergedSpectra[[F]], lwd=0.25, sub="", main="", ylab="", xlab="",
       xlim=xlim, ylim=c(0, (max(intensity(mergedSpectra[[F]]))*1.05)))
  labelPlot("F")
  points(mergedPeaks[[F]], lwd=0.25, pch=4)
  ## label highest peaks
  top <- intensity(mergedPeaks[[F]]) %in%
              sort(intensity(mergedPeaks[[F]]), decreasing=TRUE)[1:10]
  labelPeaks(mergedPeaks[[F]], index=top, underline=TRUE, cex=0.8, lwd=0.25)
}

