Fetch Rewards Coding Exercise - Analytics Engineer

Overview

This repository contains the solutions for the Fetch Rewards Coding Exercise for the role of Analytics Engineer. The exercise focuses on transforming unstructured JSON data into a structured relational data model, writing SQL queries to answer business-related questions, identifying data quality issues, and communicating findings with stakeholders.

Repository Structure

Data Files:

brands.json: Contains brand-related information, including fields like barcode, category, brandCode, name, and more.
users.json: Stores user data such as userId, state, createdDate, and lastLogin.
receipts.json: Includes receipts data such as bonusPointsEarned, totalSpent, and nested lists of purchased items under rewardsReceiptItemList.

Code:

eda_fetch.ipynb: Jupyter notebook used for data exploration, analysis, and data quality assessments. This notebook includes the transformation of JSON data into structured tables.
relational_model_diagram.png: A visual representation of the relational data model created based on the unstructured data from the JSON files.

SQL Queries:

business_queries.sql: SQL queries that answer specific business questions derived from the structured relational data model.
Results:
create_commands_ddl.sql: SQL query for creating tables in database, 

Communication:

slack_message.md: A sample Slack message to a business stakeholder, summarizing the key findings from the analysis and recommendations for improving data quality and model efficiency.
S
teps Undertaken

1. Review of Unstructured Data and Relational Model Design
The provided JSON data files (brands.json, users.json, receipts.json) were reviewed and transformed into a structured relational data model, following best practices for database design.

brands: Stores details like barcode, category, brandCode, and name.
users: Contains user details like userId, state, and createdDate.
receipts: Holds receipt information, including bonusPointsEarned, createDate, totalSpent, and a list of purchased items (rewardsReceiptItemList).

The relational model diagram (relational_model_diagram.png) visualizes the relationships between the tables, showing how they interact through primary and foreign keys.

2. SQL Queries for Business Questions
SQL queries were written to answer key business questions. These queries were based on the structured data model and include:

Top 5 brands by receipts scanned for the most recent month: This query identifies the top 5 brands based on the number of receipts scanned in the latest month.
Comparison of top 5 brands from the most recent month vs. the previous month: A comparative analysis of brand rankings between two consecutive months.

Additional queries include:

Which brand has the most spend among users created in the past 6 months?
Which brand has the most transactions among new users?
These queries can be found in the business_queries.sql file.

3. Data Quality Assessment

The project involved identifying and addressing several data quality issues using Python (Jupyter Notebook). Issues include:

Missing Values: Found in fields like categoryCode, topBrand, and state.
Duplicate Entries: Observed in the users.json file, particularly duplicate _id.$oid values.
Consistency Checks: Implemented for fields like createdDate to avoid invalid or future dates.
The Python code used for this assessment is included in eda_fetch.ipynb.

4. Communication with Stakeholders

To communicate findings, a sample Slack message was drafted, summarizing key insights and offering recommendations for improving data quality and efficiency. The message is located in slack_message.md.

Running the Code
Prerequisites:
Python 3.x
Jupyter Notebook
Pandas library for data manipulation
SQL engine (for testing the SQL queries)
Running the Jupyter Notebook:
Open eda_fetch.ipynb in Jupyter Notebook.

Install the required libraries using:
pip install pandas matplotlib
Load the notebook to explore the data, assess quality, and view transformations.

Running the SQL Queries:

Create tables in your SQL engine using the structured data model (brands, users, receipts).
Execute the queries provided in business_queries.sql.

Data Quality Issues Identified

Missing Values: Found in non-critical fields like categoryCode and topBrand.
Duplicate Records: Detected in the users.json file, particularly in the userId field.
Future Dates: No users were found with future createdDate, but validation checks were implemented to handle edge cases.
Performance and Scaling Considerations
Storage: To optimize storage, JSON data can be converted to Parquet format, which compresses data efficiently.
Scaling: For large datasets, cloud solutions like AWS Redshift and S3 should be used for distributed processing.
Real-Time Data: Streaming platforms like AWS Kinesis or Apache Kafka can handle real-time data ingestion and analysis if the data needs frequent updates.

Recommendations for Improving Data Quality

Implement data validation rules during data entry to avoid missing values and duplicates.
Use time-based partitioning to handle large datasets and improve query performance.
Regularly monitor data quality using automated validation scripts and reporting tools.

Conclusion

This exercise demonstrates how to transform unstructured data into a structured format, perform business-critical queries, assess data quality, and communicate results with stakeholders. By leveraging cloud services like AWS, this process can be scaled efficiently for larger datasets.
