-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

\sql
SET GLOBAL local_infile=1;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

DROP TABLE IF EXISTS news_popularity_train;
CREATE TABLE news_popularity_train (timedelta FLOAT, n_tokens_title FLOAT, n_tokens_content FLOAT, n_unique_tokens FLOAT, n_non_stop_words FLOAT, n_non_stop_unique_tokens FLOAT, num_hrefs FLOAT, num_self_hrefs FLOAT, num_imgs FLOAT, num_videos FLOAT, average_token_length FLOAT, num_keywords FLOAT, data_channel_is_lifestyle FLOAT, data_channel_is_entertainment FLOAT, data_channel_is_bus FLOAT, data_channel_is_socmed FLOAT, data_channel_is_tech FLOAT, data_channel_is_world FLOAT, kw_min_min FLOAT, kw_max_min FLOAT, kw_avg_min FLOAT, kw_min_max FLOAT, kw_max_max FLOAT, kw_avg_max FLOAT, kw_min_avg FLOAT, kw_max_avg FLOAT, kw_avg_avg FLOAT, self_reference_min_shares FLOAT, self_reference_max_shares FLOAT, self_reference_avg_sharess FLOAT, weekday_is_monday FLOAT, weekday_is_tuesday FLOAT, weekday_is_wednesday FLOAT, weekday_is_thursday FLOAT, weekday_is_friday FLOAT, weekday_is_saturday FLOAT, weekday_is_sunday FLOAT, is_weekend FLOAT, LDA_00 FLOAT, LDA_01 FLOAT, LDA_02 FLOAT, LDA_03 FLOAT, LDA_04 FLOAT, global_subjectivity FLOAT, global_sentiment_polarity FLOAT, global_rate_positive_words FLOAT, global_rate_negative_words FLOAT, rate_positive_words FLOAT, rate_negative_words FLOAT, avg_positive_polarity FLOAT, min_positive_polarity FLOAT, max_positive_polarity FLOAT, avg_negative_polarity FLOAT, min_negative_polarity FLOAT, max_negative_polarity FLOAT, title_subjectivity FLOAT, title_sentiment_polarity FLOAT, abs_title_subjectivity FLOAT, abs_title_sentiment_polarity FLOAT, shares FLOAT );

DROP TABLE IF EXISTS news_popularity_test;
CREATE TABLE news_popularity_test LIKE news_popularity_train;

\js
util.importTable("news_popularity_train.csv",{table: "news_popularity_train", dialect: "csv-unix", skipRows:1})
util.importTable("news_popularity_test.csv",{table: "news_popularity_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.news_popularity_train', 'shares', JSON_OBJECT('task', 'regression'), @model);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.news_popularity_test', 'shares', @model, 'r2', @score);
-- Print the score
SELECT @score;

DROP DATABASE heatwaveml_bench;