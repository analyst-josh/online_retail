/* 
===========================================================
  Online Retail Analysis - SQL Exploratory Queries
  Author: Joshua B 
  Description: Queries for data understanding & reporting
===========================================================
*/

SELECT 
    COUNT(*) AS total_records
FROM
    retail_data;

/* Show 10 sample rows */
SELECT 
    *
FROM
    retail_data
LIMIT 10;

/* Distinct countries */
SELECT DISTINCT
    country
FROM
    retail_data
ORDER BY country;

/* Distinct transaction types */
SELECT DISTINCT
    transaction_type
FROM
    retail_data
ORDER BY transaction_type;


/* 
-----------------------------------------------------------
  2. Total Revenue & Quantity
-----------------------------------------------------------
*/

SELECT 
    ROUND(SUM(quantity * price), 2) AS total_revenue,
    SUM(quantity) AS total_quantity
FROM
    retail_data
WHERE
    transaction_type = 'sale';


/* 
-----------------------------------------------------------
  3. Product-level Analysis
-----------------------------------------------------------
*/

SELECT 
    stock_id,
    description,
    ROUND(SUM(quantity * price), 2) AS revenue,
    SUM(quantity) AS total_units
FROM
    retail_data
WHERE
    transaction_type = 'sale'
GROUP BY stock_id , description
ORDER BY revenue DESC
LIMIT 10;

/* Top 10 products by units sold */
SELECT 
    stock_id, description, SUM(quantity) AS total_units
FROM
    retail_data
WHERE
    transaction_type = 'sale'
GROUP BY stock_id , description
ORDER BY total_units DESC
LIMIT 10;


/* 
-----------------------------------------------------------
  4. Country-level Analysis
-----------------------------------------------------------
*/

SELECT 
    country,
    ROUND(SUM(quantity * price), 2) AS revenue,
    COUNT(DISTINCT invoice_id) AS invoice_count
FROM
    retail_data
WHERE
    transaction_type = 'sale'
GROUP BY country
ORDER BY revenue DESC;


/* 
-----------------------------------------------------------
  5. Time-based Analysis
-----------------------------------------------------------
*/

SELECT 
    DATE_TRUNC('month', invoice_date) AS month,
    ROUND(SUM(quantity * price), 2) AS revenue
FROM
    retail_data
WHERE
    transaction_type = 'sale'
GROUP BY month
ORDER BY month;


/* 
-----------------------------------------------------------
  6. Returns & Adjustments
-----------------------------------------------------------
*/

SELECT 
    COUNT(*) AS total_returns
FROM
    retail_data
WHERE
    quantity < 0;

/* Revenue impact of returns */
SELECT 
    ROUND(SUM(quantity * price), 2) AS returns_revenue
FROM
    retail_data
WHERE
    quantity < 0;

/* Adjustments and discounts summary */
SELECT 
    transaction_type,
    ROUND(SUM(quantity * price), 2) AS total_value,
    COUNT(*) AS record_count
FROM
    retail_data
WHERE
    transaction_type NOT IN ('sale')
GROUP BY transaction_type
ORDER BY total_value;


/* 
-----------------------------------------------------------
  7. Customer Analysis
-----------------------------------------------------------
*/

SELECT 
    customer_id, ROUND(SUM(quantity * price), 2) AS revenue
FROM
    retail_data
WHERE
    transaction_type = 'sale'
        AND customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;

/* Number of unique customers */
SELECT 
    COUNT(DISTINCT customer_id) AS unique_customers
FROM
    retail_data
WHERE
    customer_id IS NOT NULL;

