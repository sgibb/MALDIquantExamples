# MALDIquant Examples

In this repository you find some examples to analyze mass spectrometry data
using [MALDIquant](http://strimmerlab.org/software/maldiquant/).

## Description

MALDIquant provides a complete analysis pipeline for MALDI-TOF and other mass
spectrometry data. Distinctive features include baseline subtraction methods
such as TopHat or SNIP, peak alignment using warping functions,
handling of replicated measurements as well as allowing spectra with
different resolutions.

Please visit: http://strimmerlab.org/software/maldiquant/

## Details

### MALDIquant examples

- [Preprocessing and peak detection example.](https://github.com/sgibb/MALDIquantExamples/blob/master/processing-peaks.R)
- [Mass calibration.](https://github.com/sgibb/MALDIquantExamples/blob/master/mass-calibration.R)
- [Direct Infusion/Orbitrap workflow.](https://github.com/sgibb/MALDIquantExamples/blob/master/DIMS.R)


- [R code to reproduce figure 1 used in Gibb and Strimmer 2012.](https://github.com/sgibb/MALDIquantExamples/blob/master/createFigure1.R)

### MALDIquantForeign examples

- [Data import using MALDIquantForeign.](https://github.com/sgibb/MALDIquantExamples/blob/master/import.R)


### Demo files distributed with the MALDIquant R package
- [Comparison of different baseline
  corrections.](https://github.com/sgibb/MALDIquant/blob/master/demo/baseline.R)
- [Peak detection and labeling.](https://github.com/sgibb/MALDIquant/blob/master/demo/peaks.R)
- [Illustration of peak alignment by
  warping.](https://github.com/sgibb/MALDIquant/blob/master/demo/warping.R)
- [Example
  workflow.](https://github.com/sgibb/MALDIquant/blob/master/demo/workflow.R)

## Download and Install

Download the zip file:

https://github.com/sgibb/MALDIquantExamples/archive/master.zip

or use

`git clone https://github.com/sgibb/MALDIquantExamples.git`

## Run

Run the example files in `R`:

```s
source("name_of_example_file.R")

## e.g.:
source("DIMS.R")
```

