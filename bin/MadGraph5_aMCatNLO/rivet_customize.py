import FWCore.ParameterSet.Config as cms

def customise(process):
    process.load('GeneratorInterface.RivetInterface.rivetAnalyzer_cfi')
    process.rivetAnalyzer.AnalysisNames = cms.vstring('COMETA_ZZ_production_analysis_Rivet3')
    process.rivetAnalyzer.useLHEweights = cms.bool(True)
    process.rivetAnalyzer.LHECollection = cms.InputTag('externalLHEProducer')
    process.generation_step+=process.rivetAnalyzer
    process.schedule.remove(process.RAWSIMoutput_step)
    return(process)
