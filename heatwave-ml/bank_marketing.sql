-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile = 1;
DROP DATABASE IF EXISTS heatwaveml_bench;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

CREATE TABLE bank_marketing_train (age INT, job VARCHAR(255), marital VARCHAR(255), education VARCHAR(255), default1 VARCHAR(255), balance FLOAT, housing VARCHAR(255), loan VARCHAR(255), contact VARCHAR(255), day INT, month VARCHAR(255), duration FLOAT, campaign INT, pdays FLOAT, previous FLOAT, poutcome VARCHAR(255), y VARCHAR(255));
CREATE TABLE bank_marketing_test LIKE bank_marketing_train;

\js
util.importTable("bank_marketing_train.csv",{table: "bank_marketing_train", dialect: "csv-unix", skipRows:1})
util.importTable("bank_marketing_test.csv",{table: "bank_marketing_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.bank_marketing_train', 'y', JSON_OBJECT('task', 'classification'), @model_bank);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model_bank, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.bank_marketing_test', 'y', @model_bank, 'balanced_accuracy', @score_bank, null);
-- Print the score
SELECT @score_bank;

DROP DATABASE heatwaveml_bench;
