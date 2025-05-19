-- Top 10 overall customers by rental count
-- Improved query with additional customer details and rental history
WITH customer_rental_counts AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    a.address,
    ci.city,
    co.country,
    MIN(r.rental_date) AS first_rental_date,
    MAX(r.rental_date) AS last_rental_date,
    COUNT(r.rental_id) AS rental_count
  FROM
    customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN address a ON c.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
  GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    a.address,
    ci.city,
    co.country
),

customer_rental_ranked AS (
  SELECT
    customer_id,
    first_name,
    last_name,
    email,
    address,
    city,
    country,
    first_rental_date,
    last_rental_date,
    rental_count,
    RANK() OVER (ORDER BY rental_count DESC) AS overall_rank
  FROM
    customer_rental_counts
)

SELECT
  customer_id,
  first_name,
  last_name,
  email,
  address,
  city,
  country,
  first_rental_date,
  last_rental_date,
  rental_count,
  overall_rank,
  DATEDIFF(last_rental_date, first_rental_date) AS customer_rental_period_days
FROM
  customer_rental_ranked
WHERE
  overall_rank <= 10
ORDER BY
  overall_rank;
