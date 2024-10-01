Key Relationships:
Users has a 1-to-many relationship with Receipts: Each user can have multiple receipts, indicated by the foreign key userId in the Receipts table referencing id_oid in the Users table.
Receipts has a 1-to-many relationship with RewardsReceiptItemList: Each receipt can have multiple items, indicated by the foreign key receipt_id in RewardsReceiptItemList referencing id_oid in the Receipts table.
Brands has a 1-to-many relationship with RewardsReceiptItemList: Each brand can appear on multiple receipts, indicated by the foreign key barcode in RewardsReceiptItemList referencing barcode in the Brands table.
