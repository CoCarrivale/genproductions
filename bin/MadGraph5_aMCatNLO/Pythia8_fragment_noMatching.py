import FWCore.ParameterSet.Config as cms

externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
 args = cms.vstring('/eos/user/c/ccarriva/ZZpol/ZZTo4L_LL_el9_amd64_gcc11_CMSSW_13_2_9_tarball.tar.xz'),
 nEvents = cms.untracked.uint32(250000),
 numberOfParameters = cms.uint32(1),
 outputFile = cms.string('cmsgrid_final.lhe'),
 scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh')
)

#from Configuration.Generator.Pythia8CommonSettings_cfi import *
#from Configuration.Generator.MCTunes2017.PythiaCP5Settings_cfi import *
#from Configuration.Generator.Pythia8aMCatNLOSettings_cfi import *
#from Configuration.Generator.PSweightsPythia.PythiaPSweightsSettings_cfi import *

generator = cms.EDFilter("Pythia8HadronizerFilter",
    maxEventsToPrint = cms.untracked.int32(1),
    pythiaPylistVerbosity = cms.untracked.int32(1),
    filterEfficiency = cms.untracked.double(1.0),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    comEnergy = cms.double(13000.),
    PythiaParameters = cms.PSet(
    #    pythia8CommonSettingsBlock,
    #    pythia8CP5SettingsBlock,
        processParameters = cms.vstring(
            'Main:timesAllowErrors = 10000',
            'Check:epTolErr = 0.01',
            'Beams:setProductionScalesFromLHEF = off',
            'SLHA:minMassSM = 1000.',
            'ParticleDecays:limitTau0 = on',
            'ParticleDecays:tau0Max = 10',
            'HadronLevel:all = off', 
            'PartonLevel:MPI = off', 
            'ParticleDecays:allowPhotonRadiation = off',
            'Tune:pp 21',  # "ATLAS A14 central tune with NNPDF2.3LO" [default=14, Monash 2013]
            'PDF:pSet 13' # NNPDF2.3 QCD+QED LO alpha_s(M_Z) = 0.130
        ),
        parameterSets = cms.vstring(
          #  'pythia8CommonSettings',
          #  'pythia8CP5Settings',
            'processParameters',
        )
    )
)
