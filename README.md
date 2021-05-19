# Line by line instructions for the POWHEG tutorial

MORNING

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
nohup python ./run_pwg_parallel_condor.py -i tutorial_ggH_powheg.input -m gg_H_quark-mass-effects -x 3 -f my_tutorial_ggHfull -q espresso -q2 longlunch -j 10 > check_manyseeds.log &
``` 

"nohup" would allow you to close the shell window where the job is running. But in this case do not close it when going
for lunch, in order to check later what is happening.

AFTERNOON

Run a simple POWHEG job (generates ttbar production at the NLO QCD)

```
python ./run_pwg_condor.py -i tutorial_ttbar_powheg.input -m hvq -p f -f my_tutorial_ttbar 
```

Generate 3000 ttbar LH events.

```
mkdir test_ttbar
cd test_ttbar
tar -xzvf ../hvq_slc7_amd64_gcc900_CMSSW_11_2_4_my_tutorial_ttbar.tgz
(if the job failed: tar -xzvf /afs/cern.ch/user/c/covarell/public/tutorial-21-05-20/hvq_slc7_amd64_gcc900_CMSSW_11_2_4_my_tutorial_ttbar.tgz)
./runcmsgrid.sh 3000 12 1
```

Now move to the analysis part (LHE or NanoGEN).