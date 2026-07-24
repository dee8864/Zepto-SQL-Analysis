# Zepto-SQL-Analysis

"If you think e-commerce analytics is only about counting products, you haven't met a dataset that forces you to clean paise-to-rupee conversions, hunt down zero-price ghosts, and calculate price-per-gram like a true inventory detective. Here's how I turned messy Zepto data into actionable business insights."

# Why did I build it?
I built this project to simulate a real-world data analyst workflow in the quick-commerce sector. Zepto is one of India's fastest-growing e-commerce platforms, and their inventory data reflects typical industry challenges: duplicate product listings, inconsistent pricing units (paise vs rupees), missing values, and the constant need to balance stock availability with revenue potential. As an aspiring data analyst, I wanted to prove that I can take raw, messy CSV files and deliver clean, business-ready SQL insights without hand-holding. This project serves as a portfolio piece that hiring managers can review in under 10 minutes to assess my SQL proficiency, problem-solving mindset, and ability to ask the right business questions.

# What skills does it demonstrate?
• PostgreSQL data type design (SERIAL, NUMERIC, BOOLEAN, VARCHAR constraints)

• Exploratory Data Analysis (EDA) using aggregate functions and filtering

• Data cleaning: NULL detection, deletion of invalid rows (zero-price products), unit conversion (paise to rupees)

• Advanced SQL queries: window-less aggregation, CASE statements for bucketing, arithmetic operations across columns

• Business metric calculation: estimated revenue, price per gram, total inventory weight

• Real-world problem interpretation: translating business questions into efficient SQL

• Version control and documentation (this README)

# My Project Journey
I started by sourcing the Zepto inventory dataset from Kaggle, originally scraped from the live app. The first challenge was importing it into PostgreSQL – I hit an UTF-8 encoding error, which I solved by re-saving the CSV in UTF-8 format. Once the table was created, I ran a quick row count and discovered duplicate product names. Instead of treating them as errors, I recognized that the same product (e.g., "Amul Butter") can appear multiple times with different weights, package quantities, or categories – a real catalog behavior.

Next, I checked for nulls across all columns. Finding none, I moved to pricing sanity checks. Several rows had MRP or discounted selling price equal to zero – clearly invalid entries. I deleted them immediately because they would skew any revenue calculation. Then came the biggest cleaning step: the dataset stored prices in paise (e.g., 45000 for ₹450). I wrote an UPDATE statement dividing both mrp and discountedSellingPrice by 100.0, converting everything to rupees in one atomic operation.

After cleaning, I tackled eight business questions provided in the project brief. Each query forced me to think like a product manager or category lead. For example, "Find the top 10 best-value products based on discount percentage" required careful grouping to avoid over-counting duplicates. "Calculate estimated revenue for each category" revealed that categories like "Fruits" and "Snacks" dominate – but also that low-revenue categories might be understocked or over-discounted. The price-per-gram query (question 6) was the most rewarding: I filtered products above 100g, divided discountedSellingPrice by weightInGms, and sorted by best value. This directly answers a customer's unspoken question: "Am I getting my money's worth?"

I also added a CASE statement to categorize products into Low (<1000g), Medium (1000-5000g), and Bulk (>5000g) weight groups – a simple but powerful segmentation for inventory planning. Finally, I calculated total inventory weight per category, which logistics teams use to optimize shelf space and delivery loads.

Throughout this journey, I documented every step in the SQL file, wrote comments, and structured queries to be readable and reusable. The result is a complete data analyst pipeline from raw CSV to business dashboard-ready outputs.

# Business Problems Solved
• The following real-world business questions were answered using SQL:

• Top 10 best-value products based on discount percentage – identifying which products give customers the highest relative savings.

• Products with high MRP but out of stock – helping procurement teams prioritise restocking of expensive, unavailable items.

• Estimated revenue for each category – calculated as discountedSellingPrice * availableQuantity, allowing category managers to see which segments drive the most potential income.

• Products where MRP > ₹500 and discount < 10% – flagging overpriced, barely-discounted items that may need promotional intervention.

• Top 5 categories offering the highest average discount percentage – revealing which product families are used as loss leaders or heavy promotional drivers.

• Price per gram for products above 100g, sorted by best value – giving customers and pricing teams a transparency metric for comparing bulk and loose items.

• Grouping products into Low, Medium, and Bulk weight categories – simplifying logistics and warehouse slotting decisions.

• Total inventory weight per category – supporting storage capacity planning and delivery vehicle load optimisation.

# Technologies Used
• PostgreSQL (pgAdmin as the client)

• CSV UTF-8 encoding for clean data import

• SQL features: aggregate functions (SUM, AVG, COUNT), GROUP BY, HAVING, ORDER BY, CASE expressions, arithmetic operators, boolean filtering, DISTINCT, LIMIT, DELETE, UPDATE

• Version control: Git + GitHub

# Key Learning Outcomes
• From this project, I learned:

• Real-world data rarely comes perfect. Expect paise vs rupees, zero-price placeholders, and duplicates that are actually legitimate SKU variations.

• Deleting rows is sometimes the right answer. Removing zero-price products before analysis prevented division-by-zero errors and inflated revenue estimates.

• Always check your unit conversions before joining or aggregating. One forgotten /100 would make revenue numbers 100x too high.

• Discount percentage alone does not define "best value". A product with 80% off on a ₹100 MRP saves ₹80, but a product with 40% off on ₹2000 saves ₹800. Context matters – that's why I kept MRP visible in discount queries.

• Weight-based segmentation (Low/Medium/Bulk) is underutilised in e-commerce analytics. It directly impacts shipping costs and warehousing.

• Estimated revenue (discountedSellingPrice * availableQuantity) is not actual revenue – it's potential revenue if everything sells. I learned to label such metrics clearly to avoid overpromising.

• Writing clean, commented SQL is a professional courtesy. My queries use consistent aliases, indentation, and explicit column names – no SELECT * after the exploration phase.

• A portfolio project is only as good as the story behind it. This README explains my decisions, struggles (encoding errors, zero-price rows, duplicate names), and solutions to show recruiters how I think, not just what I wrote.

This project is open for feedback, collaboration, or reuse. If you are a hiring manager, feel free to run the SQL file against any PostgreSQL instance to verify results. Thank you for reading my journey from messy CSV to clean insights.

![dashboard preview](https://github.com/dee8864/Zepto-SQL-Analysis/blob/main/%23VISUALS%20Zepto%20SQL%20Analysis.png)
![dashboard prebiew](https://www.google.com/search?q=zepto+sql+project+logo&sca_esv=df599af11dfaf41f&rlz=1C1GCEA_enIN1184IN1184&udm=2&biw=1280&bih=551&sxsrf=APpeQnvy07_6f4bexKc4QPkX5J34tbe3gQ%3A1784874235205&ei=-wRjatWQDPDn4-EP8vu_uAM&ved=0ahUKEwiV-ofW1uqVAxXw8zgGHfL9DzcQ4dUDCBE&uact=5&oq=zepto+sql+project+logo&gs_lp=Egtnd3Mtd2l6LWltZyIWemVwdG8gc3FsIHByb2plY3QgbG9nb0i2FFC8CFj1EHABeACQAQCYAacDoAHsC6oBCTAuMS4xLjIuMbgBA8gBAPgBAZgCAqACrQLCAgQQABgemAMAiAYBkgcFMS4wLjGgB1iyBwMyLTG4B6QCwgcDMi0yyAcHgAgB&sclient=gws-wiz-img#sv=CAMSURoyKhBlLWkyM0JuenNjVmdBbTdNMg5pMjNCbnpzY1ZnQW03TToOYkZHOC1ha3JGREJzc00gBCoXCgFzEhBlLWkyM0JuenNjVmdBbTdNGAEwARgHINi4lccESggQARgBIAEoAQ)

[View Zepto SQL Project Logo](https://www.google.com/search?q=zepto+sql+project+logo&tbm=isch)
<a href="https://www.google.com/search?q=zepto+sql+project+logo&tbm=isch" target="_blank">
    View Zepto SQL Project Logo
</a>
