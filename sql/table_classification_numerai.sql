-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile = 1;
DROP DATABASE IF EXISTS heatwaveml_bench;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

CREATE TABLE `numerai_train` ( attribute_0 FLOAT, attribute_1 FLOAT, attribute_2 FLOAT, attribute_3 FLOAT, attribute_4 FLOAT, attribute_5 FLOAT, attribute_6 FLOAT, attribute_7 FLOAT, attribute_8 FLOAT, attribute_9 FLOAT, attribute_10 FLOAT, attribute_11 FLOAT, attribute_12 FLOAT, attribute_13 FLOAT, attribute_14 FLOAT, attribute_15 FLOAT, attribute_16 FLOAT, attribute_17 FLOAT, attribute_18 FLOAT, attribute_19 FLOAT, attribute_20 FLOAT, attribute_21 INT);
CREATE TABLE `numerai_test` LIKE `numerai_train`;

\js
util.importTable("numerai28.6_train.csv",{table: "numerai_train", dialect: "csv-unix", skipRows:1})
util.importTable("numerai28.6_test.csv",{table: "numerai_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.numerai_train', 'attribute_21', JSON_OBJECT('task', 'classification'), @model_numerai);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model_numerai, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.numerai_test', 'attribute_21', @model_numerai, 'balanced_accuracy', @score_numerai, null);
-- Print the score
SELECT @score_numerai;

DROP DATABASE heatwaveml_bench;
