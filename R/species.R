#' This dataset contains 96 MALDI-TOF mass spectra of different bacteria
#' species.
#'
#' This dataset contains 96 MALDI-TOF mass spectra of four different bacteria
#' species. Each species is represented by eight individual samples and each
#' sample has three technical replicates.
#'
#' @usage getPathSpecies
#'
#' @return Returns the local file path for the corresponding tar-archive.
#'
#' @references
#'
#' This dataset was kindly provided by
#' Dr. Bryan R. Thoma \email{bryanthoma@@yahoo.com}.
#'
#' @examples
#' library("MALDIquantExamples")
#' getPathSpecies()
#'
#' @keywords datasets
#' @export
getPathSpecies <- function() {
  spectra <- system.file(file.path("extdata", "species", "spectra.tar.gz"),
                                   package="MALDIquantExamples", mustWork=TRUE)
  return(setNames(spectra, "spectra"))
}

