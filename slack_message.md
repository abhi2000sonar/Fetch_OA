Hi,

I hope you're doing well! I wanted to provide you with a quick update on the data analysis we conducted for the Fetch Rewards project. Below are the key findings and some recommendations for improving the data quality:

Key Findings:

Top 5 Brands by Receipts Scanned: For the most recent month, we identified the top 5 brands based on receipts scanned. This information will help us focus on the most popular brands and determine where to allocate marketing resources effectively.

Brand Performance Over Time: We compared the top 5 brands from the most recent month with the previous month. This comparison reveals trends in customer preferences and brand popularity over time, which can aid in strategic decision-making.

Average Spend by Receipt Status: We compared the average spend on receipts with a status of 'Accepted' and 'Rejected'. Receipts marked as 'Accepted' had a higher average spend, which suggests that encouraging users to complete accurate submissions could boost overall revenue.

Items Purchased by Receipt Status: We also compared the total number of items purchased from 'Accepted' and 'Rejected' receipts. This analysis provides insights into customer behavior and helps refine the validation process for receipts.

Brand with Most Spend Among New Users: Among users created in the last 6 months, the brand with the most spend was identified. This insight can help guide brand partnerships and promotions, especially for newly onboarded users.

Data Quality Issues and Recommendations:

Missing and Inconsistent Values: We encountered missing values in key fields like categoryCode and topBrand in the brand data. I recommend implementing validation checks during data entry to ensure all critical fields are populated.

Duplicate Records: Several duplicate records were found in the user data, particularly for _id.$oid. This could be due to users being logged multiple times. We suggest creating a unique constraint on the user ID field and reviewing the data pipeline to avoid duplicate entries.

Outdated and Inconsistent Timestamps: Some of the createdDate values in the user data appeared inconsistent, with records from future dates. Implementing time validation and ensuring timestamps follow consistent formats will help maintain data integrity.

Next Steps:

Data Pipeline Improvements: Implement validation and cleaning procedures at the source to avoid common issues like duplicates and missing values.
Further Analysis: We can further explore user behavior by segmenting the data based on receipt status, geography, or other factors to get more granular insights.
Collaboration: I'd love to collaborate further on this and get your thoughts on how we can best leverage these insights to improve the customer experience and optimize brand engagement.
Feel free to reach out if you have any questions or need more details!

Best regards,

Abhishek
