-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

DROP DATABASE IF EXISTS heatwaveml_bench;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

CREATE TABLE higgs_train ( target FLOAT, lepton_pT FLOAT, lepton_eta FLOAT, lepton_phi FLOAT, missing_energy_magnitude FLOAT, missing_energy_phi FLOAT, jet_1_pt FLOAT, jet_1_eta FLOAT, jet_1_phi FLOAT, `jet_1_b-tag` FLOAT, jet_2_pt FLOAT, jet_2_eta FLOAT, jet_2_phi FLOAT, `jet_2_b-tag` FLOAT, jet_3_pt FLOAT, jet_3_eta FLOAT, jet_3_phi FLOAT, `jet_3_b-tag` FLOAT, jet_4_pt FLOAT, jet_4_eta FLOAT, jet_4_phi FLOAT, `jet_4_b-tag` FLOAT, m_jj FLOAT, m_jjj FLOAT, m_lv FLOAT, m_jlv FLOAT, m_bb FLOAT, m_wbb FLOAT, m_wwbb FLOAT);
CREATE TABLE higgs_test LIKE higgs_train;

\js
util.importTable("higgs_train.csv",{table: "higgs_train", dialect: "csv-unix", skipRows:1})
util.importTable("higgs_test.csv",{table: "higgs_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.higgs_train', 'target', JSON_OBJECT('task', 'classification'), @model);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.higgs_test', 'target', @model, 'balanced_accuracy', @score);
-- Print the score
SELECT @score;

DROP DATABASE heatwaveml_bench;