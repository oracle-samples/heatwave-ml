-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile=1;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

DROP TABLE IF EXISTS yolanda_train;
CREATE TABLE yolanda_train (Feature_1 FLOAT, Feature_2 FLOAT, Feature_3 FLOAT, Feature_4 FLOAT, Feature_5 FLOAT, Feature_6 FLOAT, Feature_7 FLOAT, Feature_8 FLOAT, Feature_9 FLOAT, Feature_10 FLOAT, Feature_11 FLOAT, Feature_12 FLOAT, Feature_13 FLOAT, Feature_14 FLOAT, Feature_15 FLOAT, Feature_16 FLOAT, Feature_17 FLOAT, Feature_18 FLOAT, Feature_19 FLOAT, Feature_20 FLOAT, Feature_21 FLOAT, Feature_22 FLOAT, Feature_23 FLOAT, Feature_24 FLOAT, Feature_25 FLOAT, Feature_26 FLOAT, Feature_27 FLOAT, Feature_28 FLOAT, Feature_29 FLOAT, Feature_30 FLOAT, Feature_31 FLOAT, Feature_32 FLOAT, Feature_33 FLOAT, Feature_34 FLOAT, Feature_35 FLOAT, Feature_36 FLOAT, Feature_37 FLOAT, Feature_38 FLOAT, Feature_39 FLOAT, Feature_40 FLOAT, Feature_41 FLOAT, Feature_42 FLOAT, Feature_43 FLOAT, Feature_44 FLOAT, Feature_45 FLOAT, Feature_46 FLOAT, Feature_47 FLOAT, Feature_48 FLOAT, Feature_49 FLOAT, Feature_50 FLOAT, Feature_51 FLOAT, Feature_52 FLOAT, Feature_53 FLOAT, Feature_54 FLOAT, Feature_55 FLOAT, Feature_56 FLOAT, Feature_57 FLOAT, Feature_58 FLOAT, Feature_59 FLOAT, Feature_60 FLOAT, Feature_61 FLOAT, Feature_62 FLOAT, Feature_63 FLOAT, Feature_64 FLOAT, Feature_65 FLOAT, Feature_66 FLOAT, Feature_67 FLOAT, Feature_68 FLOAT, Feature_69 FLOAT, Feature_70 FLOAT, Feature_71 FLOAT, Feature_72 FLOAT, Feature_73 FLOAT, Feature_74 FLOAT, Feature_75 FLOAT, Feature_76 FLOAT, Feature_77 FLOAT, Feature_78 FLOAT, Feature_79 FLOAT, Feature_80 FLOAT, Feature_81 FLOAT, Feature_82 FLOAT, Feature_83 FLOAT, Feature_84 FLOAT, Feature_85 FLOAT, Feature_86 FLOAT, Feature_87 FLOAT, Feature_88 FLOAT, Feature_89 FLOAT, Feature_90 FLOAT, Feature_91 FLOAT, Feature_92 FLOAT, Feature_93 FLOAT, Feature_94 FLOAT, Feature_95 FLOAT, Feature_96 FLOAT, Feature_97 FLOAT, Feature_98 FLOAT, Feature_99 FLOAT, Feature_100 FLOAT, Feature_101 FLOAT );

DROP TABLE IF EXISTS yolanda_test;
CREATE TABLE yolanda_test LIKE yolanda_train;

\js
util.importTable("yolanda_train.csv",{table: "yolanda_train", dialect: "csv-unix", skipRows:1})
util.importTable("yolanda_test.csv",{table: "yolanda_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.yolanda_train', 'Feature_101', JSON_OBJECT('task', 'regression'), @model);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.yolanda_test', 'Feature_101', @model, 'r2', @score);
-- Print the score
SELECT @score;

DROP DATABASE heatwaveml_bench;