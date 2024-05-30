# cmsDriver command
cmsDriver.py Configuration/GenTest/python/Pythia8_fragment_noMatching.py --python_filename zzpol_cfg.py --eventcontent RAWSIM,LHE --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN,LHE --fileout file:zzpol.root --conditions auto:mc --beamspot Realistic25ns13TeVEarly2018Collision --step LHE,GEN --geometry DB:Extended --era Run2_2018 --no_exec --mc -n $1
