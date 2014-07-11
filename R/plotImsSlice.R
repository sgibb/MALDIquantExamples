#' This function is a basic function for MALDI-IMS data.
#'
#' @title Plot MALDI-IMS data
#'
#' @param x list of \code{\linkS4class{MassSpectrum}} objects.
#' @param range \code{double}, length two, mass range
#' @param main \code{character} plot title.
#'
#' @return Nothing, plots an image.
#'
#' @seealso \url{https://github.com/sgibb/ims-shiny/}
#'
#' @export
#'
plotImsSlice <- function(x, range, main) {
  ## display only mass in range
  suppressWarnings(x <- trim(x, range=range))

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
  m <- m/max(m, na.rm=TRUE)

  ## build title
  main <- paste(main, " (m/z: ", range[1], "-", range[2], ")", sep="")

  ## prepare plot area
  plot(NA, type="n", xlim=c(1, nc), ylim=c(1, nr), axes=FALSE, asp=1,
       xlab="", ylab="", main=main)
  ## plot image
  rasterImage(m, xleft=1, xright=nc, ybottom=1, ytop=nr, interpolate=FALSE)
}

