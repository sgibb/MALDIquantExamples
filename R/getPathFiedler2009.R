#' This dataset contains 480 MALDI-TOF mass spectra used in
#' \emph{Fiedler et al. 2009}.
#'
#' @section Abstract:
#'
#' \bold{Purpose}: Mass spectrometry-based serum peptidome profiling is a
#' promising tool to identify novel disease-associated biomarkers, but is
#' limited by preanalytic factors and the intricacies of complex data
#' processing. Therefore, we investigated whether standardized sample protocols
#' and new bioinformatic tools combined with external data validation improve
#' the validity of peptidome profiling for the discovery of pancreatic
#' cancer-associated serum markers.
#'
#' \bold{Experimental Design}: For the discovery study, two sets of sera from
#' patients with pancreatic cancer (n = 40) and healthy controls (n = 40) were
#' obtained from two different clinical centers. For external data validation,
#' we collected an independent set of samples from patients (n = 20) and healthy
#' controls (n = 20). Magnetic beads with different surface functionalities were
#' used for peptidome fractionation followed by matrix-assisted laser
#' desorption/ionization time-of-flight (MALDI-TOF) mass spectrometry (MS).
#' Data evaluation was carried out by comparing two different bioinformatic
#' strategies. Following proteome database search, the matching candidate
#' peptide was verified by MALDI-TOF MS after specific antibody-based
#' immunoaffinity chromatography and independently confirmed by an ELISA assay.
#'
#' \bold{Results}: Two significant peaks (m/z 3884; 5959) achieved a
#' sensitivity of 86.3\% and a specificity of 97.6\% for the discrimination of
#' patients and healthy controls in the external validation set. Adding peak
#' m/z 3884 to conventional clinical tumor markers (CA 19-9 and CEA) improved
#' sensitivity and specificity, as shown by receiver operator characteristics
#' curve analysis (AUROCcombined = 1.00). Mass spectrometry-based m/z 3884
#' peak identification and following immunologic quantitation revealed platelet
#' factor 4 as the corresponding peptide.
#'
#' \bold{Conclusions}: MALDI-TOF MS-based serum peptidome profiling allowed the
#' discovery and validation of platelet factor 4 as a new discriminating marker
#' in pancreatic cancer.
#'
#' @title Serum peptidome profiling revealed platelet factor 4 as a potential
#' discriminating Peptide associated with pancreatic cancer
#'
#' @format
#'  A list containing 480 \code{\link[MALDIquant]{MassSpectrum-class}}
#'  objects.
#'
#'  Three sets:
#'  \enumerate{
#'    \item 20 patients with pancreatic cancer and 20 healthy patients from
#'    University hospital Leipzig (set A, discovery).
#'    \item 20 patients with pancreatic cancer and 20 healthy patients from
#'    University hospital Heidelberg (set B, discovery).
#'    \item 20 patients with pancreatic cancer and 20 healthy patients from
#'    University hospital Leipzig (set C, validation, half resolution).
#'  }
#'
#'  Set A and B were measured on the same target (batch). Set C was measured a
#'  few month later. \cr
#'  Each sample has four technical replicates.
#'
#' @usage getPathFiedler2009
#' @return Returns a \code{character} vector of length two. The first element is
#' the local path to the tar-archive of the spectra and the second is the path
#' to the csv file with additional information about each spectrum.
#'
#' @references
#' Fiedler, Georg Martin, et al. "Serum peptidome profiling revealed platelet
#' factor 4 as a potential discriminating Peptide associated with pancreatic
#' cancer." Clinical Cancer Research 15.11 (2009): 3812-3819.
#'
#' @examples
#' library("MALDIquantExamples")
#' getPathFiedler2009()
#'
#' @keywords datasets
#' @export
getPathFiedler2009 <- function() {
  spectra <- system.file(file.path("extdata", "fiedler2009", "spectra.tar.gz"),
                                   package="MALDIquantExamples", mustWork=TRUE)
  info <- system.file(file.path("extdata", "fiedler2009", "spectra_info.csv"),
                                package="MALDIquantExamples", mustWork=TRUE)
  return(c(spectra=spectra, info=info))
}

