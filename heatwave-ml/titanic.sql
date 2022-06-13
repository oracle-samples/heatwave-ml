-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

DROP DATABASE IF EXISTS heatwaveml_bench;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

CREATE TABLE titanic_train ( pclass INT, survived INT, name VARCHAR(255), sex VARCHAR(255), age FLOAT, sibsp INT, parch INT, ticket VARCHAR(255), fare FLOAT, cabin VARCHAR(255), embarked VARCHAR(255), boat VARCHAR(255), body FLOAT, `home.dest` VARCHAR(255));
CREATE TABLE titanic_test LIKE titanic_train;

\js
util.importTable("titanic_train.csv",{table: "titanic_train", dialect: "csv-unix", skipRows:1})
util.importTable("titanic_test.csv",{table: "titanic_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.titanic_train', 'survived', JSON_OBJECT('task', 'classification'), @model);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.titanic_test', 'survived', @model, 'balanced_accuracy', @score);
-- Print the score
SELECT @score;

DROP DATABASE heatwaveml_bench;