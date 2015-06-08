#' This dataset contains 2222 MALDI-TOF mass spectra of a mouse kidney.
#'
#' This MALDI Imaging dataset contains 2222 MALDI-TOF mass spectra of a mouse
#' kidney. It ranges from (x=29, y=68) to (x=101, y=92).
#'
#' @usage getPathNyakas2013
#'
#' @return Returns the local file path for the corresponding tar-archive.
#
#' @references
#'
#' This dataset was kindly provided by
#' Dr. Adrien Nyakas (\email{adrien.nyakas@@dcb.unibe.ch}).
#'
#' See also: \url{http://dx.doi.org/10.6084/m9.figshare.735961}.
#'
#' @examples
#' library("MALDIquantExamples")
#' getPathNyakas2013()
#'
#' @keywords datasets
#' @export
getPathNyakas2013 <- function() {
  spectra <- system.file(file.path("extdata", "nyakas2013", "spectra.tar.gz"),
                         package="MALDIquantExamples", mustWork=TRUE)
  setNames(spectra, "spectra")
}
