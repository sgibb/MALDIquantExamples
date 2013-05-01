## 28 April 2013

## This is a MALDIquant/MALDIquantForeign example file. It is released into
## public domain with the right to use it for any purpose but without any
## warranty.

## This example file demonstrates the import of imzML files
## using MALDIquantForeign and how to display an image from IMS data.

## load libraries
library("MALDIquant")

## MALDIquantForeign >= 0.4 is needed
library("MALDIquantForeign")

if (packageVersion("MALDIquantForeign") < "0.4") {
  stop("Your MALDIquantForeign (", packageVersion("MALDIquantForeign"),
       ") is too old. You need to update MALDIquantForeign!")
}

## define plot function
plotImage <- function(x, range, main) {
  ## display only mass in range
  x <- trim(x, range[1], range[2])

  ## find x and y positions
  pos <- lapply(x, function(y)metaData(y)$imaging$pos)
  pos <- do.call(rbind, pos)

  ## max x/y to build image matrix
  nc <- max(pos[, "x"])
  nr <- max(pos[, "y"])

  ## init matrix
  m <- matrix(NA, nrow=nr, ncol=nc)

  ## fill matrix with intensity values
  for (i in seq(along=x)) {
    m[pos[i, "y"], pos[i, "x"]] <- sum(intensity(x[[i]]), na.rm=TRUE)
  }

  ## scale matrix (better contrast)
  m <- m/max(m)

  ## build title
  main <- paste(main, " (m/z: ", range[1], "-", range[2], ")", sep="")

  ## prepare plot area
  plot(NA, type="n", xlim=c(1, nc), ylim=c(1, nr), axes=FALSE, asp=1,
       xlab="", ylab="", main=main)
  ## plot image
  rasterImage(m, xleft=1, xright=nc, ybottom=1, ytop=nr, interpolate=FALSE)
}

## download and import zipped imzML example file of an urinary bladder from
## maldi-msi.org
s <- import("http://www.maldi-msi.org/download/imzml/s043_processed.zip")
## we could safely ignore the two warnings: "centroid data are not supported"

## plot image
plotImage(s, range=c(156.95, 157.45), main="urinary bladder")
