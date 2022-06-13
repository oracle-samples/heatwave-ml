# HeatWave ML Code for Performance Benchmarks

HeatWave is an integrated, massively parallel, high-performance, in-memory query accelerator for MySQL Database Service that accelerates performance of MySQL by orders of magnitude for analytics and mixed workloads. It is the only service that enables you to run OLTP and OLAP workloads simultaneously and directly from your MySQL database, without any changes to your applications. This eliminates the need for complex, time-consuming, and expensive data movement and integration with a separate analytics database. Your applications connect to the HeatWave cluster through standard MySQL protocols, and You can manage HeatWave via Oracle Cloud REST APIs, SDKs, and the Console.

MySQL HeatWave users currently do not have an easy way of creating machine-learning models for their data in the database, or generating predictions and explanations for it. Such users, while being database experts, frequently are relatively new to Machine Learning and can benefit from products that streamline the creation and usage of machine learning models. HeatWave ML is the product that addresses this need.

This set of benchmarks is based around popularly used datasets in Machine Learning fetched from multiple sources.

| Benchmark       | Explanation                                                                                          | #Rows (Training Set) | #Features |
| --------------- | ---------------------------------------------------------------------------------------------------- | -------------------- | --------- |
| airlines        | Predict Flight Delays                                                                                | 377568               | 8         |
| bank_marketing  | Direct marketing – Banking Products                                                                  | 31648                | 17        |
| cnae-9          | Documents with free text business descriptions of Brazilian companies                                | 757                  | 857       |
| connect-4       | 8-ply positions in the game of connect-4 in which neither player has won yet – predict win/loss      | 47290                | 161       |
| fashion_mnist   | Clothing classification problem                                                                      | 60000                | 785       |
| nomao           | Active learning is used to efficiently detect data that refer to a same place based on Nomao browser | 24126                | 119       |
| numerai         | Data is cleaned, regularized and encrypted global equity data                                        | 67425                | 22        |
| higgs           | Monte Carlo Simulations                                                                              | 10500000             | 29        |
| census          | Determine if a person makes > 50k                                                                    | 32561                | 15        |
| titanic         | Survival Status of individuals                                                                       | 917                  | 14        |
| creditcard      | Identify fraudulent  transactions                                                                    | 199364               | 30        |
| appetency       | Predict the propensity of customers to buy new products                                              | 35000                | 230       |
| black_friday    | Customer purchases on Black Friday                                                                   | 116774               | 10        |
| diamonds        | Predict price of a diamond                                                                           | 37758                | 10        |
| mercedes        | Time the car took to pass testing                                                                    | 2946                 | 377       |
| news_popularity | Predict the number of shares of article in social networks (popularity)                              | 27750                | 60        |
| nyc_taxi        | Predict tip amount for NYC taxi cab                                                                  | 407284               | 15        |
| twitter         | The popularity of a topic on social media                                                            | 408275               | 78        |


## Software prerequisites:
1. [Python 3.8][1]
2. [MySQL Shell][2]

## Required Services:
1. [Oracle Cloud Infrastructure][3]
2. [MySQL Database Service][4] and [HeatWave][5]

## Getting started
1. Provision MySQL Database Service instance and add a 2-node HeatWave cluster.
2. Clone this repository and change directories
```
git clone https://github.com/oracle-samples/heatwave-ml.git
cd heatwave-ml
```
3. Create a Python virtual environment and activate it as follows
```
python3.8 -m venv py_heatwaveml
source py_heatwaveml/bin/activate
```
3. Install the necessary Python packages
```
pip install pandas==1.4.2 numpy==1.22.3 unlzw3==0.2.1 sklearn==1.0.2
```

## Download and Preprocess the datasets to the current directory
Click on the link below to download the respective benchmark. You can also use wget from the command line.

airlines

- https://www.openml.org/data/get_csv/66526/phpvcoG8S

bank_marketing

- https://archive.ics.uci.edu/ml/machine-learning-databases/00222/bank.zip

cnae-9

- https://www.openml.org/data/get_csv/1586233/phpmcGu2X

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

- https://www.openml.org/data/get_csv/2160285/phpg2t68G

higgs

- https://archive.ics.uci.edu/ml/machine-learning-databases/00280/HIGGS.csv.gz

census

- https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data
- https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test

titanic

- https://www.openml.org/data/get_csv/16826755/phpMYEkMl

creditcard (Please download the below dataset, convert it to csv and save it as creditcard.csv)

- http://www.ulb.ac.be/di/map/adalpozz/data/creditcard.Rdata

appetency

- https://www.openml.org/data/get_csv/53994/KDDCup09_appetency.arff

twitter

- https://archive.ics.uci.edu/ml/machine-learning-databases/00248/regression.tar.gz

nyc_taxi

- https://www.openml.org/data/get_csv/22044763/dataset

news_popularity

- https://www.openml.org/data/get_csv/22044756/dataset

black_friday

- https://www.openml.org/data/get_csv/21230845/file639340bd9ca9.arff

mercedes

- https://www.openml.org/data/get_csv/21854646/dataset

diamonds

- https://www.openml.org/data/get_csv/21792853/dataset


After you have downloaded a benchmark, run the preprocess.py script with the benchmark name as below
```
python3 heatwave-ml/preprocess.py --benchmark <name>
```

## Running a benchmark
Launch MySQL Shell as below
```
mysqlsh user@hostname --mysql --sql
```
On the mysql-shell prompt, run
```
> source heatwave-ml/<benchmark_name>.sql
```
where <benchmark_name> is a name from the above table. The train and test csvs generated above should
be present in the current directory in MySQL Shell. Each SQL file will create the schemas for a benchmark,
train a HeatWave ML model on it, and score the model on the test data. The test score will be output at the e
end.

## Running scalability experiments
In order to run scalability numbers for HeatWave ML, for the benchmarks above, run the ML_TRAIN commands from the sql files above for each benchmark on 1, 2, 4, 8 and 16 nodes. Measure the end-to-end training time (ML_TRAIN time from MySQL client perspective) for each configuration (benchmark + number of nodes). Graphing the number of nodes against the runtime on each node should give the scalability for a benchmark.

## How to Contribute
Refer to [CONTRIBUTING.md](CONTRIBUTING.md)

 [1]: https://www.python.org/downloads/release/python-3813/
 [2]: https://dev.mysql.com/doc/mysql-shell/8.0/en/
 [3]: https://docs.cloud.oracle.com/en-us/iaas/Content/home.htm
 [4]: https://docs.oracle.com/en-us/iaas/mysql-database/
 [5]: https://dev.mysql.com/doc/heatwave/en/