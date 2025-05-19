-- Inventory turnover rate per film
-- Analyzes how frequently each film's inventory is rented
WITH film_inventory AS (
  SELECT
    f.film_id,
    f.title,
    f.rental_rate,
    f.replacement_cost,
    f.rating,
    c.name AS category,
    COUNT(DISTINCT i.inventory_id) AS inventory_count,
    COUNT(r.rental_id) AS rental_count,
    MIN(r.rental_date) AS first_rental_date,
    MAX(r.rental_date) AS last_rental_date
  FROM
    film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
  GROUP BY
    f.film_id,
    f.title,
    f.rental_rate,
    f.replacement_cost,
    f.rating,
    c.name
)

SELECT
  film_id,
  title,
  category,
  rating,
  rental_rate,
  replacement_cost,
  inventory_count,
  rental_count,
  first_rental_date,
  last_rental_date,
  DATEDIFF(last_rental_date, first_rental_date) AS days_in_inventory,
  CASE
    WHEN DATEDIFF(last_rental_date, first_rental_date) > 0
    THEN ROUND(rental_count / inventory_count / (DATEDIFF(last_rental_date, first_rental_date) / 30), 2)
    ELSE NULL
  END AS monthly_turnover_rate,
  ROUND(rental_count / inventory_count, 2) AS rentals_per_inventory,
  ROUND((rental_count * rental_rate) / replacement_cost, 2) AS roi_ratio
FROM
  film_inventory
WHERE
  rental_count > 0
ORDER BY
  monthly_turnover_rate DESC;
