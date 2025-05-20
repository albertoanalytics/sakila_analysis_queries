-- Total number of rentals and average rentals per customer for each store
-- Improved query with consistent formatting, added store location, and optimized CTE
WITH store_customer_rentals AS (
  SELECT
    s.store_id,
    s.address_id,
    r.customer_id,
    COUNT(r.rental_id) AS rental_count
  FROM
    rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN store s ON i.store_id = s.store_id
  GROUP BY
    s.store_id,
    s.address_id,
    r.customer_id
)

SELECT
  scr.store_id,
  a.address AS store_address,
  ci.city AS store_city,
  COUNT(DISTINCT scr.customer_id) AS total_customers,
  SUM(scr.rental_count) AS total_rentals,
  ROUND(AVG(scr.rental_count), 2) AS avg_rentals_per_customer
FROM
  store_customer_rentals scr
  JOIN store s ON scr.store_id = s.store_id
  JOIN address a ON s.address_id = a.address_id
  JOIN city ci ON a.city_id = ci.city_id
GROUP BY
  scr.store_id,
  a.address,
  ci.city
ORDER BY
  total_rentals DESC;
