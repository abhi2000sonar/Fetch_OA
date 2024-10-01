CREATE TABLE brands (
    id_oid NVARCHAR(24) PRIMARY KEY,    -- Primary key (unique identifier for each brand)
    barcode NVARCHAR(50) NOT NULL,      -- Barcode of the item
    brandCode NVARCHAR(50),             -- Brand code
    category NVARCHAR(50),              -- Category of the product
    categoryCode NVARCHAR(50),          -- Category code of the product
    name NVARCHAR(255) NOT NULL,        -- Name of the brand
    topBrand BOOLEAN                    -- Boolean flag indicating if it’s a top brand
);

CREATE TABLE users (
    id_oid NVARCHAR(24) PRIMARY KEY,    -- Primary key (unique identifier for each user)
    active BOOLEAN NOT NULL,            -- Boolean indicating whether the user is active
    createdDate BIGINT NOT NULL,        -- Date when the user created the account (Unix timestamp)
    lastLogin BIGINT,                   -- Last login date (Unix timestamp)
    role NVARCHAR(20) NOT NULL,         -- Role of the user (e.g., 'consumer')
    signUpSource NVARCHAR(50),          -- Source from which the user signed up
    state NVARCHAR(2)                   -- State abbreviation (e.g., WI)
);


CREATE TABLE receipts (
    id_oid NVARCHAR(24) PRIMARY KEY,            -- Primary key (unique identifier for each receipt)
    bonusPointsEarned INT NOT NULL,             -- Number of bonus points earned
    bonusPointsEarnedReason NVARCHAR(255),      -- Reason for bonus points
    createDate BIGINT NOT NULL,                 -- Date when the receipt was created (Unix timestamp)
    dateScanned BIGINT,                         -- Date when the receipt was scanned (Unix timestamp)
    finishedDate BIGINT,                        -- Date when the receipt finished processing
    modifyDate BIGINT,                          -- Date when the receipt was modified
    pointsAwardedDate BIGINT,                   -- Date when points were awarded
    pointsEarned NUMERIC(10, 2),                -- Number of points earned
    purchaseDate BIGINT,                        -- Date of the purchase
    purchasedItemCount INT NOT NULL,            -- Number of items purchased on the receipt
    rewardsReceiptStatus NVARCHAR(50),          -- Status of the receipt
    totalSpent NUMERIC(10, 2) NOT NULL,         -- Total amount spent on the receipt
    userId NVARCHAR(24) NOT NULL,               -- Foreign key referencing users.id_oid
    
    -- Foreign key constraint linking to the Users table
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id_oid)
);


CREATE TABLE rewardsReceiptItemList (
    receipt_id NVARCHAR(24) NOT NULL,           -- Foreign key referencing receipts.id_oid
    barcode NVARCHAR(50),                       -- Foreign key referencing brands.barcode
    description NVARCHAR(255),                  -- Description of the purchased item
    finalPrice NUMERIC(10, 2),                  -- Final price of the item
    itemPrice NUMERIC(10, 2),                   -- Original price of the item
    needsFetchReview BOOLEAN,                   -- Boolean indicating if the item needs a fetch review
    partnerItemId NVARCHAR(50),                 -- Partner item ID
    quantityPurchased INT,                      -- Quantity of the item purchased
    userFlaggedBarcode NVARCHAR(50),            -- User-flagged barcode
    userFlaggedNewItem BOOLEAN,                 -- Boolean indicating if the item is user-flagged as new
    userFlaggedPrice NUMERIC(10, 2),            -- User-flagged price of the item
    userFlaggedQuantity INT,                    -- User-flagged quantity of the item

    -- Foreign key constraint linking to the Receipts table
    CONSTRAINT fk_receipt FOREIGN KEY (receipt_id) REFERENCES receipts(id_oid),

    -- Foreign key constraint linking to the Brands table
    CONSTRAINT fk_brand FOREIGN KEY (barcode) REFERENCES brands(barcode)
);
