#!/bin/sh
###############################################################################
## this script creates the dataset in
## inst/extdata/nyakas2013/spectra.tar.gz
###############################################################################

wget http://files.figshare.com/1106682/MouseKidney_IMS_testdata.zip
unzip MouseKidney_IMS_testdata.zip
mv "Imaging - Demo Datensatz/130611_MouseKidney" nyakas2013
find nyakas2013 -name "Analysis*" -exec rm -rf {} \;
tar -cvzf spectra.tar.gz nyakas2013/
mkdir -p ../../extdata/nyakas2013
mv spectra.tar.gz ../../extdata/nyakas2013
rm -rf "Imaging - Demo Datensatz" MouseKidney_IMS_testdata.zip nyakas2013 __MACOSX
