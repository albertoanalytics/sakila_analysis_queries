-- Total revenue per store
-- Improved query linking revenue to inventory's store rather than staff's store
-- This provides a more accurate view of which store's inventory is generating revenue
SELECT
  s.store_id,
  a.address AS store_address,
  ci.city AS store_city,
  co.country AS store_country,
  COUNT(DISTINCT r.customer_id) AS unique_customers,
  COUNT(p.payment_id) AS payment_count,
  ROUND(SUM(p.amount), 2) AS total_revenue,
  ROUND(AVG(p.amount), 2) AS avg_payment_amount,
  MIN(p.payment_date) AS first_payment_date,
  MAX(p.payment_date) AS last_payment_date
FROM
  payment p
  JOIN rental r ON p.rental_id = r.rental_id
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN store s ON i.store_id = s.store_id
  JOIN address a ON s.address_id = a.address_id
  JOIN city ci ON a.city_id = ci.city_id
  JOIN country co ON ci.country_id = co.country_id
GROUP BY
  s.store_id,
  a.address,
  ci.city,
  co.country
ORDER BY
  total_revenue DESC;
