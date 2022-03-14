-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile=1;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

DROP TABLE IF EXISTS `connect-4_train`;
CREATE TABLE `connect-4_train` (a1 VARCHAR(255),a2 VARCHAR(255), a3 VARCHAR(255), a4 VARCHAR(255), a5 VARCHAR(255), a6 VARCHAR(255), b1 VARCHAR(255), b2 VARCHAR(255), b3 VARCHAR(255), b4 VARCHAR(255), b5 VARCHAR(255), b6 VARCHAR(255), c1 VARCHAR(255), c2 VARCHAR(255), c3 VARCHAR(255), c4 VARCHAR(255), c5 VARCHAR(255), c6 VARCHAR(255), d1 VARCHAR(255), d2 VARCHAR(255), d3 VARCHAR(255), d4 VARCHAR(255), d5 VARCHAR(255), d6 VARCHAR(255), e1 VARCHAR(255), e2 VARCHAR(255), e3 VARCHAR(255), e4 VARCHAR(255), e5 VARCHAR(255), e6 VARCHAR(255), f1 VARCHAR(255), f2 VARCHAR(255), f3 VARCHAR(255), f4 VARCHAR(255), f5 VARCHAR(255), f6 VARCHAR(255), g1 VARCHAR(255), g2 VARCHAR(255), g3 VARCHAR(255), g4 VARCHAR(255), g5 VARCHAR(255), g6 VARCHAR(255), class VARCHAR(255));

DROP TABLE IF EXISTS `connect-4_test`;
CREATE TABLE `connect-4_test` LIKE `connect-4_train`;

\js
util.importTable("connect-4_train.csv",{table: "connect-4_train", dialect: "csv-unix", skipRows:1})
util.importTable("connect-4_test.csv",{table: "connect-4_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.`connect-4_train`', 'class', JSON_OBJECT('task', 'classification'), @model);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.`connect-4_test`', 'class', @model, 'balanced_accuracy', @score);
-- Print the score
SELECT @score;

DROP DATABASE heatwaveml_bench;