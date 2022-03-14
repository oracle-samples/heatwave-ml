-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile=1;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

DROP TABLE IF EXISTS airlines_train;
CREATE TABLE airlines_train (Airline VARCHAR(255), Flight FLOAT, AirportFrom VARCHAR(255), AirportTo VARCHAR(255), DayOfWeek INT, Time FLOAT, Length FLOAT, Delay INT);

DROP TABLE IF EXISTS airlines_test;
CREATE TABLE airlines_test LIKE airlines_train;

\js
util.importTable("airlines_train.csv",{table: "airlines_train", dialect: "csv-unix", skipRows:1})
util.importTable("airlines_test.csv",{table: "airlines_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.airlines_train', 'Delay', JSON_OBJECT('task', 'classification'), @model);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.airlines_test', 'Delay', @model, 'balanced_accuracy', @score);
-- Print the score
SELECT @score;

DROP DATABASE heatwaveml_bench;