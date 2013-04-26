# 06 May 2012


## load MALDIquant library
library("MALDIquant")


#### DATA INPUT ####
library("MALDIquantForeign")
datapath = file.path( system.file("Examples", package="readBrukerFlexData"),
                     "2010_05_19_Gibb_C8_A1")
dir(datapath)
sA1 = importBrukerFlex(datapath)
par(mfrow=c(2, 1))
lapply(sA1, plot)
par(mfrow=c(1, 1))


# in the following we use only the first spectrum
s = sA1[[1]]

plot(s)
mass(s)      # extract m/z values
intensity(s) # and corresponding intensities
as.matrix(s) # convert to two-column matrix

#### PREPROCESSING ####

## sqrt transform (for variance stabilization)
s2 = transformIntensity(s, fun=sqrt)
s2

## smoothing
s3 = transformIntensity(s2, movingAverage, halfWindowSize=2)

## or alternatively you could define your own function:
#simpleSmooth = function(y) {
#  return ( filter(y, rep(1, 5)/5, sides=2) ) # 5 point moving average
#}
#
#s3 = transformIntensity(s2, simpleSmooth)

s3
length(s2) # 22431
length(s3) # 22427 - at both ends data points have been removed


## baseline subtraction

s4 = removeBaseline(s3, method="SNIP")
s4


#### DATA REDUCTION ####

# peak picking

p = detectPeaks(s4)
length(p) # 181
peak.data = as.matrix(p) # extract peak information


#### PRODUCE SOME PLOTS ####

par(mfrow=c(2,3))

xl = range(mass(s)) # use same xlim on all plots for better comparison
plot(s, sub="", main="1: raw", xlim=xl)
plot(s2, sub="", main="2: variance stabilization", xlim=xl)
plot(s3, sub="", main="3: smoothing", xlim=xl)
plot(s4, sub="", main="4: base line correction", xlim=xl)
plot(s4, sub="", main="5: peak detection", xlim=xl)
points(p)
top20 = intensity(p) %in% sort(intensity(p), decreasing=TRUE)[1:20]
labelPeaks(p, index=top20, underline=TRUE)
plot(p, sub="", main="6: peak plot", xlim=xl)
labelPeaks(p, index=top20, underline=TRUE)

par(mfrow=c(1,1))

