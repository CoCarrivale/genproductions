# Line by line instructions for the POWHEG tutorial

Choose a recent CMSSW release. While POWHEG is not CMS code, this is useful to define a precise set of
C++/fortran compilers, additional libraries etc. of which memory will be kept when the POWHEG workflow is 
submitted to official production. NOTICE THE DIFFERENCE WITH MADGRAPH CMS SETUP, where the CMSSW release is chosen
only later, when defining a specific event generation.

```
setenv SCRAM_ARCH slc7_amd64_gcc900  (in bash: export SCRAM_ARCH=slc7_amd64_gcc900)
scram p -n pwgtutorial_11_2_4 CMSSW_11_2_4
cd pwgtutorial_11_2_4/src
eval `scram runtime -csh`  (in bash: -sh)
```

Download the "genproductions" package, which is a generic container for CMS MC-generator scripts and configuration cards. 

```
git clone -b tutorial-21-05-20 git@github.com:covarell/genproductions.git
cd genproductions/bin/Powheg
```

Run the "manyseeds" job (generates Higgs in gluon fusion, at the NLO QCD and with heavy-quark masses properly
taken into account)

```
nohup python ./run_pwg_parallel_condor.py -i tutorial_ggH_powheg.input -m gg_H_quark-mass-effects -x 2 -f my_tutorial_ggHfull -q espresso -q2 longlunch -j 10 > check_manyseeds.log &
``` 
