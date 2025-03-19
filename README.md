# myfinance

MyFinance is a personal finance management app built using Flutter with SQLite databases for storage. The app allows users to track their income, expenses, and overall financial health. It features a user-friendly dashboard, pie charts for visualizing spending patterns, and supports categories and notifications for upcoming payment dates.

## Getting Started

## Dashboard with Financial Summary
Displays:
💰 Total Income
💸 Total Expenses
🔥 Net Balance
Pie chart to visualize spending categories
Horizontal scrollable row with:
Total Transactions
Total Categories
Upcoming Payments


B. Transactions Management
Users can:
Add, Edit, Delete transactions
Select the transaction type: Income or Expense
Assign a category to each transaction
Set a date for each transaction
SQLite CRUD operations:
CREATE → Add new transactions
READ → Fetch all transactions
UPDATE → Modify existing transactions
DELETE → Remove transactions


 Categories Management
Users can:
Add, Edit, Delete categories
Define whether a category belongs to Income or Expense
Add a description
Categories are saved in a separate SQLite database:
categoriesDb.db


Database Structure
The app uses two separate SQLite databases:

📁 1. Transaction Database: transactionDb.db
Table: transactions
Columns:
s_no: Transaction ID (Primary Key, auto-increment)
title: Transaction title
amount: Transaction amount
transaction_type: Income or Expense
category: Associated category
date: Date of the transaction


Category Database: categoriesDb.db
Table: categories
Columns:
s_no: Category ID (Primary Key, auto-increment)
name: Category name
category_type: Income or Expense
description: Description of the category
created_at: Creation timestamp
updated_at: Last update timestamp

