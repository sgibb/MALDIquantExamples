###############################################################################
## this script collects all metadata from the spectrum files and creates
## inst/extdata/fiedler2009/spectra_info.csv
###############################################################################

###############################################################################
## load packages
###############################################################################
library("MALDIquant")
library("MALDIquantForeign")

###############################################################################
## load all spectra
###############################################################################

basedir <- file.path("..", "..", "extdata", "fiedler2009")

## read all 480 native spectra
spectra <- import(file.path(basedir, "spectra.tar.gz"))

###############################################################################
## fetch and transform metadata
###############################################################################

## get metadata: stored in the acqu files in CMT section
comments <- vapply(spectra, function(x)metaData(x)$comment[1L], character(1L))

## entries in comments are semicolon separated
comments <- read.table(textConnection(comments), sep=";", header=FALSE,
                       stringsAsFactors=FALSE)

## ID: the first/second element in the comments
patientID.orig <- comments[cbind(1:nrow(comments),
                             as.integer(grepl("Name", comments[, 1L])) + 1L)]

## health status: decoded as "disease" or "P"
health <- ifelse(grepl("^(disease|P)$", comments[, 3L]), "cancer", "control")

## experiment: discovery/validation (validation has not any letter in the IDs)
experiment <- ifelse(grepl("^[H|L]", patientID.orig), "discovery", "validation")

## location: patients from Heidelberg have an H in their ID
location <- ifelse(grepl("^H", patientID.orig), "heidelberg", "leipzig")

## create a better patientID for validation experiments
patientID <- patientID.orig
isValidation <- experiment == "validation"

## ID is now VPxxx and VCxxx for validation/cancer/x and validation/control/x
patientID[isValidation] <- paste0("V", ifelse(health[isValidation] == "cancer",
                                              "P", "C"),
                                  patientID[isValidation])
## use always 3 digit numbers for ID
patientID <- sprintf("%s%03i", substr(patientID, 1L, 2L),
                     as.integer(substr(patientID, 3L, nchar(patientID))))

###############################################################################
## write spectra_info.csv
###############################################################################

## collect all meta information in a data.frame
spectra.info <- data.frame(patientID=patientID,
                           patientID.orig=patientID.orig,
                           experiment=experiment,
                           location=location,
                           health=health,
                           stringsAsFactors=FALSE)

write.table(spectra.info, file=file.path(basedir, "spectra_info.csv"),
            sep=",", row.names=FALSE)

