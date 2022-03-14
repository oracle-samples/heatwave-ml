-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile=1;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

DROP TABLE IF EXISTS creditcard_train;
CREATE TABLE creditcard_train ( Time INT, V1 FLOAT, V2 FLOAT, V3 FLOAT, V4 FLOAT, V5 FLOAT, V6 FLOAT, V7 FLOAT, V8 FLOAT, V9 FLOAT, V10 FLOAT, V11 FLOAT, V12 FLOAT, V13 FLOAT, V14 FLOAT, V15 FLOAT, V16 FLOAT, V17 FLOAT, V18 FLOAT, V19 FLOAT, V20 FLOAT, V21 FLOAT, V22 FLOAT, V23 FLOAT, V24 FLOAT, V25 FLOAT, V26 FLOAT, V27 FLOAT, V28 FLOAT, Amount FLOAT, Class INT);

DROP TABLE IF EXISTS creditcard_test;
CREATE TABLE creditcard_test LIKE creditcard_train;

\js
util.importTable("creditcard_train.csv",{table: "creditcard_train", dialect: "csv-unix", skipRows:1})
util.importTable("creditcard_test.csv",{table: "creditcard_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.creditcard_train', 'Class', JSON_OBJECT('task', 'classification'), @model);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.creditcard_test', 'Class', @model, 'balanced_accuracy', @score);
-- Print the score
SELECT @score;

DROP DATABASE heatwaveml_bench;