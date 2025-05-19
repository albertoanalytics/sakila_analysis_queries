-- Top 10 customers who spend the most overall
-- Improved query with additional customer details, payment history, and rounding
WITH customer_total_spent AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    a.address,
    ci.city,
    co.country,
    COUNT(p.payment_id) AS payment_count,
    MIN(p.payment_date) AS first_payment_date,
    MAX(p.payment_date) AS last_payment_date,
    SUM(p.amount) AS total_spent
  FROM
    customer c
    JOIN payment p ON c.customer_id = p.customer_id
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
)

SELECT
  customer_id,
  first_name,
  last_name,
  email,
  address,
  city,
  country,
  payment_count,
  first_payment_date,
  last_payment_date,
  ROUND(total_spent, 2) AS total_spent,
  ROUND(total_spent / payment_count, 2) AS avg_payment_amount
FROM
  customer_total_spent
ORDER BY
  total_spent DESC
LIMIT 10;
