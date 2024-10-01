Fetch Rewards Coding Exercise - Analytics Engineer

Overview

This repository contains the solutions to the Fetch Rewards Coding Exercise for the role of Analytics Engineer. The exercise involved working with unstructured JSON data, designing a relational data model, writing SQL queries to answer business questions, identifying data quality issues, and communicating findings with stakeholders.

Structure of the Repository
Data Files:
brands.json: Data related to brands, including fields like barcode, category, brandCode, etc.
users.json: Data related to users, such as userId, state, createdDate, etc.
receipts.json: Data related to receipts, including bonusPointsEarned, totalSpent, rewardsReceiptItemList, etc.

Code:
eda_fetch.ipynb: Jupyter notebook containing the code used for data exploration, quality assessment, and SQL query generation.
relational_model_diagram.png: A diagram representing the structured relational model created from the unstructured data.

Queries:
business_queries.sql: SQL queries that answer specific business questions based on the structured relational data model.
Results:

results.md: A summary of the findings from the analysis, including answers to the business questions.
Steps Undertaken
1. Review Existing Unstructured Data
The three JSON files (brands.json, users.json, receipts.json) were reviewed and transformed into a structured relational data model. The fields and relationships between the data entities were diagrammed to show how the tables would join.

brands table: Contains fields such as barcode, category, brandCode, name, etc.
users table: Contains fields such as userId, state, createdDate, etc.
receipts table: Contains fields such as bonusPointsEarned, createDate, totalSpent, userId, etc.
The diagram of the data model is included as relational_model_diagram.png in the repository.

2. Write SQL Queries for Business Questions
Two business questions were answered using SQL queries against the structured data model.
The following queries are included in business_queries.sql:

Top 5 brands by receipts scanned for the most recent month: This query identifies the top 5 brands based on the number of receipts scanned in the most recent month.
Comparison of top 5 brands by receipts scanned for recent month vs. previous month: This query compares the rankings for the top 5 brands between the most recent month and the previous month.

Additional queries include:

Which brand has the most spend among users created within the past 6 months.
Which brand has the most transactions among users created within the past 6 months.
3. Data Quality Assessment
Various data quality issues were identified and addressed. The Python code used to explore and evaluate these issues is included in the Jupyter notebook (data_analysis.ipynb). Some key findings include:

Missing values in non-critical fields (e.g., categoryCode, topBrand, state).
Duplicate user records in users.json.
Consistency checks for fields like createdDate to ensure there are no future dates.
4. Communicating with Stakeholders
A sample Slack message to a business stakeholder is included in the repository (slack_message.md), outlining the key findings from the data analysis and recommendations for improving data quality.

How to Run the Code
Prerequisites:

Python 3.x
Jupyter Notebook
Pandas library for data manipulation
SQL engine (for testing the SQL queries)

Running the Jupyter Notebook:

Load the data_analysis.ipynb notebook to view the data exploration, data quality assessments, and transformations.
Ensure you have the required libraries installed (pandas, matplotlib).

Running the SQL Queries:

The SQL queries can be executed in any SQL engine (e.g., PostgreSQL, MySQL, SQLite).
Use the structured data model to create the required tables (brands, users, receipts) and run the queries provided in business_queries.sql.
Data Quality Issues Identified
Missing values: Fields like categoryCode, topBrand, and state contained missing values.
Duplicate entries: In the users.json file, duplicate userId values were found.
Future Dates: There were no users with future createdDate values, but some additional validation checks for edge cases were implemented.
Performance and Scaling Considerations
Data Storage: Using Parquet files to compress and store the datasets efficiently.
Scaling: In a production environment, this data model can be scaled by using cloud-based solutions like AWS S3 and Redshift for distributed data processing.
Real-time Updates: If the data is updated frequently, streaming architectures (e.g., AWS Kinesis or Kafka) can be employed to handle the real-time ingestion of new data.

