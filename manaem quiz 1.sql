Use BikeStores

--------Question#1--------

Select first_name, last_name, city 
From
sales.customers
Where
(state = 'NY' or state= 'CA') and email lIKE '%.com' and last_name LIKE 'M%'
ORDER by city asc, last_name asc;


-----Question#2-------

SELECT
    product_name, list_price, discounted_price
	From (select product_name, list_price, (list_price - list_price*10/100)
	as discounted_price
	From production.products
	Where list_price>500) as dis 
	order by list_price desc 
offset 10 rows fetch next 10 rows only;

-------Question#3--------

SELECT
    order_id,
    order_date,
    required_date,
    order_status

FROM sales.orders
WHERE order_status In (1,2)
    AND shipped_date IS NULL
    AND order_date BETWEEN '2018-01-01' AND '2018-06-30';

	--------Question#4--------

	SELECT
    c.last_name,
    o.order_id,
    o.order_date,
    s.store_name,
    p.product_name,
    oi.quantity
FROM sales.orders
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN stores s
    ON o.store_id = s.store_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
  AND o.order_date >= '2018-01-01'
  AND o.order_date < '2019-01-01'
ORDER BY o.order_date DESC;

------Question#5------

SELECT
    p.product_name,
    c.category_name,
    b.brand_name
FROM production.products p
LEFT JOIN sales_details sd
    ON p.product_id = sd.product_id
LEFT JOIN categories c
    ON p.category_id = c.category_id
LEFT JOIN brands b
    ON p.brand_id = b.brand_id
WHERE sd.product_id IS NULL;