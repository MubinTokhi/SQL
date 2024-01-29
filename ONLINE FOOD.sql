select  * from online_food.items;
select  * from online_food.orders;

-- DISTINCT ORDER FOOD NAMES

select distinct name from online_food.items;
select count(distinct name) from online_food.items;

-- Cheacking a Veg group
delete from online_food.items where is_veg = 2;
select is_veg, count(name) as TOTAL from online_food.items
group by is_veg;

-- DISTINCT ORDERS

select distinct order_id from online_food.orders;
select count(distinct order_id) from online_food.orders;

-- CHICKEN FOODS

select name, id from online_food.items where name like '%chicken%';
select count(name) from online_food.items where name like '%chicken%';

-- AVERAGE ITEMS PER ORDER

select round(count(name)/count(distinct order_id) , 0) as AVG_ITEM from online_food.items;


-- ITEMS ORDER EACH TIME AND FOOD NAMES

select order_id, count(order_id) as TIMES_ORDER from online_food.items
group by order_id having times_order>1 order by times_order desc;

select name, count(name) as TIMES_ORDER from online_food.items
group by name having times_order>1 order by times_order desc;


-- RESTURANT NAMES

select distinct restaurant_name from online_food.orders; 

-- MOST ORDERED RETURANT AND ITS MONTH

select restaurant_name, count(restaurant_name) as TOTAL from online_food.orders
group by restaurant_name order by TOTAL desc;


select date_format(order_time , '%y-%m' ), count(distinct order_id) as ID from online_food.orders
group by date_format(order_time , '%y-%m')
order by ID desc;

select max(order_time) from online_food.orders;


-- TOTAL ORDER MADE
select sum(order_total) AS TOTAL_AMOUNT from online_food.orders;

select date_format(order_time , "%y-%m") as date, sum(order_total) AS TOTAL_AMOUNT
from online_food.orders group by date;

-- AVG ORDER VALUE

select count(*) from online_food.orders;

select round((sum(order_total)/95) , 2) as AVG_ORDER_COST from online_food.orders;


-- YEARLY REVENUE AND CHANGES

select date_format(order_time,'%y'),sum(order_total) as REV
from online_food.orders group by date_format(order_time,'%y'); 


with final as (
select date_format(order_time,'%y') as DT,sum(order_total) as REV
from online_food.orders group by date_format(order_time,'%y')
)
select DT, REV, lag(REV) over (order by DT) as PREREV from final;

SELECT DT, REV, PREREV, (REV - PREREV) AS CH
FROM ( SELECT DT, REV, LAG(REV) OVER (ORDER BY DT) AS PREREV FROM final);

-- RANKING YEAR 


with final as (
select date_format(order_time,'%y') as DT,sum(order_total) as REV
from online_food.orders group by date_format(order_time,'%y')
)
select DT, REV, rank() over (order by REV desc) as RANKING from final;

-- ITEMS CHECK UP FOR EACH ORDER

select a.order_id,a.order_total,a.restaurant_name,b.name from online_food.orders as a inner join online_food.items as b on a.order_id = b.order_id;

