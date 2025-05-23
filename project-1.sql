create database project1;
use project1 ;
create table sales (
transactions_id	int primary key ,
sale_date	date ,
sale_time time ,
customer_id	 int,
gender	varchar(20) ,
age	int ,
category varchar(20) ,	
quantiy	int ,
price_per_unit	int ,
cogs float ,	
total_sale int );

select count(*) from  sales ; --- this is used  for count the values in the table --------
select * from sales ; ---- It is used for the select the table ---

--- Datacleaning---

---- The command is used for find the null values in table -----
select  * from sales 
where
     transactions_id is null
     or
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
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
     total_sale is null ;
     
     ----- In this command is used for delete the null values in table ------
delete  from sales 
where
     transactions_id is null
     or
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
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
     total_sale is null ;
     
--- Data Exprolration ------
     
--- How many sales we have ? ----   
select count(*) as total_sale from sales ;

---- How many unqiue coustomers we have ? -------
select count(distinct customer_id) as total_sale from sales ;

---- How many category we have ? -----
select distinct category as total_sale from sales ;

---- Data Analysis & Findings ----- 
-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05' ? 

select *
from sales 
where sale_date = ' 2022-11-05 ' ;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 04 in the month of Nov-2022

select *
from sales 
where
category = 'clothing'
and 
quantiy >= 4 
and 
DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category ? 

select 
category ,
sum(total_sale) ,
COUNT(*) as total_order
from sales
group by 1 ;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category ?

select 
round(avg(age) , 0)  as average_age
from sales 
where
category = 'beauty' ;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from sales 
where 
total_sale > 1000 ;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category ?

select 
	category,
	gender , 
	count(*) as total_trans
    from sales
group
 by 
category,
gender 
order by 1 ;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year?

SELECT 
    year,
    month,
    avg_sales
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sales,
        RANK() OVER(
            PARTITION BY YEAR(sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS ranks
    FROM sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS s1
WHERE ranks = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select 
customer_id ,
sum(total_sale) as total_sales
from sales
group by 1
order by 1 , 2 desc
limit 5 ;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
category ,
count(distinct customer_id) as uni_cs
from sales
group by 1 ;

--- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)?--- 
WITH hourly_sale
AS
(
 select
    *,
    case
        when EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        when EXTRACT(HOUR FROM sale_time)  between 12 and 17 THEN 'Afternoon'
		else 'Evening'
    end as shift
 from sales)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift ;


------------------------ END OF THR PROJECT -------------------------
 


     
     
