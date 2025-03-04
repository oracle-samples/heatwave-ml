-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile = 1;
DROP DATABASE IF EXISTS heatwaveml_bench;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

CREATE TABLE nyc_taxi_train (VendorID INT, store_and_fwd_flag VARCHAR(255), RatecodeID INT, PULocationID INT, DOLocationID INT, passenger_count FLOAT, extra FLOAT,
mta_tax FLOAT, tip_amount FLOAT, tolls_amount FLOAT, improvement_surcharge FLOAT, trip_type INT, lpep_pickup_datetime_day FLOAT, lpep_pickup_datetime_hour FLOAT, lpep_pickup_datetime_minute FLOAT);
CREATE TABLE nyc_taxi_test LIKE nyc_taxi_train;

\js
util.importTable("nyc_taxi_train.csv",{table: "nyc_taxi_train", dialect: "csv-unix", skipRows:1})
util.importTable("nyc_taxi_test.csv",{table: "nyc_taxi_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.nyc_taxi_train', 'tip_amount', JSON_OBJECT('task', 'regression'), @model_nyc_taxi);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model_nyc_taxi, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.nyc_taxi_test', 'tip_amount', @model_nyc_taxi, 'r2', @score_nyc_taxi, null);
-- Print the score
SELECT @score_nyc_taxi;

DROP DATABASE heatwaveml_bench;
