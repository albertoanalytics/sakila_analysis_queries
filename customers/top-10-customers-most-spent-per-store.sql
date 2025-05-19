-- Top 10 customers who spend the most per store
-- Improved query with store details, consistent formatting, and rounding
WITH customer_store_total_spent AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    i.store_id,
    SUM(p.amount) AS total_spent
  FROM
    customer c
    JOIN payment p ON c.customer_id = p.customer_id
    JOIN rental r ON p.rental_id = r.rental_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
  GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    i.store_id
),

customer_store_spent_ranked AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.store_id,
    s.address_id,
    c.total_spent,
    RANK() OVER (PARTITION BY c.store_id ORDER BY c.total_spent DESC) AS store_rank
  FROM
    customer_store_total_spent c
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
  ROUND(csr.total_spent, 2) AS total_spent,
  csr.store_rank
FROM
  customer_store_spent_ranked csr
  JOIN address a ON csr.address_id = a.address_id
  JOIN city ci ON a.city_id = ci.city_id
WHERE
  csr.store_rank <= 10
ORDER BY
  csr.store_id,
  csr.store_rank;
