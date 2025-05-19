-- Customers who have rented films from both stores
-- Improved query with consistent formatting and added customer details
SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  c.email,
  a.address,
  ci.city,
  co.country
FROM
  customer c
  JOIN address a ON c.address_id = a.address_id
  JOIN city ci ON a.city_id = ci.city_id
  JOIN country co ON ci.country_id = co.country_id
WHERE
  EXISTS (
    SELECT 1
    FROM
      rental r
      JOIN inventory i ON r.inventory_id = i.inventory_id
    WHERE
      r.customer_id = c.customer_id
      AND i.store_id = 1
  )
  AND EXISTS (
    SELECT 1
    FROM
      rental r
      JOIN inventory i ON r.inventory_id = i.inventory_id
    WHERE
      r.customer_id = c.customer_id
      AND i.store_id = 2
  )
ORDER BY
  c.last_name,
  c.first_name;
