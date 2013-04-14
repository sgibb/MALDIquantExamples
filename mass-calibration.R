## 07 December 2012

## This is a MALDIquant example file. It is released into public domain with the
## right to use it for any purpose but without any warranty.

## This example file demonstrate the calibration of the x-axis (mass values)
## using MALDIquant. 
## The calibration of the x-axis is also known as alignment or warping.


## load MALDIquant library
library("MALDIquant")

## load example spectra
data("fiedler2009subset", package="MALDIquant")


##############################################################################
## run simple preprocessing (see workflow demo for details)
##############################################################################

## sqrt transform (for variance stabilization)
spectra <- transformIntensity(fiedler2009subset, sqrt)

## simple 5 point moving average for smoothing spectra
spectra <- transformIntensity(spectra, movingAverage, halfWindowSize=2)

## remove baseline
spectra <- removeBaseline(spectra)

## run peak detection
peaks <- detectPeaks(spectra)


##############################################################################
## mass calibration
##############################################################################

## a two step approach

##############################################################################
## first step: align spectra/peak list by warping
##############################################################################

## 1. create reference peaks (also known as landmark peaks;
##    could be done automatically by determineWarpingFunctions or 
##    referencePeaks).
refPeaks <- referencePeaks(peaks)
## 2. calculate individual warping functions.
warpingFunctions <- determineWarpingFunctions(peaks, reference=refPeaks)
## 3. warp each MassPeaks object.
peaks <- warpMassPeaks(peaks, warpingFunctions)
## (4. [optional] warp each MassSpectrum object)
# spectra <- warpMassSpectra(spectra, warpingFunctions)

##############################################################################
## second step: binning, or create identical mass values for same peaks
##############################################################################

## after warping you get similar but not necessary identical mass values for 
## the same peaks, e.g. for peak 8 in spectrum 1: 1077.630
##                  and for peak 6 in spectrum 2: 1077.670
##                                                ...
## To overcome these small differences binning is used.
peaks <- binPeaks(peaks)
## after binning, e.g. for peak 8 in spectrum 1: 1077.523
##                 and for peak 6 in spectrum 2: 1077.523
##                                               ...


##############################################################################
## continue with further processing of the peaks
##############################################################################

## ...
