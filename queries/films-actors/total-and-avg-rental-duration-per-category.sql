-- Total and average rental duration per film category
-- Improved query with additional metrics and consistent formatting
SELECT
  c.category_id,
  c.name AS category_name,
  COUNT(f.film_id) AS film_count,
  SUM(f.rental_duration) AS total_rental_duration,
  ROUND(AVG(f.rental_duration), 2) AS avg_rental_duration,
  MIN(f.rental_duration) AS min_rental_duration,
  MAX(f.rental_duration) AS max_rental_duration,
  ROUND(STDDEV(f.rental_duration), 2) AS stddev_rental_duration,
  ROUND(AVG(f.rental_rate), 2) AS avg_rental_rate,
  ROUND(AVG(f.length), 2) AS avg_film_length
FROM
  film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
GROUP BY
  c.category_id,
  c.name
ORDER BY
  avg_rental_duration DESC;
