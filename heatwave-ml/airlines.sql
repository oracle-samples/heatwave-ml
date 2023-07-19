-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile = 1;
DROP DATABASE IF EXISTS heatwaveml_bench;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

CREATE TABLE airlines_train (Airline VARCHAR(255), Flight FLOAT, AirportFrom VARCHAR(255), AirportTo VARCHAR(255), DayOfWeek INT, Time FLOAT, Length FLOAT, Delay INT);
CREATE TABLE airlines_test LIKE airlines_train;

\js
util.importTable("airlines_train.csv",{table: "airlines_train", dialect: "csv-unix", skipRows:1})
util.importTable("airlines_test.csv",{table: "airlines_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.airlines_train', 'Delay', JSON_OBJECT('task', 'classification'), @model_airlines);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model_airlines, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.airlines_test', 'Delay', @model_airlines, 'balanced_accuracy', @score_airlines, null);
-- Print the score
SELECT @score_airlines;

DROP DATABASE heatwaveml_bench;
