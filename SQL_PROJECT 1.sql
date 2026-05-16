-- sqp_project (retail sales)
create database SQL_project_1;

--create table 
create table retail_sales
(
transactions_id INT,
sale_date date ,
sale_time time ,
customer_id int ,
gender	varchar(10),
age	int,
category varchar(50),
quantiy	int,
price_per_unit int,
cogs int,
total_sale int
);

--show the table 
select*from retail_sales 
Limit 10

--count 
select 
   count (*)
from retail_sales

-- finding if theer is any null value in columns 
select*from retail_sales 
where transactions_id is null 

select*from retail_sales
where sale_date is null

select*from retail_sales
where sale_time is null

select*from retail_sales
where customer_id is null

select*from retail_sales
where gender is null

select*from retail_sales
where 
age is null
or
category is null
or 
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null

--delete null values
delete from retail_sales
where 
age is null
or
category is null
or 
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null

-- data exploration 
--how many sales we have
select count(*)as total_sale from retail_sales

--how many transaction_id do we have 
select count(distinct transactions_id) as total_sale from retail_sales 

--how many category do we have 
select count (distinct category) as total_sale from retail_sales


---BUSINESS KEY PROBLEMSS 

--write an sql query to retrieve all columns  for sales on '2022-11-05'
select *
from retail_sales
where
sale_date='2022-11-05';

-- write an sql query where category is clothing and quantity sold is more than 10 in the month of nov 2022
select*from retail_sales
where 
category='Clothing'
and
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
and 
quantiy>=4

--WRITE QUERY TO FIND TOTAL SALES FOR EACH CATEGORY 
SELECT 
category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1

--write a query to find avg age of customers who purchased items from the 'beauty category '
select
round(avg (age))
from retail_sales
where category='Beauty'

-- write a query to find all transactions where the total_sale is greater tha 1000
select*from retail_sales
where total_sale>1000


--write a query to find the total number of transactions made by each gender in each category 
select
 category,
 gender,
 count(*) as total_trans
from retail_sales
group by
category,
gender


-- write an sql query to calculate the avg sale for each month  . find out the best selling month in each year 
SELECT
    EXTRACT(YEAR FROM sale_date) AS year,

    EXTRACT(MONTH FROM sale_date) AS month,

    SUM(total_sale) AS total_sale,

    RANK() OVER (
        PARTITION BY EXTRACT(YEAR FROM sale_date)
        ORDER BY SUM(total_sale) DESC
    ) AS ranking

FROM retail_sales

GROUP BY 1,2;

---find the top 5 customer based on highest total_sales
select
customer_id,
sum(total_sale) as total_sales
from retail_sales
group by 1 
order by 2 desc
limit 5 

-- customer purchase unique item from each category 
select
category,
count(distinct customer_id)
from retail_sales
group by category 

--write a query to create each shift and the number of orders (ex: morning<=12, afternoon btw 12&17, evening >17)
select *,
case
when extract(hour from sale_time ) <12 then 'MORNING'
when extract(hour from sale_time)between 12 and 17 then 'AFTERNOON'
else 'EVENING'
end as shift
from retail_sales
