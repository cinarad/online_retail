# 🌐 Online Retail Store Transactions – Personal Project

## 🔗 Overview

This project explores synthetic transactional data from a large e-commerce retailer to analyse customer purchasing behaviour over a 2-year period (May 2023 – May 2025) across multiple countries. The dataset was designed with intentional inconsistencies and messiness to simulate real-world data cleaning challenges. PostgreSQL was used for data exploration and cleaning, while Power BI was used for data modelling and visualisation.

---

## 📊 Dataset Summary

**Rows**: 20,000+ transactions
**Customers**: 1,500 unique IDs
**Products**: 500+ across \~10 categories

### 📄 Columns (Variables)

| Column Name   | Description                                   |
| ------------- | --------------------------------------------- |
| InvoiceID     | Unique identifier for each invoice            |
| InvoiceDate   | Timestamp of the purchase                     |
| CustomerID    | Unique identifier for each customer           |
| CustomerName  | Full name of the customer                     |
| Country       | Customer's country                            |
| ProductID     | Unique product identifier                     |
| ProductName   | Name/description of the product               |
| Category      | Product category (e.g. Electronics, Clothing) |
| Quantity      | Number of units purchased                     |
| UnitPrice     | Price per unit                                |
| TotalAmount   | Quantity \* UnitPrice                         |
| PaymentMethod | Method used (e.g. Credit Card, PayPal)        |
| ReturnStatus  | "Returned" or "Not Returned"                  |
| ReviewScore   | 1 to 5 or NULL if not reviewed                |
| PromoApplied  | "Yes" or "No" if promo was applied            |
| DeliveryDays  | Days it took to deliver                       |
| ShippingCost  | Cost of shipping per order                    |

---

## 🌐 Data Cleaning & Preparation (PostgreSQL)

* Identified and resolved common issues:

  * Missing values (e.g. ReviewScore, CustomerName)
  * Duplicates in CustomerID and CustomerName
  * Inconsistent country names: normalised entries like "USA", "U.S.", and "United States" to "United States"
  * Mixed data types (e.g. UnitPrice as "\$19.99")
  * Column header typos (e.g. "CustmerID")
* Standardised names and formatting:

  * Capitalised names: e.g., "john smith" → "John Smith"
  * Unified country names: e.g., "new zealand" → "New Zealand"

### 🔎 Key Data Quality Findings

* `CustomerID` is the only reliable unique identifier.
* 16 customer names linked to two different CustomerIDs each.
* Duplicate InvoiceIDs were not found (correct uniqueness).

### ✅ Decision:

* Use `CustomerID` for all joins and aggregations.
* Use `CustomerName` only for display.

---

## 🏛️ Data Modelling in Power BI
![image](https://github.com/user-attachments/assets/fea2db79-af59-4d94-bd8d-248dc214d954)

### Schema:

Adopted a **Star Schema** with 1 Fact Table and 3 Dimension Tables.

#### 📊 Fact Table: `FactSales`

* invoice\_id
* invoice\_date
* customer\_id
* product\_id
* quantity
* unit\_price
* promo
* payment\_method
* delivery\_days
* return\_status

#### 🗒️ Dimension Tables:

* **Date**: date, month, quarter, weekday
* **Customer**: customer\_id (PK), name, country
* **Product**: product\_id (PK), category, unit\_price

### ⚙️ Additional Enhancements:

* Created **Time of Day** column using duplicated `InvoiceDate` to extract hours:

  * Morning: 5:00 - 11:59
  * Afternoon: 12:00 - 16:59
  * Evening: 17:00 - 22:59
  * Night: 23:00 - 4:59

---

## 📊 Measures and KPIs (DAX)

```DAX
Total Quantity = SUM(FactSales[quantity])

Total Sales = SUMX(FactSales, FactSales[quantity] * RELATED(product[unit_price]))

Avg Delivery Day = AVERAGE(FactSales[delivery_days])

Return Rate = DIVIDE(
    CALCULATE(COUNTROWS(FactSales), FactSales[return_status] = "Returned"),
    COUNTROWS(FactSales)
)
```
![image](https://github.com/user-attachments/assets/f2e29946-0df3-42b0-aa72-51c454843314)

---

## 📈 Key Dashboard Insights

* 💼 **Total Revenue**: \$15,411,232.13
* 🌍 **Top Markets**: United States, New Zealand, India
* 🌂 **Best Time to Sell**: Morning hours lead in sales quantity
* 🎒 **Top Category**: Clothing
* ❌ **Highest Return Rate**: Home category — may require deeper investigation
* 📆 **Forecast**: Potential dip projected in mid-2025

---

## 🎨 Visualisation Summary (Power BI)

* Overview KPIs: Total Customers, Products, Revenue, Average Sales
* Time Series Forecast: 2-year sales trend with 3-month projection
* Segmentation by: Country, Category, Time of Day, Return Rate
* Top 5 Customers, Top Categories, and Return Metrics

---

## 📆 Timeline

* **Data Cleaning**: PostgreSQL
* **Data Modelling & Visualisation**: Power BI

---

## 🌟 Tools Used

* PostgreSQL
* Power BI (Power Query, DAX)

---

## 💼 Summary

This project demonstrates the full analytics workflow from messy raw data to actionable insights. It showcases skills in data cleaning, normalisation, SQL, data modelling, and interactive visualisation using Power BI. It reflects a realistic scenario of preparing data for business decision-making in e-commerce.

---

> Feel free to explore the Power BI dashboard or reach out with any questions!
