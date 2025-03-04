-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile = 1;
DROP DATABASE IF EXISTS heatwaveml_bench;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

CREATE TABLE census_train ( age INT, workclass VARCHAR(255), fnlwgt INT, education VARCHAR(255), `education-num` INT, `marital-status` VARCHAR(255), occupation VARCHAR(255), relationship VARCHAR(255), race VARCHAR(255), sex VARCHAR(255), `capital-gain` INT, `capital-loss` INT, `hours-per-week` INT, `native-country` VARCHAR(255), revenue VARCHAR(255));
CREATE TABLE census_test LIKE census_train;

\js
util.importTable("census_train.csv",{table: "census_train", dialect: "csv-unix", skipRows:1})
util.importTable("census_test.csv",{table: "census_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.census_train', 'revenue', JSON_OBJECT('task', 'classification'), @model_census);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model_census, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.census_test', 'revenue', @model_census, 'balanced_accuracy', @score_census, null);
-- Print the score
SELECT @score_census;

DROP DATABASE heatwaveml_bench;
