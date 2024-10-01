1. What questions do you have about the data?

After examining the structure and content of the brands_df and users_df, several important questions have arisen:

Missing Data:

Brands Data: I noticed that certain fields have a significant number of missing values:
categoryCode is missing for 650 out of 1167 entries, and topBrand is missing for 612 entries. Is this expected, or should we attempt to fill these fields in based on other data?
brandCode is missing for 234 entries. 
How critical is this field, and should entries with missing brandCode be treated differently?
Should category and categoryCode always be present together, or are there cases where one can be absent?
Duplicates in Users Data:

Users Data: I found 353 rows with duplicate id_oid entries, which is concerning as these might represent repeated users. 
Can duplicates in the id_oid field be valid, or should each id_oid be unique? How should we handle these duplicate entries in production?
Data Consistency:

active Flag in Users: The active field only has True and False values, which is expected. However, how do we define when a user should be considered inactive? Should the data include additional information (like inactivity duration) to better reflect this?

topBrand in Brands: The topBrand field has True, False, and many NaN values. Are these NaN values meaningful, or should they be interpreted as False? How does the business treat a brand when this field is missing?
Inconsistent Records:

Users Data: There are some missing values in signUpSource (48 missing) and state (56 missing). Should these missing values be filled, or are these fields not always necessary?

For the lastLogin.$date field, 62 entries are missing. 
Should we assume that these users have never logged in, or is this a data entry error? If this represents never-logged-in users, should these users be treated differently from those with login data?

Data Types:

The createdDate.$date in users_df is an integer (epoch timestamp), which is expected, but should this be converted to a more readable date format for future analysis? Are there any business rules that depend on the precise creation date?

Business Rules for Critical Fields:

What are the business rules governing brandCode and barcode? 
Should every brand have a valid barcode and brandCode, or are some brands exceptions to this rule?
Should all users have a state and signUpSource? Are there specific user profiles where this information might not be captured?

2. How did you discover the data quality issues?

From the analysis of the brands_df and users_df data, I discovered the following:

Missing Values:

In the brands_df, the critical fields such as id_oid, barcode, and name have no missing values, which is good. However, as noted previously (from earlier exploration), fields like categoryCode, topBrand, and brandCode do contain missing values.
In the users_df, the key fields like id_oid, active, and createdDate.$date also have no missing values, which suggests that the core structure of the data is complete.
Outliers or Future Dates:

When I checked for future dates in the createdDate.$date field of users_df, the result was an empty DataFrame, meaning there are no records with a future createdDate. 
This is a positive result, indicating that the data entries for user creation dates are valid and within a reasonable range.

Inconsistent Values in active Field:

Upon reviewing the active field in the users_df, I found that nearly all users (494 out of 495) are marked as True (active), while only one user is marked as False. This might indicate a potential imbalance in the dataset, as we would expect a larger proportion of inactive users, depending on the nature of the user base. 

It raises the question: Is this single inactive user accurate, or is there an issue with how the active status is recorded? This could either be an issue with the user lifecycle or simply reflect the data we have.

3. What do you need to know to resolve the data quality issues?

Handling Missing Values:
From the output, I can see that there are no missing values in critical fields like barcode in the brands_df, which means we do not need to drop any rows based on this field.
However, fields like categoryCode and topBrand have missing values. I need to know if these missing values are acceptable or if we should try to fill them in. For instance:
Should we impute missing values in categoryCode or topBrand based on other data (e.g., category or brand patterns)?
Are there cases where categoryCode can be legitimately missing?

Handling Duplicates:

In the users_df, I handled the duplicates based on the _id.$oid field. After removing duplicates, I’m left with 212 unique entries, down from 495 entries originally. This is a significant reduction, and I need to clarify the following:
Are these duplicates expected? Should we always remove duplicates based on _id.$oid, or do duplicates represent valid entries?
Should we merge or aggregate duplicate entries instead of dropping them?

Invalid or Future Dates:

When filtering out users with future createdDate.$date values, none of the records had future dates, which is a positive result.
However, I need to confirm if there are any specific rules regarding the acceptable date range for user creation:
Should we filter out records where createdDate.$date is too far in the past or within a certain timeframe? For example, should users created more than a decade ago still be considered active?

Inconsistent or Missing Data in users_df:

The users_df still has missing values in fields like signUpSource (5 missing) and state (6 missing). While these fields aren’t as critical as the _id.$oid field, I need to know:
How should we handle missing values in non-critical fields like signUpSource and state? Should we drop the records with missing values, or should we fill them in with default values or based on patterns in the data?


4. What other information would you need to help you optimize the data assets you're trying to create?

Category Code Information:

The categoryCode field in the brands_df has a range of different categories, such as 'BAKING', 'BEVERAGES', 'CANDY_AND_SWEETS', etc. However, there are also missing values (nan). To optimize the data, I need to know the following:
How should we handle missing category codes? Should we try to infer them from other available data (such as the product name), or should they be left blank if they’re not available?
Is there a specific hierarchical structure or mapping between category and categoryCode? If so, understanding this relationship will help us categorize products more accurately, especially if we need to fill in missing values or validate the data.

User Sign-Up Patterns:

The createdDate.$date field in the users_df shows that users were created over a broad range of time:
The minimum creation date is December 19, 2014.
The maximum creation date is February 12, 2021.
The median creation date is January 13, 2021, suggesting that many users signed up in early 2021.

To optimize the user data:

Is there any business significance to users created before a certain date? Should we handle older users differently, for example, by focusing on more recent users (e.g., those created after 2020) for analysis or retention efforts?
Should users created during certain periods (e.g., promotion events) be treated differently? Understanding any specific marketing or promotional periods could help categorize and analyze user behavior better.
How should we handle the inactive users, if any, based on the createdDate and lastLogin fields? We could optimize user engagement strategies by segmenting users based on their sign-up and last activity dates.
Business Rules for Key Fields:

For categoryCode, is it acceptable for some brands to not have a category code, or should every product have one? This will help decide whether to treat the missing values as legitimate or as data quality issues.
Similarly, should all users have a sign-up date within a certain range (e.g., within the last five years), or are much older users still relevant for analysis? This information would help us clean the user data accordingly.
Consistency Across Tables:

Is there a relationship between brands_df and other datasets (like receipts_df)? For example, is categoryCode in the brands_df linked to any other product metadata across datasets? Understanding these relationships would help ensure consistent categorization across different tables and improve data quality.

Data Volume and Frequency:

How frequently does new data get added to these datasets? Knowing this will help me plan how often to refresh the dataset and ensure that optimizations (e.g., handling new users or brands) are done in real-time or at regular intervals.

5. What performance and scaling concerns do you anticipate in production and how do you plan to address them?

Memory Usage:

The brands_df DataFrame is relatively large, with fields such as barcode, name, and _id.$oid taking up considerable memory space. The total memory usage across the columns suggests that this dataset could grow significantly if new records are added frequently.
The users_df DataFrame is smaller but contains important fields like role and _id.$oid, which also consume memory. If user data grows, this could also become a concern.
Plan:

To handle potential memory issues, I’ve started storing the data in Parquet format with compression (gzip). Parquet is an efficient columnar storage format that can handle large datasets more effectively, reducing both disk storage and memory consumption. This helps with faster read/write operations, especially when dealing with large data volumes.

Data Growth and Scaling:

As the brands_df and users_df datasets grow, performance may degrade if the data is stored in non-optimized formats like CSV or JSON. In a production environment, the system could face challenges if thousands or millions of records are added.

Plan:

Using Parquet is an initial step toward optimizing storage and read/write performance. However, to scale further, I would recommend moving the datasets to a distributed environment such as AWS S3, where the data can be stored in an optimized format and processed using AWS Athena or Apache Spark for distributed query execution.

Data Retrieval and Querying:

With larger datasets, querying across multiple tables (such as joining brands_df and users_df) could become resource-intensive and slow down performance, especially if complex queries or aggregations are required.

Plan:

To optimize query performance, I would consider using indexes on key fields such as _id.$oid in both datasets. Additionally, in a production environment, using Amazon Redshift or Google BigQuery would allow for more efficient querying of large datasets.
Partitioning the data based on commonly queried fields (e.g., categoryCode in brands_df or createdDate.$date in users_df) would further improve query performance by reducing the amount of data scanned for each query.

Data Access and Processing Speed:

If the data is used for real-time analytics or reporting, the current in-memory approach might not scale well as the datasets grow.

Plan:

For real-time or near-real-time analytics, streaming architectures using tools like AWS Kinesis or Kafka can be introduced to process incoming data in real-time and keep the datasets up to date without requiring batch processing.

Handling Frequent Updates:

If new brands and users are being added frequently, maintaining consistency across multiple tables could be a concern.

Plan:

I would recommend implementing automated ETL pipelines using AWS Glue or similar services to ensure that new data is processed and integrated into the existing datasets without manual intervention. The use of data versioning and schema evolution capabilities in Parquet files will also help maintain compatibility as the schema evolves over time.




