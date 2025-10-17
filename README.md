# SQL-PROJECT
# 🛒 Grocery Store SQL Project

## 📋 Overview
This project is a **SQL-based analysis of a grocery store database**, designed to demonstrate key database concepts such as **data modeling, relationships, joins, aggregation, and analytical queries**.  
It provides insights into **customer behavior**, **sales trends**, **product performance**, and **employee contributions** using structured SQL queries.

---

## 🏗️ Database Design

### 📂 Database Name:
`grocerydb`

### 🧩 Tables Created:
1. **supplier** – Stores supplier details  
2. **categories** – Holds product category data  
3. **employees** – Employee information and hire dates  
4. **customers** – Customer details and addresses  
5. **products** – Product data with foreign keys for supplier and category  
6. **orders** – Customer orders linked to employees and customers  
7. **order_details** – Transaction-level details (quantity, price, total)

---

## 🔑 Relationships

| Table | Relationship | Description |
|--------|---------------|-------------|
| `products` ↔ `supplier` | Many-to-One | Each product has one supplier |
| `products` ↔ `categories` | Many-to-One | Each product belongs to a category |
| `orders` ↔ `customers` | Many-to-One | Each order placed by one customer |
| `orders` ↔ `employees` | Many-to-One | Each order handled by one employee |
| `order_details` ↔ `orders` | Many-to-One | Each record belongs to one order |
| `order_details` ↔ `products` | Many-to-One | Each record belongs to one product |

All foreign keys are created with:
```sql
ON UPDATE CASCADE ON DELETE CASCADE

## 📖 Project Overview
This project demonstrates how to design, implement, and analyze a **relational database** for a grocery store using **MySQL**.  
It covers every aspect of SQL — from **database creation and normalization** to **business insights and reporting queries**.

The main goal of this project is to simulate real-world data analytics scenarios using SQL and to extract meaningful patterns from transactional data.

---

## 🧱 Database Creation

### 🔹 Database Name:
```sql
CREATE DATABASE grocerydb;
USE grocerydb;

