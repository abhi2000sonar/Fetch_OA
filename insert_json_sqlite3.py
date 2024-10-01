import sqlite3
import pandas as pd
import json

# Load JSON data from files
def load_json_data(file_path):
    with open(file_path, 'r') as file:
        return json.load(file)

# Connect to SQLite (or any other SQL database)
conn = sqlite3.connect('fetch_rewards.db')  # You can use other databases like PostgreSQL or MySQL
cursor = conn.cursor()

# Create tables (only needed if tables are not already created)
cursor.execute('''
CREATE TABLE IF NOT EXISTS brands (
    id_oid NVARCHAR(24) PRIMARY KEY,
    barcode NVARCHAR(50) NOT NULL,
    brandCode NVARCHAR(50),
    category NVARCHAR(50),
    categoryCode NVARCHAR(50),
    name NVARCHAR(255) NOT NULL,
    topBrand BOOLEAN
);
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS users (
    id_oid NVARCHAR(24) PRIMARY KEY,
    active BOOLEAN NOT NULL,
    createdDate BIGINT NOT NULL,
    lastLogin BIGINT,
    role NVARCHAR(20) NOT NULL,
    signUpSource NVARCHAR(50),
    state NVARCHAR(2)
);
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS receipts (
    id_oid NVARCHAR(24) PRIMARY KEY,
    bonusPointsEarned INT NOT NULL,
    bonusPointsEarnedReason NVARCHAR(255),
    createDate BIGINT NOT NULL,
    dateScanned BIGINT,
    finishedDate BIGINT,
    modifyDate BIGINT,
    pointsAwardedDate BIGINT,
    pointsEarned NUMERIC(10, 2),
    purchaseDate BIGINT,
    purchasedItemCount INT NOT NULL,
    rewardsReceiptStatus NVARCHAR(50),
    totalSpent NUMERIC(10, 2) NOT NULL,
    userId NVARCHAR(24) NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(id_oid)
);
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS rewardsReceiptItemList (
    receipt_id NVARCHAR(24) NOT NULL,
    barcode NVARCHAR(50),
    description NVARCHAR(255),
    finalPrice NUMERIC(10, 2),
    itemPrice NUMERIC(10, 2),
    needsFetchReview BOOLEAN,
    partnerItemId NVARCHAR(50),
    quantityPurchased INT,
    userFlaggedBarcode NVARCHAR(50),
    userFlaggedNewItem BOOLEAN,
    userFlaggedPrice NUMERIC(10, 2),
    userFlaggedQuantity INT,
    FOREIGN KEY (receipt_id) REFERENCES receipts(id_oid),
    FOREIGN KEY (barcode) REFERENCES brands(barcode)
);
''')

# Load and insert Brands data
brands_data = load_json_data('brands.json')
brands_values = [
    (
        brand['_id']['$oid'],
        brand['barcode'],
        brand.get('brandCode'),
        brand['category'],
        brand.get('categoryCode'),
        brand['name'],
        brand.get('topBrand', None)
    )
    for brand in brands_data
]

cursor.executemany('''
    INSERT OR REPLACE INTO brands (id_oid, barcode, brandCode, category, categoryCode, name, topBrand)
    VALUES (?, ?, ?, ?, ?, ?, ?)
''', brands_values)

# Load and insert Users data
users_data = load_json_data('users.json')
users_values = [
    (
        user['_id']['$oid'],
        user['active'],
        user['createdDate']['$date'],
        user.get('lastLogin', {}).get('$date', None),
        user['role'],
        user.get('signUpSource', None),
        user.get('state', None)
    )
    for user in users_data
]

cursor.executemany('''
    INSERT OR REPLACE INTO users (id_oid, active, createdDate, lastLogin, role, signUpSource, state)
    VALUES (?, ?, ?, ?, ?, ?, ?)
''', users_values)

# Load and insert Receipts data
receipts_data = load_json_data('receipts.json')
receipts_values = [
    (
        receipt['_id']['$oid'],
        receipt['bonusPointsEarned'],
        receipt.get('bonusPointsEarnedReason', None),
        receipt['createDate']['$date'],
        receipt.get('dateScanned', {}).get('$date', None),
        receipt.get('finishedDate', {}).get('$date', None),
        receipt.get('modifyDate', {}).get('$date', None),
        receipt.get('pointsAwardedDate', {}).get('$date', None),
        receipt['pointsEarned'],
        receipt['purchaseDate']['$date'],
        receipt['purchasedItemCount'],
        receipt.get('rewardsReceiptStatus', None),
        receipt['totalSpent'],
        receipt['userId']
    )
    for receipt in receipts_data
]

cursor.executemany('''
    INSERT OR REPLACE INTO receipts (id_oid, bonusPointsEarned, bonusPointsEarnedReason, createDate, dateScanned, finishedDate, modifyDate, pointsAwardedDate, pointsEarned, purchaseDate, purchasedItemCount, rewardsReceiptStatus, totalSpent, userId)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''', receipts_values)

# Insert into rewardsReceiptItemList for each receipt
rewards_receipt_item_values = []
for receipt in receipts_data:
    if 'rewardsReceiptItemList' in receipt:
        for item in receipt['rewardsReceiptItemList']:
            rewards_receipt_item_values.append((
                receipt['_id']['$oid'],
                item.get('barcode', None),
                item.get('description', None),
                item.get('finalPrice', None),
                item.get('itemPrice', None),
                item.get('needsFetchReview', None),
                item.get('partnerItemId', None),
                item.get('quantityPurchased', None),
                item.get('userFlaggedBarcode', None),
                item.get('userFlaggedNewItem', None),
                item.get('userFlaggedPrice', None),
                item.get('userFlaggedQuantity', None)
            ))

cursor.executemany('''
    INSERT OR REPLACE INTO rewardsReceiptItemList (receipt_id, barcode, description, finalPrice, itemPrice, needsFetchReview, partnerItemId, quantityPurchased, userFlaggedBarcode, userFlaggedNewItem, userFlaggedPrice, userFlaggedQuantity)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''', rewards_receipt_item_values)

# Commit and close the connection
conn.commit()
conn.close()

print("All data successfully inserted into the database.")
