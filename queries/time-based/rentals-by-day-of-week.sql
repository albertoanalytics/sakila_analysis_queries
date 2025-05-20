-- Rentals by day of week
-- Analyzes rental patterns by day of week to identify busy days
WITH day_rentals AS (
  SELECT
    DAYOFWEEK(r.rental_date) AS day_number, -- 1 = Sunday, 2 = Monday, etc.
    DAYNAME(r.rental_date) AS day_of_week,
    COUNT(r.rental_id) AS rental_count,
    SUM(p.amount) AS revenue
  FROM
    rental r
    JOIN payment p ON r.rental_id = p.rental_id
  GROUP BY
    DAYOFWEEK(r.rental_date),
    DAYNAME(r.rental_date)
),

day_rentals_with_stats AS (
  SELECT
    day_number,
    day_of_week,
    rental_count,
    ROUND(revenue, 2) AS revenue,
    ROUND(revenue / rental_count, 2) AS avg_revenue_per_rental,
    ROUND(100 * rental_count / SUM(rental_count) OVER (), 2) AS pct_of_total_rentals,
    ROUND(100 * revenue / SUM(revenue) OVER (), 2) AS pct_of_total_revenue
  FROM
    day_rentals
)

SELECT
  day_of_week,
  rental_count,
  revenue,
  avg_revenue_per_rental,
  pct_of_total_rentals,
  pct_of_total_revenue
FROM
  day_rentals_with_stats
ORDER BY
  day_number;
