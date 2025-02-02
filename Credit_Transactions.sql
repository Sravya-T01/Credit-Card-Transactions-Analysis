SELECT * from credit_card_transactions;

--- 1. query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

WITH amount_spent_per_city AS 
(
    SELECT city, sum(amount) AS per_city_amount
    FROM credit_card_transactions
    GROUP BY city
),
total_amount_spent AS
(
    SELECT sum(amount) AS total_amount FROM credit_card_transactions
)

SELECT TOP 5 
    city,
    per_city_amount,
    round((per_city_amount/total_amount)*100, 3) as percentage_contribution
FROM amount_spent_per_city, total_amount_spent
ORDER BY per_city_amount DESC;


--- 2. query to print highest spent month and amount spent in that month for each card type

with cte1 as 
(SELECT
    card_type,
    DATEPART(year, date) as yr,
    DATEPART(month, date) as mt,
    sum(amount) as total_amount
from credit_card_transactions
group by 
    card_type,
    DATEPART(year, date),
    DATEPART(month, date))

,cte2 as 
(SELECT 
    card_type,
    mt, yr,
    total_amount,
    dense_rank() OVER(partition by card_type order by total_amount desc) as rank
from cte1)

SELECT card_type, mt as month, yr as year, total_amount
from cte2
where rank=1;


--- 3. write a query to print the transaction details (all columns from the table) for each card type when it reaches a cumulative of 1000000(1 million) total spends

with cte as (
    SELECT *,
        sum(amount) over(partition by card_type order by date, transaction_id) as total_spent
        from credit_card_transactions
)

SELECT * 
from
(SELECT * ,
    rank() over(partition by card_type order by total_spent asc) as rnk
from cte 
where total_spent >= 1000000) a WHERE rnk=1;

--- 4. write a query to find city which had lowest percentage spend for gold card type

WITH cte AS (
    SELECT 
        city,
        card_type,
        SUM(amount) AS amount,
        sum(case when card_type='Gold' then amount else 0 end) as gold_amount
    FROM credit_card_transactions
    GROUP BY city, card_type
)

SELECT TOP 1 city,
    CASE 
        WHEN SUM(amount) > 0 THEN SUM(gold_amount) / SUM(amount)
        ELSE 0 
    END AS gold_ratio
from cte 
GROUP BY city
HAVING SUM(gold_amount) > 0
ORDER BY gold_ratio ASC;

--- 5. write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
with cte1 as 
(SELECT 
    city, exp_type, sum(amount) as total_Amount
from credit_card_transactions
group by city,exp_type
)

,cte2 as
(SELECT *,
    rank() over(partition by city order by total_amount desc) as rn_desc,
    rank() over(partition by city order by total_amount asc) as rn_asc
from cte1
)

SELECT city,
    max(case when rn_desc = 1 then exp_type end) as highest_expense_type,
    max(case when rn_asc = 1 then exp_type end) as lowest_expense_type
from cte2
group by city;

-- 6. Write a query to find percentage contribution of spends by females for each expense type

SELECT 
    exp_type,
    round(sum(case when gender = 'F' then amount else 0 end)*100/sum(amount),2) as female_percentage
FROM credit_card_transactions
group by exp_type
order by female_percentage desc;

-- 7- which card and expense type combination saw highest month over month percentage growth in Jan-2014(compared to Dec-2013)

with cte as 
(SELECT 
    card_type,
    exp_type,
    DATEPART(year, date) yr,
    DATEPART(month, date) mt,
    sum(amount) as total_spent
FROM credit_card_transactions
GROUP BY 
    card_type,
    exp_type,
    DATEPART(year, date),
    DATEPART(month, date)
)
,cte2 AS
(SELECT *,
    LAG(total_spent,1) OVER(partition by card_type,exp_type order by yr,mt asc) as prev_month_spend
from cte)

SELECT top 1 *,
    CASE 
        WHEN prev_month_spend > 0 THEN (total_spent - prev_month_spend) * 1.0 / prev_month_spend
        ELSE NULL
    END AS mom_growth
from cte2
where prev_month_spend is not null and yr = 2014 and mt = 1
order by mom_growth DESC;

-- 8. during weekends which city has highest total spend to total number of transcations ratio 

SELECT top 1 
    city,
    sum(amount)/count(*) as total_to_transation_ratio
from credit_card_transactions
where DATEPART(weekday, date) in (1,7)
group by city
order by total_to_transation_ratio desc;

-- 10. which city took least number of days to reach its 500th transaction after the first transaction in that city
with cte as
(SELECT 
    *,
    row_number() over(partition by city order by date,transaction_id) as rn
from credit_card_transactions
)

SELECT top 1 city, 
    datediff(day, min(date), max(date)) as diff_in_days
FROM cte 
where rn = 1 or rn = 500
group by city
having min(date) != max(date)
order by diff_in_days