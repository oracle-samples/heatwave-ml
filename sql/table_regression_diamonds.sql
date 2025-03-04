-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile = 1;
DROP DATABASE IF EXISTS heatwaveml_bench;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

CREATE TABLE diamonds_train (carat FLOAT, cut VARCHAR(255), color VARCHAR(255), clarity VARCHAR(255), depth FLOAT, _table Float, price FLOAT , x FLOAT, y FLOAT, z FLOAT);
CREATE TABLE diamonds_test LIKE diamonds_train;

\js
util.importTable("diamonds_train.csv",{table: "diamonds_train", dialect: "csv-unix", skipRows:1})
util.importTable("diamonds_test.csv",{table: "diamonds_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.diamonds_train', 'price', JSON_OBJECT('task', 'regression'), @model_diamonds);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model_diamonds, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.diamonds_test', 'price', @model_diamonds, 'r2', @score_diamonds, null);
-- Print the score
SELECT @score_diamonds;

DROP DATABASE heatwaveml_bench;
