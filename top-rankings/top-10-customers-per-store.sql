-- Top 10 customers per store by rental count
-- Improved query with store details, customer email, and consistent formatting
WITH customer_store_rental_counts AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    i.store_id,
    COUNT(r.rental_id) AS rental_count
  FROM
    customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
  GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    i.store_id
),

customer_store_rental_ranked AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.store_id,
    s.address_id,
    c.rental_count,
    RANK() OVER (PARTITION BY c.store_id ORDER BY c.rental_count DESC) AS store_rank
  FROM
    customer_store_rental_counts c
    JOIN store s ON c.store_id = s.store_id
)

SELECT
  csr.customer_id,
  csr.first_name,
  csr.last_name,
  csr.email,
  csr.store_id,
  a.address AS store_address,
  ci.city AS store_city,
  csr.rental_count,
  csr.store_rank
FROM
  customer_store_rental_ranked csr
  JOIN address a ON csr.address_id = a.address_id
  JOIN city ci ON a.city_id = ci.city_id
WHERE
  csr.store_rank <= 10
ORDER BY
  csr.store_id,
  csr.store_rank;
