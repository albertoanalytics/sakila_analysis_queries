-- Top 10 most rented films
-- Improved query with added film details, category, and rental rates
WITH film_rental_counts AS (
  SELECT
    f.film_id,
    f.title,
    f.description,
    f.release_year,
    f.rental_rate,
    f.length,
    f.rating,
    c.name AS category,
    COUNT(DISTINCT i.inventory_id) AS inventory_count,
    COUNT(r.rental_id) AS rental_count
  FROM
    film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
  GROUP BY
    f.film_id,
    f.title,
    f.description,
    f.release_year,
    f.rental_rate,
    f.length,
    f.rating,
    c.name
)

SELECT
  film_id,
  title,
  description,
  release_year,
  rental_rate,
  length,
  rating,
  category,
  inventory_count,
  rental_count,
  ROUND(rental_count / inventory_count, 2) AS rentals_per_inventory_item
FROM
  film_rental_counts
ORDER BY
  rental_count DESC
LIMIT 10;
