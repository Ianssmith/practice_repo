USE challenge1;

-- 1. What is the total amount each customer spent at the restaurant?
SELECT sales.customer_id, SUM(price) FROM menu 
LEFT JOIN sales 
ON menu.product_id = sales.product_id
GROUP BY sales.customer_id
; 

-- 2. How many days has each customer visited the restaurant?
SELECT sales.customer_id, COUNT(DISTINCT order_date) FROM sales
GROUP BY sales.customer_id
;

-- 3. What was the first item from the menu purchased by each customer?
-- select sales.product_id
/*
#without cte order_rank is not accessable
select *,
dense_rank() over (order by order_date) as order_rank
from sales
where order_rank = 1
group by customer_id
;
*/

with cte_func as(
    select sales.customer_id,
    sales.order_date,
    menu.product_name,
    dense_rank() over (
        partition by sales.customer_id 
        order by sales.order_date) as order_rank
    from sales
    inner join menu
    on sales.product_id = menu.product_id
)
select * 
from cte_func 
where order_rank = 1
; 

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT menu.product_name, COUNT(sales.product_id) as counts
FROM sales
inner join menu
    on menu.product_id = sales.product_id
GROUP BY menu.product_name #question: why does this not work when I group by sales.product_id instead
ORDER BY counts DESC
LIMIT 1

;

-- 5. Which item was the most popular for each customer?

/*
question: why can I run?
select * from sales group by sales.customer_id; is there a workaround
*/

with favs as(
select sales.customer_id, 
    menu.product_name,
    count(menu.product_id) as orderCounts,
    dense_rank() over (
        partition by sales.customer_id
        order by count(sales.customer_id) desc 
    ) as myrank 

from menu
inner join sales
on menu.product_id = sales.product_id
group by sales.customer_id, menu.product_name 

)
select customer_id, 
    product_name,
    orderCounts 
    from favs
    where myrank = 1
;

-- 6. Which item was purchased first by the customer after they became a member?

with myfunc as (
    select 
        sales.customer_id,
        sales.product_id,
        sales.order_date,
        dense_rank() over (partition by sales.customer_id
            order by sales.order_date asc) as myrank
    from sales
    inner join members
    on members.customer_id = sales.customer_id
    and sales.order_date > members.join_date

)

select myfunc.customer_id,
    myfunc.order_date,
    myfunc.myrank,
    menu.product_name
from myfunc
inner join menu
on myfunc.product_id = menu.product_id
where myfunc.myrank = 1
;

-- 7. Which item was purchased just before the customer became a member?

/*
sales(customer_id, order_date, product_id)
menu(product_id, product_name, price)
members(customer_id, join_date)
*/
select * from members;
select * from sales;
select * from menu;

-- 8. What is the total items and amount spent for each member before they became a member?

-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
