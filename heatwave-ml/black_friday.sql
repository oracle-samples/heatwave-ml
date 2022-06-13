-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

DROP DATABASE IF EXISTS heatwaveml_bench;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

CREATE TABLE black_friday_train (Gender VARCHAR(255), Age VARCHAR(255), Occupation VARCHAR(255), City_Category VARCHAR(255), Stay_In_Current_City_Years VARCHAR(255), Marital_Status VARCHAR(255), Product_Category_1 VARCHAR(255), Product_Category_2 VARCHAR(255), Product_Category_3 VARCHAR(255), Purchase FLOAT);
CREATE TABLE black_friday_test LIKE black_friday_train;

\js
util.importTable("black_friday_train.csv",{table: "black_friday_train", dialect: "csv-unix", skipRows:1})
util.importTable("black_friday_test.csv",{table: "black_friday_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.black_friday_train', 'Purchase', JSON_OBJECT('task', 'regression'), @model);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.black_friday_test', 'Purchase', @model, 'r2', @score);
-- Print the score
SELECT @score;

DROP DATABASE heatwaveml_bench;