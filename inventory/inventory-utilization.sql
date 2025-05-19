-- Inventory utilization percentage
-- Analyzes what percentage of time each film's inventory is rented out
WITH inventory_duration AS (
  SELECT
    i.inventory_id,
    f.film_id,
    f.title,
    c.name AS category,
    r.rental_id,
    r.rental_date,
    r.return_date,
    DATEDIFF(
      COALESCE(r.return_date, CURRENT_DATE),
      r.rental_date
    ) AS rental_days,
    DATEDIFF(CURRENT_DATE, MIN(r.rental_date) OVER (PARTITION BY i.inventory_id)) AS days_since_first_rental
  FROM
    inventory i
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
  WHERE
    r.rental_id IS NOT NULL
),

film_utilization AS (
  SELECT
    film_id,
    title,
    category,
    COUNT(DISTINCT inventory_id) AS inventory_count,
    SUM(rental_days) AS total_days_rented,
    MAX(days_since_first_rental) * COUNT(DISTINCT inventory_id) AS total_days_available
  FROM
    inventory_duration
  GROUP BY
    film_id,
    title,
    category
)

SELECT
  film_id,
  title,
  category,
  inventory_count,
  total_days_rented,
  total_days_available,
  ROUND(
    (total_days_rented / total_days_available) * 100,
    2
  ) AS utilization_percentage
FROM
  film_utilization
WHERE
  total_days_available > 0
ORDER BY
  utilization_percentage DESC;
