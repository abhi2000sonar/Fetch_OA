-- Query 1: Top 5 Brands by Receipts Scanned for Most Recent Month
SELECT b.name, COUNT(r.id_oid) AS receipt_count
FROM receipts r
JOIN brands b ON r.userId = b.id_oid
WHERE strftime('%Y-%m', datetime(r.createDate / 1000, 'unixepoch')) = (
    SELECT MAX(strftime('%Y-%m', datetime(createDate / 1000, 'unixepoch'))) 
    FROM receipts
)
GROUP BY b.name
ORDER BY receipt_count DESC
LIMIT 5;

-- Query 2: Comparing Ranking of Top 5 Brands for the Recent Month vs. Previous Month
WITH recent_month AS (
    SELECT b.name, COUNT(r.id_oid) AS receipt_count
    FROM receipts r
    JOIN brands b ON r.userId = b.id_oid
    WHERE strftime('%Y-%m', datetime(r.createDate / 1000, 'unixepoch')) = (
        SELECT MAX(strftime('%Y-%m', datetime(createDate / 1000, 'unixepoch')))
        FROM receipts
    )
    GROUP BY b.name
), 
previous_month AS (
    SELECT b.name, COUNT(r.id_oid) AS receipt_count
    FROM receipts r
    JOIN brands b ON r.userId = b.id_oid
    WHERE strftime('%Y-%m', datetime(r.createDate / 1000, 'unixepoch')) = (
        SELECT strftime('%Y-%m', datetime(MAX(createDate / 1000, 'unixepoch'), '-1 month'))
        FROM receipts
    )
    GROUP BY b.name
)
SELECT rm.name, rm.receipt_count AS recent_count, pm.receipt_count AS previous_count
FROM recent_month rm
LEFT JOIN previous_month pm ON rm.name = pm.name;

-- Query 3: Average Spend Comparison Between Accepted and Rejected Receipts
SELECT rewardsReceiptStatus, AVG(totalSpent) AS avg_spent
FROM receipts
WHERE rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY rewardsReceiptStatus;

-- Query 4: Total Number of Items Purchased Comparison Between Accepted and Rejected Receipts
SELECT rewardsReceiptStatus, SUM(purchasedItemCount) AS total_items_purchased
FROM receipts
WHERE rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY rewardsReceiptStatus;

-- Query 5: Brand with Most Spend Among Users Created in the Last 6 Months
WITH recent_users AS (
    SELECT id_oid
    FROM users
    WHERE datetime(createdDate / 1000, 'unixepoch') >= datetime('now', '-6 months')
)
SELECT b.name, SUM(r.totalSpent) AS total_spent
FROM receipts r
JOIN recent_users u ON r.userId = u.id_oid
JOIN brands b ON b.barcode = r.id_oid
GROUP BY b.name
ORDER BY total_spent DESC
LIMIT 1;
