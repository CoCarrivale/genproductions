#!/bin/bash

export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh
export SCRAM_ARCH=el8_amd64_gcc10

cd /afs/cern.ch/user/c/covarell/work/zzpol_slc8/genproductions/bin/MadGraph5_aMCatNLO/ZZTo4L_test/ZZTo4L_test_gridpack/src 
eval `scram runtime -sh`
cd - 
cmsRun /afs/cern.ch/user/c/covarell/work/zzpol_slc8/genproductions/bin/MadGraph5_aMCatNLO/ZZTo4L_test/ZZTo4L_test_gridpack/src/zzpol${1}_cfg.py
cp out.yoda /afs/cern.ch/user/c/covarell/work/zzpol_slc8/genproductions/bin/MadGraph5_aMCatNLO/out${1}.yoda

