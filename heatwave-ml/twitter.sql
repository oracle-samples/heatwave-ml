-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile=1;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

DROP TABLE IF EXISTS twitter_train;
CREATE TABLE twitter_train (NCD_0 FLOAT, NCD_1 FLOAT, NCD_2 FLOAT, NCD_3 FLOAT, NCD_4 FLOAT, NCD_5 FLOAT, NCD_6 FLOAT, AI_0 FLOAT, AI_1 FLOAT, AI_2 FLOAT, AI_3 FLOAT, AI_4 FLOAT, AI_5 FLOAT, AI_6 FLOAT, ASNA_0 FLOAT, ASNA_1 FLOAT, ASNA_2 FLOAT, ASNA_3 FLOAT, ASNA_4 FLOAT, ASNA_5 FLOAT, ASNA_6 FLOAT, BL_0 FLOAT, BL_1 FLOAT, BL_2 FLOAT, BL_3 FLOAT, BL_4 FLOAT, BL_5 FLOAT, BL_6 FLOAT, NAC_0 FLOAT, NAC_1 FLOAT, NAC_2 FLOAT, NAC_3 FLOAT, NAC_4 FLOAT, NAC_5 FLOAT, NAC_6 FLOAT, ASNAC_0 FLOAT, ASNAC_1 FLOAT, ASNAC_2 FLOAT, ASNAC_3 FLOAT, ASNAC_4 FLOAT, ASNAC_5 FLOAT, ASNAC_6 FLOAT, CS_0 FLOAT, CS_1 FLOAT, CS_2 FLOAT, CS_3 FLOAT, CS_4 FLOAT, CS_5 FLOAT, CS_6 FLOAT, AT_0 FLOAT, AT_1 FLOAT, AT_2 FLOAT, AT_3 FLOAT, AT_4 FLOAT, AT_5 FLOAT, AT_6 FLOAT, NA_0 FLOAT, NA_1 FLOAT, NA_2 FLOAT, NA_3 FLOAT, NA_4 FLOAT, NA_5 FLOAT, NA_6 FLOAT, ADL_0 FLOAT, ADL_1 FLOAT, ADL_2 FLOAT, ADL_3 FLOAT, ADL_4 FLOAT, ADL_5 FLOAT, ADL_6 FLOAT, NAD_0 FLOAT, NAD_1 FLOAT, NAD_2 FLOAT, NAD_3 FLOAT, NAD_4 FLOAT, NAD_5 FLOAT, NAD_6 FLOAT, Annotation FLOAT );

DROP TABLE IF EXISTS twitter_test;
CREATE TABLE twitter_test LIKE twitter_train;

\js
util.importTable("twitter_train.csv",{table: "twitter_train", dialect: "csv-unix", skipRows:1})
util.importTable("twitter_test.csv",{table: "twitter_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.twitter_train', 'Annotation', JSON_OBJECT('task', 'regression'), @model);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.twitter_test', 'Annotation', @model, 'r2', @score);
-- Print the score
SELECT @score;

DROP DATABASE heatwaveml_bench;