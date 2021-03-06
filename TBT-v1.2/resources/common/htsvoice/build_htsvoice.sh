#! bin/bash

###########################################################################
##                                                                       ##
##                Centre for Development of Advanced Computing           ##
##                               Mumbai                                  ##
##                         Copyright (c) 2017                            ##
##                        All Rights Reserved.                           ##
##                                                                       ##
##  Permission is hereby granted, free of charge, to use and distribute  ##
##  this software and its documentation without restriction, including   ##
##  without limitation the rights to use, copy, modify, merge, publish,  ##
##  distribute, sublicense, and/or sell copies of this work, and to      ##
##  permit persons to whom this work is furnished to do so, subject to   ##
##  the following conditions:                                            ##
##   1. The code must retain the above copyright notice, this list of    ##
##      conditions and the following disclaimer.                         ##
##   2. Any modifications must be clearly marked as such.                ##
##   3. Original authors' names are not deleted.                         ##
##   4. The authors' names are not used to endorse or promote products   ##
##      derived from this software without specific prior written        ##
##      permission.                                                      ##
##                                                                       ##
##                                                                       ##
###########################################################################
##                                                                       ##
##                     TTS Building Toolkit                              ##
##                                                                       ##
##            Designed and Developed by Atish and Rachana                ##
##          		Date:  April 2017                                ##
##                                                                       ## 
###########################################################################

#HTS-demo_CMU-ARCTIC-SLT requires Festival-2.4, SPTK-3.9, HTS-2.3, and hts_engine API-1.10.
#Please install them before running this demo.


sudo locate SPTK > sptk_list
sudo locate hts_engine_API-1.10 > hts_engine_list
sptk=$(head -1 sptk_list) > list1
hts_engine=$(head -1 hts_engine_list) > list2

#cd HTS-demo_CMU-ARCTIC-SLT
./configure --with-fest-search-path=$FESTDIR/examples \
                 --with-sptk-search-path=$sptk/bin \
                 --with-hts-search-path=/usr/local/HTS-2.3/bin \
                 --with-hts-engine-search-path=$hts_engine/bin


echo "================DONE WITH HTSVOICE SETUP======================"


echo "##########Raw files generation Started##########################"

LNG=$1

rm -rf data/raw
rm -rf data/utts
rm -rf data/questions
rm -rf data/Makefile
rm -rf data/labels/gen
rm -rf scripts/Training.pl
mkdir data/labels/gen


cp -r ../temp/htsvoice/raw_files/raw data/
cp -r ../resources/languages/$LNG/htsvoice/questions data/
cp -r ../temp/htsvoice/utts data/
cp -r ../resources/common/htsvoice/call_make.sh data/

cp -r ../resources/common/htsvoice/Makefile data/
cp -r ../resources/common/htsvoice/scripts_of_htsvoice/Training.pl scripts/
cp -r ../resources/common/htsvoice/scripts_of_htsvoice/build_train_scp_from_fal.sh scripts/ 

make

cp -r voices/qst001/ver1/cmu_us_arctic_slt.htsvoice ../output

#rm -rf  hts_engine_list list1 list2 sptk_list


echo "%%%%%%%%%%%%%%%Voice Building Started%%%%%%%%%Wait for Some Time==============>>>>"






