-- Seasonal rental patterns
-- Analyzes rental patterns by month and year to identify seasonal trends
-- 
-- Note: When interpreting results from time-based analyses on the Sakila sample database,
-- it's important to be aware that as a demonstration database, data may not be evenly
-- distributed across all time periods. The specific date range and distribution in your
-- instance should be considered when drawing conclusions from these queries.

WITH monthly_rentals AS (
  SELECT
    EXTRACT(YEAR FROM r.rental_date) AS rental_year,
    EXTRACT(MONTH FROM r.rental_date) AS rental_month,
    MONTHNAME(r.rental_date) AS month_name,
    COUNT(r.rental_id) AS rental_count,
    SUM(p.amount) AS revenue
  FROM
    rental r
    JOIN payment p ON r.rental_id = p.rental_id
  GROUP BY
    EXTRACT(YEAR FROM r.rental_date),
    EXTRACT(MONTH FROM r.rental_date),
    MONTHNAME(r.rental_date)
)

SELECT
  rental_year,
  rental_month,
  month_name,
  rental_count,
  ROUND(revenue, 2) AS revenue,
  ROUND(revenue / rental_count, 2) AS avg_revenue_per_rental,
  ROUND(
    100 * (rental_count - LAG(rental_count) OVER (ORDER BY rental_year, rental_month)) / 
    LAG(rental_count) OVER (ORDER BY rental_year, rental_month),
    2
  ) AS pct_change_from_prev_month
FROM
  monthly_rentals
ORDER BY
  rental_year,
  rental_month;
