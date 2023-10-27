SELECT * FROM sales.transactions;
SELECT * FROM sales.date;
SELECT * FROM sales.customers;
SELECT * FROM sales.markets;
SElECT * FROM sales.products;


SELECT COUNT(*) FROM sales.transactions;
SELECT COUNT(*) FROM sales.customers;

SELECT * FROM sales.transactions WHERE market_code ="Mark001";
SELECT * FROM sales.transactions WHERE currency ="USD";

SELECT a.*,b.* FROM sales.transactions a JOIN sales.date b ON  a.order_date = b.date WHERE b.year = 2020;
SELECT SUM(a.sales_amount) AS Revenue_2020 FROM sales.transactions a JOIN sales.date b ON  a.order_date = b.date WHERE b.year = 2020;
SELECT SUM(a.sales_amount) AS Revenue_2019 FROM sales.transactions a JOIN sales.date b ON  a.order_date = b.date WHERE b.year = 2019;
SELECT SUM(a.sales_amount) AS Revenue_2020 FROM sales.transactions a JOIN sales.date b ON  a.order_date = b.date WHERE b.year = 2020
AND a.market_code ="Mark001";

SELECT DISTINCT product_code  FROM sales.transactions WHERE market_code ="Mark001";
SELECT COUNT(DISTINCT product_code)  FROM sales.transactions WHERE market_code ="Mark001";

-- Finding the duplicate records

with cte as(
SELECT * ,row_number() OVER(PARTITION BY product_code,customer_code,market_code,order_date,sales_qty,sales_amount ORDER BY 
 product_code,customer_code,market_code,order_date,sales_qty,sales_amount) AS row_no FROM sales.transactions)
 select count(*)
 from cte 
 where row_no >1;
 -- The above query outputs to 281 ..So there are 281 duplicate records which needs to be deleted.
SELECT DISTINCT currency , count(currency) FROM sales.transactions 
GROUP BY currency
ORDER BY currency;

-- From the above query, 279 +2 records need to be deleted.

-- The first one is 'INR'   
-- The second one is 'INR\r'
-- The third one is 'USD'
-- The fourth on is 'USD\r'

# product_code, customer_code, market_code, order_date, sales_qty, sales_amount, currency, row_no
'Prod001', 'Cus002', 'Mark002', '2018-05-08', '3', '-1', 'INR\r', '2'
# product_code, customer_code, market_code, order_date, sales_qty, sales_amount, currency, row_no
'Prod002', 'Cus003', 'Mark003', '2018-04-06', '1', '875', 'INR\r', '2'
# product_code, customer_code, market_code, order_date, sales_qty, sales_amount, currency, row_no
'Prod002', 'Cus003', 'Mark003', '2018-04-11', '1', '583', 'INR\r', '2'
-- Have to delete the one with currency as INR and USD...will do it in power query.

 