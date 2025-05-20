-- Customer lifetime value
-- Calculates the lifetime value of customers based on their payment history
WITH customer_payments AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    a.address,
    ci.city,
    co.country,
    SUM(p.amount) AS total_spent,
    COUNT(p.payment_id) AS payment_count,
    MIN(p.payment_date) AS first_payment,
    MAX(p.payment_date) AS last_payment,
    DATEDIFF(MAX(p.payment_date), MIN(p.payment_date)) AS customer_lifespan_days
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
  HAVING
    DATEDIFF(MAX(p.payment_date), MIN(p.payment_date)) > 0
)

SELECT
  customer_id,
  first_name,
  last_name,
  email,
  city,
  country,
  ROUND(total_spent, 2) AS total_spent,
  payment_count,
  first_payment,
  last_payment,
  customer_lifespan_days,
  ROUND(total_spent / payment_count, 2) AS avg_transaction_value,
  ROUND(payment_count / (customer_lifespan_days / 30), 2) AS monthly_frequency,
  ROUND(total_spent / (customer_lifespan_days / 30), 2) AS monthly_value,
  ROUND(total_spent / (customer_lifespan_days / 365), 2) AS annual_value,
  -- Forecasted 3-year value (assuming consistent behavior)
  ROUND(total_spent * (1095 / customer_lifespan_days), 2) AS projected_three_year_value
FROM
  customer_payments
ORDER BY
  annual_value DESC;
