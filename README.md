# MALDIquant Examples
[![Build Status](https://travis-ci.org/sgibb/MALDIquantExamples.svg?branch=master)](https://travis-ci.org/sgibb/MALDIquantExamples)
[![license](http://img.shields.io/badge/license-GPL%20%28%3E=%203%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-3.0.html)

This R package provides some some examples to demonstrate how to analyze
mass spectrometry data using
[MALDIquant](http://strimmerlab.org/software/maldiquant/).

## Description

MALDIquant provides a complete analysis pipeline for MALDI-TOF and other mass
spectrometry data. Distinctive features include baseline subtraction methods
such as TopHat or SNIP, peak alignment using warping functions,
handling of replicated measurements as well as allowing spectra with
different resolutions.

Please visit: http://strimmerlab.org/software/maldiquant/

## Details

### MALDIquant examples

- [MALDIquant vignette](http://cran.r-project.org/web/packages/MALDIquant/vignettes/MALDIquant-intro.pdf)

- [Preprocessing and peak detection example - single spectrum.](https://github.com/sgibb/MALDIquant/blob/master/demo/peaks.R)

- Analysis of [Fiedler et al. 2009](http://dx.doi.org/10.1158/1078-0432.CCR-08-2701) using MALDIquant
    [vignette](https://github.com/sgibb/MALDIquantExamples/blob/master/inst/doc/fiedler2009.pdf?raw=true),
    [R code](https://github.com/sgibb/MALDIquantExamples/blob/master/inst/doc/fiedler2009.R)

- Bacterial Species Determination using MALDIquant
    [vignette](https://github.com/sgibb/MALDIquantExamples/blob/master/inst/doc/species.pdf?raw=true),
    [R code](https://github.com/sgibb/MALDIquantExamples/blob/master/inst/doc/species.R)

- [R code to reproduce figure 1 used in Gibb and Strimmer 2012](https://github.com/sgibb/MALDIquantExamples/blob/master/R/createFigure1.R)
    ([colorized version] (https://github.com/sgibb/MALDIquantExamples/blob/master/R/createFigure1_color.R)).

### MALDIquantForeign examples

- [MALDIquantForeign vignette](http://cran.r-project.org/web/packages/MALDIquantForeign/vignettes/MALDIquantForeign-intro.pdf)

### Mass Spectrometry Imaging (MSI) examples

- [Mass Spectrometry Imaging using MALDIquant.](https://github.com/sgibb/MALDIquantExamples/blob/master/inst/doc/nyakas2013.pdf?raw=true)

- [MALDIquant IMS + shiny example.](https://github.com/sgibb/ims-shiny)


### Demo files distributed with the MALDIquant R package

- [Comparison of different baseline corrections.](https://github.com/sgibb/MALDIquant/blob/master/demo/baseline.R)
- [Peak detection and labeling.](https://github.com/sgibb/MALDIquant/blob/master/demo/peaks.R)
- [Illustration of peak alignment by warping.](https://github.com/sgibb/MALDIquant/blob/master/demo/warping.R)
- [Example workflow.](https://github.com/sgibb/MALDIquant/blob/master/demo/workflow.R)

## Installation

[GitHub](https://github.com) is not supported by the basic `install.packages`
command. You could use the
[devtools](http://cran.r-project.org/web/packages/devtools/index.html) package
to install [MALDIquantExamples](https://github.com/sgibb/MALDIquantExamples).

```r
install.packages("devtools")
library("devtools")
install_github("sgibb/MALDIquantExamples")
```

## Contact

You are welcome to:

* submit suggestions and bug-reports at: <https://github.com/sgibb/MALDIquantExamples/issues>
* send a pull request on: <https://github.com/sgibb/MALDIquantExamples/>
* compose an e-mail to: <mail@sebastiangibb.de>

