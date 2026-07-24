

--drop table
drop table if exists zepto;

--create table
create table zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name varchar(150) not null,
mrp	numeric(10,2),
discountPercent numeric(10,2),
availableQuantity int,
discountedSellingPrice numeric(10,2),
weightInGms int,
outOfStock boolean,
quantity int
);

select * from zepto;


--data exploration

--count of rows
select count(*) from zepto;

--sample data
SELECT * FROM zepto
LIMIT 10;

--null values
SELECT * FROM zepto
WHERE name IS NULL
OR category IS NULL
OR mrp IS NULL
OR discountPercent IS NULL
OR discountedSellingPrice IS NULL
OR weightInGms IS NULL
OR availableQuantity IS NULL
OR outOfStock IS NULL
OR quantity IS NULL;

--different product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

--products in stock vs out of stock
select category, outofstock, count(outofstock)
from zepto
group by category, outofstock
order by category desc;

SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

--product names present multiple times
select name, count(name)
from zepto
group by name
having count(name)>1
order by count(name) desc;

SELECT name, COUNT(sku_id) AS "Number of SKUs"
FROM zepto
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;

--data cleaning

--products with price = 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto
WHERE mrp = 0 or discountedSellingPrice=0;

--convert paise to rupees
UPDATE zepto
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT * FROM zepto;

--data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
select name, category, mrp, max(discountPercent)
from zepto
group by name, category, mrp, discountPercent
order by discountPercent desc limit 10;

--Q2.What are the Products with High MRP but Out of Stock
SELECT DISTINCT name, mrp, outofstock, max(mrp)
FROM zepto
WHERE outOfStock = TRUE 
group by name, mrp, outofstock
ORDER BY mrp DESC limit 10;

--Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC;

--Q5. Identify the top 5 category offering the highest average discount percentage.
select category, avg(discountPercent) from zepto
group by category
order by avg(discountPercent) desc limit 5;

--Q6. Find the price per gram for products above 100g and short by best value.
select  distinct name, mrp, weightInGms, discountedSellingPrice, 
		(discountedSellingPrice/weightInGms) as price
from zepto
where weightInGms>=100
group by name, mrp, weightInGms, discountedSellingPrice
order by price desc;

--Q7. Group the products into category like low, medium, bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto;

--Q8.What is the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;