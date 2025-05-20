-- Total revenue and average revenue per customer for each store
-- Improved query with consistent formatting, added store location, and optimized CTE
WITH store_customer_revenue AS (
  SELECT
    s.store_id,
    s.address_id,
    c.customer_id,
    SUM(p.amount) AS customer_revenue
  FROM
    payment p
    JOIN rental r ON p.rental_id = r.rental_id
    JOIN customer c ON r.customer_id = c.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN store s ON i.store_id = s.store_id
  GROUP BY
    s.store_id,
    s.address_id,
    c.customer_id
)

SELECT
  scr.store_id,
  a.address AS store_address,
  ci.city AS store_city,
  COUNT(DISTINCT scr.customer_id) AS total_customers,
  SUM(scr.customer_revenue) AS total_revenue,
  ROUND(AVG(scr.customer_revenue), 2) AS avg_revenue_per_customer
FROM
  store_customer_revenue scr
  JOIN store s ON scr.store_id = s.store_id
  JOIN address a ON s.address_id = a.address_id
  JOIN city ci ON a.city_id = ci.city_id
GROUP BY
  scr.store_id,
  a.address,
  ci.city
ORDER BY
  total_revenue DESC;
