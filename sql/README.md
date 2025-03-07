# HeatWave ML Code for Performance Benchmarks

This set of benchmarks is based around popularly used datasets in Machine Learning fetched from multiple sources.

## Software prerequisites:
1. [Python 3.8][1]
2. [MySQL Shell][2]

## Download and Preprocess the datasets to the current directory
Click on the link below to download the respective benchmark. You can also use wget from the command line.

airlines

- https://www.openml.org/data/get_csv/66526/phpvcoG8S.csv

bank_marketing

- https://archive.ics.uci.edu/ml/machine-learning-databases/00222/bank.zip

cnae-9

- https://www.openml.org/data/get_csv/1586233/phpmcGu2X.csv

connect-4

- https://archive.ics.uci.edu/ml/machine-learning-databases/connect-4/connect-4.data.Z

fashion_mnist

- https://github.com/zalandoresearch/fashion-mnist/blob/master/data/fashion/t10k-images-idx3-ubyte.gz
- https://github.com/zalandoresearch/fashion-mnist/blob/master/data/fashion/t10k-labels-idx1-ubyte.gz
- https://github.com/zalandoresearch/fashion-mnist/blob/master/data/fashion/train-images-idx3-ubyte.gz
- https://github.com/zalandoresearch/fashion-mnist/blob/master/data/fashion/train-labels-idx1-ubyte.gz

nomao

- https://archive.ics.uci.edu/ml/machine-learning-databases/00227/Nomao.zip

numerai

- https://www.openml.org/data/get_csv/2160285/phpg2t68G.csv

higgs

- https://archive.ics.uci.edu/ml/machine-learning-databases/00280/HIGGS.csv.gz

census

- https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data
- https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test

titanic

- https://www.openml.org/data/get_csv/16826755/phpMYEkMl.csv

creditcard

- http://www.ulb.ac.be/di/map/adalpozz/data/creditcard.Rdata

appetency

- https://www.openml.org/data/get_csv/53994/KDDCup09_appetency.arff

twitter

- https://archive.ics.uci.edu/ml/machine-learning-databases/00248/regression.tar.gz

nyc_taxi

- https://www.openml.org/data/get_csv/22044763/dataset.csv

news_popularity

- https://www.openml.org/data/get_csv/22044756/dataset.csv

black_friday

- https://www.openml.org/data/get_csv/21230845/file639340bd9ca9.arff

mercedes

- https://www.openml.org/data/get_csv/21854646/dataset.csv

diamonds

- https://www.openml.org/data/get_csv/21792853/dataset.csv


After you have downloaded a benchmark, run the preprocess.py script with the benchmark name as below
```
python3 sql/preprocess.py --benchmark <name>
```

## Running a benchmark
Launch MySQL Shell as below
```
mysqlsh user@hostname --mysql --sql
```
On the mysql-shell prompt, run
```
> source sql/<benchmark_name>.sql
```
where <benchmark_name> is a name from the above table. The train and test csvs generated above should
be present in the current directory in MySQL Shell. Each SQL file will create the schemas for a benchmark,
train a HeatWave ML model on it, and score the model on the test data. The test score will be output at the e
end.

## Running scalability experiments
In order to run scalability numbers for HeatWave ML, for the benchmarks above, run the ML_TRAIN commands from the sql files above for each benchmark on 1, 2, 4, 8 and 16 nodes. Measure the end-to-end training time (ML_TRAIN time from MySQL client perspective) for each configuration (benchmark + number of nodes). Graphing the number of nodes against the runtime on each node should give the scalability for a benchmark.

 [1]: https://www.python.org/downloads/release/python-3813/
 [2]: https://dev.mysql.com/doc/mysql-shell/8.0/en/
 [3]: https://docs.cloud.oracle.com/en-us/iaas/Content/home.htm
 [4]: https://docs.oracle.com/en-us/iaas/mysql-database/
 [5]: https://dev.mysql.com/doc/heatwave/en/
