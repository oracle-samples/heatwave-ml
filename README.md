# HeatWave AutoML examples and performance benchmarks

[HeatWave](https://www.oracle.com/heatwave/) is an integrated, massively parallel, high-performance, in-memory query accelerator for MySQL Database Service that accelerates performance of MySQL by orders of magnitude for analytics and mixed workloads. It is the only service that enables you to run OLTP and OLAP workloads simultaneously and directly from your MySQL database, without any changes to your applications. This eliminates the need for complex, time-consuming, and expensive data movement and integration with a separate analytics database. Your applications connect to the HeatWave cluster through standard MySQL protocols.

HeatWave users currently do not have an easy way of creating machine-learning models for their data in the database, or generating predictions and explanations for it. Such users, while being database experts, frequently are relatively new to Machine Learning and can benefit from products that streamline the creation and usage of machine learning models. HeatWave AutoML is the product that addresses this need.

## Required Services:
1. [Oracle Cloud Infrastructure][3]
2. [MySQL Database Service][4] and [HeatWave][5]

## Getting started
1. Provision MySQL Database Service instance and add a HeatWave cluster.
2. Clone this repository and change directories
```
git clone https://github.com/oracle-samples/heatwave-ml.git
```
3. Create a Python virtual environment and activate it as follows
```
python3.8 -m venv py_heatwaveml
source py_heatwaveml/bin/activate
```
3. Install the necessary Python packages
```
pip install pandas numpy unlzw3 scikit-learn pyreadr --user
```

## Python Notebooks
To help customers get started with Heatwave ML and showcase its capabilities, we have prepared a set of Jupyter notebooks. Each notebook focuses on a simple application of Heatwave ML components in practice and walks you through a solution. Here is the list of existing notebooks and a screenshot of the rendered HTML.

<style>
table.wrap80 { table-layout: fixed; }
table.wrap80 th, table.wrap80 td { white-space: normal; overflow-wrap: anywhere; word-break: break-word; }
table.wrap80 col.desc { width: 80ch; }
</style>
<table>
<table class="wrap80">
<colgroup>
<col class="desc">
<col>
</colgroup>
    <tr>
        <th> Description</td>
        <th> Link</td>
    </tr>
    <tr>
        <td>Demonstrates the application of ML_GENERATE for content generation using data from the 2024 Olympic Games</td>
        <td><a href="./python/heatwave/generation.ipynb">HeatWave</a> <a href="./python/mysqlai/generation.ipynb">MySQL AI</a></td>
   </tr>
   <tr>
        <td>Demonstrates the application of ML_GENERATE for summarization using data from the 2024 Olympic Games</td>
        <td><a href="./python/heatwave/summarization.ipynb">HeatWave</a> <a href="./python/mysqlai/summarization.ipynb">MySQL AI</a></td>
   </tr>
   <tr>
        <td>Showcase the use of ML_RAG for Retrieval Augmented Generation (RAG) and HEATWAVE_CHAT for engaging in natural language interactions using data from the 2024 Olympic Games</td>
        <td><a href="./python/heatwave/rag_chat.ipynb">HeatWave</a> <a href="./python/mysqlai/rag_chat.ipynb">MySQL AI</a></td>
   </tr>
   <tr>
        <td>Training a model to predict whether a bank customer will subscribe to a term deposit</td>
        <td><a href="./python/heatwave/classification_bank_marketing.ipynb">HeatWave</a> <a href="./python/mysqlai/classification_bank_marketing.ipynb">MySQL AI</a></td>
   </tr>
   <tr>
        <td>Predict the price of a diamond based on its characteristics and prior prices of other diamonds</td>
        <td><a href="./python/heatwave/regression_diamonds.ipynb">HeatWave</a> <a href="./python/mysqlai/regression_diamonds.ipynb">MySQL AI</a></td>
   </tr>
   <tr>
        <td>Train an unsupervised anomaly detection model. In this context, "unsupervised" signifies that we'll be training our models without explicitly using the "Class" label (fraudulent or legitimate) during the training phase. Instead, we'll rely on the inherent patterns and structures within the transaction data to identify deviations from the norm.
</td>
        <td><a href="./python/heatwave/fraud_detection_creditcard.ipynb">HeatWave</a> <a href="./python/mysqlai/fraud_detection_creditcard.ipynb">MySQL AI</a></td>
   </tr>
   <tr>
        <td>Building a personalized movie recommendation system using the MovieLens 100K dataset</td>
        <td><a href="./python/heatwave/recommendations_movie_lens.ipynb">HeatWave</a> <a href="./python/mysqlai/recommendations_movie_lens.ipynb">MySQL AI</a></td>
   </tr>
    <tr>
        <td>Building and evaluating a forecasting model using the synthetic Electricity Consumption dataset</td>
        <td><a href="./python/heatwave/forecasting_synthetic_electricity_consumption_dataset.ipynb">HeatWave</a> <a href="./python/mysqlai/forecasting_synthetic_electricity_consumption_dataset.ipynb">MySQL AI</a></td>
   </tr>
   <tr>
        <td>Building a LangChain chatbot using HeatWave GenAI showing how HeatWave GenAI can be easily used with any LangChain application</td>
        <td><a href="./python/heatwave/langchain_chatbot.ipynb">HeatWave</a></td>
   </tr>
</table>

## SQL examples
SQL Code to run training, predictions and scoring on a variety of common Machine Learning classification and regression datasets.

<table>
    <tr>
        <th> Example</td>
        <th> Description</td>
        <th> #Rows (Training Set)</td>
        <th> #Features</td>
    </tr>
    <tr>
        <td><a href="./sql/table_classification_airlines.sql">airlines</a></td>
        <td>Predict Flight Delays</td>
        <td>377568</td>
        <td>8</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_bank_marketing.sql">bank_marketing</a></td>
        <td>Direct marketing – Banking Products</td>
        <td>31648</td>
        <td>17</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_cnae-9.sql">cnae-9</a></td>
        <td>Documents with free text business descriptions of Brazilian companies</td>
        <td>757</td>
        <td>857</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_connect-4.sql">connect-4</a></td>
        <td>8-ply positions in the game of connect-4 in which neither player has won yet – predict win/loss</td>
        <td>47290</td>
        <td>161</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_fashion_mnist.sql">fashion_mnist</a></td>
        <td>Clothing classification problem</td>
        <td>60000</td>
        <td>785</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_nomao.sql">nomao</a></td>
        <td>Active learning is used to efficiently detect data that refer to a same place based on Nomao browser</td>
        <td>24126</td>
        <td>119</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_numerai.sql">numerai</a></td>
        <td>Data is cleaned, regularized and encrypted global equity data</td>
        <td>67425</td>
        <td>22</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_higgs.sql">higgs</a></td>
        <td>Monte Carlo Simulations</td>
        <td>10500000</td>
        <td>29</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_census.sql">census</a></td>
        <td>Determine if a person makes > $50k</td>
        <td>32561</td>
        <td>15</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_titanic.sql">titanic</a></td>
        <td>Survival Status of individuals</td>
        <td>917</td>
        <td>14</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_creditcard.sql">creditcard</a></td>
        <td>Identify fraudulent  transactions</td>
        <td>199364</td>
        <td>30</td>
   </tr>
   <tr>
        <td><a href="./sql/table_classification_appetency.sql">appetency</a></td>
        <td>Predict the propensity of customers to buy new products</td>
        <td>35000</td>
        <td>230</td>
   </tr>
   <tr>
        <td><a href="./sql/table_regression_black_friday.sql">black_friday</a></td>
        <td>Customer purchases on Black Friday</td>
        <td>116774</td>
        <td>10</td>
   </tr>
   <tr>
        <td><a href="./sql/table_regression_diamonds.sql">diamonds</a></td>
        <td>Predict price of a diamond</td>
        <td>37758</td>
        <td>10</td>
   </tr>
   <tr>
        <td><a href="./sql/table_regression_mercedes.sql">mercedes</a></td>
        <td>Time the car took to pass testing</td>
        <td>2946</td>
        <td>377</td>
   </tr>
   <tr>
        <td><a href="./sql/table_regression_news_popularity.sql">news_popularity</a></td>
        <td>Predict the number of shares of article in social networks (popularity)</td>
        <td>27750</td>
        <td>60</td>
   </tr>
   <tr>
        <td><a href="./sql/table_regression_nyc_taxi.sql">nyc_taxi</a></td>
        <td>Predict tip amount for NYC taxi cab</td>
        <td>407284</td>
        <td>15</td>
   </tr>
   <tr>
        <td><a href="./sql/table_regression_twitter.sql">twitter</a></td>
        <td>The popularity of a topic on social media</td>
        <td>408275</td>
        <td>78</td>
   </tr>
</table>

## Contributing

This project welcomes contributions from the community. Before submitting a pull request, please [review our contribution guide](./CONTRIBUTING.md)

## Security

Please consult the [security guide](./SECURITY.md) for our responsible security vulnerability disclosure process

## License

Copyright (c) 2025 Oracle and/or its affiliates.

Released under the Universal Permissive License v1.0 as shown at
<https://oss.oracle.com/licenses/upl/>.


 [1]: https://www.python.org/downloads/release/python-3813/
 [2]: https://dev.mysql.com/doc/mysql-shell/8.0/en/
 [3]: https://docs.cloud.oracle.com/en-us/iaas/Content/home.htm
 [4]: https://docs.oracle.com/en-us/iaas/mysql-database/
 [5]: https://dev.mysql.com/doc/heatwave/en/
